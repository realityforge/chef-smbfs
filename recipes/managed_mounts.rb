#
# Copyright 2012, Peter Donald
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "smbfs"

node[:smbfs][:mounts].each_pair do |path, config|

  location = nil
  search(:shares, "id:#{config[:share]}") do |share|
    if share['mounts'] && share['mounts'][node.chef_environment]
      location = share['mounts'][node.chef_environment]['location']
    end
  end

  raise "Unable to locate share #{config[:share]}" unless location

  if config[:path]
    location = "#{location}/#{config[:path]}"
  end

  options = []

  if config[:username]
    password_file = "/etc/smbfs#{path}/.credentials"

    directory File.dirname(password_file) do
      owner "root"
      group "root"
      mode 0600
      recursive true
      action :create
    end

    file password_file do
      owner "root"
      group "root"
      mode 0600
      content "username=#{config[:username]}\npassword=#{config[:password]}\n"
      action :create
    end

    options << "credentials=#{password_file}"

  end

  if config[:options]
    config[:options].each_pair do |key, value|
      if value
        options << "#{key}=#{value}"
      else
        options << "#{key}"
      end
    end
  end


  mount path.to_s do
    device location
    fstype "cifs"
    options options.join(',') unless options.empty?
    action [:mount, :enable]
  end
end
#
# Copyright Peter Donald
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

action :run do
  options = []

  if new_resource.username
    password_file = "/etc/smbfs#{new_resource.path}/.credentials"

    directory ::File.dirname(password_file) do
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
      content "username=#{new_resource.username}\npassword=#{new_resource.password}\n"
      action :create
    end

    options << "credentials=#{password_file}"
  end

  if new_resource.options
    new_resource.options.each_pair do |key, value|
      if value
        options << "#{key}=#{value}"
      else
        options << key.to_s
      end
    end
  end

  mount new_resource.path do
    device new_resource.cifs_path
    fstype "cifs"
    options options.join(',') unless options.empty?
    action [:mount, :enable]
  end

  new_resource.updated_by_last_action(true)
end

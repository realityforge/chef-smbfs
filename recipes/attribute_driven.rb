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

node['smbfs']['mounts'].each_pair do |path, config|
  smbfs_mount path.to_s do
    cifs_path config['cifs_path']
    username config['username'] if config['username']
    password config['password'] if config['password']
    options config['options'] if config['options']
  end
end
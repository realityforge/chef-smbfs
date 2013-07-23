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

actions :run

attribute :path, :kind_of => String, :name_attribute => true
attribute :cifs_path, :kind_of => String, :required => true
attribute :username, :kind_of => String, :default => nil
attribute :password, :kind_of => String, :default => nil
attribute :dir_owner, :kind_of => String, :default => nil
attribute :dir_group, :kind_of => String, :default => nil
attribute :dir_mode, :kind_of => String, :default => nil
attribute :options, :kind_of => Hash, :default => nil

def initialize( *args )
  super
  @action = :run
end

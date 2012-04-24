Description
===========

A recipe that installs smbfs on linux hosts and includes a recipe for adding managed nodes.

Example for mounting a share
----------------------------

    node[:smbfs][:mounts]["/mnt"] =
      {
        :share => "AppData",
        :path => "IRIS/Subdir",
        "username" => "MyUser",
        "password" => "MyPass",
        :options =>
          {
            "rw" => nil
          }
      }


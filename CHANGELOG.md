## v0.2.0:

* Improve the documentation.
* Start testing foodcritic rules via TravisCI.
* Refactor the cookbook to introduce a resource `smbfs_mount` that is responsible for managing the mount.
* Remove the usage of data bags to map shares to cifs paths. This is a policy decision and should not be
  present in the cookbook.

## v0.1.0:

* Initial release
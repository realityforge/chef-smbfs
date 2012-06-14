## v0.2.0:

* Refactor the cookbook to introduce a resource `smbfs_mount` that is responsible for managing the mount.
* Remove the usage of the databag to map shares to cifs paths as that is a policy decision and should not be
  present in the cookbook.

## v0.1.0:

* Initial release
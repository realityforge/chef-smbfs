Description
===========

[![Build Status](https://secure.travis-ci.org/realityforge-cookbooks/smbfs.png?branch=master)](http://travis-ci.org/realityforge/-cookbooks/smbfs)

A recipe that installs smbfs on linux hosts. It also includes a recipe for adding managed mounts.

Example for mounting a share
----------------------------

    node['smbfs']['mounts']['/mnt'] =
      {
        'cifs_path' => '//san01.example.org/myshare$/Some/Path',
        'username' => 'MyUser',
        'password' => 'MyPass',
        'options' =>
          {
            'rw' => nil
          }
      }

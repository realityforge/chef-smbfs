Description
===========

[![Build Status](https://secure.travis-ci.org/realityforge-cookbooks/smbfs.png?branch=master)](http://travis-ci.org/realityforge/-cookbooks/smbfs)

A recipe that installs smbfs on linux hosts. It also includes a resource for mounting cifs shares and an attribute driven recipe managing smbfs mounts.

Requirements
============

Tested on Ubuntu 11.

Attributes
==========

* `node['smbfs']['mounts']` - A map that describes zero or more cifs mounts. Used to drive the `attribtue_driven` recipe.

Usage
=====

There are two recipes provided:

* `smbfs::default` - Install the smbfs package.
* `smbfs::attribute_driven` - Invokes the `smbfs::default` recipe and then interprets the `node['smbfs']['mounts']`
  attribtue and defines the resources for the mouts.

Resources
=========

`smbfs_mount`
-------------

The `smbfs_mount` resource helps define a mount for a cifs share.

- path: the path on which to mout the share. This is the name of the resource.
- cifs_path: The url for cifs mount.
- username: The username if authenticated access required to cifs share. Defaults to nil.
- password: The password. Must be present iff username is present. Defaults to nil.
- option: Arbitrary key value pairs passed to mount.

The simplest example for mounting a share;

    smbfs_mount '/mnt' do
      cifs_path '//san01.example.org/myshare$/Some/Path'
      username 'MyUser',
      password 'MyPass',
      options {'rw' => nil}
    end

Attribute Driven Recipe
=======================

The simplest example for mounting a share;

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

    include_recipe 'smbfs::attribute_driven'

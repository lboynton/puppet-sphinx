puppet-sphinx
=============

Puppet module for adding and configuring sphinx search. Tested on CentOS 6.

Usage
-------------
For the default settings, simply include the sphinx class with

```puppet
include sphinx
```

and configure the instance by using at least one `sphinx::config` block.

```puppet
sphinx::config { 'testing':
    site    => 'example.com',
    source  => 'puppet:///files/sphinx/example.com',
    host    => 'dbhost',
    user    => 'dbuser',
    pass    => 'dbpass',
    db      => 'dbname',
}
```

To configure the memory usage:

```puppet
class { 'sphinx':
    mem_limit => '1024M',
}
```

Use this instead of `include sphinx`.

Dependencies
-------------
Installs sphinx from EPEL, so this puppet module is required.

* [puppet-module-epel](https://github.com/stahnma/puppet-module-epel)

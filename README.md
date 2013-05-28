puppet-sphinx
=============

Puppet module for adding and configuring sphinx search. Tested on CentOS 6.

Usage
=============
For the default settings, simply include the sphinx class with

    include sphinx

and configure the instance by using at least one `sphinx::config` block.

    sphinx::config { 'testing':
        site    => 'example.com',
        source  => 'puppet:///files/sphinx/example.com',
        host    => 'dbhost',
        user    => 'dbuser',
        pass    => 'dbpass',
        db      => 'dbname',
    }

To configure the memory usage:

    class { 'sphinx':
        mem_limit => '1024M',
    }

Use this instead of `include sphinx`.

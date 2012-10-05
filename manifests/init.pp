class sphinx {
    # sphinx not in yum repo
    exec {
		"/usr/bin/wget http://sphinxsearch.com/files/sphinx-2.0.5-1.rhel6.x86_64.rpm -O /root/sphinx.rpm":
			alias => "get-sphinx",
			creates => "/root/sphinx.rpm",
	}

    package { "sphinx":
        ensure => installed,
        provider => rpm,
        source => "/root/sphinx.rpm",
        require => Exec["get-sphinx"]
    }

    file { "/etc/sphinx/sphinx.conf":
        ensure => file,
        source => "puppet:///modules/sphinx/sphinx.conf",
        alias  => "sphinx-conf",
    }

    file { "/etc/sphinx.d":
        ensure => directory,
        owner  => "root",
        group  => "root",
        alias  => "sphinx.d",
    }

    file { "/etc/sphinx.d/searchd.conf":
        ensure  => present,
        owner   => "root",
        group   => "root",
        require  => File['sphinx.d'],
    }
}
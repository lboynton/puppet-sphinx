class sphinx($mem_limit = '2047M') {

    if !defined(Package['mysql-libs']) {
        package { 'mysql-libs':
            ensure  => installed,
        }
    }

    # sphinx not in yum repo
    exec {
		'/usr/bin/wget http://sphinxsearch.com/files/sphinx-2.0.8-1.rhel6.x86_64.rpm -O /root/sphinx.rpm':
			alias   => 'get-sphinx',
			creates => '/root/sphinx.rpm',
	}

    package { 'sphinx':
        ensure      => latest,
        provider    => rpm,
        source      => '/root/sphinx.rpm',
        subscribe   => Exec['get-sphinx'],
        require     => Package['mysql-libs']
    }

    file { '/etc/sphinx/sphinx.conf':
        ensure  => file,
        source  => 'puppet:///modules/sphinx/sphinx.conf',
        alias   => 'sphinx-conf',
        owner   => 'root',
        group   => 'root',
        before  => Service['searchd'],
    }

    file { '/etc/sphinx.d':
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        alias   => 'sphinx.d',
        before  => Service['searchd'],
    }

    file { '/etc/sphinx.d/searchd.conf':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        require => File['sphinx.d'],
        source  => 'puppet:///modules/sphinx/searchd.conf',
        before  => Service['searchd'],
    }

    file { '/etc/sphinx.d/indexer.conf':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        require => File['sphinx.d'],
        content => template('sphinx/indexer.conf.erb'),
        before  => Service['searchd'],
    }

    file { '/var/data':
        ensure  => directory,
        owner   => 'sphinx',
        group   => 'sphinx',
        require => Package['sphinx'],
        before  => Service['searchd'],
    }

    service { 'searchd':
        ensure      => running,
        enable      => true,
        require     => File['/var/data'],
        subscribe   => Package['sphinx'],
    }
}
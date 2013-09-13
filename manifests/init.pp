class sphinx($mem_limit = '2047M') {

    include epel

    package { 'sphinx':
        ensure  => latest,
        require => Class['epel'],
    }

    file { '/etc/sphinx/sphinx.conf':
        ensure  => file,
        source  => 'puppet:///modules/sphinx/sphinx.conf',
        alias   => 'sphinx-conf',
        owner   => 'root',
        group   => 'root',
        require  => Package['sphinx'],
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

    # service will fail to start unless it has been configured
    service { 'searchd':
        ensure      => running,
        enable      => true,
        require     => File['/var/data'],
        subscribe   => Package['sphinx'],
    }
}
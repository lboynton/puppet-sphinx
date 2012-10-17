define sphinx::config(
    $source,
    $type   => 'mysql',
    $host   => '127.0.0.1',
    $user   => undef,
    $pass   => undef,
    $db     => undef,
    $port   => 3306,
    $site   => undef
) {
    file { "/etc/sphinx.d/${site}/":
        ensure => directory,
        source => $source,
        recurse => true,
        purge   => true,
        force   => true,
        owner   => 'root',
        group   => 'root',
    }

    file { "/etc/sphinx.d/${site}/default.source":
        content => template("sphinx/default.source.erb"),
        owner   => 'root',
        group   => 'root',
    }
}
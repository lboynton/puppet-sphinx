define sphinx::config($source) {
    file { "/etc/sphinx.d/${name}/":
        ensure => directory,
        source => $source,
        recurse => true,
        purge   => true,
        force   => true,
        owner   => 'root',
        group   => 'root',
    }
}
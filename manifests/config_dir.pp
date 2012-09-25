define sphinx::config_dir {
    file { "/etc/sphinx.d/${name}":
        ensure => directory,
    }
}
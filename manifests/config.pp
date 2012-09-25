define sphinx::config($dir, $source) {
    file { "/etc/sphinx.d/${dir}":
        ensure => directory,
        alias  => "sphinx.d-${name}",
    }

    file { "/etc/sphinx.d/${dir}/${name}":
        ensure => file,
        source => $source,
    }
}
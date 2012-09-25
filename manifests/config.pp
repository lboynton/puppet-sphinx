define sphinx::config($dir, $source) {
    file { "/etc/sphinx.d/${dir}/${name}":
        ensure => file,
        source => $source,
    }
}
define archive::tar_gz($source, $target) {
  exec {"$name unpack":
    command => "/usr/bin/curl -s -S ${source} | tar -xzf - -C ${target} && touch ${name}",
    creates => $name,
    require => Package[curl],
  }
}

# setup docker for mesos

class pmerdin::docker () {
  apt::source { 'docker.io':
    location    => "https://get.docker.io/ubuntu",
    #release     => $::lsbdistcodename,
    release     => 'docker',
    repos       => 'main',
    key         => 'A88D21E9',
    key_server  => 'keyserver.ubuntu.com',
    include_src => false,
  } ->
  package{ 'lxc-docker':
      ensure => latest,
  } ->
  file{ '/usr/local/bin/docker':
    ensure => link,
    target => '/usr/bin/docker.io',
  }

  package{ 'cgroup-bin':
    ensure => latest,
  } ->
  file{ "${mesos::slave::conf_dir}/containerizers":
    content => inline_template('docker,mesos'),
    notify  => Service['mesos-slave'],
  }

  docker::image{ 'libmesos/ubuntu': }

}

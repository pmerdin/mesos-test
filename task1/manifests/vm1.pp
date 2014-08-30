
# a hack to make sure package list is loaded. it can probably be done somehow via apt package, just needs an investigation
exec { "apt-update":
    command => "/usr/bin/apt-get update"
}

Exec['apt-update'] -> Package<| |>

#Class<| title=='mesos::repo' |> {
class { 'mesos::repo':
    source => 'mesosphere',
    before => Exec['apt-update']
}

class{'mesos::master':
  master_port => 5050,
  work_dir => '/var/lib/mesos',
# options => {
#    quorum   => 4
#  },
}


# initialise repos for this test

class pmerdin::repo_init () {
    # a hack to make sure package list is loaded. it can probably be done somehow via apt package, just needs an investigation
    exec { "apt-update":
        command => "/usr/bin/apt-get update"
    }

    Exec['apt-update'] -> Package<| |>

    class { 'mesos::repo':
        source => 'mesosphere',
        before => Exec['apt-update']
    }

}
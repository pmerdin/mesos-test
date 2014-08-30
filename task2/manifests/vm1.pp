include pmerdin::repo_init

class{'mesos::master':
  master_port => 5050,
  work_dir => '/var/lib/mesos',
  listen_address => $::ipaddress_eth1, # listen on the static IP
# options => {
#    quorum   => 4
#  },
}
->
class{ 'marathon':
    install_java => false,
}

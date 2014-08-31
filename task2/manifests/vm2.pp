include pmerdin::repo_init

class{'mesos::slave':
  master => '192.168.1.10',
  listen_address => $::ipaddress_eth1, # listen on the static IP
}

include pmerdin::docker

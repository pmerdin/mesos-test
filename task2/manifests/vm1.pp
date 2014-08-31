include pmerdin::repo_init
include pmerdin::marathon

class{'mesos::master':
  master_port => 5050,
  work_dir => '/var/lib/mesos',
  listen_address => $::ipaddress_eth1, # listen on the static IP
#  zookeeper => 'zk://192.168.1.10:2181/mesos',
# options => {
#    quorum   => 4
#  },
}
->
class{ 'marathon':
    install_java => false,
    #marathon_master => 'zk://192.168.1.10:2181/mesos',
    marathon_master => '192.168.1.10:5050',
    download_url => 'https://codeload.github.com/mesosphere/marathon/tar.gz/master',
    version => 'master',
}


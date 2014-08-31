include pmerdin::repo_init

package{ 'scala': } ->
exec{ 'get sbt':
  command => "/usr/bin/wget -O /tmp/sbt-0.13.5.deb http://dl.bintray.com/sbt/debian/sbt-0.13.5.deb && dpkg -i /tmp/sbt-0.13.5.deb",
  creates => '/usr/bin/sbt',
} ->
exec{ 'compile marathon':
  command => "/usr/bin/sbt assembly && bin/build-distribution",
#  creates => '/opt/marathon/target/scala-2.10/marathon-assembly-0.7.0-SNAPSHOT.jar',
  require => Class['Marathon::Source']
  cwd     => '/opt/marathon',
} -> Service['marathon']


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


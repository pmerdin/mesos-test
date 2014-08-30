# == Class: mesos
#
# This module manages mesos installation
#
# === Examples
#
#      class{ 'mesos::master': }
#  or
#      class{ 'mesos:slave': }
#
#
# === Authors
#
# Tomas Barton <barton.tomas@gmail.com>
#
# === Copyright
#
# Copyright 2013-2014 Tomas Barton
#
class mesos(
  $ensure         = hiera('mesos::version', 'present'),
  $setup_repo     = undef
) {
  # master and slave creates separate logs automatically
  # TODO: currently not used
  $log_dir        = hiera('mesos::log_dir', '/var/log/mesos')
  $conf_dir       = hiera('mesos::conf_dir', '/etc/mesos')
  # e.g. zk://localhost:2181/mesos
  $zookeeper      = hiera('mesos::zookeeper', '')
  # if "zk" is empty, master value is used
  $master         = hiera('mesos::master', '127.0.0.1')
  $master_port    = hiera('mesos::master_port', '5050')
  $owner          = hiera('mesos::owner', 'root')
  $group          = hiera('mesos::group', 'root')
  $listen_address = hiera('mesos::listen_address', $::ipaddress)
  $repo           = hiera('mesos::repo', $setup_repo)

  class {'mesos::install':
    ensure      => $ensure,
    repo_source => $repo,
  }

  class {'mesos::config':
    log_dir   => $log_dir,
    conf_dir  => $conf_dir,
    owner     => $owner,
    group     => $group,
    zookeeper => $zookeeper,
    require   => Class['mesos::install']
  }

}

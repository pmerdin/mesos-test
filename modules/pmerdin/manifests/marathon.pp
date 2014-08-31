# compiles current version of marathon from git ( a bit hacky )
class pmerdin::marathon () {


  package{ 'openjdk-7-jdk': } ->
  package{ 'scala': } ->
  exec{ 'get sbt':
    command => "/usr/bin/wget -O /tmp/sbt-0.13.5.deb http://dl.bintray.com/sbt/debian/sbt-0.13.5.deb && dpkg -i /tmp/sbt-0.13.5.deb",
    creates => '/usr/bin/sbt',
  } ->
  exec{ 'compile marathon':
    command => "/usr/bin/sbt assembly && bin/build-distribution",
    creates => '/opt/marathon/target/scala-2.10/marathon-assembly-0.7.0-SNAPSHOT.jar',
    require => Class['Marathon::Source']
    cwd     => '/opt/marathon',
  } -> Service['marathon']

}
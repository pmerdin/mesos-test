
# initialise repos for this test

class pmerdin::repo_init (
) {
    class { 'mesos::repo':
        source => 'mesosphere',
    }
}
#
# The staging profile is used to set up the staging module. It provides a
# single place to adjust staging class parameters.
#
class profile::staging {
  class {'::staging':
    path  => '/var/staging',
    owner => root,
    group => root,
  }
}

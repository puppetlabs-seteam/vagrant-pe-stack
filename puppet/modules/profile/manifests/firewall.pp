# To use this profile, include something like the following in your site.pp
#
# case $::osfamily {
#   'RedHat', 'Debian': {
#     include profile::firewall
#     Firewall {
#       require => Class['profile::firewall::pre'],
#       before  => Class['profile::firewall::post'],
#     }
#   }
# }
#
# You will then be able to declare firewall rules in other classes and be
# assured proper order configuration of the firewall without ever
# accidentally cutting off connectivity (even temporarily).
#
class profile::firewall {
  include stdlib::stages

  class { '::firewall':                stage => 'setup'  }
  class { '::profile::firewall::pre':  stage => 'setup'  }
  class { '::profile::firewall::post': stage => 'deploy' }

  resources { "firewall":
    purge => true,
  }

}

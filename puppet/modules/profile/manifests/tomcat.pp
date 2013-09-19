class profile::tomcat {

  # Allow specification of a tomcat application server package name and version
  # based on a global variable (e.g. parameter passed in from the ENC)
  $package = $::profile_tomcat_package ? {
    default => $::profile_tomcat_package,
    undef   => undef,
  }
  $version = $::profile_tomcat_version ? {
    default => $::profile_tomcat_version,
    undef   => undef,
  }

  class { '::tomcat':
    package => $package,
    version => $version,
  }

  include tomcat::app::docs
  include tomcat::app::admin

}

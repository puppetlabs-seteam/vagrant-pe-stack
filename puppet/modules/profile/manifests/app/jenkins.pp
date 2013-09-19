class profile::app::jenkins {
  include profile::tomcat
  include profile::staging

  # Allow specification of a Jenkins application package name and version
  # based on a global variable (e.g. parameter passed in from the ENC). Also
  # allow specified ensure.
  $package = $::profile_app_jenkins_package ? {
    default => $::profile_app_jenkins_package,
    undef   => undef,
  }
  $ensure = $::profile_app_jenkins_ensure ? {
    default => $::profile_app_jenkins_ensure,
    undef   => undef,
  }
  $version = $::profile_app_jenkins_version ? {
    default => $::profile_app_jenkins_version,
    undef   => 'latest',
  }
  $version_string = $version ? {
    undef    => '-unspecified',
    'latest' => '-unspecified',
    default  => "-${version}",
  }

  # This directory is used by the Jenkins app, and should exist
  file { "${tomcat::params::user_homedir}/.jenkins":
    ensure => directory,
    owner  => $tomcat::params::user,
    group  => $tomcat::params::group,
    mode   => '0750',
    before => Tomcat::War['jenkins'],
  }

  # The Jenkins app should be deployed
  tomcat::war { 'jenkins':
    ensure  => $ensure,
    warfile => "jenkins${version_string}.war",
    source  => "http://mirrors.jenkins-ci.org/war/${version}/jenkins.war",
  }

}

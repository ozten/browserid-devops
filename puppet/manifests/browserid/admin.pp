class browserid::admin {
    user {
        "browserid":
            ensure  => present,
            comment => "browserid app",
            gid     => "browserid",
            home    => "/home/browserid";
    }

    group {
        "browserid":
            ensure => present;
    }
  package { "expat-devel": ensure => "present" }
  package { "java-1.6.0-openjdk": ensure => "present" }
  package { "rpm-build": ensure => "present" }
  package { "subversion": ensure => "present" }

}
include browserid::admin
group { "browserid":
  ensure => "present",
}

user { "browserid":
  ensure => "present",
  home => "/home/browserid"
}

group { "puppet":
  ensure => "present",
}
File { owner => 0, group => 0, mode => 0644 }

file { "/etc/motd":
  content => "Welcome to your Vagrant-built virtual machine! Managed by Puppet.\n"
}

package { "mysql-server": ensure => "present" }

service { "mysqld":
  ensure => "running",
  enable => true
}

package { "git": ensure => "present" }

package { "wget": ensure => "present" }

file {"/service/browserid/supervise":
  ensure => "directory"
}

package {"gmp": ensure => "present" }

package {"gmp-devel": ensure => "present" }

package {"openssl": ensure => "present" }

package {"openssl-devel": ensure => "present" }

# git clone git://github.com/mozilla/browserid.git

# file {"/service/browserid/run":
#  ensure => "present",
#  source => "puppet:///files/daemontools/browserid/run"
# }

# This still has some errors
# Had to pin jwcrypto to 0.3.1 manually before running
#exec { "browserid node dependencies installed":
#  command => "/usr/bin/npm install",
#  cwd => "/home/browserid/browserid",
#  user => "browserid"
#}
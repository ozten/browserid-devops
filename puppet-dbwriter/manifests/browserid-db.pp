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

package { "mysql-server": ensure => "absent" }

package { "git": ensure => "present" }

package { "wget": ensure => "present" }

package {"gmp": ensure => "present" }

package {"gmp-devel": ensure => "present" }

package {"openssl": ensure => "present" }

package {"openssl-devel": ensure => "present" }

# git clone git://github.com/mozilla/browserid.git

exec { "browserid node dependencies installed":
  command => "/usr/bin/npm install",
  cwd => "/home/browserid/browserid",
  user => "browserid"
}

file {"/service/browserid-dbwriter": ensure => "directory" }

file {"/service/browserid-dbwriter/run":
  ensure => "file",
  source => "/vagrant/puppet-dbwriter/files/daemontools/browserid-dbwriter/run",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-dbwriter/supervise":
  ensure => "directory",
  owner => "root",
  mode => "0755"
}

# no browserid processes, just dbwriter
file {"/service/browserid-browserid": ensure => "absent", force => true }
file {"/service/browserid-example": ensure => "absent", force => true }
file {"/service/browserid-example-primary": ensure => "absent", force => true }
file {"/service/browserid-router": ensure => "absent", force => true }
file {"/service/browserid-verifier": ensure => "absent", force => true }
file {"/service/browserid-proxy": ensure => "absent", force => true }
file {"/service/browserid-static": ensure => "absent", force => true }
file {"/service/browserid-keysigner": ensure => "absent", force => true }

include browserid::webhead
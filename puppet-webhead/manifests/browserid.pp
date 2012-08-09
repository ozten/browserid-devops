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

file {"/service/browserid-browserid": ensure => "directory" }

# TODO puppet:///files/... instead of /vagarnt/files/...
# TODO reduce duplicate code with a define
file {"/service/browserid-browserid/run":
  ensure => "file",
  source => "/vagrant/puppet-webhead/files/daemontools/browserid-browserid/run",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-browserid/supervise":
  ensure => "directory",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-example": ensure => "directory" }

file {"/service/browserid-example/run":
  ensure => "file",
  source => "/vagrant/puppet-webhead/files/daemontools/browserid-example/run",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-example/supervise":
  ensure => "directory",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-keysigner": ensure => "directory" }

file {"/service/browserid-keysigner/run":
  ensure => "file",
  source => "/vagrant/puppet-webhead/files/daemontools/browserid-keysigner/run",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-keysigner/supervise":
  ensure => "directory",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-router": ensure => "directory" }

file {"/service/browserid-router/run":
  ensure => "file",
  source => "/vagrant/puppet-webhead/files/daemontools/browserid-router/run",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-router/supervise":
  ensure => "directory",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-verifier": ensure => "directory" }

file {"/service/browserid-verifier/run":
  ensure => "file",
  source => "/vagrant/puppet-webhead/files/daemontools/browserid-verifier/run",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-verifier/supervise":
  ensure => "directory",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-dbwriter": ensure => "directory" }

file {"/service/browserid-dbwriter/run":
  ensure => "file",
  source => "/vagrant/puppet-webhead/files/daemontools/browserid-dbwriter/run",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-dbwriter/supervise":
  ensure => "directory",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-example-primary": ensure => "directory" }

file {"/service/browserid-example-primary/run":
  ensure => "file",
  source => "/vagrant/puppet-webhead/files/daemontools/browserid-example-primary/run",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-example-primary/supervise":
  ensure => "directory",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-proxy": ensure => "directory" }

file {"/service/browserid-proxy/run":
  ensure => "file",
  source => "/vagrant/puppet-webhead/files/daemontools/browserid-proxy/run",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-proxy/supervise":
  ensure => "directory",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-static": ensure => "directory" }

file {"/service/browserid-static/run":
  ensure => "file",
  source => "/vagrant/puppet-webhead/files/daemontools/browserid-static/run",
  owner => "root",
  mode => "0755"
}

file {"/service/browserid-static/supervise":
  ensure => "directory",
  owner => "root",
  mode => "0755"
}

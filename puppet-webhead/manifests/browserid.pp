#TODO ver.txt was written by hand...

#TODO /etc/hosts
# 192.168.33.11 webhead.intcluster.mozilla.com static.webhead.intcluster.mozilla.com
# 192.168.33.22 swebhead.intcluster.mozilla.com
# 192.168.33.24 keysign.intcluster.mozilla.com

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

# Our VM image is shared, cull
file {"/service/browserid-dbwriter": ensure => "absent", force => true }
file {"/service/browserid-keysigner": ensure => "absent", force => true }

include browserid::webhead

# TODO exec /home/browserid/browserid/scripts/compress
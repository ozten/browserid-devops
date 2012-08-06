group { "puppet":
  ensure => "present",
}
File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine! Managed by Puppet.\n"
}

package { "mysql-server": ensure => "present" }

service { "mysqld":
  ensure => "running",
  enable => true
}

package {'git': ensure => 'present'}

package {'wget': ensure => 'present'}
class browserid::webhead {
    package { 'nginx': ensure => 'present' }
    # TODO /etc/nginx/conf.d doesn't work as idweb.conf is a partial
    # config... Edited idweb.conf to be a standalone file and
    # replacing default.conf with it
    file {'/etc/nginx/conf.d/default.conf':
      ensure => 'present',
      source => ['/vagrant/puppet-webhead/files/etc/nginx/conf.d/idweb.conf.$environment',
                 '/vagrant/puppet-webhead/files/etc/nginx/conf.d/idweb.conf'],
      before => Service["nginx"];
    }
    service {'nginx': ensure => 'running'}
}
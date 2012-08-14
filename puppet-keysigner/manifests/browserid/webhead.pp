# TODO make this a define instead of a class so that source can be keysignerweb.conf
# this file duplicates one under puppet-webhead
class browserid::webhead {
    package { 'nginx': ensure => 'present' }
    # TODO /etc/nginx/conf.d doesn't work as idweb.conf is a partial
    # config... Edited idweb.conf to be a standalone file and
    # replacing default.conf with it
    file {'/etc/nginx/conf.d/default.conf':
      ensure => 'present',
      source => ['/vagrant/puppet-keysigner/files/etc/nginx/conf.d/keysignerweb.conf.$environment',
                 '/vagrant/puppet-keysigner/files/etc/nginx/conf.d/keysignerweb.conf'],
      before => Service["nginx"];
    }
    service {'nginx': ensure => 'running'}
}
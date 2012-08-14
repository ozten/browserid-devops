# TODO make this a define instead of a class so that source can be dbwriterweb.conf
# this file duplicates one under puppet-webhead
class browserid::webhead {
    package { 'nginx': ensure => 'present' }
    # TODO /etc/nginx/conf.d doesn't work as idweb.conf is a partial
    # config... Edited idweb.conf to be a standalone file and
    # replacing default.conf with it
    file {'/etc/nginx/conf.d/default.conf':
      ensure => 'present',
      source => ['/vagrant/puppet-dbwriter/files/etc/nginx/conf.d/dbwriterweb.conf.$environment',
                 '/vagrant/puppet-dbwriter/files/etc/nginx/conf.d/dbwriterweb.conf'],
      before => Service["nginx"];
    }
    service {'nginx': ensure => 'running'}
}
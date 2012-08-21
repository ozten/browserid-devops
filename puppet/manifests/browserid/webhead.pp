class browserid::webhead {
    include browserid::setup

    package { 'nginx': ensure => 'present' }
    # TODO /etc/nginx/conf.d doesn't work as idweb.conf is a partial
    # config... Edited idweb.conf to be a standalone file and
    # replacing default.conf with it
    file {'/etc/nginx/conf.d/default.conf':
      ensure => 'present',
      source => ['/vagrant/puppet/files/etc/nginx/conf.d/idweb.conf.$environment',
                 '/vagrant/puppet/files/etc/nginx/conf.d/idweb.conf'],
      before => Service["nginx"];
    }
    service {'nginx': ensure => 'running'}

    file {
        "/opt/browserid/config/production.json":
            ensure  => file,
            mode    => 0644,
            owner   => "root",
            group   => "root",
            #require => Class["browserid::package"],
            #content => template("browserid/production.json.$environment");
            source => '/vagrant/puppet/files/browserid/config/vagrant.json';
        #"/opt/browserid/config/webhead.json":
        #    ensure  => file,
        #    mode    => 0644,
        #    owner   => "root",
        #    group   => "root",
        #    require => Class["browserid::package"],
        #    content => template("browserid/webhead.json.$environment");
        #"/etc/nginx/conf.d/idweb.conf":
        #    ensure => file,
        #    source => [
    #"puppet:///files/etc/nginx/conf.d/idweb.conf.$environment",
    #"puppet:///files/etc/nginx/conf.d/idweb.conf",
     #       ],
     #       before => Service["nginx"];
        "/var/browserid/browserid_cookie.sekret":
            ensure => file,
            mode   => 0640,
            owner  => "root",
            group  => "browserid",
            #source => "puppet:///modules/browserid/browserid_cookie.sekret.${browserid::setup::bid_env}";
            source => "/vagrant/puppet/secrets/browserid/browserid_cookie.sekret";
        "/var/browserid/root.cert":
            ensure => file,
            mode   => 0644,
            owner  => "root",
            group  => "browserid",
            #source => "puppet:///modules/browserid/root.cert.${browserid::setup::bid_env}";
            source => "/vagrant/puppet/secrets/browserid/root.cert";

        # The private key should only exist on the signers.
        "/var/browserid/root.secretkey":
            ensure => absent;

        # Allow the metrics process to pick up logs.
        #"/opt/bid_metrics/.ssh/authorized_keys":
        #    ensure => file,
        #    mode   => 0600,
        #    owner  => "bid_metrics",
        #    source => "puppet:///modules/browserid/metrics-webhead.authorized_keys";
        #"/opt/bid_metrics/queue":
        #    ensure => directory,
        #    mode   => 0700,
        #    owner  => "bid_metrics";
    }
}
include browserid::webhead
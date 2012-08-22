class browserid::webhead {
    include browserid::setup

    file {"/service/browserid-browserid": ensure => "directory" }

    # TODO puppet:///files/... instead of /vagarnt/files/...
    # TODO reduce duplicate code with a define
    file {"/service/browserid-browserid/run":
      ensure => "file",
      source => "/vagrant/puppet/files/daemontools/browserid-browserid/run",
      owner => "root",
      mode => "0755"
    }

    file {"/service/browserid-browserid/supervise":
      ensure => "directory",
      owner => "root",
      mode => "0755"
    }

    file {"/service/browserid-router": ensure => "directory" }

    file {"/service/browserid-router/run":
      ensure => "file",
      source => "/vagrant/puppet/files/daemontools/browserid-router/run",
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
      source => "/vagrant/puppet/files/daemontools/browserid-verifier/run",
      owner => "root",
      mode => "0755"
    }

    file {"/service/browserid-verifier/supervise":
      ensure => "directory",
      owner => "root",
      mode => "0755"
    }

    file {"/service/browserid-proxy": ensure => "directory" }

    file {"/service/browserid-proxy/run":
      ensure => "file",
      source => "/vagrant/puppet/files/daemontools/browserid-proxy/run",
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
      source => "/vagrant/puppet/files/daemontools/browserid-static/run",
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
    file {"/service/browserid-example": ensure => "absent", force => true }
    file {"/service/browserid-example-primary": ensure => "absent", force => true }

    # TODO exec /opt/browserid/browserid/scripts/compress

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
        # How is log done in real configs?
        "/var/browserid/log/browserid.log":
            ensure => file,
            mode   => 0660,
            owner  => "root",
            group  => "browserid";
        "/var/browserid/log/verifier.log":
            ensure => file,
            mode   => 0660,
            owner  => "root",
            group  => "browserid";
        "/var/browserid/log/static.log":
            ensure => file,
            mode   => 0660,
            owner  => "root",
            group  => "browserid";
        "/var/browserid/log/router.log":
            ensure => file,
            mode   => 0660,
            owner  => "root",
            group  => "browserid";
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
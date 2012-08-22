class browserid::keysigner {
    include browserid::setup

    # TODO puppet:///files/... instead of /vagarnt/files/...
    # TODO reduce duplicate code with a define

    file {"/service/browserid-keysigner": ensure => "directory" }

    file {"/service/browserid-keysigner/run":
      ensure => "file",
      source => "/vagrant/puppet/files/daemontools/browserid-keysigner/run",
      owner => "root",
      mode => "0755"
    }

    file {"/service/browserid-keysigner/supervise":
      ensure => "directory",
      owner => "root",
      mode => "0755"
    }

    file {
        "/var/browserid/log/keysigner.log":
            ensure => file,
            mode   => 0660,
            owner  => "root",
            group  => "browserid";

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
        "/var/browserid/root.secretkey":
            ensure => file,
            mode   => 0640,
            owner  => "root",
            group  => "browserid",
            source => "/vagrant/puppet/secrets/browserid/root.secretkey";
    }


    # no browserid processes, just keysigner
    file {"/service/browserid-browserid": ensure => "absent", force => true }
    file {"/service/browserid-example": ensure => "absent", force => true }
    file {"/service/browserid-dbwriter": ensure => "absent", force => true }
    file {"/service/browserid-router": ensure => "absent", force => true }
    file {"/service/browserid-verifier": ensure => "absent", force => true }
    file {"/service/browserid-example-primary": ensure => "absent", force => true }
    file {"/service/browserid-proxy": ensure => "absent", force => true }
    file {"/service/browserid-static": ensure => "absent", force => true }

    package { 'nginx': ensure => 'present' }
    # TODO /etc/nginx/conf.d doesn't work as idweb.conf is a partial
    file {'/etc/nginx/conf.d/default.conf':
      ensure => 'present',
      source => ['/vagrant/puppet/files/etc/nginx/conf.d/dbwriterweb.conf.$environment',
                 '/vagrant/puppet/files/etc/nginx/conf.d/dbwriterweb.conf'],
      before => Service["nginx"];
    }
    service {'nginx': ensure => 'running'}
}
include browserid::keysigner
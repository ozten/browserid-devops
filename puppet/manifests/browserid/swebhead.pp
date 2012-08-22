class browserid::swebhead {
    include browserid::setup

    file {"/service/browserid-dbwriter": ensure => "directory" }

    file {"/service/browserid-dbwriter/run":
      ensure => "file",
      source => "/vagrant/puppet/files/daemontools/browserid-dbwriter/run",
      owner => "root",
      mode => "0755"
    }

    file {"/service/browserid-dbwriter/supervise":
      ensure => "directory",
      owner => "root",
      mode => "0755"
    }

    # TODO make this a define instead of a class so that source can be dbwriterweb.conf
    # Use same nginx config on keysigner and swebhead (?)

    package { 'nginx': ensure => 'present' }
    # TODO /etc/nginx/conf.d doesn't work as idweb.conf is a partial
    # config... Edited idweb.conf to be a standalone file and
    # replacing default.conf with it
    file {'/etc/nginx/conf.d/default.conf':
      ensure => 'present',
      source => ['/vagrant/puppet/files/etc/nginx/conf.d/dbwriterweb.conf.$environment',
                 '/vagrant/puppet/files/etc/nginx/conf.d/dbwriterweb.conf'],
      before => Service["nginx"];
    }
    service {'nginx': ensure => 'running'}


    file {
        "/var/browserid/log/dbwriter.log":
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

        # The private key should only exist on the signers.
        "/var/browserid/root.secretkey":
            ensure => absent;
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
}

include browserid::swebhead
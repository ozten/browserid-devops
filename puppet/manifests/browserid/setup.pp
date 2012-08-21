class browserid::setup {
    # include browserid::package
    include browserid::user
    # include statsd

    file {
        "/var/log/browserid":
            ensure => "/var/browserid/log",
            force  => true;
        "/var/browserid":
            ensure => directory,
            mode   => 0755,
            owner  => "root",
            group  => "browserid";
        "/var/browserid/log":
            ensure => directory,
            mode   => 0755,
            owner  => "browserid",
            group  => "browserid";
        #"/usr/lib64/nagios/plugins/custom/check_node_memory.sh":
        #    ensure => file,
        #    mode   => 0755,
        #    owner  => "root",
        #    group  => "root",
        #    source => "puppet:///files/usr/lib/nagios/plugins/custom/check_node_memory.sh";
        "/opt/browserid":
            ensure => directory,
            mode   => 0755,
            owner  => "root",
            group  => "root";
        "/opt/browserid/config":
            ensure => directory,
            mode   => 0755,
            owner  => "root",
            group  => "root";
    }


    #TODO /etc/hosts
    # 192.168.33.11 webhead.intcluster.mozilla.com static.webhead.intcluster.mozilla.com
    # 192.168.33.22 swebhead.intcluster.mozilla.com
    # 192.168.33.24 keysign.intcluster.mozilla.com

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
}
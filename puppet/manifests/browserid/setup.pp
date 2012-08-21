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
}
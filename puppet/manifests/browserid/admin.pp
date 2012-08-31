class browserid::admin {
    group {
        "browserid":
            ensure => present;
        "nagcmd":
            ensure => present;
    }

    user {
        "browserid":
            ensure  => present,
            comment => "browserid app",
            gid     => "browserid",
            home    => "/home/browserid";
        "apache":
            ensure => present,
            groups => ["nagcmd"];
        "nagios":
            ensure => present,
            password => "nagios",
            groups => ["nagcmd"];
    }

    package {
        "expat-devel":
            ensure => present;
        "java-1.6.0-openjdk":
            ensure => present;
        "rpm-build":
            ensure => present;
        "subversion":
            ensure => present;
        "gettext":
            ensure => present;
        "httpd":
            ensure => present;
        "php":
            ensure => present;
        "gd":
            ensure => present;
        "gd-devel":
            ensure => present;
    }

    # puppet apply -e '
    # mkdir ~/downloads
    # cd ~/downloads
    # wget http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-3.4.1.tar.gz
    # wget http://prdownloads.sourceforge.net/sourceforge/nagiosplug/nagios-plugins-1.4.16.tar.gz
    # tar xzf nagios-3.4.1.tar.gz
    # cd nagios
    # ./configure --with-command-group=nagcmd
    # make all
    # make install
    # make install-init
    # make install-config
    # make install-commandmode
    # vi /usr/local/nagios/etc/objects/contacts.cfg
    # make install-webconf
    # htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
    ## password set to 'nagios'
    # tar xvf nagios-plugins-1.4.16.tar.gz
    # cd nagios-plugins-1.4.16
    # ./configure --with-nagios-user=nagios --with-nagios-group=nagios
    # make
    # make install
    # chkconfig --add nagios
    # chkconfig nagios on
    # /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
    # service nagios start
}
include browserid::admin
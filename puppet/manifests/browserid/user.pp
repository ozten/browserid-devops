class browserid::user {
    user {
        "browserid":
            ensure  => present,
            comment => "browserid app",
            uid     => 450,
            gid     => "browserid",
            home    => "/opt/browserid";
    }

    group {
        "browserid":
            ensure => present;
    }
}

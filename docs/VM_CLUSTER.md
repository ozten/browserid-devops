= VM Cluster =
VM cluster is a way to run the [Persona](https://github.com/mozilla/browserid)
service in production like configuration.

== Installation ==

The main dependency is a working Vagrant setup. This can be an epic journey, so
check out [these steps](https://id.etherpad.mozilla.org/vagrant-browserid).

== Usage ==

    vagrant up

Will launch a series of VMs.

* 192.168.33.12 test - Selenium, 123done, etc

https://webhead.intcluster.mozilla.com
* 192.168.33.21 router (port 63300) was (10002)
** browserid (port 62700) (was 10007)
** static (https://static.webhead.intcluster.mozilla.com)
** verifier (port 62800) (was 10000)
* 192.168.33.22 dbwriter
* 192.168.33.23 mysql - Database Server, no BrowserID codebase
* 192.168.33.24 keysigner (port 62700) was (10003)

The `test` server will see the `router` as login.vmcluster.mozilla.com.

== Puppet ==

`$environment` is set to `production`

In the future, we should probably have it set to `vmcluster` or something to
keep our manifests managable between `stage`, `vmcluster`, and `production`.
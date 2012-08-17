# VM Cluster #
VM cluster is a way to run the [Persona](https://github.com/mozilla/browserid)
service in production like configuration.

## Installation ##

The main dependency is a working Vagrant setup. This can be an epic journey, so
check out [these steps](https://id.etherpad.mozilla.org/vagrant-browserid).

## Usage ##

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

## Puppet ##

`$environment` is set to `production`

In the future, we should probably have it set to `intcluster` or something to
keep our manifests managable between `stage`, `intcluster`, and `production`.

## Testing ##
### Email ###

Currently intcluster **does not** send email. It runs with
`BROWSERID_FAKE_VERIFICATION` turned on.

How to verify a user...
* Go through normal signup flow (we'll use foo@bar.com)
* https://webhead.intcluster.mozilla.com/fake_verification?email#foo@bar.com
* Copy token, way we got gEFXJoL8FxytQvFlnWSNbuteDesNlPfDWs9QWI151QcStP5E
* https://webhead.intcluster.mozilla.com/verify_email_address?token#gEFXJoL8FxytQvFlnWSNbuteDesNlPfDWs9QWI151QcStP5E

## Limitations ##

The following subsystems are absent from the intcluster:

* Zeus Load Balancer
* Watchmouse
* RSBAC
* logstash
* Nagios
* Pencil
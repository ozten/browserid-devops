# browserid-devops #

Temporary repo for hacking on vagrant, puppet, selenium, etc.

# Status #
A vagrant box with locally running copy of browserid on http://localhost:10001

# Howto #
Setup ruby, gems, vagrant

    vagrant up

Now you can go to http://localhost:10001/ and click 'Get an assertion'.

BrowserID services are managed by daemontools...

If you need to restart a service, you can do

    vagrant ssh
    # restart all services
    sudo svc -t /service/browserid-*
    # restart a service
    sudo svc -t /service/browserid-verifier

If you want to tail the logs:

    vagarnt ssh
    sudo su browserid
    cd /home/browserid/browserid
    tail -f var/log/*.log

# Vagrant Tips #

`vagrant up` and `vagrant ssh` are very useful, here are some others...

## Test puppet or Vagrantfile changes ##

    vagrant reload

## shutdown ##

    vagrant halt

## Cut a new VM base image for others ##

In the VM
    sudo rm /etc/udev/rules.d/70-persistent-net.rules

Outside the VM

    vagrant package --output browserid-scilinux-base0.box
    scp  browserid-scilinux-base0.box me@somewhere.han.dy:boxen/
    emacs Vagrantfile
    # update both config.vm.box and config.vm.box_url

## Put a VM to sleep ##

    vagrant suspend

## start with a fresh VM ##

    vagrant destroy
    vagrant up

# Daemontools Tips

You can detect a service keeps restarting and is hozed by

    sudo /command/svstat  /service/browserid-*
    # look at how long various services have been running to spot an issue

Last known error message from daemontools

    ps aux | grep readproctitle

# Limitations #

Due to issues with dev this morning, this image has a broken /wsapi/cert_key
But you should be able to exercise other aspects of the dialog and example RP / Primary

Some aspects are "baked" into the VM intead of being puppetized

* daemontools
* nodejs
* browserid checkout
* starting/stopping browserid
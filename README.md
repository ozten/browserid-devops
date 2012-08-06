# browserid-devops #

Temporary repo for hacking on vagrant, puppet, selenium, etc.

# Status #
A vagrant box with locally running copy of browserid on http://localhost:10001

# Howto #
Setup ruby, gems, vagrant

    vagrant up
    vagrant ssh
    sudo su browserid
    cd /home/browserid/browserid
    HOST=localhost IP_ADDRESS=0.0.0.0 PUBLIC_URL=http://localhost:10001 npm start

# Vagrant Tips #

`vagrant up` and `vagrant ssh` are very useful, here are some others...

## Test puppet or Vagrantfile changes ##

    vagrant reload

## shutdown ##

    vagrant halt

## Cut a new VM base image for others ##

    vagrant package --output browserid-scilinux-base0.box
    scp  browserid-scilinux-base0.box me@somewhere.han.dy:boxen/
    emacs Vagrantfile
    # update both config.vm.box and config.vm.box_url

## Put a VM to sleep ##

    vagrant suspend

## start with a fresh VM ##

    vagrant destroy
    vagrant up



# Limitations #

Some aspects are "baked" into the VM intead of being puppetized

* daemontools
* nodejs
* browserid checkout
* starting/stopping browserid
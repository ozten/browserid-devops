# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  config.vm.define :webhead do |web_config|
    web_config.vm.box = "browserid-scilinux-web2"
    web_config.vm.box_url = "http://ozten.com/random/identity/devops/browserid-scilinux-base2.box"

    # Based on
    # config.vm.box_url = "http://download.frameos.org/sl6-64-chefclient-0.10.box"

    # Troubleshooting? use the GUI
    web_config.vm.boot_mode = :gui

    web_config.vm.network :hostonly, "192.168.33.11"

    web_config.vm.forward_port 10000, 10000

    # Example RP
    web_config.vm.forward_port 10001, 10001
    web_config.vm.forward_port 10002, 10002

    # Keysigner
    web_config.vm.forward_port 10003, 10003

    # Example IdP
    web_config.vm.forward_port 10005, 10005
    web_config.vm.forward_port 10006, 10006
    web_config.vm.forward_port 10007, 10007
    web_config.vm.forward_port 10010, 10010

    web_config.vm.share_folder "v-puppet", "/etc/puppet", "puppet"

    web_config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file  = "browserid.pp"
    end
  end

  config.vm.define :dbwriter do |db_config|
    db_config.vm.box = "browserid-scilinux-db2"
    db_config.vm.box_url = "http://ozten.com/random/identity/devops/browserid-scilinux-base2.box"

    db_config.vm.network :hostonly, "192.168.33.22"
    db_config.vm.boot_mode = :gui

    # DB Writer
    db_config.vm.forward_port 10004, 10004

    db_config.vm.share_folder "v-puppet", "/etc/puppet", "db_puppet"

    db_config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "db_puppet/manifests"
     puppet.manifest_file  = "browserid-db.pp"
    end
  end
end
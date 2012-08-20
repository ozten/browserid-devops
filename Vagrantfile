# -*- mode: ruby -*-
# vi: set ft=ruby :

##
## Set up
##
## 1. Nginx + Router + main read API (webhead)
## 2. write API (dbwriter)
## 3. keysigner/certifier (certifier)
## 4. database (mysql)

Vagrant::Config.run do |config|

  # selenium VM is an ubuntu GUI box with firefox installed
  # it installs jenkins, 123done (for a local RP), and browserid (for
  # the selenium tests inside the browserid repo).
  config.vm.define :selenium do |sel|
    sel.vm.host_name = "selenium.intcluster.mozilla.com"
    sel.vm.box = "browserid-scilinux-selenium3.box"
    sel.vm.box_url = "http://ozten.com/random/identity/devops/browserid-scilinux-selenium3.box"
    sel.vm.boot_mode = :gui
    sel.vm.network :hostonly, "192.168.33.13"
    # shell script handles provisioning details
    # TODO /etc/hosts hack
    sel.vm.provision :shell, :inline => '/vagrant/selenium/selenium-VM-install.sh 1> selenium-VM-install.log'
  end



  # webhead runs router and main browserid process in read mode only
  config.vm.define :webhead do |web_config|
    web_config.vm.host_name = "webhead.intcluster.mozilla.com"
    web_config.vm.box = "browserid-scilinux-webhead3.box"
    web_config.vm.box_url = "http://ozten.com/random/identity/devops/browserid-scilinux-webhead3.box"

    # Based on
    # config.vm.box_url = "http://download.frameos.org/sl6-64-chefclient-0.10.box"

    # Troubleshooting? use the GUI
    # web_config.vm.boot_mode = :gui

    web_config.vm.network :hostonly, "192.168.33.11"

    web_config.vm.share_folder "v-puppet", "/etc/puppet", "puppet-webhead"

    web_config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet-webhead/manifests"
     puppet.manifest_file  = "browserid.pp"
    end
  end

  config.vm.define :keysigner do |ks_config|
    ks_config.vm.host_name = "keysign.intcluster.mozilla.com"
    ks_config.vm.box = "browserid-scilinux-keysigner3.box"
    ks_config.vm.box_url = "http://ozten.com/random/identity/devops/browserid-scilinux-keysigner3.box"

    ks_config.vm.network :hostonly, "192.168.33.24"
    # ks_config.vm.boot_mode = :gui

    ks_config.vm.share_folder "v-puppet", "/etc/puppet", "puppet-keysigner"

    ks_config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet-keysigner/manifests"
     puppet.manifest_file  = "browserid-keysigner.pp"
    end
  end

  # aka Secure Webhead
  config.vm.define :swebhead do |db_config|
    db_config.vm.host_name = "swebhead.intcluster.mozilla.com"
    db_config.vm.box = "browserid-scilinux-swebhead3.box"
    db_config.vm.box_url = "http://ozten.com/random/identity/devops/browserid-scilinux-swebhead3.box"

    db_config.vm.network :hostonly, "192.168.33.22"
    # db_config.vm.boot_mode = :gui

    # DB Writer
    db_config.vm.forward_port 10004, 10004

    db_config.vm.share_folder "v-puppet", "/etc/puppet", "puppet-dbwriter"

    db_config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet-dbwriter/manifests"
     puppet.manifest_file  = "browserid-db.pp"
    end
  end

  # Represents the DB master
  config.vm.define :mysql do |db_config|
    db_config.vm.host_name = "mysql.intcluster.mozilla.com"
    db_config.vm.box = "browserid-scilinux-mysql4.box"
    db_config.vm.box_url = "http://ozten.com/random/identity/devops/browserid-scilinux-mysql4.box"

    db_config.vm.network :hostonly, "192.168.33.33"

    db_config.vm.share_folder "v-puppet", "/etc/puppet", "puppet-mysql"

    db_config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet-mysql/manifests"
     puppet.manifest_file  = "browserid-mysql.pp"
    end
  end
end

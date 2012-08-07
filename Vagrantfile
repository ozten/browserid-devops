# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "browserid-scilinux-base1"
  config.vm.box_url = "http://ozten.com/random/identity/devops/browserid-scilinux-base1.box"

  # Based on
  # config.vm.box_url = "http://download.frameos.org/sl6-64-chefclient-0.10.box"

  # Troubleshooting? use the GUI
  # config.vm.boot_mode = :gui

  config.vm.network :hostonly, "192.168.33.11"

  config.vm.forward_port 10000, 10000
  config.vm.forward_port 10001, 10001
  config.vm.forward_port 10002, 10002
  config.vm.forward_port 10003, 10003
  config.vm.forward_port 10004, 10004
  config.vm.forward_port 10005, 10005
  config.vm.forward_port 10006, 10006
  config.vm.forward_port 10007, 10007
  config.vm.forward_port 10010, 10010


  config.vm.share_folder "v-puppet", "/etc/puppet", "puppet"

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file  = "browserid.pp"
  end
end

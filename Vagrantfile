# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "myscilinux"

  config.vm.box_url = "http://download.frameos.org/sl6-64-chefclient-0.10.box"

  # config.vm.boot_mode = :gui

  # config.vm.network :hostonly, "192.168.33.11"

  # config.vm.forward_port 80, 8080

  config.vm.share_folder "v-puppet", "/etc/puppet", "puppet"

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file myscilinux.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  #
  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file  = "browserid.pp"
  end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # IF you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end

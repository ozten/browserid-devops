# we could offload this to a yaml file like kuma or mozillians do it;
# hard-coding for now. the port forwarding may be particularly wrong.

Vagrant::Config.run do |config|
    # defaults for all VMs
    config.vm.box = "scilinux"
    config.vm.box_url = "http://dl.dropbox.com/u/95681659/scilinux.box"

    config.vm.define :web do |web_config|
        web_config.vm.provision :puppet, :module_path => "bid_modules/web"
        web_config.vm.forward_port 80, 8080
        web_config.vm.host_name = "web1.dev"
        web_config.vm.network :hostonly, "10.10.10.110"
    end

    config.vm.define :db do |db_config|
        db_config.vm.provision :puppet, :module_path => "bid_modules/db"
        db_config.vm.forward_port 3306, 3306
        db_config.vm.host_name = "db1.dev"
        db_config.vm.network :hostonly, "10.10.10.120"
    end

    config.vm.define :dbwriter do |dbw_config|
        dbw_config.vm.provision :puppet, :module_path => "bid_modules/dbwriter"
        dbw_config.vm.host_name = "dbwriter1.dev"
        dbw_config.vm.network :hostonly, "10.10.10.115"
    end

    config.vm.define :keysigner do |key_config|
        key_config.vm.provision :puppet, :module_path => "bid_modules/keysigner"
        key_config.vm.host_name = "keysigner1.dev"
        key_config.vm.network :hostonly, "10.10.10.115"
    end
end

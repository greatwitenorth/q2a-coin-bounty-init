# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 443, host: 8080
  config.vm.synced_folder "./", "/var/www"
  config.vm.provision "shell", path: "init.sh"

  config.vm.provider "virtualbox" do |vb|

    # You'll probably want at least 2GB memory so compiling bitcoind doesn't fail
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    #vb.cpus = 2
  end

end
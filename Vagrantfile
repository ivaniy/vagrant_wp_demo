# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  #config.ssh.insert_key = true  # it's  default walue  Vagrant will automatically insert a keypair to use for SSH, replacing Vagrant's default insecure key

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 1024
    vb.cpus = 2
  end

  config.vm.define "nginx" do |nginx|
    nginx.vm.provision "file", source: "./wrdprs.conf", destination: "$HOME/"
    nginx.vm.provision "shell", path: "nginx_cfg.sh", privileged: false
    nginx.vm.synced_folder "./wrdprs.loc", "/var/www/wrdprs.loc", :mount_options => ["dmode=777", "fmode=666"]
    nginx.vm.network "private_network", ip: "192.168.56.10"
    nginx.hostmanager.aliases = %w(wrdprs.loc)
  end
  
  config.vm.define "php_fpm" do |php_fpm|
    php_fpm.vm.provision "shell", path: "php_cfg.sh"
    php_fpm.vm.synced_folder "./wrdprs.loc", "/var/www/wrdprs.loc", :mount_options => ["dmode=777", "fmode=666"]
    php_fpm.vm.network "private_network", ip: "192.168.56.30"
  end   
  
  config.vm.define "mysql" do |mysql|
    # Adding vagrant generated private key for ssh access to php from mysql 
    mysql.vm.provision "file", source: ".vagrant/machines/php_fpm/virtualbox/private_key", destination: "~/.ssh/id_rsa"
    mysql.vm.provision "shell", path: "mysql_cfg.sh"
    mysql.vm.network "private_network", ip: "192.168.56.20"
  end
  


  # config.vm.box_check_update = false
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"


  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end

  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end

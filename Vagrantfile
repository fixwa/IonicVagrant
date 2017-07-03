# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "IonicVagrant"

  config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.network "forwarded_port", guest: 8100, host: 8100
  config.vm.network "forwarded_port", guest: 35729, host: 35729

  config.vm.synced_folder "ionic-projects/", "/ionic-projects", create: true
    config.vm.provider "virtualbox" do |vb|
      vb.name = "IonicVagrant"
      vb.gui = false
      vb.customize ["modifyvm", :id, "--usb", "on"]
      #vb.customize ["usbfilter", "add", "0", "--target", :id, "1197123b", "--vendorid", "0x04e8"]
      vb.customize ["usbfilter", "add", "0", "--target", :id, "--name", "android", "--vendorid", "0x18d1"]
    end
end
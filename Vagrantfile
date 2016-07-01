# -*- mode: ruby -*-
# vi: set ft=ruby :

vagrant_root = File.dirname(__FILE__)
project_name = "ansible-playground"

Vagrant.configure(2) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty64"
    config.vm.provider "virtualbox" do |vb|
        vb.memory = "1028"
        vb.cpus = "1"
        vb.gui = false
    end

    config.vm.define "#{project_name}" do |machine|
        machine.vm.hostname = "#{project_name}"
        machine.vm.synced_folder "#{vagrant_root}/shared", "/home/vagrant/shared"
        machine.vm.provision :shell, :path => "#{vagrant_root}/provision/ansible-setup.sh"
    end
end

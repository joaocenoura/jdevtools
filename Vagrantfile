# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?("vagrant-timezone")
    config.timezone.value = "Europe/Lisbon"
  end
  config.vm.box = "chef/debian-7.8"

  # port forwarding gitlab
  config.vm.network "forwarded_port", guest: 80, host: 9870
  config.vm.network "forwarded_port", guest: 8081, host: 9871
  config.vm.network "forwarded_port", guest: 9000, host: 9872
  config.vm.network "private_network", ip: "192.168.33.100"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end
 
  config.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioning/playbook.yml"
      ansible.tags = "install"
  end
end

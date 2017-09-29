# Defines our Vagrant environment
#
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  # create load balancer
  config.vm.define :haproxy do |haproxy_config|
      haproxy_config.vm.box = "ubuntu/trusty64"
      haproxy_config.vm.hostname = "haproxy"
      haproxy_config.vm.network :private_network, ip: "10.0.16.30"
      haproxy_config.vm.provider "vitualbox" do |vb|
        vb.memory = "256"
      end
  end

  # create mesosMaster node

  # create some mesosMaster servers
  # https://docs.vagrantup.com/v2/vagrantfile/tips.html
  (1..3).each do |i|
    config.vm.define "mesosMaster#{i}" do |node|
        node.vm.box = "ubuntu/trusty64"
        node.vm.hostname = "mesosMaster#{i}"
        node.vm.network :private_network, ip: "10.0.16.1#{i}"
        node.vm.provider "vitualbox" do |vb|
          vb.memory = "256"
        end
    end
  end


  # create some mesosClient servers
  # https://docs.vagrantup.com/v2/vagrantfile/tips.html
  (1..3).each do |i|
    config.vm.define "mesosClient#{i}" do |node|
        node.vm.box = "ubuntu/trusty64"
        node.vm.hostname = "mesosClient#{i}"
        node.vm.network :private_network, ip: "10.0.16.2#{i}"
        node.vm.provider "vitualbox" do |vb|
          vb.memory = "256"
        end
    end
  end

# # creating ansible host
# config.vm.define :ansible do |ansible_config|
#      ansible_config.vm.box = "ubuntu/trusty64"
#      ansible_config.vm.hostname = "ansible"
#      ansible_config.vm.network :private_network, ip: "10.0.16.10"
#      ansible_config.vm.provider "vitualbox" do |vb|
#        vb.memory = "256"
#      end
#      ansible_config.vm.provision :shell, path: "bootstrap-ansible.sh"
#  end

end

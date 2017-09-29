#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible
apt-get -y install fping

# Creating pki and pushing the keys to new hosts.
ssh-keygen -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""
ssh-keyscan ansible haproxy mesosMaster1 mesosMaster2 mesosMaster3 mesosClient1 mesosClient2 mesosClient3  >> /home/vagrant/.ssh/known_hosts
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant


# configure hosts file for our internal network defined by Vagrantfile
cat >> /etc/hosts <<EOF
# vagrant environment nodes
10.0.16.10  ansible
10.0.16.11  mesosMaster1
10.0.16.12  mesosMaster2
10.0.16.13  mesosMaster3
10.0.16.30  haproxy
10.0.16.21  mesosClient1
10.0.16.22  mesosClient2
10.0.16.23  mesosClient3
EOF

#Creating ansible config in the vagrant home directory
cat >> /home/vagrant/ansible.cfg <<EOF
[defaults]
hostfile = /home/vagrant/inventory.ini
EOF
chown vagrant:vagrant /home/vagrant/ansible.cfg

#Creating ansible inventory fine in the vagrant home directory
cat >> /home/vagrant/inventory.ini <<EOF
[ansible]
ansible

[mesosMaster]
mesosMaster1
mesosMaster2
mesosMaster3

[haproxy]
haproxy

[mesosClient]
mesosClient1
mesosClient2
mesosClient3
EOF

chown vagrant:vagrant /home/vagrant/inventory.ini

# Creating ssh-addkey.yml file, so that we can push the key to rest of the hosts.
cat >> /home/vagrant/ssh-addkey.yml << EOF
---
- hosts: all
  sudo: yes
  gather_facts: no
  remote_user: vagrant

  tasks:

  - name: install ssh key
    authorized_key: user=vagrant 
                    key="{{ lookup('file', '/home/vagrant/.ssh/id_rsa.pub') }}" 
                    state=present
EOF

chown vagrant:vagrant /home/vagrant/ssh-addkey.yml

# run the following ansible yml as vagrant user
# sudo su vagrant -c ansible-playbook /home/vagrant/ssh-addkey.yml --ask-pass 

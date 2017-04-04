ssh-keygen -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""
ssh-keyscan localhost >> /home/vagrant/.ssh/known_hosts
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chown vagrant:vagrant /home/vagrant/.ssh/known_hosts /home/vagrant/.ssh/id_rsa.pub /home/vagrant/.ssh/id_rsa /home/vagrant/.ssh/authorized_keys

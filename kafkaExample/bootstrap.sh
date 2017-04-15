ssh-keygen -t rsa -f /home/ubuntu/.ssh/id_rsa -q -N ""
ssh-keyscan localhost >> /home/ubuntu/.ssh/known_hosts
cat /home/ubuntu/.ssh/id_rsa.pub >> /home/ubuntu/.ssh/authorized_keys
chown ubuntu:ubuntu /home/ubuntu/.ssh/known_hosts /home/ubuntu/.ssh/id_rsa.pub /home/ubuntu/.ssh/id_rsa /home/ubuntu/.ssh/authorized_keys

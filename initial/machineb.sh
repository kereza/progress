#! /bin/bash

sudo apt-get update -y
sudo useradd -m jenkins
mkdir /home/jenkins/.ssh/
cp -ar /vagrant/.ssh/authorized_keys /home/jenkins/.ssh/
sudo chown jenkins:jenkins /home/jenkins -R
chmod 600 /home/jenkins/.ssh/authorized_keys
#adding the user jenkins and using the vagrant shared directory to copy the SSH keys for that user.

sudo echo "jenkins ALL = NOPASSWD: ALL" >> /etc/sudoers
#Giving the jenkins user full sudo privileges without password (not good for security, but for this task it will do)
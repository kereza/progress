#! /bin/bash

sudo cat /vagrant/initial/repo.txt >> /etc/apt/sources.list 
sudo apt-get update -y
#adding additional repositories so we can install an older version of Jenkins on Ubuntu 14.04

sudo apt-get install ansible -y 
sudo echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
# disable strict host check when accessing via SSH so we do not get prompted for Yes/No to add the server to known_hosts

sudo rm -rf /etc/ansible
sudo cp -ar /vagrant/ansible /etc/
#using the vagrant shared directory to copy predefined ansible configurations

cd /etc/ansible
sudo chmod 644 *
sudo ln -sf /usr/bin/ruby1.9.1 /usr/bin/ruby
#if this symlink is not created I receive some ruby error

sudo rm -rf /home/vagrant/.ssh
sudo cp -ar /vagrant/.ssh /home/vagrant
sudo chown vagrant:vagrant /home/vagrant -R
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/id_dsa
chmod 644 /home/vagrant/.ssh/id_dsa.pub
#Using the vagrant shared directory to copy ssh keys for easy access. 
#This way ansible can be run with the vagrant user with sudo privileges to insall Jenkins

sudo -H -u vagrant bash -c 'ansible-playbook /etc/ansible/jenkins.yml'
#

rm -rf /var/lib/jenkins/.ssh
cp -ar /vagrant/.ssh /var/lib/jenkins
sudo chown jenkins:jenkins /var/lib/jenkins/.ssh -R
chmod 700 /var/lib/jenkins/.ssh
chmod 600 /var/lib/jenkins/.ssh/authorized_keys
chmod 600 /var/lib/jenkins/.ssh/id_dsa
chmod 644 /var/lib/jenkins/.ssh/id_dsa.pub
#Using the vagrant shared directory to copy ssh keys for the jenkins user. 
#This way the jenkins user can easily communicate with other machines for executing remote jobs.
 
sudo cp -ar /vagrant/jenkinsjobs/ssh /var/lib/jenkins/jobs
sudo chown jenkins:jenkins /var/lib/jenkins/jobs -R
sudo chmod 755 /var/lib/jenkins/jobs/ssh
#Using the vagrant shared directory to copy and already created Jenkins job. 

sudo echo "jenkins ALL = NOPASSWD: ALL" >> /etc/sudoers
#Giving the jenkins user full sudo privileges without password (not good for security, but for this task it will do)

sudo service jenkins restart
# Restarting the jenkins service so it can pick up the newly copied job. 

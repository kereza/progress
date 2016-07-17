# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
	config.vm.box = "ubuntu64-AA"	
	 
	 config.vm.box_url = "https://atlas.hashicorp.com/ubuntu/boxes/trusty64/versions/20160708.1.2/providers/virtualbox.box"
	 #Uncomment the below line if the box will be download and used locally
	 #config.vm.box_url = "C:\\cygwin\\home\\ikerezov\\precise\\ubuntu-14.04.3-x86_64-20151128-virtualbox.box"

	
		config.vm.define "machineA" do |a|
			a.vm.hostname = "machineA"
			a.vm.box = "MachineA"
			a.vm.network "public_network", ip: "192.168.0.105"
			a.vm.provision :shell, path: "\initial\\machinea.sh", privileged: true
			a.vbguest.auto_update = false
			a.vm.provider "virtualbox" do |v|
				v.memory = 512
				v.cpus = 2
			end
		end
		
		
	config.vm.define "machineB" do |b|
			b.vm.hostname = "machineB"
			b.vm.box = "MachineB"
			b.vm.network "public_network", ip: "192.168.0.106"
			b.vm.provision :shell, path: "\initial\\machineb.sh", privileged: true
			b.vbguest.auto_update = false
			b.vm.provider "virtualbox" do |n|
				n.memory = 512
				n.cpus = 2
			end
			
	end	
end


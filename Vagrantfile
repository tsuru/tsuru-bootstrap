# vi: set ft=ruby :

Vagrant.configure("2") do |config|
   config.vm.box = "puppetprecise64"
   config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box"
   config.vm.network :private_network, ip: "192.168.50.4"
#   config.vm.network :forwarded_port, guest: 80, host: 8080
   config.vm.hostname = "tsuru.lan"
end

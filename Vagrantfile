# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu14.04"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.network :private_network, ip: "192.168.50.4"
  config.vm.provision :shell, :path => "install.sh"

  config.vm.provider :virtualbox do |vbox|
    vbox.memory = 1024
  end
end

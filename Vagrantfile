# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provision :shell do |shell|
    shell.path = "install.sh"
    shell.args = [
      ENV["TSURU_BOOTSTRAP"] || "stable",
      ENV["TSURU_NOW_SCRIPT_URL"] || "https://raw.githubusercontent.com/tsuru/now/master/run.bash",
      ENV["TSURU_NOW_HOOK_URL"] || "https://raw.githubusercontent.com/tsuru/tsuru/master/misc/git-hooks/pre-receive.archive-server",
      ENV["TSURU_NOW_OPTIONS"] || "",
    ]
  end

  config.vm.provider :vmware_fusion do |vbox, override|
    vbox.memory = 1024
    override.vm.box = "phusion/ubuntu-14.04-amd64"
#    override.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
#    override.vm.network :private_network, ip: "192.168.50.4"
  end

  config.vm.provider :virtualbox do |vbox, override|
    vbox.memory = 1024
    override.vm.box = "ubuntu14.04"
    override.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
    override.vm.network :private_network, ip: "192.168.50.4"
  end

  config.vm.provider :kvm do |kvm, override|
    kvm.memory_size = 1024
    override.vm.box = "trusty64"
    override.vm.box_url = "https://vagrant-kvm-boxes-si.s3.amazonaws.com/trusty64-kvm-20140418.box"
    override.vm.network :private_network, ip: "192.168.50.4"
  end

  config.vm.provider :parallels do |prl, override|
    prl.memory = 1024
    override.vm.box = "parallels/ubuntu-14.04"
    override.vm.network :private_network, ip: "192.168.50.4"
  end

  config.vm.provider :aws do |aws, override|
    override.vm.box = "dummy"
    override.vm.box_url = "https://raw.githubusercontent.com/mitchellh/vagrant-aws/master/dummy.box"
    override.nfs.functional = false

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = ENV["AWS_PRIVATE_KEY_PATH"]

    aws.access_key_id = ENV["AWS_ACCESS_KEY_ID"]
    aws.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
    aws.keypair_name = ENV["AWS_KEYPAIR_NAME"]
    aws.ami = ENV["AWS_AMI"]
    aws.region = ENV["AWS_REGION"]
    aws.block_device_mapping = [{ 'DeviceName' => '/dev/sda1', 'Ebs.VolumeSize' => 50 }]
    aws.instance_ready_timeout = 300
    aws.terminate_on_shutdown = true
    aws.tags = {
      "Name" => "tsuru_bootstrap",
    }
  end
end

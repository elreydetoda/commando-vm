# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.guest = :windows
  config.vm.communicator = "winrm"
  config.vm.boot_timeout = 300
  config.vm.network "forwarded_port", guest: 3389, host: 3389, auto_correct: true, host_ip: "127.0.0.1"
  # thank you https://github.com/hashicorp/vagrant/issues/6430#issuecomment-184097261
  config.winrm.retry_limit = 30
  config.winrm.retry_delay = 10

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
  end

  config.vm.provider 'hyperv' do |hv|
    hv.ip_address_timeout = 240
    hv.memory = 1024
  end

  config.vm.provider :libvirt do |domain|
    domain.memory = 2028
    domain.cpus = 2
  end
end

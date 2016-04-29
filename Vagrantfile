# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

servers = [
#  {
#    "id" => "h2",
#    "memory" => 4 * 1024,
#    "cpu" => 4,
#    "ipaddr" => ["192.168.33.12", "192.168.33.121", "192.168.33.122", "192.168.33.123"]
#  },
  {
    "id" => "h3",
    "memory" => 4 * 1024,
    "cpu" => 4,
    "ipaddr" => ["192.168.33.13", "192.168.33.131", "192.168.33.132", "192.168.33.133"]
  },
  {
    "id" => "h1",
    "memory" => 4 * 1024,
    "cpu" => 4,
    "ipaddr" => ["192.168.33.11", "192.168.33.111", "192.168.33.112", "192.168.33.113"]
  }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "bento/ubuntu-14.04"
  #config.vm.box = "bento/ubuntu-15.04"

  servers.each do |server|
    config.vm.define server["id"].to_sym do |s|
      server["ipaddr"].each do |ipaddr|
        s.vm.network :private_network, ip: ipaddr
      end  
    end
    config.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", server["memory"], "--cpus", server["cpu"]]
    end
  end

  #config.ssh.insert_key = false
  #config.vm.provision "ansible" do |ansible|
  #  ansible.verbose = "v"
  #  ansible.playbook = "playbook.yaml"
  #  ansible.inventory_path = "hosts"
  #  ansible.limit = "all"
  #end
end

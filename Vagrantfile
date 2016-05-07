# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

CPU_NUM = 4
MEM_SIZE = 2 * 1024
PORT_NUM = 4  # for dpdk pmd.

servers = [
#  {
#    "id" => "h2",
#    "memory" => MEM_SIZE,
#    "cpu" => CPU_NUM,
#    "nic" => {
#               "ipaddr" => "192.168.33.12",
#               "port_num" => PORT_NUM,
#               "port_ipaddrs" => []
#             }
#  },
  {
    "id" => "h3",
    "memory" => MEM_SIZE,
    "cpu" => CPU_NUM,
    "nic" => {
      "ipaddr" => "192.168.33.13",
      "port_num" => PORT_NUM,
      "port_ipaddrs" => []
    }
  },
  {
    "id" => "h1",
    "memory" => MEM_SIZE,
    "cpu" => CPU_NUM,
    "nic" => {
      "ipaddr" => "192.168.33.11",
      "port_num" => PORT_NUM,
      "port_ipaddrs" => []
    }
  }
]

# Assign random IP address to ports.
reserved_ipaddrs = []  # Used for checking conflict.
servers.each do |s|
  reserved_ipaddrs << s["nic"]["ipaddr"]
end

servers.each do |s|
  s["nic"]["port_num"].times do
    # Random IP is decided by using 1 ~ 3 bytes of server's IP.
    tmp = s["nic"]["ipaddr"].split(".")
    tmp.pop
    base = tmp.join(".")
  
    flg = false
    while flg == false
      tmp = rand(253) + 2  # Generate 4th byte ranging from 2 to 254.
      tmp = base + "." + tmp.to_s
      if !(reserved_ipaddrs.include? tmp)
        reserved_ipaddrs << tmp
        s["nic"]["port_ipaddrs"] << tmp
        flg = true
      end
    end
  end
end


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "bento/ubuntu-14.04"
  #config.vm.box = "bento/ubuntu-15.04"

  servers.each do |server|
    config.vm.define server["id"].to_sym do |s|
      s.vm.network :private_network, ip: server["nic"]["ipaddr"]
      server["nic"]["port_ipaddrs"].each do |ipaddr|
        s.vm.network :private_network, ip: ipaddr
      end  
    end

    config.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", server["memory"], "--cpus", server["cpu"]]
    end
  end
end

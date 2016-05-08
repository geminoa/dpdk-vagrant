## DPDK and pktgen with Vagrant

This program setup DPDK 16.04 and pktge-dpdk 3.0.00 on virtual machines of Ubuntu 14.04.

### 1. Installation

##### VirtualBox
Download VirtualBox 5.0 from [here](https://www.virtualbox.org/). I only tested version 5.0.20 but it might work >= 5.0.

##### vagrant
Download vagrant 1.7.4 from [here](https://www.vagrantup.com/). The latest version is 1.8.1 at the time I'm writing this document but I don't still test it.

##### Virtual machine
Get vagrant box `bento/ubuntu-14.04` as following.

```
$ vagrant box add bento/ubuntu-14.04
==> box: Loading metadata for box 'bento/ubuntu-14.04'
    box: URL: https://atlas.hashicorp.com/bento/ubuntu-14.04
This box can work with multiple providers! The providers that it
can work with are listed below. Please review the list and choose
the provider you will be working with.

1) parallels
2) virtualbox
3) vmware_desktop

Enter your choice: 2
```

##### ansible
Install ansible  >= 2.0 by following this [instruction](http://docs.ansible.com/ansible/intro_installation.html#installation).
I only tested version 2.0.1.0 but it might work.

##### DPDK 16.04
Installed by running script.

##### pktgen-dpdk 3.0.00
Installed by running script.

### 2. How to use

1. Create VMs. 2 VMs with 4 CPUs and 4096[MB] memory by default. You can change this setting by editing `Vagrantfile`.
```
$ vagrant up
```

2. Run ansible-playbook.
```
$ ansible-playbook -i hosts site.yml
```
or use rake if you installed it.
```
$ rake
```

### 3. Configuration

##### VM configuration
You can change parameters of VM creation by editing `Vagrantfile`.

CPU_NUM, MEM_SIZE and PORT_NUM are the default params. PORT_NUM is the number of interfaces for using as DPDK port.

`servers` contains params of each of servers and refers default params.
You can edit `servers` for detailed configuration.
If you change the number of VMs or `ipaddr`, you have to edit `hosts` file.
```
# ---------- Edit to change VM params -------------
CPU_NUM = 4
MEM_SIZE = 4 * 1024
PORT_NUM = 4  # for dpdk pmd.

servers = [
#  {
#    "id" => "h2",
#    "memory" => MEM_SIZE,
#    "cpu" => CPU_NUM,
#    "nic" => {
#               "ipaddr" => "192.168.33.12",
#               "port_num" => PORT_NUM
#             }
#  },
  {
    "id" => "h3",
    "memory" => MEM_SIZE,
    "cpu" => CPU_NUM,
    "nic" => {
      "ipaddr" => "192.168.33.13",
      "port_num" => PORT_NUM
    }
  },
  {
    "id" => "h1",
    "memory" => MEM_SIZE,
    "cpu" => CPU_NUM,
    "nic" => {
      "ipaddr" => "192.168.33.11",
      "port_num" => PORT_NUM
    }
  }
]

# -------------------------------------------------

```

### Status
This program is under construction, so it doesn't work now.

### License
This program is released under the MIT license:
- http://opensource.org/licenses/MIT

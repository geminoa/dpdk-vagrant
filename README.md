## DPDK and pktgen with Vagrant

This program setup DPDK 16.04 and pktge-dpdk 3.0.02 on virtual machines of Ubuntu 16.04.

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
Install by running this tool.

##### pktgen-dpdk 3.0.02
Install by running this tool.

### 2. How to use

(1) Create VMs. 2 VMs with 4 CPUs and 4096[MB] memory by default. You can change this setting by editing `Vagrantfile`.
```
$ vagrant up
```

(2) Run ansible-playbook.
```
$ ansible-playbook -i hosts site.yml
```
or use rake if you installed it.
```
$ rake
```

(3) Run DPDK applications.
Login h1 (or h2), then compile and run applications as following.
```
$ vagrant ssh h1
Welcome to Ubuntu 14.04.4 LTS (GNU/Linux 4.2.0-35-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
Last login: Sun May  8 01:38:50 2016 from 192.168.33.1
vagrant@vagrant:~$ cd dpdk/examples/helloworld/
vagrant@vagrant:~/dpdk/examples/helloworld$
vagrant@vagrant:~/dpdk/examples/helloworld$ make
  CC main.o
  LD helloworld
  INSTALL-APP helloworld
  INSTALL-MAP helloworld.map
vagrant@vagrant:~/dpdk/examples/helloworld$ sudo ./build/helloworld -c f -n 4
EAL: Detected 4 lcore(s)
EAL: Probing VFIO support...
EAL: VFIO support initialized
EAL: PCI device 0000:00:03.0 on NUMA socket -1
EAL:   probe driver: 8086:100e rte_em_pmd
EAL: PCI device 0000:00:08.0 on NUMA socket -1
EAL:   probe driver: 8086:100e rte_em_pmd
EAL: PCI device 0000:00:09.0 on NUMA socket -1
EAL:   probe driver: 8086:100e rte_em_pmd
EAL: PCI device 0000:00:0a.0 on NUMA socket -1
EAL:   probe driver: 8086:100e rte_em_pmd
EAL: PCI device 0000:00:10.0 on NUMA socket -1
EAL:   probe driver: 8086:100e rte_em_pmd
EAL: PCI device 0000:00:11.0 on NUMA socket -1
EAL:   probe driver: 8086:100e rte_em_pmd
hello from core 1
hello from core 2
hello from core 3
hello from core 0
```

(4) Run pktgen-dpdk.
Login h2 (if you don't change default configuration) and move to pktgen's directory.
```
$ vagrant ssh h2
Welcome to Ubuntu 14.04.4 LTS (GNU/Linux 4.2.0-35-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
Last login: Sun May  8 01:44:03 2016 from 10.0.2.2
vagrant@vagrant:~$ ls
do_after_reboot.sh  dpdk  install.sh  netsniff-ng  pktgen-dpdk
vagrant@vagrant:~$ cd pktgen-dpdk/
```

Run pktgen located on $HOME/pktgen-dpdk/app/app/x86_64-native-linuxapp-gcc/pktgen.
You can run it directory, but it better to use `doit` script.
```
vagrant@vagrant:~/pktgen-dpdk$ sudo -E ./doit
```

if you change options for pktgen, edit `doit` script. Please refer to pktgen-dpdk's [README](http://dpdk.org/browse/apps/pktgen-dpdk/tree/README.md) for details.
```

dpdk_opts="-c 3  -n 2 --proc-type auto --log-level 7"
#dpdk_opts="-l 18-26 -n 3 --proc-type auto --log-level 7 --socket-mem 256,256 --file-prefix pg"
pktgen_opts="-T -P"
#port_map="-m [19:20].0 -m [21:22].1 -m [23:24].2 -m [25:26].3"
port_map="-m [0:1].0 -m [2:3].1"
#port_map="-m [2-4].0 -m [5-7].1"
#load_file="-f themes/black-yellow.theme"
load_file="-f themes/white-black.theme"
#black_list="-b 06:00.0 -b 06:00.1 -b 08:00.0 -b 08:00.1 -b 09:00.0 -b 09:00.1 -b 83:00.1"
black_list=""
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
#    "id" => "h3",
#    "memory" => MEM_SIZE,
#    "cpu" => CPU_NUM,
#    "nic" => {
#               "ipaddr" => "192.168.33.13",
#               "port_num" => PORT_NUM
#             }
#  },
  {
    "id" => "h2",
    "memory" => MEM_SIZE,
    "cpu" => CPU_NUM,
    "nic" => {
      "ipaddr" => "192.168.33.12",
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
This program is under construction.

### License
This program is released under the MIT license:
- http://opensource.org/licenses/MIT

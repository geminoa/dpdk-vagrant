#!/bin/sh

echo "Setup port for dpdk."

# modprobe
echo sudo modprobe uio_pci_generic 
sudo modprobe uio_pci_generic 
echo sudo modprobe vfio-pci
sudo modprobe vfio-pci


# hugepages
mkdir /mnt/huge
mount -t hugetlbfs nodev /mnt/huge

# 1024 * 2MB
echo 1024 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages

# If on a Numa
#echo 1024 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages


# setup vars for nic bind.
script=${RTE_SDK}/tools/dpdk_nic_bind.py
opt="--bind=uio_pci_generic"

for eth in eth2 eth3 eth4 eth5
do
  sudo ifconfig ${eth} down
  echo python ${script} ${opt} ${eth} 
  sudo python ${script} ${opt} ${eth}
done

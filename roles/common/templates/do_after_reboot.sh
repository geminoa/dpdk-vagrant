#!/bin/sh

echo "Setup port for dpdk."

# modprobe
echo sudo modprobe uio_pci_generic 
sudo modprobe uio_pci_generic 
echo sudo modprobe vfio-pci
sudo modprobe vfio-pci

# setup vars for nic bind.
script=${RTE_SDK}/tools/dpdk_nic_bind.py
opt="--bind=uio_pci_generic"

for eth in eth2 eth3 eth4 eth5
do
  sudo ifconfig ${eth} down
  echo python ${script} ${opt} ${eth} 
  sudo python ${script} ${opt} ${eth}
done

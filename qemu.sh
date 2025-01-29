#!/bin/bash
# Do this after installation first

sudo apt install -y qemu-system libvirt-daemon-system virt-manager bridge-utils 

# Add bridge network interface

sudo echo "
# VM Bridge Interface
auto br0
iface br0 inet dhcp
   pre-up ip tuntap add dev tap0 mode tap user <username>
   pre-up ip link set tap0 up
   bridge_ports all tap0
   bridge_stp off
   bridge_maxwait 0
   bridge_fd      0
   post-down ip link set tap0 down
   post-down ip tuntap del dev tap0 mode tap" | sudo tee -a /etc/network/interface > /dev/null
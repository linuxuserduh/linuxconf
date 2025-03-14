#!/bin/bash
# Do this after installation first

sudo apt install -y qemu-system-x86 libvirt-daemon-system virt-manager

# add user to group
sudo adduser $USER libvirt

# autostart guest network
sudo virsh net-autostart default

# Install VirtIO drivers for win10
wget https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso

# virtio for win7
#wget https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.173-4/virtio-win-0.1.173.iso
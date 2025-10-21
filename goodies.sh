#!/bin/bash
# optional softwares
# for dual boot
sudo apt install -y grub-customizer

# libreoffice
sudo apt install -y libreoffice libreoffice-gtk3 openjdk-17-jre-

# qemu
sudo apt install -y qemu-system-x86 libvirt-daemon-system virt-manager

# add user to group
sudo adduser $USER libvirt

# autostart guest network
sudo virsh net-autostart default

# Install VirtIO drivers for win10 and later
wget https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso

# virtio for win7
# wget https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.173-4/virtio-win-0.1.173.iso
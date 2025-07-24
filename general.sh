#!/bin/bash
# needed contrib for relevant packages like MS fonts and steam
sudo vim /etc/apt/sources.list
sudo apt update

# basic necessities
sudo apt install -y htop ufw mpv ffmpeg yt-dlp- ssh smartmontools preload qbittorrent #tlp # if using a laptop

# image viewer & editor
sudo apt install --no-install-recommends -y feh gimp

# fonts
sudo apt install -y fonts-wqy-zenhei fonts-ibm-plex ttf-mscorefonts-installer cabextract
wget https://archive.org/download/PowerPointViewer_201801/PowerPointViewer.exe
cabextract PowerPointViewer.exe -F ppviewer.cab
mkdir -p ~/.fonts/ppviewer/
cabextract ppviewer.cab -F '*.TTC' -d ~/.fonts/ppviewer/
cabextract ppviewer.cab -F '*.TTF' -d ~/.fonts/ppviewer/
fc-cache
rm PowerPointViewer.exe ppviewer.cab

# firewall
sudo ufw default deny incoming && sudo ufw default allow outgoing
sudo ufw limit ssh
sudo ufw enable

# librewolf
sudo apt update && sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt --allow-releaseinfo-change update
sudo apt install librewolf -y

# vscode
sudo apt install -y curl
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft-archive-keyring.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update && sudo apt install -y code
rm microsoft.gpg

# xanmod kernel
wget -qO - https://dl.xanmod.org/archive.key | sudo gpg --dearmor -vo /etc/apt/keyrings/xanmod-archive-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/xanmod-archive-keyring.gpg] http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-release.list
sudo apt update && sudo apt install -y linux-xanmod-x64v3 #linux-xanmod-lts-x64v2 # for my old intel

# clean unnecessary packages if installed via standard install, not netinst cd
sudo apt purge --autoremove -y debian-refence-common im-config ibus mlterm-common #cups # in case I have a compatible printer


# optional stuff
# libreoffice
# sudo apt install -y libreoffice libreoffice-gtk3 openjdk-17-jre-

# qemu
# sudo apt install -y qemu-system-x86 libvirt-daemon-system virt-manager

# # add user to group
# sudo adduser $USER libvirt

# # autostart guest network
# sudo virsh net-autostart default

# # Install VirtIO drivers for win10 and later
# wget https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso

# virtio for win7
# wget https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.173-4/virtio-win-0.1.173.iso
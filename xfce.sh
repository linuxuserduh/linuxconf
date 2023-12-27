#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y xfce4 xfce4-terminal xfce4-power-manager tango-icon-theme- pulseaudio- pipewire wireplumber pipewire-pulse vim htop tlp tlp-rdw- mpv yt-dlp- xdg-utils

# network manager
sudo apt install network-manager modemmanager- xfce4-wavelan-plugin

# image viewer
sudo apt install --no-install-recommends -y feh

# firewall
sudo apt install -y ufw
sudo ufw default deny incoming && sudo ufw default allow outgoing
sudo ufw enable

# librewolf debian 11-12
sudo apt install -y wget gnupg lsb-release apt-transport-https ca-certificates
distro=$(if echo " una bookworm vanessa focal jammy bullseye vera uma " | grep -q " $(lsb_release -sc) "; then lsb_release -sc; else echo focal; fi)
wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg
sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF
sudo apt update
sudo apt install librewolf -y

# dotnet-sdk
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt update && sudo apt install dotnet-sdk-7.0

# network config
sudo vim /etc/network/interfaces

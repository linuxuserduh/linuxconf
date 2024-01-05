#!/bin/bash
# recommended installations
sudo apt install -y vim htop tlp tlp-rdw- ethtool- ufw mpv yt-dlp- xdg-utils

# image viewer
sudo apt install --no-install-recommends -y feh

# fonts
sudo apt install fonts-wqy-zenhei
# fonts-ibm-plex

# firewall
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

# dotnet-sdk 6.0
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt update && sudo apt install -y dotnet-sdk-6.0

# vscode (thanks to TheOdinProject for scripted installation)
wget -O code-latest.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt install -y ./code-latest.deb
rm code-latest.deb
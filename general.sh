#!/bin/bash
# recommended installations
sudo apt install -y vim htop ufw mpv yt-dlp- xdg-utils ssh curl ffmpeg vainfo smartmontools zip unzip

# image viewer
sudo apt install --no-install-recommends -y feh

# fonts
sudo apt install fonts-wqy-zenhei

# firewall
sudo ufw default deny incoming && sudo ufw default allow outgoing
sudo ufw limit ssh
sudo ufw enable

# librewolf debian 11+
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

# lutris
echo "deb [signed-by=/etc/apt/keyrings/lutris.gpg] https://download.opensuse.org/repositories/home:/strycore/Debian_12/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list > /dev/null
wget -q -O- https://download.opensuse.org/repositories/home:/strycore/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/lutris.gpg > /dev/null
sudo apt update
sudo apt install -y lutris pulseaudio-

# dotnet-sdk 
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt update && sudo apt install -y dotnet-sdk-8.0

# mono
sudo apt install dirmngr ca-certificates gnupg
sudo gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/debian stable-buster main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update && sudo apt install -y mono-devel

# vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft-archive-keyring.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update && sudo apt install -y code
rm microsoft.gpg

# libreoffice-lts & ms fonts
sudo apt install -y libreoffice
wget https://archive.org/download/PowerPointViewer_201801/PowerPointViewer.exe
cabextract PowerPointViewer.exe -F ppviewer.cab
mkdir -p ~/.fonts/ppviewer/
cabextract ppviewer.cab -F '*.TTC' -d ~/.fonts/ppviewer/
cabextract ppviewer.cab -F '*.TTF' -d ~/.fonts/ppviewer/
fc-cache
rm PowerPointViewer.exe ppviewer.cab
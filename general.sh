#!/bin/bash
# recommended installations
sudo apt install -y htop ufw mpv ffmpeg yt-dlp- xdg-utils ssh smartmontools zip unzip qbittorrent

# image viewer
sudo apt install --no-install-recommends -y feh

# image editor
sudo apt install --no-install-recommends -y gimp

# fonts
sudo apt install fonts-wqy-zenhei

# firewall
sudo ufw default deny incoming && sudo ufw default allow outgoing
sudo ufw limit ssh
sudo ufw enable

# librewolf
sudo apt update && sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt --allow-releaseinfo-change update
sudo apt install librewolf -y

# lutris
echo "deb [signed-by=/etc/apt/keyrings/lutris.gpg] https://download.opensuse.org/repositories/home:/strycore/Debian_12/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list > /dev/null
wget -q -O- https://download.opensuse.org/repositories/home:/strycore/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/lutris.gpg > /dev/null
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y lutris wine64 wine32 pulseaudio- fluidsynth- gamemode-

# vscode
sudo apt install -y curl
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft-archive-keyring.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update && sudo apt install -y code
rm microsoft.gpg

# libreoffice-lts & ms fonts
# sudo apt install -y libreoffice libreoffice-gtk3 openjdk-17-jre- cabextract
wget https://archive.org/download/PowerPointViewer_201801/PowerPointViewer.exe
cabextract PowerPointViewer.exe -F ppviewer.cab
mkdir -p ~/.fonts/ppviewer/
cabextract ppviewer.cab -F '*.TTC' -d ~/.fonts/ppviewer/
cabextract ppviewer.cab -F '*.TTF' -d ~/.fonts/ppviewer/
fc-cache
rm PowerPointViewer.exe ppviewer.cab
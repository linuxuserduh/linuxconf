#!/bin/bash
# needed contrib for relevant packages like cabextract for MS fonts and steam
sudo vim /etc/apt/sources.list
sudo apt update

# necessities
sudo apt install -y htop ufw mpv ffmpeg yt-dlp- ssh smartmontools nohang qbittorrent preload #tlp # if using a laptop

# image viewer & editor
sudo apt install -y --no-install-recommends feh gimp

# fonts (required for certain websites on a browser)
sudo apt install -y fonts-wqy-zenhei ttf-mscorefonts-installer cabextract
wget https://archive.org/download/PowerPointViewer_201801/PowerPointViewer.exe
wget https://archive.org/download/ftp.microsoft.com/ftp.microsoft.com.zip/ftp.microsoft.com/Softlib/MSLFILES/TAHOMA32.EXE
cabextract PowerPointViewer.exe -F ppviewer.cab
mkdir -p ~/.fonts/ppviewer/
cabextract ppviewer.cab -F '*.TTC' -d ~/.fonts/ppviewer/
cabextract ppviewer.cab -F '*.TTF' -d ~/.fonts/ppviewer/
cabextract TAHOMA32.EXE -F '*.TTF' -d ~/.fonts/
fc-cache
rm PowerPointViewer.exe ppviewer.cab TAHOMA32.EXE

# firewall
sudo ufw default deny incoming && sudo ufw default allow outgoing
sudo ufw limit ssh
sudo ufw enable

# librewolf browser
sudo apt update && sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt --allow-releaseinfo-change update
sudo apt install librewolf -y

# vscode
sudo apt install -y curl
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/microsoft-archive-keyring.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update && sudo apt install -y code
rm microsoft.gpg

# xanmod kernel
wget -qO - https://dl.xanmod.org/archive.key | sudo gpg --dearmor -vo /etc/apt/keyrings/xanmod-archive-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/xanmod-archive-keyring.gpg] http://deb.xanmod.org $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/xanmod-release.list
sudo apt update && sudo apt install -y linux-xanmod-x64v3 #linux-xanmod-lts-x64v2 # for my old intel

# remove unnecessary packages if installed via standard install iso
sudo apt purge --autoremove -y debian-reference-common im-config ibus mlterm-common #cups # in case I have a compatible printer
#!/bin/bash
# debloat process (groups then individual pkgs)
sudo dnf remove @input-methods @guest-desktop-agents @dial-up @desktop-accessibility @printing @multimedia -y
sudo dnf remove localsearch nano abrt dnfdragora-updater cups system-config-printer-libs xfce4-taskmanager xfce4-datetime-plugin xfce4-places-plugin -y

# comment if using laptop
sudo dnf remove @networkmanager-submodules blueman bluez-libs -y

# enable rpmfusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

# non-free drivers
sudo dnf install ffmpeg --allowerasing -y
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y

# general apps
sudo dnf install fuse fuse-libs qbittorrent ristretto atril mousepad xarchiver seahorse -y

# ufw
sudo dnf swap -y --allowerasing firewalld ufw
sudo ufw default deny incoming && sudo ufw default allow outgoing
sudo ufw enable
sudo systemctl enable ufw

# brave
sudo dnf install dnf-plugins-core -y
sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo dnf install brave-browser -y

# msfonts
sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
sudo rpm -ivh --nodigest https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# clean unneededed packages
sudo dnf autoremove -y
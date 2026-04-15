#!/bin/bash
# debloat process (groups then individual pkgs)
sudo dnf remove -y @xfce-extra-plugins @input-methods @printing @dial-up @xfce-media @guest-desktop-agents @multimedia @xfce-apps -x ristretto,atril,mousepad,xarchiver,seahorse
sudo dnf remove -y @networkmanager-submodules # comment if using laptop
sudo dnf remove -y localsearch nano abrt dnfdragora-updater cups system-config-printer mediawriter pragha cockpit-system xfce4-taskmanager xfce4-datetime-plugin xfce4-places-plugin

# enable rpmfusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

# clean first before upgrade & installing pkgs to reduce unwanted pkg upgrades
sudo dnf autoremove -y
sudo dnf upgrade -y --refresh

# multimedia video decoding
sudo dnf swap -y --allowerasing ffmpeg-free ffmpeg
sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld

# general apps
sudo dnf install -y fuse-devel qbittorrent

# ufw
sudo dnf swap -y --allowerasing firewalld ufw
sudo ufw default deny incoming && sudo ufw default allow outgoing
sudo ufw enable

# librewolf
sudo dnf config-manager addrepo --from-repofile=https://repo.librewolf.net/librewolf.repo
sudo dnf swap -y firefox librewolf

# media player
sudo dnf install -y --setopt=install_weak_deps=False mpv

# msfonts
sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
sudo rpm -ivh --nodigest https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
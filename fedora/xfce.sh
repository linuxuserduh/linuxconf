#!/bin/bash
# debloat process (groups then individual pkgs)
sudo dnf remove @xfce-media @input-methods @guest-desktop-agents @dial-up @desktop-accessibility @multimedia -y
sudo dnf remove @xfce-apps -yx ristretto,atril,mousepad,xarchiver,seahorse

sudo dnf remove irqbalance localsearch nano abrt rsyslog dnfdragora-updater nfs-utils pragha xfce4-screensaver xfce4-taskmanager -y

# Uncomment to remove printing deps
# sudo dnf remove @printing cups system-config-printer-libs

# comment if using laptop
sudo dnf remove @networkmanager-submodules blueman bluez-libs -y
sudo dnf install tlp -y && sudo systemctl enable --now tlp

# enable rpmfusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

# replace X11
sudo dnf copr enable @xlibre/xlibre-xserver
sudo dnf install xlibre-xserver xlibre-xf86-input-libinput xlibre-xserver-common xlibre-xserver-Xorg --allowerasing

# non-free packages
sudo dnf install ffmpeg mesa-va-drivers-freeworld --allowerasing -y

# prerequisites
sudo dnf install fuse fuse-libs qbittorrent unrar @xfce-office -y
sudo dnf install mpv audacious --setopt=install_weak_deps=False -y

# brave
sudo dnf install dnf-plugins-core -y
sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo dnf install brave-browser -y

# msfonts
sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
sudo rpm -ivh --nodigest https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

# clean unnecessary packages
sudo dnf autoremove -y

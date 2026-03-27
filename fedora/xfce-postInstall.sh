#!/bin/bash
# remove bloats (groups then individual pkgs)
sudo dnf remove -y @xfce-extra-plugins @input-methods @printing @dial-up @xfce-media @guest-desktop-agents @multimedia @networkmanager-submodules @xfce-apps -x ristretto,atril,mousepad,xarchiver,seahorse,NetworkManager-wifi
sudo dnf remove -y localsearch nano abrt-desktop dnfdragora-updater cups system-config-printer mediawriter pragha cockpit-system xfce4-taskmanager xfce4-datetime-plugin xfce4-places-plugin bluez


# enable rpmfusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

# clean first before upgrade & installing pkgs
sudo dnf autoremove -y
sudo dnf upgrade -y --refresh
sudo dnf install -y git htop NetworkManager-tui hdparm fuse-devel

# librewolf
sudo dnf config-manager addrepo --from-repofile=https://repo.librewolf.net/librewolf.repo
sudo dnf swap -y firefox librewolf # also removes ffmpeg-free

# multimedia video decoding
sudo dnf install -y --allowerasing ffmpeg
sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld
#sudo dnf install -y libva-utils # for video decoding info (vainfo)

# media player
sudo dnf install -y --setopt=install_weak_deps=False mpv

# msfonts
sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
sudo rpm -ivh --nodigest https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

## Programming
# vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf install -y code

# unityhub
sudo sh -c 'echo -e "[unityhub]\nname=Unity Hub\nbaseurl=https://hub.unity3d.com/linux/repos/rpm/stable\nenabled=1\ngpgcheck=1\ngpgkey=https://hub.unity3d.com/linux/repos/rpm/stable/repodata/repomd.xml.key\nrepo_gpgcheck=1" > /etc/yum.repos.d/unityhub.repo'
sudo dnf install -y unityhub dotnet-sdk-8.0 GConf2
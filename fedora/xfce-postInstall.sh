#!/bin/bash
# remove bloats (groups then individual pkgs)
sudo dnf remove -y @xfce-extra-plugins @input-methods @printing @dial-up @xfce-media @guest-desktop-agents @networkmanager-submodules @multimedia @xfce-apps -x ristretto,atril,mousepad,xarchiver,seahorse
sudo dnf remove -y localsearch nano abrt dnfdragora cups system-config-printer mediawriter pragha xfce4-taskmanager xfce4-datetime-plugin xfce4-places-plugin

# enable rpmfusion (non-free packages)
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

# vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf install -y code

# lutris
sudo dnf install -y lutris vulkan-tools xrandr -x gamescope,fluid-soundfont-gs

# steam
sudo dnf install steam -y

# unityhub
sudo sh -c 'echo -e "[unityhub]\nname=Unity Hub\nbaseurl=https://hub.unity3d.com/linux/repos/rpm/stable\nenabled=1\ngpgcheck=1\ngpgkey=https://hub.unity3d.com/linux/repos/rpm/stable/repodata/repomd.xml.key\nrepo_gpgcheck=1" > /etc/yum.repos.d/unityhub.repo'
sudo dnf install -y unityhub dotnet-sdk-8.0 GConf2


## ryzen config
# ryzenadj
sudo dnf -y install cmake gcc-c++ pciutils-devel
git clone https://github.com/FlyGoat/RyzenAdj
cd RyzenAdj
cmake -B build -DCMAKE_BUILD_TYPE=Release
make -C build -j"$(nproc)"
sudo cp -v build/ryzenadj /usr/local/bin/
cd ../

# ryzen_smu
sudo dnf install dkms openssl
git clone https://github.com/amkillam/ryzen_smu
cd ryzen_smu/ && sudo make dkms-install

# set custom configs on boot
echo -e '#!/bin/bash
ryzenadj -a 35000 -b 42000 -c 35000 -f 80 -g 30000 -k 55000
echo 0 | tee /sys/devices/system/cpu/cpufreq/boost' | sudo tee /usr/local/sbin/ryzenconfig.sh > /dev/null
sudo chmod 0700 /usr/local/sbin/ryzenconfig.sh

echo -e '[Unit]
Description=Custom Ryzen config
[Service]
ExecStart=/usr/local/sbin/ryzenconfig.sh
[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/ryzenconfig.service > /dev/null

sudo systemctl enable ryzenconfig.service
sudo systemctl start ryzenconfig.service
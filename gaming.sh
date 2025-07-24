#!/bin/bash
# lutris
echo "deb [signed-by=/etc/apt/keyrings/lutris.gpg] https://download.opensuse.org/repositories/home:/strycore/Debian_12/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list > /dev/null
wget -q -O- https://download.opensuse.org/repositories/home:/strycore/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/lutris.gpg > /dev/null
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y lutris wine64 wine32 pulseaudio- fluidsynth- gamemode- gamescope-

# steam
sudo apt install -y steam-installer

# parsec (game stream/remote desktop)
wget https://builds.parsec.app/package/parsec-linux.deb
wget https://archive.debian.org/debian/pool/main/libj/libjpeg8/libjpeg8_8b-1_amd64.deb # thanks to panosadm from thinkdebian.net
sudo dpkg -i parsec-linux.deb libjpeg8_8b-1_amd64.deb

    # in case of black screen on app (not on stream), add this code inside ~/.parsec/config.json:
    # "client_renderer": {
    # "value": 5
    # }

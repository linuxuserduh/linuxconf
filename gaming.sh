#!/bin/bash
# lutris
 echo -e "Types: deb\nURIs: https://download.opensuse.org/repositories/home:/strycore/Debian_12/\nSuites: ./\nComponents: \nSigned-By: /etc/apt/keyrings/lutris.gpg" | sudo tee /etc/apt/sources.list.d/lutris.sources > /dev/null
wget -q -O- https://download.opensuse.org/repositories/home:/strycore/Debian_12/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/lutris.gpg
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y lutris wine64 wine32 pulseaudio- fluidsynth- gamescope-

# allow gamemode renice limitation to 4
echo -e '@gamemode - nice -4' | sudo tee /etc/security/limits.d/10-gamemode.conf > /dev/null

# steam
sudo apt install -y steam-installer

# parsec (game stream/remote desktop)
wget https://builds.parsec.app/package/parsec-linux.deb
wget https://archive.debian.org/debian/pool/main/libj/libjpeg8/libjpeg8_8b-1_amd64.deb # thanks to panosadm from thinkdebian.net
sudo dpkg -i parsec-linux.deb libjpeg8_8b-1_amd64.deb
rm parsec-linux.deb libjpeg8_8b-1_amd64.deb

    # in case of black screen on app (not on stream), add this code inside ~/.parsec/config.json:
    # "client_renderer": {
    # "value": 5
    # }

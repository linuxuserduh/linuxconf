#!/bin/bash
sudo apt install -y xfce4 xfce4-terminal xfce4-screenshooter xfce4-power-manager thunar-archive-plugin gvfs-backends network-manager network-manager-gnome gnome-icon-theme- mobile-broadband-provider-info- modemmanager- tango-icon-theme- pulseaudio- bluez- pipewire gnome-disk-utility #xfce4-power-manager-plugins # useful for laptop

# for event sounds
sudo apt install -y libcanberra-gtk3-module libcanberra-pulse pipewire-alsa

sudo echo 'export GTK_modules="canberra-gtk-module"' >> ~/.xsessionrc
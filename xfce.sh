#!/bin/bash
sudo apt install -y xfce4 xfce4-terminal xfce4-screenshooter xfce4-power-manager thunar-archive-plugin gvfs-backends network-manager network-manager-gnome gnome-icon-theme- mobile-broadband-provider-info- modemmanager- tango-icon-theme- pulseaudio- bluez- pipewire gnome-disk-utility #xfce4-power-manager-plugins # useful for laptop

# for event sounds
sudo apt install -y libcanberra-gtk3-module libcanberra-pulse pipewire-alsa

sudo echo 'export GTK_modules="canberra-gtk-module"' >> ~/.xsessionrc

## backlight issue fix for laptops
# create the necessary directory
sudo mkdir /etc/polkit-1/rules.d

# fix permissions on the directory
sudo chmod 755 /etc/polkit-1/rules.d

# create the configuration file with the following content
echo -e 'polkit.addRule(function(action, subject) {
    if (action.id == "org.xfce.power.backlight-helper" &&
        subject.isInGroup("users")) {
        return polkit.Result.YES;
    }
});' | sudo tee /etc/polkit-1/rules.d/89-backlight.rules > /dev/null

# fix permissions on the configuration file
sudo chmod 644 /etc/polkit-1/rules.d/89-backlight.rules

# in the following file change the "backlight" rules to <allow_any>yes</allow_any>
sudo vim /usr/share/polkit-1/actions/org.freedesktop.login1.policy
#!/bin/bash
sudo apt install -y dwm stterm xorg libx11-dev libxft-dev libxinerama-dev light gnome-keyring- network-manager modemmanager- pulseaudio- pipewire wireplumber pipewire-pulse pavucontrol pcmanfm


# slstatus
git clone https://git.suckless.org/tools/slstatus

# configs for dwm & stterm
echo "Creating configs.."
dwmSources () {
    dirName="dwmSources"
    mkdir "$dirName"
    cd "$dirName"
    apt source dwm stterm
}
dwmSources

# add backlight rules for fn keys to work
sudo echo 'ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"' | sudo tee -a /etc/udev/rules.d/backlight.rules > /dev/null

# .xinitrc
echo -e '#!/bin/sh \n\nslstatus & \nexec dwm' > ~/.xinitrc

# Autostart startx at login
echo -e 'if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then \n\texec startx \nfi' > ~/.bash_profile

# GTK Dark theme
mkdir ~/.config/gtk-3.0
echo -e '[Settings] \ngtk-application-prefer-dark-theme=1' > ~/.config/gtk-3.0/settings.ini
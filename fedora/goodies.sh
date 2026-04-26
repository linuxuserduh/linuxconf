#!/bin/bash
# audio player
sudo dnf install audacious --setopt=install_weak_deps=False -y

# media player (video & audio)
sudo dnf install mpv --setopt=install_weak_deps=False -y

# librewolf
# sudo dnf config-manager addrepo --from-repofile=https://repo.librewolf.net/librewolf.repo
# sudo dnf install librewolf -y

# obs studio
# sudo dnf install flatpak -y
# flatpak install flathub com.obsproject.Studio

# syncthing
# sudo dnf install syncthing -y
# echo -e '[syncthing]
# title=Syncthing
# description=Syncthing file synchronisation
# ports=22000|21027/udp

# [syncthing-gui]
# title=Syncthing-GUI
# description=Syncthing web gui
# ports=8384/tcp' | sudo tee /etc/ufw/applications.d/syncthing > /dev/null
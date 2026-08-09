#!/bin/bash
# gimp
sudo dnf install gimp -y

# librewolf
# sudo dnf config-manager addrepo --from-repofile=https://repo.librewolf.net/librewolf.repo
# sudo dnf install librewolf -y

# ufw
# Warning: When using virtualization, network won't work without firewalld
# sudo dnf swap -y --allowerasing firewalld ufw
# sudo ufw default deny incoming && sudo ufw default allow outgoing
# sudo ufw enable
# sudo systemctl enable ufw

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
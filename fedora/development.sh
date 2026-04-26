#!/bin/bash
# vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf install code -y

# unity
sudo sh -c 'echo -e "[unityhub]\nname=Unity Hub\nbaseurl=https://hub.unity3d.com/linux/repos/rpm/stable\nenabled=1\ngpgcheck=1\ngpgkey=https://hub.unity3d.com/linux/repos/rpm/stable/repodata/repomd.xml.key\nrepo_gpgcheck=1" > /etc/yum.repos.d/unityhub.repo'
echo "DOTNET_CLI_TELEMETRY_OPTOUT=1" | sudo tee -a /etc/environment
sudo dnf install unityhub dotnet-sdk-8.0 GConf2 git-lfs -y

# image editor
sudo dnf install gimp -y

# audio editor
#sudo dnf install audacity -y

# paint
#sudo dnf install krita -y

# 3d animations
#sudo dnf install blender -y
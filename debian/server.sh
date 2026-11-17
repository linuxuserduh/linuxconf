#!/bin/bash
# essentials
sudo apt install vim htop iotop openssh-server irqbalance thermald linux-cpupower fail2ban unattended-upgrades systemd-timesyncd bsd-mailx unbound -y

## setup network before pihole
# ufw setup
sudo apt install ufw -y

sudo ufw limit ssh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow 53/tcp
sudo ufw allow 53/udp
sudo ufw allow 67/tcp
sudo ufw allow 67/udp
sudo ufw allow 123/udp

sudo ufw enable

sudo vim /etc/network/interfaces

# pi-hole
curl -sSL https://install.pi-hole.net | bash

# set host to use pihole
echo 'static domain_name_servers=127.0.0.1' | sudo tee -a /etc/dhcpcd.conf > /dev/null

# setup unbound
# https://docs.pi-hole.net/guides/dns/unbound/

# only use swappiness when necessary
echo 'vm.swappiness = 1' | sudo tee /etc/sysctl.d/10-swappiness.conf > /dev/null
sudo sysctl -p /etc/sysctl.d/10-swappiness.conf


## optionals
# minecraft server setup (see ufw-ports for firewall config)
sudo apt install default-jre-headless screen -y

echo -e '[minecraft]
title=Minecraft Server
description=Minecraft server port
ports=25565/tcp' | sudo tee /etc/ufw/applications.d/minecraft > /dev/null
sudo ufw allow minecraft
sudo ufw reload

echo -e "#!/bin/bash
java -Xms512M -Xmx2G -jar bta-server.jar --nogui" >> start.sh
chmod +x start.sh
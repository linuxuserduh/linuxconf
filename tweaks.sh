#!/bin/bash

# allow renice limitation to 4 (sitting between normal and crucial processes) and add user to group
echo '@gamemode - nice -4' | sudo tee /etc/security/limits.d/10-gamemode.conf > /dev/null
sudo usermod -aG gamemode $(whoami)

# reduce DRI latency
echo -e '<driconf>
   <device>
       <application name="Default">
           <option name="vblank_mode" value="0" />
       </application>
   </device>
</driconf>' > ~/.drirc

## CachyOS udev rules
# I/O Scheduler Rules
echo -e '# HDD
ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"

# SSD
ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"

# NVMe SSD
ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="none"' | sudo tee /etc/udev/rules.d/60-ioschedulers.rules > /dev/null

# hdparm rules (note: always check where the main system (sdX) is located)
echo -e 'ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="sda", RUN+="/usr/bin/hdparm -B 254 -S 0 /dev/sda"' | sudo tee /etc/udev/rules.d/69-hdparm.rules > /dev/null
#echo -e 'ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTRS{id/bus}=="ata", RUN+="/usr/bin/hdparm -B 254 -S 0 /dev/%k"' | sudo tee /etc/udev/rules.d/69-hdparm.rules > /dev/null

# Sysctl config
echo -e '# This action will speed up your boot and shutdown, because one less module is loaded. Additionally disabling watchdog timers increases performance and lowers power consumption
# Disable NMI watchdog
kernel.nmi_watchdog = 0

# Increase netdev receive queue
# May help prevent losing packets
net.core.netdev_max_backlog = 4096

# Prefer latency over max throughput
net.ipv4.tcp_low_latency = 1' | sudo tee /etc/sysctl.d/99-custom-settings.conf > /dev/null

sudo sysctl -p /etc/sysctl.d/99-custom-settings.conf
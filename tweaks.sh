#!/bin/bash
## CachyOS udev rules
# I/O Scheduler Rules
echo -e '# HDD
ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", \
    ATTR{queue/scheduler}="bfq"

# SSD
ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", \
    ATTR{queue/scheduler}="mq-deadline"

# NVMe SSD
ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", \
    ATTR{queue/scheduler}="none"' | sudo tee /etc/udev/rules.d/60-ioschedulers.rules > /dev/null

# SATA Rules
echo -e '# SATA Active Link Power Management
ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", \
    ATTR{link_power_management_supported}=="1", \
    ATTR{link_power_management_policy}=="*", \
    ATTR{link_power_management_policy}="max_performance"' | sudo tee /etc/udev/rules.d/50-sata.rules > /dev/null


# HDParm Rules from ArchWiki
echo -e 'ACTION=="add|change", SUBSYSTEM=="block", KERNEL=="sda", RUN+="/usr/bin/hdparm -B 254 -S 0 /dev/sda"' | sudo tee /etc/udev/rules.d/69-hdparm.rules > /dev/null


# Sysctl config
echo -e '# This action will speed up your boot and shutdown, because one less module is loaded. Additionally disabling watchdog timers increases performance and lowers power consumption
# Disable NMI watchdog
kernel.nmi_watchdog = 0' | sudo tee /etc/sysctl.d/10-nmi-watchdog.conf > /dev/null

sudo sysctl -p /etc/sysctl.d/10-nmi-watchdog.conf
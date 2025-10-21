#!/bin/bash
# From CachyOS settings
# I/O Scheduler Rules
sudo echo -e '# HDD
ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"

# SSD
ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="mq-deadline"

# NVMe SSD
ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="none"' | sudo tee /etc/udev/rules.d/60-ioschedulers.rules > /dev/null

# Sysctl config
sudo echo -e '# This action will speed up your boot and shutdown, because one less module is loaded. Additionally disabling watchdog timers increases performance and lowers power consumption
# Disable NMI watchdog
kernel.nmi_watchdog = 0

# Increase netdev receive queue
# May help prevent losing packets
net.core.netdev_max_backlog = 4096

# Prefer latency over max throughput
net.ipv4.tcp_low_latency = 1' | sudo tee /etc/sysctl.d/99-custom-settings.conf > /dev/null

sudo sysctl -p /etc/sysctl.d/99-custom-settings.conf
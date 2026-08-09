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


# ZRAM Rules
echo -e 'ACTION=="change", KERNEL=="zram0", ATTR{initstate}=="1", SYSCTL{vm.swappiness}="150"' | sudo tee /etc/udev/rules.d/30-zram.rules > /dev/null


# Sysctl config from CachyOS settings github
echo -e '# This action will speed up your boot and shutdown, because one less module is loaded. Additionally disabling watchdog timers increases performance and lowers power consumption
# Disable NMI watchdog
kernel.nmi_watchdog = 0' | sudo tee /etc/sysctl.d/10-nmi-watchdog.conf > /dev/null
sudo sysctl -p /etc/sysctl.d/10-nmi-watchdog.conf

echo -e '# Blacklist the Intel TCO Watchdog/Timer module
blacklist iTCO_wdt

# Blacklist the AMD SP5100 TCO Watchdog/Timer module (Required for Ryzen cpus)
blacklist sp5100_tco' | sudo tee /usr/lib/modprobe.d/blacklist.conf > /dev/null


# Useful if using zram
echo -e '# The sysctl swappiness parameter determines the kernel preference for pushing anonymous pages or page cache to disk in memory-starved situations.
# A low value causes the kernel to prefer freeing up open files (page cache), a high value causes the kernel to try to use swap space,
# and a value of 100 means IO cost is assumed to be equal.
vm.swappiness = 100

# The value controls the tendency of the kernel to reclaim the memory which is used for caching of directory and inode objects (VFS cache).
# Lowering it from the default value of 100 makes the kernel less inclined to reclaim VFS cache (do not set it to 0, this may produce out-of-memory conditions)
vm.vfs_cache_pressure = 50

# Contains, as bytes, the number of pages at which a process which is
# generating disk writes will itself start writing out dirty data.
# Default is 0.
vm.dirty_bytes = 268435456

# page-cluster controls the number of pages up to which consecutive pages are read in from swap in a single attempt.
# This is the swap counterpart to page cache readahead. The mentioned consecutivity is not in terms of virtual/physical addresses,
# but consecutive on swap space - that means they were swapped out together. (Default is 3)
# increase this value to 1 or 2 if you are using physical swap (1 if ssd, 2 if hdd)
vm.page-cluster = 0

# Contains, as bytes, the number of pages at which the background kernel
# flusher threads will start writing out dirty data. Default is 0.
vm.dirty_background_bytes = 67108864

# The kernel flusher threads will periodically wake up and write old data out to disk.  This
# tunable expresses the interval between those wakeups, in 100ths of a second (Default is 500).
vm.dirty_writeback_centisecs = 1500' | sudo tee /etc/sysctl.d/70-iomem-management.conf > /dev/null
sudo sysctl -p /etc/sysctl.d/70-iomem-management.conf
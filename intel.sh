#!/bin/bash
# For post-installation
# Enable GuC / HuC firmware loading
sudo echo 'options i915 enable_guc=2' | sudo tee -a /etc/modprobe.d/i915.conf > /dev/null
sudo update-initramfs -u -k $(uname -r)

# Disable Vertical Synchronization (VSYNC)
echo -e '<driconf> \n\t<device screen="0" driver="dri2"> \n\t\t<application name="Default"> \n\t\t\t<option name="vblank_mode" value="0"/> \n\t\t</application> \n\t</device> \n</driconf>' >> ~/.drirc

# for laptop
# sudo apt install thermald

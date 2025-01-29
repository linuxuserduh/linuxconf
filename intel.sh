#!/bin/sh
# Enable GuC / HuC firmware loading
sudo echo 'options i915 enable_guc=2' | sudo tee -a /etc/modprobe.d/i915.conf > /dev/null
sudo update-initramfs -u -k $(uname -r)

# With the modesetting driver
sudo echo -e 'Section "Device" \n\tIdentifier "Intel Graphics" \n\tDriver "modesetting" \n\tOption \t"DRI"  \t"iris" \n\tOption\t"Backlight"\t"intel_backlight" \n\tOption\t"TearFree"\t"false" \n\tOption\t"TripleBuffer"\t"false" \n\tOption\t"SwapbuffersWait"\t"false" \nEndSection' | sudo tee /etc/X11/xorg.conf.d/20-intel.conf > /dev/null

# Disable Vertical Synchronization (VSYNC)
echo -e '<device screen="0" driver="dri2"> \n\t<application name="Default"> \n\t\t<option name="vblank_mode" value="0"/> \n\t</application> \n</device>' >> ~/.drirc
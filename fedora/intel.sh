#!/bin/bash
# video decoding
sudo dnf install intel-media-driver -y #thermald # for laptops
#sudo dnf install libva-intel-media-driver -y # for old intel

# Enable GuC / HuC firmware loading (experimental)
# sudo echo 'options i915 enable_guc=2' | sudo tee -a /etc/modprobe.d/i915.conf > /dev/null
# sudo dracut --force
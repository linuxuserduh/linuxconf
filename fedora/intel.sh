#!/bin/bash
# video decoding
sudo dnf install -y intel-media-driver #thermald # for laptops
#sudo dnf install -y libva-intel-media-driver # for old intel

# Enable GuC / HuC firmware loading
sudo echo 'options i915 enable_guc=2' | sudo tee -a /etc/modprobe.d/i915.conf > /dev/null
sudo dracut --force
#!/bin/bash

# thermal management (must-have for intel)
sudo dnf install thermald

# video decoding
sudo dnf install intel-media-driver -y
#sudo dnf install libva-intel-driver -y # for intel pre-4th gen

# Enable GuC / HuC firmware loading (experimental)
# sudo echo 'options i915 enable_guc=2' | sudo tee -a /etc/modprobe.d/i915.conf > /dev/null
# sudo dracut --force
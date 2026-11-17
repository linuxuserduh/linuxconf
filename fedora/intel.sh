#!/bin/bash
# thermal management (must-have)
sudo dnf install thermald

# video decoding
sudo dnf install intel-media-driver -y
#sudo dnf install libva-intel-driver -y # for haswell and older
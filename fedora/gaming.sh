#!/bin/bash
# lutris
sudo dnf install -y lutris vulkan-tools xrandr -x fluid-soundfont-gs

# steam
sudo dnf install steam -y

# add user to gamemode group
sudo usermod -aG gamemode $(whoami)

# reduce DRI latency
echo -e '<driconf>
   <device>
       <application name="Default">
           <option name="vblank_mode" value="0" />
       </application>
   </device>
</driconf>' > ~/.drirc
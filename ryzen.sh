#!/bin/bash
sudo apt update
sudo apt install -y linux-cpupower cpufrequtils

# Ryzen Master alternative for my 2200G
cd ..
sudo apt install -y build-essential cmake libpci-dev

git clone https://github.com/FlyGoat/RyzenAdj.git
cd RyzenAdj
rm -r win32
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
sudo ln -s ryzenadj /usr/local/bin/ryzenadj

# do a lil' configuration if necessary
sudo echo -e '#!/bin/bash\nryzenadj -a 35000 -b 48000 -c 35000 -f 75 -g 45000 -k 65000' | sudo tee -a /usr/local/sbin/ryzenadj.sh > /dev/null

sudo chmod 0700 /usr/local/sbin/ryzenadj.sh
sudo systemctl enable ryzenadj.service
sudo systemctl start ryzenadj.service
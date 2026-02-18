#!/bin/bash
# Ryzen Master alternative for my 2200G
sudo apt update
sudo apt install -y linux-cpupower build-essential cmake libpci-dev

cd ..
git clone https://github.com/FlyGoat/RyzenAdj.git
cd RyzenAdj
rm -r win32
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
sudo ln -s ryzenadj /usr/local/bin/ryzenadj

# set custom configs on boot
echo -e '#!/bin/bash
cpupower frequency-set -g schedutil
ryzenadj -a 35000 -b 42000 -c 35000 -f 80 -g 30000 -k 50000
echo 0 | tee /sys/devices/system/cpu/cpufreq/boost' | sudo tee /usr/local/sbin/ryzenconfig.sh > /dev/null
sudo chmod 0700 /usr/local/sbin/ryzenconfig.sh

echo -e '[Unit]
Description=Custom Ryzen config
[Service]
ExecStart=/usr/local/sbin/ryzenconfig.sh
[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/ryzenconfig.service > /dev/null

sudo systemctl enable ryzenconfig.service
sudo systemctl start ryzenconfig.service


## Intel Q6600 & GeForce 8800 GTX raw performance on Ryzen 3 2200g
# cpupower frequency-set -u 1600000
# ryzenadj -a 15000 -b 23000 -c 15000 -f 75 -g 30000 -k 50000

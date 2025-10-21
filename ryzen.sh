#!/bin/bash
sudo apt update
sudo apt install -y cpufrequtils

# Set governor to schedutil when boot
sudo echo 'GOVERNOR="schedutil"' | sudo tee /etc/default/cpufrequtils > /dev/null

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
echo -e '#!/bin/bash
ryzenadj -a 35000 -b 48000 -c 35000 -f 80 -g 45000 -k 65000' | sudo tee /usr/local/sbin/ryzenadj.sh > /dev/null

sudo chmod 0700 /usr/local/sbin/ryzenadj.sh

echo -e '[Unit]
Description=Adjust Ryzen's TDP at its desired values
[Service]
ExecStart=/usr/local/sbin/ryzenadj.sh
[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/ryzenadj.service > /dev/null

sudo systemctl enable ryzenadj.service
sudo systemctl start ryzenadj.service

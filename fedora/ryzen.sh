#!/bin/bash
# ryzenadj
sudo dnf -y install cmake gcc-c++ pciutils-devel
git clone https://github.com/FlyGoat/RyzenAdj
cd RyzenAdj
cmake -B build -DCMAKE_BUILD_TYPE=Release
make -C build -j"$(nproc)"
sudo cp -v build/ryzenadj /usr/local/bin/
cd ../

# ryzen_smu
sudo dnf install -y dkms openssl
git clone https://github.com/amkillam/ryzen_smu
cd ryzen_smu/ && sudo make dkms-install

# set custom configs on boot
echo -e '#!/bin/bash
ryzenadj -a 35000 -b 42000 -c 35000 -f 80 -g 30000 -k 55000
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
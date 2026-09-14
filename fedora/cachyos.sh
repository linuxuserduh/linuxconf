#!/bin/bash
# CachyOS Kernel
# Identify cpu arch support
/lib64/ld-linux-x86-64.so.2 --help | grep "(supported, searched)"

# LLVM-ThinLTO build
sudo dnf copr enable bieszczaders/kernel-cachyos-lto

sudo dnf install kernel-cachyos-lto kernel-cachyos-lto-devel-matched -y # For x86-64-v3
#sudo dnf install kernel-cachyos-lts-lto kernel-cachyos-lts-lto-devel-matched -y # For x86-64-v2 and older

sudo setsebool -P domain_kernel_load_modules on

# always boot with the latest CachyOS kernel
sudo dnf install libdnf5-plugin-actions -y
sudo mkdir -p /etc/dnf/libdnf5-plugins/actions.d
sudo tee /etc/dnf/libdnf5-plugins/actions.d/cachy-default.actions << 'EOF'
# After installing any kernel* package, set the latest CachyOS kernel as the default boot entry
post_transaction:kernel*:in::/usr/bin/sh -c /usr/bin/grubby\ --set-default=/boot/$(ls\ /boot\ |\ grep\ vmlinuz.*cachy\ |\ sort\ -V\ |\ tail\ -1)
EOF

# addons
sudo dnf copr enable bieszczaders/kernel-cachyos-addons
sudo dnf install scx-scheds -y

echo -e "polkit.addRule(function (action, subject) {
  if (action.id.indexOf("org.scx.") === 0 && subject.isInGroup("wheel")) {
    return polkit.Result.YES;
  }
});" | sudo tee /etc/polkit-1/rules.d/99-scx-loader.rules > /dev/null
sudo systemctl restart polkit
#!/bin/bash
device_pref(){
    device_set=0
    device_input=0
    goodies={}

    while [ $device_set = 0 ]; do
        echo "Choose which device you're using."
        echo "[1] - Desktop, [2] - Laptop"
        read -p "Selection: " device_input

        if [ "$device_input" = "1" ] || [ "$device_input" = "2" ]; then

                while true; do
                    # TODO: if goodies has 0 in any array index, ignore other inputs and terminate the selection process
                    echo "Select what goodies you want to install (Can do multiple inputs eg. '1 2 3'):"
                    echo "[1] - vscode"
                    echo "[2] - Unity"
                    echo "[3] - Lutris"
                    echo "[4] - Steam"
                    echo "[0] - None"
                    read -p "Selection: " goodies

                    # If goodies has value/s, break
                    if [ "$goodies" != "0" ] || []; then

                    else
                        echo "Unknown specific input/s. Please try again."
                    fi
                done

            device_set=1
            debloat_process
        else
            echo "Unknown input Please try again."
        fi
    done
}

debloat_process()
{
    echo "------"
    echo "Initiating debloat process..."
    echo "------"

    # debloat process (groups then individual pkgs)
    sudo dnf remove -y @xfce-extra-plugins @input-methods @printing @dial-up @xfce-media @guest-desktop-agents @multimedia @xfce-apps -x ristretto,atril,mousepad,xarchiver,seahorse
    
    if [ "$device_input" = "1" ]; then
        sudo dnf remove -y @networkmanager-submodules -x NetworkManager-wifi,NetworkManager-bluetooth
    else
        sudo dnf remove -y @networkmanager-submodules
    fi

    sudo dnf remove -y localsearch nano abrt dnfdragora-updater cups system-config-printer mediawriter pragha cockpit-system xfce4-taskmanager xfce4-datetime-plugin xfce4-places-plugin

    # enable rpmfusion
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
    sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1

    # clean first before upgrade & installing pkgs to reduce unwanted pkg upgrades
    sudo dnf autoremove -y
    sudo dnf upgrade -y --refresh

    echo "------"
    echo "Debloat process complete."
    echo "------"
EOF
}

package_selection(){


    # multimedia video decoding
    sudo dnf swap -y --allowerasing ffmpeg-free ffmpeg
    sudo dnf swap -y mesa-va-drivers mesa-va-drivers-freeworld

    # general apps
    sudo dnf install -y fuse-devel qbittorrent

    # ufw
    sudo dnf swap -y --allowerasing firewalld ufw
    sudo ufw default deny incoming && sudo ufw default allow outgoing
    sudo ufw enable

    # librewolf
    sudo dnf config-manager addrepo --from-repofile=https://repo.librewolf.net/librewolf.repo
    sudo dnf swap -y firefox librewolf

    # media player
    sudo dnf install -y --setopt=install_weak_deps=False mpv

    # msfonts
    sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig
    sudo rpm -ivh --nodigest https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

    if [ "$device_input" = "1" ]; then
        sudo dnf install -y tlp
    fi

    # TODO: if goodies has 0 in any array index, ignore other inputs and terminate the selection process
    for selection in $goodies; do
        case $selection in
            0)
                break
                ;;
            1)
                echo "Installing VS Code..."
                sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
                sudo dnf install -y code
                ;;
            2)
                echo "Installing Unity Hub..."
                sudo sh -c 'echo -e "[unityhub]\nname=Unity Hub\nbaseurl=https://hub.unity3d.com/linux/repos/rpm/stable\nenabled=1\ngpgcheck=1\ngpgkey=https://hub.unity3d.com/linux/repos/rpm/stable/repodata/repomd.xml.key\nrepo_gpgcheck=1" > /etc/yum.repos.d/unityhub.repo'
                echo "DOTNET_CLI_TELEMETRY_OPTOUT=1" | sudo tee -a /etc/environment
                sudo dnf install -y unityhub dotnet-sdk-8.0 GConf2 git-lfs
                ;;
            3)
                echo "Installing Lutris..."
                sudo dnf install -y lutris vulkan-tools xrandr -x gamescope,fluid-soundfont-gs
                ;;
            4)
                echo "Installing Steam..."
                sudo dnf install steam -y
                ;;
            *)
                echo "Invalid option: $selection"
                ;;
        esac
    done
}

device_pref
package_selection
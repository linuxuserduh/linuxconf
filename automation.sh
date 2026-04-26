#!/bin/bash
device_set=0
device_input=0
goodies=(0, 0, 0, 0, 0)

# Select which platform it's using
device_pref(){
    while [ $device_set -eq 0 ]; do
        echo "Choose which device you're using."
        echo "[1] - Desktop, [2] - Laptop"
        read -p "Selection: " device_input

        if [ "$device_input" -eq "1" ] || [ "$device_input" -eq "2" ]; then
            while [ goodies_set -eq 1 ]; do
                # TODO: if goodies has 0 in any array index, ignore other inputs and terminate the selection process
                echo "Select what goodies you want to install (Can do multiple inputs eg. '1 2 3'):"

                if [goodies[1] -eq "1"]; then
                    echo "[1] - vscode +"
                else
                    echo "[1] - vscode"
                fi

                if [goodies[2] -eq "1"]; then
                    echo "[2] - Unity +"
                else
                    echo "[2] - Unity"

                fi

                if [goodies[3] -eq "1"]; then
                    echo "[3] - Lutris +"
                else
                    echo "[3] - Lutris"
                fi

                if [goodies[4] -eq "1"]; then
                    echo "[4] - Steam +"
                else
                    echo "[4] - Steam"
                fi

                echo "[0] - Finish"
                read -p "Selection: " goodies

                if [ "$goodies[0]" -ne "0" ] || []; then
                    goodies_set=1
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
    
    # if using laptop
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
}

package_selection(){
    # non-free hardware
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
    # for selection in $goodies; do
    #     case $selection in
    #         0)
    #             break
    #             ;;
    #         1 -eq )
    #             echo "Installing VS Code..."
    #             sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
    #             sudo dnf install -y code
    #             ;;
    #         2)
    #             echo "Installing Unity Hub..."
    #             sudo sh -c 'echo -e "[unityhub]\nname=Unity Hub\nbaseurl=https://hub.unity3d.com/linux/repos/rpm/stable\nenabled=1\ngpgcheck=1\ngpgkey=https://hub.unity3d.com/linux/repos/rpm/stable/repodata/repomd.xml.key\nrepo_gpgcheck=1" > /etc/yum.repos.d/unityhub.repo'
    #             echo "DOTNET_CLI_TELEMETRY_OPTOUT=1" | sudo tee -a /etc/environment
    #             sudo dnf install -y unityhub dotnet-sdk-8.0 GConf2 git-lfs
    #             ;;
    #         3)
    #             echo "Installing Lutris..."
    #             sudo dnf install -y lutris vulkan-tools xrandr -x gamescope,fluid-soundfont-gs
    #             ;;
    #         4)
    #             echo "Installing Steam..."
    #             sudo dnf install steam -y
    #             ;;
    #         *)
    #             echo "Invalid option: $selection"
    #             ;;
    #     esac
    done
}

device_pref
package_selection
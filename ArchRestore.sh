#!/usr/bin/env bash
#
# Arch Linux Restore Script
# Alan Franco
# github.com/fzappa
#

USER="user"
MBR="/dev/sda"
ROOT="/dev/sda1"
SWAP="/dev/sda3"

MKFS="mkfs.ext4"
NEWSWAP="NO"  # YES | NO
NEWDISK="YES" # YES | NO

KEYBOARD="br-abnt2"
LANG1="pt_BR.UTF-8 UTF-8"
LANG2="pt_BR.UTF-8"
HOST1="orion"

EDITED="NO" # YES | NO





############### COLORS ###############

RED='\e[0;31m'
REDB='\e[1;31;5m'
GREEN='\e[1;92m'
GREENB='\e[1;92;5m'
BLUE='\e[0;34m'
BLUEB='\e[0;34:5m'
YELLOW='\e[1;33m'
YELLOWB='\e[1;33;5m'
WHITE='\e[1;37m'
WHITEB='\e[1;37:5m'
NC='\e[0m' # No Color



############### BEGIN ###############

if [ $EDITED == "YES" ]; then


  ARCHPKG="Arch-pkglist.txt"
  AURPKG="Aur-pkglist.txt"
  KEY="$1"


  packagelist=( 
  accountsservice acpi acpid alsa-firmware alsa-utils amd-ucode android-tools \ 
  android-udev archlinux-wallpaper archlinux-xdg-menu audacious autoconf \ 
  automake b43-fwcutter bash bind-tools binutils bison blueman boost \ 
  btrfs-progs bzip2 catfish chromium cmake coreutils cpupower crda cronie \ 
  cryptsetup cups cups-pdf cups-pk-helper device-mapper dhclient dhcpcd \ 
  diffutils dmenu dmidecode dmraid dnsmasq dosfstools e2fsprogs \ 
  ecryptfs-utils efibootmgr eigen engrampa evince exfat-utils exo \ 
  f2fs-tools fakeroot feh ffmpegthumbnailer file file-roller filesystem \ 
  findutils firefox flatpak flex galculator-gtk2 garcon gawk gcc \ 
  gcc-libs gcolor2 gettext ghostscript gimp git glibc gnome-icon-theme \ 
  gnome-keyring go gparted grep groff grub gsfonts gst-libav \ 
  gst-plugins-bad gst-plugins-ugly gtk-xfce-engine gufw gvfs \ 
  gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb gzip haskell-iwlib \ 
  haveged hexchat hplip htop inetutils iproute2 iputils ipw2100-fw \ 
  ipw2200-fw jdk8-openjdk jfsutils jq jre8-openjdk jre8-openjdk-headless \ 
  less lib32-flex lib32-gtk3 lib32-libva-intel-driver \ 
  lib32-libva-mesa-driver lib32-libva-vdpau-driver lib32-mesa-demos \ 
  lib32-nvidia-utils libdvdcss libgsf libgtop libopenraw libreoffice-still \ 
  libtool libva-intel-driver libva-mesa-driver libva-vdpau-driver licenses \ 
  light-locker lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings \ 
  linux linux-firmware logrotate lsb-release lshw lvm2 lxappearance-obconf \ 
  m4 make man-db man-pages mc mdadm memtest86+ menumaker mesa-demos \ 
  mlocate mobile-broadband-provider-info modemmanager mousepad mplayer \ 
  mtpfs nano netctl network-manager-applet networkmanager \ 
  networkmanager-openconnect networkmanager-openvpn networkmanager-pptp \ 
  networkmanager-vpnc nfs-utils nss-mdns ntfs-3g ntp numlockx nvidia \ 
  nvidia-settings nvidia-utils obconf oblogout obmenu octave openbox \ 
  openssh opera orage os-prober p7zip pacman pacman-contrib parole \ 
  patch patchutils pavucontrol pciutils pcmanfm perl perl-file-mimeinfo \ 
  pidgin pkgconf poppler-data poppler-glib powertop procps-ng psmisc \ 
  pulseaudio pulseaudio-bluetooth pulseaudio-zeroconf pyqt5-common \ 
  pyside2 python-iwlib python-pillow python-pip python-pyqt5 \ 
  python-reportlab qpdfview qt5-3d qt5-base qt5-canvas3d qt5-charts \ 
  qt5-connectivity qt5-datavis3d qt5-declarative qt5-doc qt5-examples \ 
  qt5-gamepad qt5-graphicaleffects qt5-imageformats qt5-location \ 
  qt5-multimedia qt5-networkauth qt5-purchasing qt5-quickcontrols \ 
  qt5-quickcontrols2 qt5-remoteobjects qt5-script qt5-scxml \ 
  qt5-sensors qt5-serialbus qt5-serialport qt5-speech qt5-svg \ 
  qt5-tools qt5-translations qt5-virtualkeyboard qt5-wayland \ 
  qt5-webchannel qt5-webengine qt5-webglplugin qt5-websockets \ 
  qt5-webview qt5-x11extras qt5-xmlpatterns qtcreator reiserfsprogs \ 
  ristretto rsync s-nail sakura samba screenfetch sed shadow \ 
  smartmontools speedcrunch splix subversion sudo sysfsutils \ 
  system-config-printer systemd systemd-sysvcompat tar \ 
  telegram-desktop terminus-font texinfo texlive-bibtexextra \ 
  texlive-core texlive-fontsextra texlive-formatsextra \ 
  texlive-games texlive-humanities texlive-latexextra \ 
  texlive-music texlive-pictures texlive-pstricks texlive-publishers \ 
  texlive-science texstudio thunar thunar-archive-plugin \ 
  thunar-media-tags-plugin thunar-volman thunderbird tint2 \ 
  tlp translate-shell ttf-bitstream-vera ttf-droid ttf-inconsolata \ 
  ttf-indic-otf ttf-liberation ttf-ubuntu-font-family tumbler \ 
  udiskie udisks2 unace unrar usb_modeswitch usbutils util-linux \ 
  vi viewnior vim virtualbox vlc vnstat volumeicon wget which \ 
  wpa_supplicant xcursor-simpleandsoft xcursor-vanilla-dmz-aa \ 
  xdg-user-dirs xf86-input-elographics xf86-input-evdev \ 
  xf86-input-keyboard xf86-input-mouse xf86-input-void xfburn \ 
  xfce4-appfinder xfce4-artwork xfce4-battery-plugin \ 
  xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin \ 
  xfce4-datetime-plugin xfce4-dict xfce4-diskperf-plugin \ 
  xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin \ 
  xfce4-mailwatch-plugin xfce4-mount-plugin xfce4-mpc-plugin \ 
  xfce4-netload-plugin xfce4-notes-plugin xfce4-notifyd \ 
  xfce4-panel xfce4-power-manager xfce4-pulseaudio-plugin \ 
  xfce4-screenshooter xfce4-sensors-plugin xfce4-session \ 
  xfce4-settings xfce4-smartbookmark-plugin xfce4-systemload-plugin \ 
  xfce4-taskmanager xfce4-terminal xfce4-time-out-plugin \ 
  xfce4-timer-plugin xfce4-verve-plugin xfce4-wavelan-plugin \ 
  xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin \ 
  xfconf xfdesktop xfsprogs xfwm4 xfwm4-themes xorg-twm xorg-xkill \ 
  xterm yelp zsh 
  )


  helpFunction(){
    echo -e "\n\n\t\t################################################"
    echo -e "\t\t#           ${YELLOWB}Arch Linux Restore Script${NC}          #"
    echo -e "\t\t# ${WHITE}$0${NC}                             #"
    echo -e "\t\t# ${BLUE}is a shell script to configure Arch Linux ${NC}   #"
    echo -e "\t\t# ${RED}Author: Alan Franco  -  github.com/fzappa ${NC}   #"
    echo -e "\t\t# ${YELLOW}Date: 05/26/2019${NC}                             #"
    echo -e "\t\t################################################"
    echo -e "\n\tUsage: ${WHITE}$0${NC} ${YELLOW}<option>${NC}\n"
    echo -e "\t${YELLOW}-b ${NC} | ${YELLOW}--backup${NC}\t\t: ${RED}Generate backup list of Arch and Aur packages${NC}"
    echo -e "\t${YELLOW}-ba${NC} | ${YELLOW}--backuparch${NC}\t: ${RED}Generate backup list of Arch packages${NC}"
    echo -e "\t${YELLOW}-bu${NC} | ${YELLOW}--backupaur${NC}\t: ${RED}Generate backup list of Aur packages${NC}"
    echo -e "\t${YELLOW}-r${NC}  | ${YELLOW}--restore${NC}\t\t: ${RED}Restore Arch and Aur packages from previous backup list${NC}"
    echo -e "\t${YELLOW}-ra${NC} | ${YELLOW}--restorearch${NC}\t: ${RED}Restore packages from previous backup list from Arch packages${NC}"
    echo -e "\t${YELLOW}-ru${NC} | ${YELLOW}--restoreaur${NC}\t: ${RED}Restore packages from previous backup list from Aur packages${NC}\n"

    echo -e "\t${YELLOW}      --confLiveCD${NC}\t: ${RED}Configure Arch from livecd${NC}"
    echo -e "\t${YELLOW}      --installLiveCD${NC}\t: ${RED}Install Arch from livecd${NC}"
    echo -e "\t${YELLOW}      --installChroot${NC}\t: ${RED}Install inside arch-chroot${NC}"
    echo -e "\t${YELLOW}      --confSys${NC}\t\t: ${RED}Configure installed system${NC}"
    echo -e "\t${YELLOW}      --installPkgs${NC}\t: ${RED}Install packages${NC}"
    echo -e "\t${YELLOW}      --installYay${NC}\t: ${RED}Install YAY from git${NC}"
    echo -e "\t${YELLOW}      --installYayPkgs${NC}\t: ${RED}Install Yay packages${NC}\n"
    echo -e "\t${YELLOW}      --confUser${NC}\t: ${RED}Create default user account${NC}\n"

    echo -e "\t${YELLOW}      --installNvidia${NC}\t: ${RED}Install NVIDIA and CUDA${NC}"
    echo -e "\t${YELLOW}      --installConky${NC}\t: ${RED}Install Conky from git${NC}"
    echo -e "\t${YELLOW}      --installLDM${NC}\t: ${RED}Install Lightdm login${NC}"
    echo -e "\t${YELLOW}      --restoreOpenBox${NC}\t: ${RED}Restore OpenBox desktop${NC}\n"

    echo -e "\t${YELLOW}      --confMirrorBr${NC}\t: ${RED}Live fastest mirrors config${NC}"
    echo -e "\n\n"
    echo -e "\t\t\t${REDB}!!!   WARNING   !!!${NC}"
    echo -e "\t\t   ${YELLOW}You ${NC}${RED}MUST${NC}${YELLOW} read and edit the script${NC}"
    echo -e "\t\t   ${YELLOW}for your own convenience${NC}\n\n"

    exit 0
  }


  sudotest(){
    if !(hash sudo 2>/dev/null); then
      echo -e "${RED}SUDO not installed.${NC}"
      if [[ $(/usr/bin/id -u) -ne 0 ]]; then # if not root
        echo -e "${YELLOW}Please, login as root and install sudo${NC}"
        exit 1
      else
        echo -e "${YELLOW}Install sudo${NC}"
        pacman -Sy
        pacman -S sudo
      fi
    else
      echo -e "${YELLOW}SUDO already installed.${NC}"
    fi
  }


  backupArch(){ # --backuparch
    echo -e "${YELLOW}Backup Arch packages to $ARCHPKG ${NC}"
    pacman -Qqen > $ARCHPKG
  }


  backupAur(){ # --backupaur
    echo -e "${YELLOW}Backup Aur packages to $AURPKG ${NC}"
    pacman -Qqem > $AURPKG
  }


  restoreArch(){ # --restorearch
    if [ -f "$ARCHPKG" ]; then
      sudotest
      echo -e "${YELLOW}Restore Arch packages from $ARCHPKG$... ${NC}"
      sudo pacman -S --needed $(comm -12 <(pacman -Slq|sort) <(sort $ARCHPKG) )
      echo -e "${YELLOW}Reinstalled all Arch packages\n. ${NC}"
    else
      echo -e "${YELLOW}$ARCHPKG$ file not found ${NC}"
      echo -e "${YELLOW}Run $0 --backuparch before ${NC}"
      exit 1
    fi
    exit 0
  }


  restoreAur(){ # --restoreaur
    if [ -f "$AURPKG" ]; then
      installYay
      echo -e "${YELLOW}Restore AUR packages from $AURPKG...${NC}"
      yay -S --needed --noconfirm - < $AURPKG
      echo -e "${YELLOW}Reinstalled all Aur packages.\n${NC}"
    else
      echo -e "${YELLOW}$AURPKG$ file not found ${NC}"
      echo -e "${YELLOW}Run $0 --backupaur before ${NC}"
      exit 1
    fi
    exit 0
  }


  installYay(){ # --installYay
    if [[ $(/usr/bin/id -u) -ne 0 ]]; then # if not root
      echo -e "${YELLOW}Install YAY... ${NC}"
      echo -e "${YELLOW}Checking Yay dependencies... ${NC}"
      sudotest

      if !(hash git 2>/dev/null ); then
        echo -e "${RED}GIT not installed. ${NC}"
        echo -e "${YELLOW}Install git ${NC}"
        sudo pacman -S git
      else
        echo -e "${YELLOW}Git already installed. ${NC}"
      fi

      if !(hash go 2>/dev/null); then
        echo -e "${RED}GO not installed. ${NC}"
        echo -e "${YELLOW}Install go ${NC}"
        sudo pacman -S go
      else
        echo -e "${YELLOW}GO already installed. ${NC}"
      fi 

      if !(hash yay 2>/dev/null); then
        echo -e "${RED}Yay not installed.${NC}"
        echo -e "${YELLOW}Install Yay${NC}"
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        cd ..
        rm -rf yay
      else
        echo -e "${YELLOW}Yay already installed.${NC}"
      fi
    else
      echo -e "\t${REDB}!!! Install yay as non root user !!!${NC}"
      exit 1
    fi
  }


  confMirrorBr(){ # --confMirrorBr
    echo -e "${YELLOW}Configure MirrorBR...${NC}"
    echo -e "Findind fastest mirrors..."
    if [[ $(/usr/bin/id -u) -ne 0 ]]; then # if not root
      if !(hash rankmirrors 2>/dev/null ); then # if not installed
        sudotest
        echo -e "rankmirrors not installed"
        echo -e "Install pacman-contrib"
        sudo pacman -Sy
        sudo pacman -S pacman-contrib
        confMirrorBr
      else # if installed
        sudotest  
        sudo curl -s "https://www.archlinux.org/mirrorlist/?country=BR&protocol=http&protocol=https&ip_version=4&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -v -n 8 - > /etc/pacman.d/mirrorlist
      fi
    else # if root
      if !(hash rankmirrors 2>/dev/null ); then # if not installed
        echo -e "rankmirrors not installed"
        echo -e "Install pacman-contrib"
        pacman -Sy
        pacman -S pacman-contrib
        confMirrorBr
      else # if installed
        curl -s "https://www.archlinux.org/mirrorlist/?country=BR&protocol=http&protocol=https&ip_version=4&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -v -n 8 - > /etc/pacman.d/mirrorlist
      fi 
    fi
  }


  confLiveCD(){ # --confLiveCD
    echo -e "${YELLOW}Configure from LiveCD...${NC}"
    loadkeys $KEYBOARD
    echo $LANG1 > /etc/locale.gen
    locale-gen
    export LANG=$LANG2
    timedatectl set-ntp true
  
    echo -e "${YELLOW}Add candies to pacman.conf${NC}"
    sed -i '/#Color/c\Color' /etc/pacman.conf
    sed -i '/#CheckSpace/c\CheckSpace' /etc/pacman.conf
    sed -i '/#TotalDownload/c\TotalDownload' /etc/pacman.conf
    sed -i '/#[multilib]/c\[multilib]' /etc/pacman.conf
    sed -i '/#Include = /etc/pacman.d/mirrorlist/c\Include = /etc/pacman.d/mirrorlist' /etc/pacman.conf

  
    echo -e "${YELLOW}Now, creating partitions: ${NC}"
    
    if [ $NEWSWAP == "YES" ]; then
      echo -e "${REDB}Formating $SWAP as swap partition ${NC}"
      echo -e "${YELLOW}mkswap $SWAP${NC}"
      mkswap $SWAP
      echo -e "${YELLOW}swapon $SWAP${NC}"
      swapon $SWAP
    else
      echo -e "${YELLOW}$SWAP will not be formated ${NC}"
      echo -e "${YELLOW}Mounting $SWAP as swap partition ${NC}"
      echo -e "${YELLOW}swapon $SWAP ${NC}"
      swapon $SWAP
    fi

    if [ $NEWDISK == "YES" ]; then
      echo -e "${REDB}Formating $ROOT with $MKFS ${NC}"
      $MKFS $ROOT
      echo -e "${YELLOW}mounting $ROOT on /mnt ${NC}"
      mount $ROOT /mnt
    else
      echo -e "${YELLOW}$ROOT will not be formated ${NC}"
      echo -e "${YELLOW}mounting $ROOT on /mnt ${NC}"
      mount $ROOT /mnt
    fi  

    echo -e "${YELLOW}Run: ${NC} ${RED}$0 --installLiveCD${NC}"
    exit 0
  }


  installLiveCD(){ # --installLiveCD
    echo -e "${YELLOW}Install from LiveCD...${NC}"
    if [ -f "/ArchRestore.sh" ]; then
      cp /ArchRestore.sh /mnt/
    else
      echo -e "${REDB} ArchRestore.sh not found on / ${NC}"
      echo -e "${YELLOW} Copy ArchRestore.sh to / and run${NC}"
      echo -e "${YELLOW} ArchRestore.sh --installLiveCD again.${NC}"
      exit 1
    fi

    if [ -f "/ArchRestore-completion.sh" ]; then
      cp /ArchRestore-completion.sh /mnt/
    else
      echo -e "${RED} ArchRestore-completion.sh not found on / ${NC}"
      echo -e "${YELLOW} Continue...${NC}"
    fi

    confMirrorBr
    pacman -Sy
    pacstrap /mnt base base-devel
    genfstab -p /mnt > /mnt/etc/fstab
    
    echo -e "${YELLOW}Run${NC} ${RED}arch-chroot /mnt${NC}"
    echo -e "${YELLOW}Run${NC} ${RED}./ArchRestore.sh --installChroot${NC}"
    exit 0
  }


  installChroot(){ # --installChroot
    echo -e "${YELLOW}Install inside arch-chroot...${NC}"
    echo -e "${YELLOW}Configure timezone${NC}"

    loadkeys $KEYBOARD
    
    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
    echo -e "${YELLOW}Synchronize clock${NC}"
    timedatectl set-ntp true
    hwclock --systohc

    echo -e "${YELLOW}Configure /etc/locale.gen${NC}"
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    echo $LANG1 >> /etc/locale.gen
    
    locale-gen

    echo -e "${YELLOW}Create /etc/locale.conf${NC}"
    export LANG=$LANG2
    touch /etc/locale.conf
    echo "LANG=$LANG2" > /etc/locale.conf
    echo "LC_ADDRESS=$LANG2" >> /etc/locale.conf
    echo "LC_IDENTIFICATION=$LANG2" >> /etc/locale.conf
    echo "LC_MEASUREMENT=$LANG2" >> /etc/locale.conf
    echo "LC_MONETARY=$LANG2" >> /etc/locale.conf
    echo "LC_NAME=$LANG2" >> /etc/locale.conf
    echo "LC_NUMERIC=$LANG2" >> /etc/locale.conf
    echo "LC_PAPER=$LANG2" >> /etc/locale.conf
    echo "LC_TELEPHONE=$LANG2" >> /etc/locale.conf
    echo "LC_TIME=$LANG2" >> /etc/locale.conf

    cp /etc/locale.conf /etc/default/locale
    
    echo "KEYMAP=$KEYBOARD" > /etc/vconsole.conf

    echo "# KEYBOARD CONFIGURATION FILE" > /etc/default/keyboard
    echo "# Consult the keyboard(5) manual page." >> /etc/default/keyboard
    echo "XKBMODEL=\"pc105\"" >> /etc/default/keyboard
    echo "XKBLAYOUT=\"br\"" >> /etc/default/keyboard
    echo "XKBVARIANT=\"\"" >> /etc/default/keyboard
    echo "XKBOPTIONS=\"\"" >> /etc/default/keyboard
    echo "BACKSPACE=\"guess\"" >> /etc/default/keyboard

    echo -e "${YELLOW}Configure hostname and hosts${NC}"
    echo $HOST1 > /etc/hostname
    echo "127.0.0.1	localhost.localdomain	localhost" > /etc/hosts
    echo "::1		localhost.localdomain	localhost" >> /etc/hosts
    echo "127.0.1.1	$HOST1.localdomain	$HOST1" >> /etc/hosts

    echo -e "${YELLOW}Add candies to pacman.conf${NC}"
    sed -i '/#Color/c\Color' /etc/pacman.conf
    sed -i '/#CheckSpace/c\CheckSpace' /etc/pacman.conf
    sed -i '/#TotalDownload/c\TotalDownload' /etc/pacman.conf
    sed -i '/#[multilib]/c\[multilib]' /etc/pacman.conf
    sed -i '/#Include = /etc/pacman.d/mirrorlist/c\Include = /etc/pacman.d/mirrorlist' /etc/pacman.conf
    
    echo -e "${YELLOW}mkinitcpio -p linux...${NC}\n"
    mkinitcpio -p linux

    echo -e "${YELLOW}Define ROOT password:${NC}\n"
    passwd

    echo -e "${YELLOW}Install grub and os-prober${NC}"
    pacman -S grub os-prober
    
    echo -e "\n${YELLOW}grub-install $MBR${NC}"
    grub-install $MBR
    
    echo -e "\n${YELLOW}Configure /etc/default/grub $MBR${NC}"
    sed -i 's/.*GRUB_DEFAULT=.*/GRUB_DEFAULT=saved/' /etc/default/grub
    sed -i 's/.*GRUB_TIMEOUT_STYLE=.*//' /etc/default/grub
    sed -i '3iGRUB_TIMEOUT_STYLE=menu' /etc/default/grub
    sed -i 's/.*GRUB_SAVEDEFAULT=.*//' /etc/default/grub
    sed -i '10iGRUB_SAVEDEFAULT=true' /etc/default/grub
    
    echo -e "\n${YELLOW}grub-mkconfig -o /boot/grub/grub.cfg${YELLOW}"
    grub-mkconfig -o /boot/grub/grub.cfg
  
    echo -e "\n${YELLOW}Now${NC} ${RED}reboot${NC}"
    exit 0
  }


  installpkgs(){ # --installPkgs
      echo -e "${YELLOW}Install packages...${NC}"
      confMirrorBr
      sudotest
      sudo pacman -S --needed qt xfce4 xfce4-goodies texlive-most
      sudo pacman -S --needed curl jq lm_sensors bind-tools translate-shell
      sudo pacman -S --needed ${packagelist[@]}
  }


  installYayPkgs(){ # --installYayPkgs
    echo -e "${YELLOW}Install Yay packages...${NC}"
    installYay
    yay -S visual-studio-code-bin
    yay -S latex-beamer
    yay -S spotify
    yay -S obkey
    yay -S openbox-themes
    yay -S skypeforlinux-stable-bin
    #yay -S quartus-free
  }


  confUser(){ # --confUser
    echo -e "${YELLOW}Configure admin user...${NC}"
    echo -e "${YELLOW}Create user $USER ${NC}"
    useradd -m -G wheel,disk,users,lp,sys,network,power -s /bin/bash $USER
    passwd $USER
    echo -e "${YELLOW}Add $USER at /etc/sudoers ${NC}"
    sed -i "80i$USER ALL=(ALL) ALL" /etc/sudoers
  }


  installNvidia(){ # --installNvidia
    echo -e "${YELLOW}Install ${GREEN}NVIDIA${NC} ${YELLOW}and Lightdm...${NC}"
    pacman -S nvidia nvidia-settings nvidia-utils
    
    SWAPID=$(blkid -o value -s UUID $SWAP)
    echo -e "${YELLOW}Configure /etc/default/grub${NC}"
    sed -i "$A s/.*GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="\"resume=UUID="$(blkid -o value -s UUID $SWAP)"" rhgb ipv6.disable=1 nouveau.modeset=0 rd.driver.blacklist=nouveau\"/" /etc/default/grub
    sed -i 's/.*GRUB_GFXMODE=.*/GRUB_GFXMODE=1920x1080x32,auto/' /etc/default/grub
    exit 0
  }


  installLDM(){ # --installLDM
    echo -e "${YELLOW}Install Lightdm...{NC}"
    if [[ $(/usr/bin/id -u) -ne 0 ]]; then # if not root
      sudotest
      sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
      sudo systemctl enable lightdm.service --force
    else
      pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
      systemctl enable lightdm.service --force
    fi
  }


  installconky(){ # --installConky
    echo -e "${YELLOW}Install Conky...${NC}"
    if [[ $(/usr/bin/id -u) -ne 0 ]]; then # if not root
      if !(hash sudo 2>/dev/null); then
        echo -e "${RED}SUDO not installed.${NC}"
        echo -e "${YELLOW}Please install sudo${NC}"
        exit 1
      else
        echo -e "${YELLOW}SUDO already installed.${NC}"
    
        git clone https://github.com/brndnmtthws/conky
        cd conky;mkdir build;cd build
        cmake -D CMAKE_BUILD_TYPE=Release -D MAINTAINER_MODE=ON -D BUILD_CURL=ON -D BUILD_LUA_RSVG=ON -D BUILD_LUA_CAIRO=ON -D BUILD_LUA_IMLIB2=ON -D BUILD_IMLIB2=ON -D BUILD_RSS=ON -D BUILD_WEATHER_METAR=ON -D BUILD_WEATHER_XOAP=ON -D BUILD_JOURNAL=ON -D BUILD_WLAN=ON -D BUILD_NVIDIA=ON -D BUILD_XDBE=ON -D BUILD_XSHAPE=ON -D CMAKE_INSTALL_PREFIX=/usr ..
        make -j6
        sudo make install
        cd ..;cd ..
        rm -rf conky
      fi
    else
      echo -e "\t${REDB}!!! Install conky as $USER !!!${NC}"
    fi
    exit 0
  }


  restoreOpenBox(){ # --restoreOpenBox
    if [[ $(/usr/bin/id -u) -ne 0 ]]; then # if not root
      echo -e "${YELLOW}Restore Openbox Autostart...${NC}"

      # echo "(nohup ~/.fehbg &)" > ~/.config/openbox/autostart
      # echo "# Painel Tint2." >> ~/.config/openbox/autostart
      # echo "(nohup /usr/bin/tint2 &)" >> ~/.config/openbox/autostart
      # echo "(nohup /usr/bin/numlockx &)" >> ~/.config/openbox/autostart
      # echo "(nohup /usr/bin/volumeicon &)" >> ~/.config/openbox/autostart
      # echo "(nohup /usr/bin/nm-applet &)" >> ~/.config/openbox/autostart
      # echo "(nohup /usr/bin/pamac-tray &)" >> ~/.config/openbox/autostart
      # echo "" >> ~/.config/openbox/autostart
      # echo "# Monitor Conky." >> ~/.config/openbox/autostart
      # echo "# pacman -S curl jq lm_sensors bind-tools translate-shell" >> ~/.config/openbox/autostart
      # echo "(nohup /usr/bin/conky -b -c ~/.conky/weather-conkyrc &) " >> ~/.config/openbox/autostart
      # echo "(nohup /usr/bin/conky -b -c ~/.conky/my-conkyrc &) " >> ~/.config/openbox/autostart
      # echo "(nohup /usr/bin/conky -b -c ~/.conky/cheat-conkyrc &) " >> ~/.config/openbox/autostart
      # echo "#(nohup /usr/bin/conky -p 3 &) " >> ~/.config/openbox/autostart
      # echo "" >> ~/.config/openbox/autostart
      # echo "$BG -solid \"#303030\"" >> ~/.config/openbox/autostart
      # echo "" >> ~/.config/openbox/autostart
      # echo "export XCURSOR_THEME=\"Ecliz-Arch\"k" >> ~/.config/openbox/autostart
      # echo "export QT_QPA_PLATFORMTHEME=\"qt5ct\"" >> ~/.config/openbox/autostart
      # echo "export QT_AUTO_SCREEN_SCALE_FACTOR=0" >> ~/.config/openbox/autostart

      # echo "#!/bin/sh" > ~/.fehbg
      # echo "/usr/bin/feh --bg-scale '/path-to-image/image.jpg'" >> ~/.fehbg
    else
      echo -e "\t${REDB}!!! Configure OpenBox as $USER !!!${NC}"
      exit 1
    fi
    exit 0
  }


  confSys(){ # --confSys
    if [[ $(/usr/bin/id -u) -ne 0 ]]; then # if not root
      echo -e "\t${REDB}!!! --confSys MUST be run as root !!!${NC}"
      exit 1
    else
      echo -e "${YELLOW}Configure system...${NC}"
      loadkeys $KEYBOARD
      systemctl enable dhcpcd
      systemctl start dhcpcd
      confUser
      confMirrorBr
      installpkgs
      echo -e "${GREEN}Optionally:${NC}"
      echo -e "${YELLOW}\t$0 --installLDM${NC}"
      echo -e "${YELLOW}\t$0 --installYay${NC}"
      echo -e "${YELLOW}\t$0 --installYayPkgs${NC}"
      echo -e "${YELLOW}\t$0 --installNvidia${NC}"
      echo -e "${YELLOW}\t$0 --installConky${NC}"
    fi
  }


  main(){
    case $KEY in
      -b|--backup)
        backupArch
        backupAur
        shift # past argument
        shift # past value
      ;;
      -ba|--backuparch)
        backupArch
        shift # past argument
        shift # past value
      ;;
      -bu|--backupaur)
        backupAur
        shift # past argument
        shift # past value
      ;;
      -r|--restore)
        restoreArch
        restoreAur
        shift # past argument
        shift # past value
      ;;
      -ra|--restorearch)
        restoreArch
        shift # past argument
        shift # past value
      ;;
      -ru|--restoreaur)
        restoreAur
        shift # past argument
        shift # past value
      ;;
      --installYay)
        installYay
        shift # past argument
        shift # past value
      ;;
      --installYayPkgs)
        installYayPkgs
        shift # past argument
        shift # past value
      ;;
      --confLiveCD)
        confLiveCD
        shift # past argument
        shift # past value
      ;;
      --installLiveCD)
        installLiveCD
        shift # past argument
        shift # past value
      ;;
      --installChroot)
        installChroot
        shift
        shift
      ;;
      --installPkgs)
        installpkgs
        shift # past argument
        shift # past value
      ;;
      --confUser)
        confUser
        shift # past argument
        shift # past value
      ;;
      --installNvidia)
        installNvidia
        shift # past argument
        shift # past value
      ;;
      --installConky)
        installconky
        shift # past argument
        shift # past value
      ;;
      --restoreOpenBox)
        restoreOpenBox
        shift # past argument
        shift # past value
      ;;
      --confMirrorBr)
        confMirrorBr
        shift # past argument
        shift # past value
      ;;
      --confSys)
        confSys
        shift # past argument
        shift # past value
      ;;
      --installLDM)
        installLDM
        shift
        shift
      ;;
      *)    # unknown option
        helpFunction
        shift # past argument
      ;;
    esac
  exit 0
  }


  ### Execute Main
  main

else
  echo -e "\t\t\t    ${REDB}!!! WARNING !!!${NC}"
  echo -e "\t${RED}!!! You MUST read and adapt the script before continue !!!${NC}\n\n"
  exit 1
fi




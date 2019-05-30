#!/usr/bin/env bash
#
# Arch Linux Restore Script
# Alan Franco
# github.com/fzappa/archrestore
#

USER=""

### Install
MBR=""  # /dev/sdX
ROOT="" # /dev/sdX1
MKFS="mkfs.ext4"

### Swap
SWAP=""      # /dev/sdX3
NEWSWAP="NO" # YES | NO

### Locale
KEYBOARD="br-abnt2"
LANG=(pt_BR.UTF-8 UTF-8) # "en_US.UTF-8 UTF-8" is default
XKB="localectl set-x11-keymap br abnt2"

### Network and packages
COUNTRY="country=BR"  # "country=BR&country=US"
HOSTNAME="hostname"
PACSTRAP="base"       # "base base-devel"

# Change to "YES" after adapting the script
EDITED="NO" # YES | NO


#############################################################

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


if [ $EDITED == "YES" ]; then


  ARCHPKG="Arch-pkglist.txt"
  AURPKG="Aur-pkglist.txt"
  KEY="$1"

  # Run <./ArchRestore.sh --backupArch> on previous installed system and 
  # paste here the list from file Arch-pkglist.txt.
  # These packages install all you need to run OpenBox and Xfce4 with Lightdm
  packagelist=( 
  accountsservice acpi acpid alsa-firmware alsa-utils amd-ucode android-tools \ 
  android-udev audacious autoconf automake avahi b43-fwcutter bash bind-tools \ 
  binutils bison blueman boost btrfs-progs bzip2 \ 
  cantarell-fonts catfish chromium cmake coreutils cpupower crda cronie \ 
  cryptsetup cups cups-pdf cups-pk-helper device-mapper dhclient dhcpcd \ 
  diffutils dmenu dmidecode dmraid dnsmasq dosfstools e2fsprogs \ 
  ecryptfs-utils efibootmgr eigen engrampa evince exfat-utils exo \ 
  f2fs-tools fakeroot feh ffmpeg ffmpegthumbnailer file file-roller \ 
  filesystem findutils firefox flatpak flex freetype2 galculator-gtk2 \ 
  garcon gawk gcc gcc-libs gcolor2 gettext ghostscript gimp git \ 
  glibc gnome-icon-theme gnome-keyring gnome-themes-extra go \ 
  gparted grep grub gsfonts gst-libav gst-plugins-bad \ 
  gst-plugins-base gst-plugins-good gst-plugins-ugly gtk-engine-murrine gtk3 \ 
  gufw gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb gzip \ 
  haskell-iwlib haveged hexchat hplip htop inetutils iproute2 \ 
  iptables iputils ipw2100-fw ipw2200-fw jdk8-openjdk jfsutils jq \ 
  jre8-openjdk jre8-openjdk-headless less lib32-flex lib32-gtk3 \ 
  lib32-libva-intel-driver lib32-libva-mesa-driver lib32-libva-vdpau-driver \ 
  lib32-mesa-demos lib32-nvidia-utils libdvdcss libgsf libgtop libopenraw \ 
  libreoffice-still libtool libva-intel-driver libva-mesa-driver \ 
  libva-vdpau-driver licenses light-locker lightdm lightdm-gtk-greeter \ 
  lightdm-gtk-greeter-settings linux-firmware linux \ 
  virtualbox-host-modules-arch logrotate lsb-release \ 
  lshw lvm2 lxappearance-obconf m4 make man-db man-pages \ 
  mc mdadm memtest86+ \ 
  menumaker mesa-demos mlocate \ 
  mobile-broadband-provider-info modemmanager mousepad mplayer \ 
  mtpfs nano network-manager-applet networkmanager \ 
  networkmanager-openconnect networkmanager-openvpn networkmanager-pptp \ 
  networkmanager-vpnc nfs-utils nss-mdns ntfs-3g ntp numlockx nvidia-utils \ 
  obconf oblogout obmenu octave openbox \ 
  openresolv openssh opera orage os-prober p7zip pacman patch \ 
  patchutils pavucontrol pciutils pcmanfm-gtk3 perl perl-file-mimeinfo pidgin \ 
  pkgconf poppler-data poppler-glib powertop procps-ng psmisc \ 
  pulseaudio-bluetooth pulseaudio pulseaudio-zeroconf pyqt5-common \ 
  python-iwlib python-pillow python-pip python-pyqt5 python-reportlab \ 
  qtcreator reiserfsprogs rsync s-nail sakura samba screenfetch \ 
  sed shadow simplescreenrecorder smartmontools \ 
  speedcrunch splix subversion sudo sysfsutils \ 
  system-config-printer systemd-sysvcompat tar \ 
  telegram-desktop terminus-font texinfo texlive-bibtexextra texlive-core \ 
  texlive-fontsextra texlive-formatsextra texlive-games texlive-humanities \ 
  texlive-latexextra texlive-music texlive-pictures texlive-pstricks \ 
  texlive-publishers texlive-science texstudio thunar-archive-plugin \ 
  thunar thunar-media-tags-plugin thunar-volman thunderbird tint2 \ 
  tlp translate-shell ttf-bitstream-vera ttf-droid ttf-inconsolata \ 
  ttf-indic-otf ttf-liberation ttf-ubuntu-font-family tumbler udiskie \ 
  udisks2 unace unrar usb_modeswitch usbutils util-linux vi viewnior \ 
  vim virtualbox virtualbox-guest-modules-arch virtualbox-guest-iso \ 
  virtualbox-guest-utils vlc vnstat \ 
  volumeicon wget which wmctrl wpa_supplicant \ 
  xcursor-simpleandsoft xcursor-vanilla-dmz-aa xdg-user-dirs \ 
  xdg-utils xf86-input-elographics xf86-input-evdev xf86-input-keyboard \ 
  xf86-input-libinput xf86-input-mouse xf86-input-void xfburn \ 
  xfce4-appfinder xfce4-battery-plugin xfce4-clipman-plugin \ 
  xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-dict xfce4-diskperf-plugin \ 
  xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-mailwatch-plugin \ 
  xfce4-mount-plugin xfce4-mpc-plugin xfce4-netload-plugin xfce4-notes-plugin \ 
  xfce4-notifyd xfce4-panel xfce4-power-manager \ 
  xfce4-pulseaudio-plugin xfce4-screenshooter xfce4-sensors-plugin \ 
  xfce4-session xfce4-settings xfce4-smartbookmark-plugin \ 
  xfce4-systemload-plugin xfce4-taskmanager xfce4-terminal \ 
  xfce4-time-out-plugin xfce4-timer-plugin xfce4-verve-plugin \ 
  xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin \ 
  xfce4-xkb-plugin xfconf xfdesktop xfsprogs xfwm4 \ 
  xorg-server xorg-twm xorg-xinit xorg-xkill xterm yelp zsh 
  )


  helpFunction(){
    echo -e "\t#################################################################"
    echo -e "\t#\t\t\t${YELLOWB}Arch Linux Restore Script${NC}\t\t#"
    echo -e "\t# ${WHITE}$0${NC}\t\t\t\t\t\t#"
    echo -e "\t# ${BLUE}is a shell script to configure Arch Linux ${NC}\t\t\t#"
    echo -e "\t# ${RED}Author: Alan Franco  -  github.com/fzappa/archrestore ${NC}\t#"
    echo -e "\t# ${YELLOW}Date: 05/26/2019${NC}\t\t\t\t\t\t#"
    echo -e "\t#################################################################\n"
    echo -e "\tUsage: ${WHITE}$0${NC} ${YELLOW}<option>${NC}\n"
    echo -e "\t${YELLOW}-b ${NC} | ${YELLOW}--backup${NC}\t\t: ${RED}Generate backup list of Arch and Aur packages${NC}"
    echo -e "\t${YELLOW}-ba${NC} | ${YELLOW}--backupArch${NC}\t: ${RED}Generate backup list of Arch packages${NC}"
    echo -e "\t${YELLOW}-bu${NC} | ${YELLOW}--backupAur${NC}\t: ${RED}Generate backup list of Aur packages${NC}"
    echo -e "\t${YELLOW}-r${NC}  | ${YELLOW}--restore${NC}\t\t: ${RED}Restore Arch and Aur packages from previous backup list${NC}"
    echo -e "\t${YELLOW}-ra${NC} | ${YELLOW}--restoreArch${NC}\t: ${RED}Restore packages from previous backup list from Arch packages${NC}"
    echo -e "\t${YELLOW}-ru${NC} | ${YELLOW}--restoreAur${NC}\t: ${RED}Restore packages from previous backup list from Aur packages${NC}\n"

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
    echo -e "\t${YELLOW}      --installGdrive${NC}\t: ${RED}Install drive for Google Drive${NC}"

    echo -e "\n\t${YELLOW}      --restoreMyConf${NC}\t: ${RED}Restore my configs${NC} ${GREEN}=>${NC} ${WHITE}Config as your flavor. ;)${NC}"

    echo -e "\n\t${YELLOW}      --confMirror${NC}\t: ${RED}Live fastest mirrors config${NC}"
    echo -e "\n"
    echo -e "\t\t\t${REDB}!!!   WARNING   !!!${NC}"
    echo -e "\t\t${YELLOW}You ${NC}${RED}MUST${NC}${YELLOW} read and edit the script${NC}"
    echo -e "\t\t${YELLOW}for your own convenience${NC}\n\n"

    exit 0
  }

  ###### BEGIN TEST FUNCTIONS ######

  testmbr(){
    if [[ -z "${MBR//}" ]]; then # if is empty
      echo -e "${RED}ERRO:${NC} ${YELLOW}MBR disk not defined.${NC}"
      read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
      exit 1
    fi
  }

  sudotest(){
    if !(hash sudo 2>/dev/null); then
      echo -e "${RED}SUDO not installed.${NC}"
      if [[ $(/usr/bin/id -u) -ne 0 ]]; then
        echo -e "${RED}ERRO:${NC} ${YELLOW}Please, login as root and install sudo${NC}"
        read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
        exit 1
      else
        echo -e "${YELLOW}Install sudo${NC}"
        pacman -Sy
        pacman -S --needed sudo
      fi
    else
      echo -e "${YELLOW}SUDO already installed.${NC}"
    fi
  }

  roottest(){
    if [[ $(/usr/bin/id -u) -ne 0 ]]; then
      echo -e "${RED}ERRO:${NC} ${YELLOW}This must be run as root${NC}"
      read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
      exit 1
    else
      echo -e "${REDB}Runing as root${NC}"
    fi
  }

  notroottest(){
    if [[ $(/usr/bin/id -u) -ne 0 ]]; then
      echo -e "${GREENB}Runing as user${NC}"
    else
      echo -e "${RED}ERRO:${NC} ${YELLOW}This must be run as user${NC}"
      read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
      exit 1
    fi
  }


  ###### END TEST FUNCTIONS ######



  ###### BEGIN PROGRAM FUNCTIONS ######

  backupArch(){ #begin --backupArch
    echo -e "${YELLOW}Backup Arch packages to $ARCHPKG ${NC}"
    pacman -Qqen > $ARCHPKG
  } #end --backupArch


  backupAur(){ #begin --backupAur
    echo -e "${YELLOW}Backup Aur packages to $AURPKG ${NC}"
    pacman -Qqem > $AURPKG
  } #end --backupAur


  restoreArch(){ #begin --restoreArch
    if [ -f "$ARCHPKG" ]; then
      sudotest
      echo -e "${YELLOW}Restore Arch packages from $ARCHPKG$... ${NC}"
      sudo pacman -S --needed $(comm -12 <(pacman -Slq|sort) <(sort $ARCHPKG) )
      echo -e "${YELLOW}Reinstalled all Arch packages\n. ${NC}"
    else
      echo -e "${RED}ERRO:${NC} ${YELLOW}$ARCHPKG$ file not found ${NC}"
      echo -e "${YELLOW}Run $0 --backupArch before ${NC}"
      read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
      exit 1
    fi
    exit 0
  } #end --restoreArch


  restoreAur(){ #begin --restoreAur
    if [ -f "$AURPKG" ]; then
      echo -e "${YELLOW}Restore AUR packages from $AURPKG...${NC}"
      notroottest
      installYay
      yay -S --needed --noconfirm - < $AURPKG
      echo -e "${YELLOW}Reinstalled all Aur packages.\n${NC}"
    else
      echo -e "${RED}ERRO:${NC} ${YELLOW}$AURPKG$ file not found ${NC}"
      echo -e "${YELLOW}Run $0 --backupAur before ${NC}"
      read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
      exit 1
    fi
    exit 0
  } #end --restoreAur


  installYay(){ #begin --installYay
    echo -e "${YELLOW}Install YAY... ${NC}"
    notroottest
    echo -e "${YELLOW}Checking Yay dependencies... ${NC}"
    sudotest

    if !(hash git 2>/dev/null ); then
      echo -e "${RED}GIT not installed. ${NC}"
      echo -e "${YELLOW}Install git ${NC}"
      sudo pacman -S --needed git
    else
      echo -e "${YELLOW}Git already installed. ${NC}"
    fi

    if !(hash go 2>/dev/null); then
      echo -e "${RED}GO not installed. ${NC}"
      echo -e "${YELLOW}Install Go ${NC}"
      echo -e "${YELLOW}Check if $USER is in /home dir...${NC}"
      if [ -d "/home/$USER" ]; then
	      echo -e "${YELLOW}/home/$USER found!${NC}"
        echo -e "${YELLOW}Creating /home/$USER/gopath${NC}"
        mkdir -p /home/$USER/gopath/tmp
        chown $USER:$USER /home/$USER/gopath -R
        sudo pacman -S --needed go
      else
	      echo -e "${RED}404 ERROR!${NC} ${YELLOW}/home/$USER not found!${NC}"
        read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
	      exit 1
      fi
    else
      echo -e "${YELLOW}GO already installed. ${NC}"
    fi 

    if !(hash yay 2>/dev/null); then
      echo -e "${RED}Yay not installed.${NC}"
      echo -e "${YELLOW}Install Yay${NC}"
      if [ ! -d "/home/$USER/gopath/tmp" ]; then
        echo -e "${YELLOW}/home/$USER/gopath/tmp not found!${NC}"
        echo -e "${YELLOW}Creating /home/$USER/gopath/tmp${NC}"
        mkdir -p /home/$USER/gopath/tmp
        chown $USER:$USER /home/$USER/gopath -R
      fi
      git clone https://aur.archlinux.org/yay.git
      cd yay
      makepkg -si
      cd ..
      rm -rf yay
    else
      echo -e "${YELLOW}Yay already installed.${NC}"
    fi
  } #end --installYay


  confMirror(){ #begin --confMirror
    echo -e "${YELLOW}Configure Mirror...${NC}"
    roottest
    if !(hash rankmirrors 2>/dev/null ); then # if not installed
      echo -e "rankmirrors not installed"
      echo -e "Install pacman-contrib"
      pacman -Sy
      pacman -S --needed pacman-contrib
      confMirror
    else # if installed
      echo -e "${YELLOW}Findind fastest mirrors...${NC}"
      curl -s "https://www.archlinux.org/mirrorlist/?$COUNTRY&protocol=http&protocol=https&ip_version=4&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -v -n 8 - 2>&1 | tee /etc/pacman.d/mirrorlist
    fi 
  } #end --confMirror


  confLiveCD(){ #begin --confLiveCD
    echo -e "${YELLOW}Configure from LiveCD...${NC}"
    testmbr
    roottest
    loadkeys $KEYBOARD
    echo ${LANG[*]} > /etc/locale.gen
    locale-gen
    export LANG=${LANG[0]}
    timedatectl set-ntp true
  
    echo -e "${YELLOW}Add candies to pacman.conf${NC}"
    sed -i 's/.*#Color.*/Color/' /etc/pacman.conf
    sed -i 's/.*#CheckSpace.*/CheckSpace/' /etc/pacman.conf
    sed -i 's/.*#TotalDownload.*/TotalDownload/' /etc/pacman.conf
    sed -i 's/.*\#\[multilib\].*/\[multilib\]/' /etc/pacman.conf
    sed -i '/\[multilib\]/!b;n;cInclude = /etc/pacman.d/mirrorlist' /etc/pacman.conf 

  
    echo -e "${YELLOW}Now, creating partitions: ${NC}"
    
    if [ $NEWSWAP == "YES" ] && [[ -n "${SWAP//}" ]]; then # if yes and not empty
      echo -e "${REDB}Formating $SWAP as swap partition ${NC}"
      echo -e "${YELLOW}mkswap $SWAP${NC}"
      mkswap $SWAP
      echo -e "${YELLOW}swapon $SWAP${NC}"
      swapon $SWAP
    elif [ $NEWSWAP == "NO" ] && [[ -n "${SWAP//}" ]]; then # if no and not empty
      echo -e "${YELLOW}$SWAP will not be formated ${NC}"
      echo -e "${YELLOW}Mounting $SWAP as swap partition ${NC}"
      echo -e "${YELLOW}swapon $SWAP ${NC}"
      swapon $SWAP
    elif [[ -z "${SWAP//}" ]]; then  # if empty
      echo -e "${RED}SWAP will not be created ${NC}"
      read -p "$(echo -e ${REDB}"Press any key to continue..."${NC})"
    fi

    if [[ -n "${ROOT//}" ]]; then # if not empty
      echo -e "${REDB}Formating $ROOT with $MKFS ${NC}"
      $MKFS $ROOT
      echo -e "${YELLOW}mounting $ROOT on /mnt ${NC}"
      mount $ROOT /mnt
      echo -e "${YELLOW}Run: ${NC} ${RED}$0 --installLiveCD${NC}"
    else
      echo -e "${RED}ERRO: System will not be installed${NC}"
      echo -e "${YELLOW}ROOT disk (/) not exists ${NC}"
      read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
      exit 1
    fi     
    exit 0
  } #end --confLiveCD


  installLiveCD(){ #begin --installLiveCD
    echo -e "${YELLOW}Install from LiveCD...${NC}"
    roottest
    if [ -f "/ArchRestore.sh" ]; then
      cp /ArchRestore.sh /mnt/
    else
      echo -e "${RED} ArchRestore.sh not found on / ${NC}"
      echo -e "${YELLOW} Copy ArchRestore.sh to / and run${NC}"
      echo -e "${YELLOW} ArchRestore.sh --installLiveCD again.${NC}"
      read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
      exit 1
    fi

    if [ -f "/ArchRestore-completion.sh" ]; then
      cp /ArchRestore-completion.sh /mnt/
    else
      echo -e "${RED} ArchRestore-completion.sh not found on / ${NC}"
      read -p "$(echo -e ${REDB}"Press any key to continue..."${NC})"
    fi

    confMirror
    pacman -Sy
    pacstrap /mnt $PACSTRAP
    genfstab -p /mnt > /mnt/etc/fstab
    
    echo -e "${GREEN}The system is ready to arch-chroot${NC}"
    echo -e "${YELLOW}Run${NC} ${RED}arch-chroot /mnt${NC}"
    echo -e "${YELLOW}Run${NC} ${RED}./ArchRestore.sh --installChroot${NC}"
    exit 0
  } #end --installLiveCD


  installChroot(){ #begin --installChroot
    echo -e "${YELLOW}Install inside arch-chroot...${NC}"
    testmbr
    roottest
    echo -e "${YELLOW}Configure timezone${NC}"

    loadkeys $KEYBOARD
    
    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
    echo -e "${YELLOW}Synchronize clock${NC}"
    pacman -S --needed ntp
    sed -i 's/0.arch.pool.ntp.org.*/a.st1.ntp.br/' /etc/ntp.conf
    sed -i 's/1.arch.pool.ntp.org.*/b.st1.ntp.br/' /etc/ntp.conf
    sed -i 's/2.arch.pool.ntp.org.*/c.st1.ntp.br/' /etc/ntp.conf
    sed -i 's/3.arch.pool.ntp.org.*/d.st1.ntp.br/' /etc/ntp.conf
    systemctl start ntpd
    systemctl enable ntpd

    echo -e "${YELLOW}Configure /etc/locale.gen${NC}"
    echo ${LANG[*]} >> /etc/locale.gen
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    
    locale-gen

    echo -e "${YELLOW}Create /etc/locale.conf${NC}"
    export LANG=${LANG[0]}
    touch /etc/locale.conf
    echo "LANG=${LANG[0]}" > /etc/locale.conf
    echo "LC_ADDRESS=${LANG[0]}" >> /etc/locale.conf
    echo "LC_IDENTIFICATION=${LANG[0]}" >> /etc/locale.conf
    echo "LC_MEASUREMENT=${LANG[0]}" >> /etc/locale.conf
    echo "LC_MONETARY=${LANG[0]}" >> /etc/locale.conf
    echo "LC_NAME=${LANG[0]}" >> /etc/locale.conf
    echo "LC_NUMERIC=${LANG[0]}" >> /etc/locale.conf
    echo "LC_PAPER=${LANG[0]}" >> /etc/locale.conf
    echo "LC_TELEPHONE=${LANG[0]}" >> /etc/locale.conf
    echo "LC_TIME=${LANG[0]}" >> /etc/locale.conf

    cp /etc/locale.conf /etc/default/locale
    
    echo "KEYMAP=$KEYBOARD" > /etc/vconsole.conf

    echo "# KEYBOARD CONFIGURATION FILE" > /etc/default/keyboard
    echo "# Consult the keyboard(5) manual page." >> /etc/default/keyboard
    echo "XKBMODEL=\"abnt2\"" >> /etc/default/keyboard
    echo "XKBLAYOUT=\"br\"" >> /etc/default/keyboard
    echo "XKBVARIANT=\"abnt2\"" >> /etc/default/keyboard
    echo "XKBOPTIONS=\"terminate:ctrl_alt_bksp\"" >> /etc/default/keyboard
    echo "BACKSPACE=\"guess\"" >> /etc/default/keyboard

    echo -e "${YELLOW}Configure hostname and hosts${NC}"
    echo $HOSTNAME > /etc/hostname
    echo "127.0.0.1	localhost.localdomain	localhost" > /etc/hosts
    echo "::1		localhost.localdomain	localhost" >> /etc/hosts
    echo "127.0.1.1	$HOSTNAME.localdomain	$HOSTNAME" >> /etc/hosts

    echo -e "${YELLOW}Add candies to pacman.conf${NC}"
    sed -i 's/.*#Color.*/Color/' /etc/pacman.conf
    sed -i 's/.*#CheckSpace.*/CheckSpace/' /etc/pacman.conf
    sed -i 's/.*#TotalDownload.*/TotalDownload/' /etc/pacman.conf
    sed -i 's/.*\#\[multilib\].*/\[multilib\]/' /etc/pacman.conf
    sed -i '/\[multilib\]/!b;n;cInclude = /etc/pacman.d/mirrorlist' /etc/pacman.conf 
    
    echo -e "${YELLOW}mkinitcpio -p linux...${NC}\n"
    mkinitcpio -p linux

    echo -e "${YELLOW}Define ROOT password:${NC}\n"
    passwd

    echo -e "${YELLOW}Install grub and os-prober${NC}"
    pacman -S --needed grub os-prober
    
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
  } #end --installChroot


  installPkgs(){ #begin --installPkgs
      echo -e "${YELLOW}Install packages...${NC}"
      roottest
      confMirror
      pacman -S --needed ${packagelist[@]}

      echo -e "${YELLOW}Disable dhcpcd...${NC}"
      systemctl stop dhcpcd
      systemctl disable dhcpcd

      echo -e "${YELLOW}Enable Network Manager...${NC}"
      systemctl enable NetworkManager.service
      systemctl start NetworkManager.service
      
      echo -e "${YELLOW}Configure xkb layout...${NC}"
      eval $XKB

      echo -e "${YELLOW}Install polkit rules...${NC}"
      tee /etc/polkit-1/rules.d/99-archrestore.rules << ENDRULES
polkit.addRule(function(action, subject) {
    if (action.id.indexOf("org.freedesktop.udisks2.") == 0 && subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});

polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.login1.power-off" ||
        action.id == "org.freedesktop.login1.reboot" ||
        action.id == "org.freedesktop.login1.hibernate" ||
        action.id == "org.freedesktop.login1.suspend") {
        return polkit.Result.YES;
    }
});

polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.upower.hibernate" ||
        action.id == "org.freedesktop.upower.suspend") {
        return polkit.Result.YES;
    }
});

/* Allow users of network group to use blueman feature requiring root without authentication */
polkit.addRule(function(action, subject) {
    if ((action.id == "org.blueman.network.setup" ||
         action.id == "org.blueman.dhcp.client" ||
         action.id == "org.blueman.rfkill.setstate" ||
         action.id == "org.blueman.pppd.pppconnect") &&
        subject.isInGroup("network")) {
        return polkit.Result.YES;
    }
});
ENDRULES

    echo -e "${YELLOW}Packages installed.${NC}"
    read -p "$(echo -e ${REDB}"Press any key to continue..."${NC})"

  } #end --installPkgs


  installYayPkgs(){ #begin --installYayPkgs
    echo -e "${YELLOW}Install Yay packages...${NC}"
    notroottest
    installYay
    yay -S visual-studio-code-bin
    yay -S latex-beamer
    yay -S spotify
    yay -S obkey
    yay -S openbox-themes
    yay -S skypeforlinux-stable-bin
    #yay -S quartus-free
  } #end --installYayPkgs


  confUser(){ #begin --confUser
    echo -e "${YELLOW}Configure admin user...${NC}"
    if [[ -z "${USER//}" ]]; then  # if empty
      echo -e "${RED}ERROR: Admin user will not be created ${NC}"
      echo -e "${YELLOW}USER not defined.${NC}"
      read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
      exit 1
    else
      sudotest
      roottest
      echo -e "${YELLOW}Create user $USER ${NC}"
      useradd -m -G wheel,lp,sys,network,power -s /bin/bash $USER
      passwd $USER
      echo -e "${YELLOW}Add $USER at /etc/sudoers ${NC}"
      sed -i "80i$USER ALL=(ALL) ALL" /etc/sudoers
    fi
  } #end --confUser


  installNvidia(){ #begin --installNvidia
    echo -e "${YELLOW}Install ${NC}${GREEN}NVIDIA${NC}"
    roottest
    pacman -S --needed nvidia nvidia-settings nvidia-utils
    SWAPID=$(blkid -o value -s UUID $SWAP)
    echo -e "${YELLOW}Configure /etc/default/grub${NC}"
    sed -i "$A s/.*GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="\"resume=UUID="$(blkid -o value -s UUID $SWAP)"" rhgb ipv6.disable=1 nouveau.modeset=0 rd.driver.blacklist=nouveau\"/" /etc/default/grub
    sed -i 's/.*GRUB_GFXMODE=.*/GRUB_GFXMODE=1920x1080x32,auto/' /etc/default/grub
    
    echo -e "${YELLOW}Update grub ...${NC}"
    grub-mkconfig -o /boot/grub/grub.cfg
    
    echo -e "${GREEN}Optionally:${NC}"
    echo -e "${YELLOW}\t$0 --installLDM${NC}"

    exit 0
  } #begin --installNvidia


  installLDM(){ #begin --installLDM
    echo -e "${YELLOW}Install Lightdm...${NC}"
    roottest
    pacman -S --needed lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
    systemctl enable lightdm.service --force
  } #end --installLDM


  installConky(){ #begin --installConky
    echo -e "${YELLOW}Install Conky...${NC}"
    sudotest
    notroottest
    
    git clone https://github.com/brndnmtthws/conky
    cd conky;mkdir build;cd build
    cmake -D CMAKE_BUILD_TYPE=Release -D MAINTAINER_MODE=ON -D BUILD_CURL=ON -D BUILD_LUA_RSVG=ON -D BUILD_LUA_CAIRO=ON -D BUILD_LUA_IMLIB2=ON -D BUILD_IMLIB2=ON -D BUILD_RSS=ON -D BUILD_WEATHER_METAR=ON -D BUILD_WEATHER_XOAP=ON -D BUILD_JOURNAL=ON -D BUILD_WLAN=ON -D BUILD_NVIDIA=ON -D BUILD_XDBE=ON -D BUILD_XSHAPE=ON -D CMAKE_INSTALL_PREFIX=/usr ..
    make -j6
    sudo make install
    cd ..;cd ..
    rm -rf conky
  } #end --installConky

  installGdrive(){ #begin --installGdrive
    # https://github.com/odeke-em/drive#
    echo -e "${YELLOW}Install drive for Google Drive...${NC}"
    notroottest
    installYay # just to check if has Go and Git installed...
    echo -e "${YELLOW}Install github.com/odeke-em/drive/...${NC}"
    export GOPATH=/home/$USER/gopath
    go get -u github.com/odeke-em/drive/cmd/drive
  } #end --installGdrive

  confSys(){ #begin --confSys
    echo -e "${YELLOW}Configure system...${NC}"
    roottest
    loadkeys $KEYBOARD
    systemctl enable ntpd
    systemctl start ntpd
    systemctl enable dhcpcd
    systemctl start dhcpcd
    echo -e "${GREEN}Optionally:${NC}"
    echo -e "${YELLOW}\t$0 --confUser${NC}"
    echo -e "${YELLOW}\t$0 --confMirror${NC}"
    echo -e "${YELLOW}\t$0 --installPkgs${NC}"
    echo -e "${YELLOW}\t$0 --installLDM${NC}"
    echo -e "${YELLOW}\t$0 --installYay${NC}"
    echo -e "${YELLOW}\t$0 --installYayPkgs${NC}"
    echo -e "${YELLOW}\t$0 --installNvidia${NC}"
    echo -e "${YELLOW}\t$0 --installConky${NC}"
    echo -e "${YELLOW}\n\t$0 --restoreMyConf${NC}"
    
    exit 0
  } #end --confSys




  restoreMyConf(){ # --restoreMyConf
    echo -e "${YELLOW}Restore my configs...${NC}"
    notroottest
    
    echo -e "${YELLOWB}Edit this as your flavor ;)${NC}"
    
  }



  ###### END PROGRAM FUNCTIONS ######



  ###### BEGIN MAIN FUNCTION ######

  main(){
    case $KEY in
      -b|--backup)
        backupArch
        backupAur
        shift # past argument
        shift # past value
      ;;
      -ba|--backupArch)
        backupArch
        shift 
        shift 
      ;;
      -bu|--backupAur)
        backupAur
        shift 
        shift 
      ;;
      -r|--restore)
        restoreArch
        restoreAur
        shift 
        shift 
      ;;
      -ra|--restoreArch)
        restoreArch
        shift 
        shift 
      ;;
      -ru|--restoreAur)
        restoreAur
        shift 
        shift 
      ;;
      --installYay)
        installYay
        shift 
        shift 
      ;;
      --installYayPkgs)
        installYayPkgs
        shift 
        shift
      ;;
      --confLiveCD)
        confLiveCD
        shift 
        shift 
      ;;
      --installLiveCD)
        installLiveCD
        shift 
        shift
      ;;
      --installChroot)
        installChroot
        shift
        shift
      ;;
      --installPkgs)
        installPkgs
        shift 
        shift 
      ;;
      --confUser)
        confUser
        shift 
        shift 
      ;;
      --installNvidia)
        installNvidia
        shift 
        shift 
      ;;
      --installConky)
        installConky
        shift 
        shift 
      ;;
      --restoreMyConf)
        restoreMyConf
        shift 
        shift 
      ;;
      --confMirror)
        confMirror
        shift 
        shift 
      ;;
      --installGdrive)
        installGdrive
        shift
        shift
      ;;
      --confSys)
        confSys
        shift 
        shift 
      ;;
      --installLDM)
        installLDM
        shift
        shift
      ;;
      *) # unknown option
        helpFunction
        shift 
      ;;
    esac
  exit 0
  }

  ###### END MAIN FUNCTION ######


  ### Execute Main
  main


else
  echo -e "\t\t\t    ${REDB}!!! WARNING !!!${NC}"
  echo -e "\t${RED}!!! You MUST read and adapt the script before continue !!!${NC}\n\n"
  exit 1
fi


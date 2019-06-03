#!/usr/bin/env bash
#sudo dd if=iso of=/dev/sdX bs=1M status=progress oflag=direct conv=sync
#https://www.archlinux.org/groups/x86_64/
#https://linuxhint.com/install_xfce_manjaro_linux/
#https://forum.manjaro.org/t/bootsplash-provided-by-the-kernel/34467/170
#https://misc.flogisoft.com/bash/tip_colors_and_formatting
#source ArchRestoreAutoComp.sh

USER="alan"

### Install
MBR="/dev/sda"   # /dev/sdX
ROOT="/dev/sda4" # /dev/sdX1
MKFS="mkfs.ext4"

### Swap
SWAP="/dev/sdd3" # /dev/sdX3
NEWSWAP="NO"     # YES | NO

### Locale
KEYBOARD="br-abnt2"
LANG=(pt_BR.UTF-8 UTF-8) # "en_US.UTF-8 UTF-8" is default
XKB="localectl set-x11-keymap br abnt2"

### Network and packages
COUNTRY="country=BR"       # "country=BR&country=US"
HOSTNAME="urania"
PACSTRAP="base base-devel" # "base base-devel"

# Change to "YES" after adapting the script
EDITED="YES" # YES | NO


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


  KEY="$1"

  ## awk '{printf "%s"" ",$0}' Arch-pkglist.txt > pkgline.txt
  # Run <./ArchRestore.sh --backupArch> on previous installed system and 
  # paste here the list from file Arch-pkglist.txt.



  ###### BEGIN MAIN FUNCTION ######

  main(){

    # Load all functions
    if [ -d "src" ]; then
      for f in src/*.sh; do 
        source $f; 
      done
    else
      echo -e "${REDB}ERRO: src/ folder not found!${NC}"
      echo -e "${RED}Unable to continue install.${NC}"
      exit 1
    fi

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
      --install)
        install
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

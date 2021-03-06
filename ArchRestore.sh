#!/usr/bin/env bash
#
# Arch Linux Restore Script
# Alan Franco
# github.com/fzappa/archrestore
#
# Following the K.I.S.S. principle (Keep It Simple, Stupid!) ;)
#
# First version date: 05/26/2019
# last update date:  05/22/2020

USER="user"
HOSTNAME="hostname"

### Install (/)
MBR=""  # /dev/sdX
ROOT="" # /dev/sdX1
MKFS="mkfs.ext4"

### Swap
SWAP=""      # /dev/sdX3
NEWSWAP="NO" # YES | NO

### Network and packages
DHCP="YES" # YES | NO

# Define if static IPv4
IFACE="ens33"
IP="10.0.0.10/24" # IP/Mask
GW="10.0.0.1"     #
DNS="8.8.8.8"     #

# To get the list from: https://www.archlinux.org/mirrorlist/
COUNTRY="country=BR" # "country=BR&country=US"...



### Locale
KEYBOARD="br-abnt2"
LANG=(pt_BR.UTF-8 UTF-8) # "en_US.UTF-8 UTF-8" is default
XKB="localectl set-x11-keymap br abnt2"

PACSTRAP="base linux linux-firmware" # "base linux linux-firmware base-devel"

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

    KEY="$1"

    ###### BEGIN MAIN FUNCTION ######

    main() {

        # Load all functions
        if [ -d "src" ]; then
            for f in src/*.sh; do
                source $f
            done
        else
            echo -e "${REDB}ERRO: src/ folder not found!${NC}"
            echo -e "${RED}Unable to continue install.${NC}"
            exit 1
        fi

        case $KEY in
        ###BEGIN backupRestore.sh
        -b | --backup)
            backupArch
            backupAur
            shift # past argument
            shift # past value
            ;;
        -ba | --backupArch)
            backupArch
            shift
            shift
            ;;
        -bu | --backupAur)
            backupAur
            shift
            shift
            ;;
        -r | --restore)
            restoreArch
            restoreAur
            shift
            shift
            ;;
        -ra | --restoreArch)
            restoreArch
            shift
            shift
            ;;
        -ru | --restoreAur)
            restoreAur
            shift
            shift
            ;;
            ###END backupRestore.sh
        --confNetwork)
            confNetwork
            shift
            shift
            ;;
        --confLiveCD)
            confLiveCD
            shift
            shift
            ;;
        --confMirror)
            confMirror
            shift
            shift
            ;;
        --confSys)
            confSys
            shift
            shift
            ;;
        --confUser)
            confUser
            shift
            shift
            ;;
        --install)
            install
            shift
            shift
            ;;
        --installChroot)
            installChroot
            shift
            shift
            ;;
        --installConky)
            installConky
            shift
            shift
            ;;
        --installPolybar)
            installPolybar
            shift
            shift
            ;;
        --installGdrive)
            installGdrive
            shift
            shift
            ;;
        --installLDM)
            installLDM
            shift
            shift
            ;;
        --installLiveCD)
            installLiveCD
            shift
            shift
            ;;
        --installNvidia)
            installNvidia
            shift
            shift
            ;;
        --installPkgs)
            installPkgs
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
        --restoreMyConf)
            restoreMyConf
            shift
            shift
            ;;
        --installXfce)
            installXfce
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

    source src/helpFunction.sh
    helpFunction
    echo -e "\t\t\t    ${REDB}!!! WARNING !!!${NC}"
    echo -e "\t${RED}!!! You MUST read and adapt the script before continue !!!${NC}\n\n"
    exit 1
fi

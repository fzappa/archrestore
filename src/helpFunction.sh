helpFunction(){
    echo -e "\t#################################################################"
    echo -e "\t#\t\t\t${YELLOWB}Arch Linux Restore Script${NC}\t\t#"
    echo -e "\t# ${WHITE}$0${NC}\t\t\t\t\t\t#"
    echo -e "\t# ${BLUE}This is a shell script to install and configure Arch Linux ${NC}\t#"
    echo -e "\t# ${RED}Author: Alan Franco\t-\tgithub.com/fzappa/archrestore ${NC}\t#"
    echo -e "\t# ${YELLOW}Version: 1.2.17${NC} \t\t${YELLOW}Date: 22/05/2020${NC}\t\t#"
    echo -e "\t#################################################################\n"
    echo -e "\tUsage: ${WHITE}$0${NC} ${YELLOW}<option>${NC}\n"
    echo -e "\t${YELLOW}-b ${NC} | ${YELLOW}--backup${NC}\t\t: ${RED}Generate backup list of Arch and Aur packages${NC}"
    echo -e "\t${YELLOW}-ba${NC} | ${YELLOW}--backupArch${NC}\t: ${RED}Generate backup list of Arch packages${NC}"
    echo -e "\t${YELLOW}-bu${NC} | ${YELLOW}--backupAur${NC}\t: ${RED}Generate backup list of Aur packages${NC}"
    echo -e "\t${YELLOW}-r${NC}  | ${YELLOW}--restore${NC}\t\t: ${RED}Restore Arch and Aur packages from previous backup list${NC}"
    echo -e "\t${YELLOW}-ra${NC} | ${YELLOW}--restoreArch${NC}\t: ${RED}Restore packages from previous backup list from Arch packages${NC}"
    echo -e "\t${YELLOW}-ru${NC} | ${YELLOW}--restoreAur${NC}\t: ${RED}Restore packages from previous backup list from Aur packages${NC}\n"

    echo -e "\t${YELLOW}      --install${NC}\t\t: ${RED}Run confLiveCD, installLiveCD and installChroot${NC}"

    echo -e "\t${YELLOW}      --confNetwork${NC}\t: ${RED}Configure network. Use if not DHCP${NC}"
    echo -e "\t${YELLOW}      --confLiveCD${NC}\t: ${RED}Configure Arch from livecd${NC}"
    echo -e "\t${YELLOW}      --installLiveCD${NC}\t: ${RED}Install Arch from livecd${NC}"
    echo -e "\t${YELLOW}      --installChroot${NC}\t: ${RED}Install inside arch-chroot${NC}"
    echo -e "\t${YELLOW}      --confSys${NC}\t\t: ${RED}Configure installed system${NC}"
    echo -e "\t${YELLOW}      --installPkgs${NC}\t: ${RED}Install packages${NC}"
    echo -e "\t${YELLOW}      --installYay${NC}\t: ${RED}Install YAY from git${NC}"
    echo -e "\t${YELLOW}      --installYayPkgs${NC}\t: ${RED}Install Yay packages${NC}\n"
    echo -e "\t${YELLOW}      --confUser${NC}\t: ${RED}Create default user account${NC}\n"

    echo -e "\t${YELLOW}      --installNvidia${NC}\t: ${RED}Install NVIDIA${NC}"
    echo -e "\t${YELLOW}      --installConky${NC}\t: ${RED}Install Conky from git${NC}"
    echo -e "\t${YELLOW}      --installLDM${NC}\t: ${RED}Install Lightdm login${NC}"
    echo -e "\t${YELLOW}      --installXfce${NC}\t: ${RED}Install Xfce${NC}"
    echo -e "\t${YELLOW}      --installGdrive${NC}\t: ${RED}Install drive for Google Drive${NC}"

    echo -e "\n\t${YELLOW}      --restoreMyConf${NC}\t: ${RED}Restore my configs${NC} ${GREEN}=>${NC} ${WHITE}Config as your flavor. ;)${NC}"

    echo -e "\n\t${YELLOW}      --confMirror${NC}\t: ${RED}Live fastest mirrors config${NC}"
    echo -e "\n"
    echo -e "\t\t\t${REDB}!!!   WARNING   !!!${NC}"
    echo -e "\t\t${YELLOW}You ${NC}${RED}MUST${NC}${YELLOW} read and edit the script${NC}"
    echo -e "\t\t${YELLOW}for your own convenience${NC}\n\n"

    exit 0
}
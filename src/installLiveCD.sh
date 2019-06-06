installLiveCD(){ #begin --installLiveCD
    echo -e "${YELLOW}Install from LiveCD...${NC}"
    roottest
    if [ -d "/install" ]; then
        cp -r /install /mnt/
    else
        echo -e "${RED} /install for ArchRestore not found on / ${NC}"
        echo -e "${YELLOW} Copy ArchRestore files to /install and run${NC}"
        echo -e "${YELLOW} /install/ArchRestore.sh --installLiveCD again.${NC}"
        read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
        exit 1
    fi

    confMirror
    pacman -Sy
    pacstrap /mnt $PACSTRAP
    genfstab -p /mnt > /mnt/etc/fstab
    
    echo -e "${GREEN}The system is ready to arch-chroot${NC}"
    echo -e "${YELLOW}Run${NC} ${RED}arch-chroot /mnt${NC}"
    echo -e "${YELLOW}Run${NC} ${RED}./ArchRestore.sh --installChroot${NC}"
} #end --installLiveCD

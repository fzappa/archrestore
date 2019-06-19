installLiveCD(){ #begin --installLiveCD
    echo -e "${YELLOW}Install from LiveCD...${NC}"
    roottest
    if [ -d "/ArchRestore" ]; then
        echo -e "${YELLOW} Copying ArchRestore files to /mnt/ArchRestore...${NC}"
        rsync -r -am --info=progress2 /ArchRestore /mnt/
    else
        echo -e "${RED} /ArchRestore not found on / ${NC}"
        echo -e "${YELLOW} Copy ArchRestore files to /ArchRestore and run${NC}"
        echo -e "${YELLOW} /ArchRestore/ArchRestore.sh --installLiveCD again.${NC}"
        read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
        exit 1
    fi

    confMirror
    pacman -Sy
    pacstrap /mnt $PACSTRAP
    genfstab -p /mnt > /mnt/etc/fstab
    
    echo -e "${GREEN}The system is ready to arch-chroot${NC}"
    echo -e "${YELLOW}Run${NC} ${RED}arch-chroot /mnt${NC}"
    echo -e "${YELLOW}Run${NC} ${RED}cd /ArchRestore${NC}"
    echo -e "${YELLOW}Run${NC} ${RED}./ArchRestore.sh --installChroot${NC}"
  } #end --installLiveCD

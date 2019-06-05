confLiveCD(){ #begin --confLiveCD
    echo -e "${YELLOW}Configure from LiveCD (confLiveCD.sh)...${NC}"
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
} #end --confLiveCD
installXfce(){ #begin --installLDM
    echo -e "${YELLOW}Install Xfce...${NC}"
    roottest
    pacman -S --needed xfce4 xfce4-goodies networkmanager network-manager-applet
  } #end --installLDM
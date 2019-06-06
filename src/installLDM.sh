installLDM(){ #begin --installLDM
    echo -e "${YELLOW}Install Lightdm...${NC}"
    roottest
    pacman -S --needed lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
    systemctl enable lightdm.service --force
} #end --installLDM
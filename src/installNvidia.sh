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
} #begin --installNvidia
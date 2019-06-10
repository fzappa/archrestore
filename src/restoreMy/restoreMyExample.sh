restoreMyExample(){
	echo -e "${YELLOW}Restore my VirtualBox.${NC}"
    pacman -S --needed --noconfirm virtualbox virtualbox-guest-modules-arch
    pacman -S --needed --noconfirm virtualbox-guest-utils virtualbox-host-modules-arch
    
    if [ $(getent group vboxusers) ]; then
        sudo gpasswd -a $USER vboxusers
    else
        sudo groupadd vboxusers
        sudo gpasswd -a $USER vboxusers
    fi

    if [ $(getent group vboxsf) ]; then
        sudo gpasswd -a $USER vboxsf
    else
        sudo groupadd vboxsf
        sudo gpasswd -a $USER vboxsf
    fi

    
    read -p "$(echo -e ${REDB}"Press any key to continue..."${NC})"
}
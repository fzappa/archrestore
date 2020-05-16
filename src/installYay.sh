installYay(){ #begin --installYay
    echo -e "${YELLOW}Install YAY... ${NC}"
    notroottest
    echo -e "${YELLOW}Checking Yay dependencies... ${NC}"
    sudotest

    if !(hash git 2>/dev/null ); then
        echo -e "${RED}GIT not installed. ${NC}"
        echo -e "${YELLOW}Install git ${NC}"
        sudo pacman -S --needed --noconfirm git
    else
        echo -e "${YELLOW}Git already installed. ${NC}"
    fi

    if !(hash go 2>/dev/null); then
        echo -e "${RED}GO not installed. ${NC}"
        echo -e "${YELLOW}Install Go ${NC}"
        echo -e "${YELLOW}Check if $USER is in /home dir...${NC}"
        if [ -d "/home/$USER" ]; then
	        echo -e "${YELLOW}/home/$USER found!${NC}"
            echo -e "${YELLOW}Creating /home/$USER/gopath${NC}"
            mkdir -p /home/$USER/gopath/tmp
            chown $USER:$USER /home/$USER/gopath -R
            sudo pacman -S --needed --noconfirm go
        else
	        echo -e "${RED}404 ERROR!${NC} ${YELLOW}/home/$USER not found!${NC}"
            read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
	        exit 1
        fi
    else
        echo -e "${YELLOW}GO already installed. ${NC}"
    fi 

    if !(hash yay 2>/dev/null); then
        echo -e "${RED}Yay not installed.${NC}"
        echo -e "${YELLOW}Install Yay${NC}"
        if [ ! -d "/home/$USER/gopath/tmp" ]; then
            echo -e "${YELLOW}/home/$USER/gopath/tmp not found!${NC}"
            echo -e "${YELLOW}Creating /home/$USER/gopath/tmp${NC}"
            mkdir -p /home/$USER/gopath/tmp
            chown $USER:$USER /home/$USER/gopath -R
        fi
        
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si
        cd ..
        rm -rf yay
    else
        echo -e "${YELLOW}Yay already installed.${NC}"
    fi
    
} #end --installYay
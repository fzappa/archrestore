confUser(){ #begin --confUser
    echo -e "${YELLOW}Configure admin user...${NC}"
    if [[ -z "${USER//}" ]]; then  # if empty
        echo -e "${RED}ERROR: Admin user will not be created ${NC}"
        echo -e "${YELLOW}USER not defined.${NC}"
        read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
        exit 1
    else
        roottest
        echo -e "${YELLOW}Create user $USER ${NC}"
        if [ -d "/home/$USER" ]; then
            useradd -d /home/$USER -G wheel,lp,sys,network,power -s /bin/bash $USER
            chown -R $USER.$USER /home/$USER
        else
            useradd -m -G wheel,lp,sys,network,power -s /bin/bash $USER
        fi
        
        passwd $USER
        echo -e "${YELLOW}Add $USER at /etc/sudoers ${NC}"
        sed -i "80i$USER ALL=(ALL) ALL" /etc/sudoers
    fi
} #end --confUser
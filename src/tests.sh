###### BEGIN TEST FUNCTIONS ######

testmbr(){
    if [[ -z "${MBR//}" ]]; then # if is empty
        echo -e "${RED}ERRO:${NC} ${YELLOW}MBR disk not defined.${NC}"
        read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
        exit 1
    fi
}

sudotest(){
    if !(hash sudo 2>/dev/null); then
        echo -e "${RED}SUDO not installed.${NC}"
        if [[ $(/usr/bin/id -u) -ne 0 ]]; then
            echo -e "${RED}ERRO:${NC} ${YELLOW}Please, login as root and install sudo${NC}"
            read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
            exit 1
        else
            echo -e "${YELLOW}Install sudo${NC}"
            pacman -Sy
            pacman -S --needed --noconfirm sudo
        fi
    else
        echo -e "${YELLOW}SUDO already installed.${NC}"
    fi
}

roottest(){
    if [[ $(/usr/bin/id -u) -ne 0 ]]; then
        echo -e "${RED}ERRO:${NC} ${YELLOW}This must be run as root${NC}"
        read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
        exit 1
    else
        echo -e "${REDB}Runing as root${NC}"
    fi
}

notroottest(){
    if [[ $(/usr/bin/id -u) -ne 0 ]]; then
        echo -e "${GREENB}Runing as user${NC}"
    else
        echo -e "${RED}ERRO:${NC} ${YELLOW}This must be run as user${NC}"
        read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
        exit 1
    fi
}


###### END TEST FUNCTIONS ######
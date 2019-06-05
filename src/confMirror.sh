confMirror(){ #begin --confMirror
    echo -e "${YELLOW}Configure Mirror...${NC}"
    roottest
    if !(hash rankmirrors 2>/dev/null ); then # if not installed
        echo -e "rankmirrors not installed"
        echo -e "Install pacman-contrib"
        pacman -Sy
        pacman -S --needed --noconfirm pacman-contrib
        confMirror
    else # if installed
        echo -e "${YELLOW}Findind fastest mirrors...${NC}"
        curl -s "https://www.archlinux.org/mirrorlist/?$COUNTRY&protocol=http&protocol=https&ip_version=4&use_mirror_status=on" | 
        sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -v -n 8 - 2>&1 | tee /etc/pacman.d/mirrorlist
    fi 
} #end --confMirror
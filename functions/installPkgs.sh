installPkgs(){ #begin --installPkgs
    echo -e "${YELLOW}Install packages...${NC}"

    if [ ! -f "Packages.txt" ]; then # if not exists
        echo -e "${YELLOW}File Packages.txt not exists.${NC}"
        read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
        exit 1
    else
        roottest
        confMirror
        packagelist=(`cat Packages.txt`)
        pacman -S --needed --noconfirm ${packagelist[@]}

        echo -e "${YELLOW}Disable dhcpcd...${NC}"
        systemctl stop dhcpcd
        systemctl disable dhcpcd

        echo -e "${YELLOW}Enable Network Manager...${NC}"
        systemctl enable NetworkManager.service
        systemctl start NetworkManager.service
      
        echo -e "${YELLOW}Configure xkb layout...${NC}"
        eval $XKB

        echo -e "${YELLOW}Install polkit rules...${NC}"
        tee /etc/polkit-1/rules.d/99-archrestore.rules << ENDRULES
polkit.addRule(function(action, subject) {
    if (action.id.indexOf("org.freedesktop.udisks2.") == 0 && subject.isInGroup("wheel")) {
        return polkit.Result.YES;
    }
});

polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.login1.power-off" ||
        action.id == "org.freedesktop.login1.reboot" ||
        action.id == "org.freedesktop.login1.hibernate" ||
        action.id == "org.freedesktop.login1.suspend") {
        return polkit.Result.YES;
    }
});

polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.upower.hibernate" ||
        action.id == "org.freedesktop.upower.suspend") {
        return polkit.Result.YES;
    }
});

/* Allow users of network group to use blueman feature requiring root without authentication */
polkit.addRule(function(action, subject) {
    if ((action.id == "org.blueman.network.setup" ||
         action.id == "org.blueman.dhcp.client" ||
         action.id == "org.blueman.rfkill.setstate" ||
         action.id == "org.blueman.pppd.pppconnect") &&
        subject.isInGroup("network")) {
        return polkit.Result.YES;
    }
});
ENDRULES

        echo -e "${YELLOW}Packages installed.${NC}"
        read -p "$(echo -e ${REDB}"Press any key to continue..."${NC})"

    fi

} #end --installPkgs
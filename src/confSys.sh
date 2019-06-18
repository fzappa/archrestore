confSys(){ #begin --confSys
    echo -e "${YELLOW}Configure system...${NC}"
    roottest
    loadkeys $KEYBOARD
    systemctl enable ntpd
    systemctl start ntpd
    systemctl enable dhcpcd
    systemctl start dhcpcd
    echo -e "${GREEN}Optionally:${NC}"
    echo -e "${YELLOW}\t$0 --confUser${NC}"
    echo -e "${YELLOW}\t$0 --confMirror${NC}"
    echo -e "${YELLOW}\t$0 --installPkgs${NC}"
    echo -e "${YELLOW}\t$0 --installLDM${NC}"
    echo -e "${YELLOW}\t$0 --installYay${NC}"
    echo -e "${YELLOW}\t$0 --installYayPkgs${NC}"
    echo -e "${YELLOW}\t$0 --installNvidia${NC}"
    echo -e "${YELLOW}\t$0 --installConky${NC}"
    echo -e "${YELLOW}\n\t$0 --restoreMyConf${NC}"
} #end --confSys
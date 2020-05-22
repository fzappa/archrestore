confNetwork(){ #begin --confNetwork
    echo -e "${YELLOW}Configure static address network...${NC}"
    roottest
      
    if [ $DHCP == "NO" ]; then 

        echo -e "\t${RED}Disable and remove netctl...${NC}"
        systemctl stop netctl.service
        systemctl disable netctl
        pacman -Rns netctl

        echo -e "\t${RED}Stop and disable dhcp service...${NC}"
        systemctl stop dhcpcd
        systemctl disable dhcpcd

        FILE="/etc/systemd/network/$IFACE.network"
        systemctl stop systemd-networkd.service
        ip address flush dev $IFACE
        echo -e "\t${YELLOW}Configure static IP with networkd.${NC}"
        echo "[Match]" > $FILE
        echo "Name=$IFACE" >> $FILE
        echo "" >> $FILE
        echo "[Network]" >> $FILE
        echo "Address=$IP" >> $FILE
        echo "Gateway=$GW" >> $FILE
        echo "DNS=$DNS" >> $FILE
        echo "DNS=8.8.8.8" >> $FILE

        echo -e "\t${YELLOW}Enable and start systemd-networkd service...${NC}"
        systemctl enable systemd-networkd.service
        systemctl start systemd-networkd.service

    else
        echo -e "${YELLOW}Using DHCP.${NC}"
    fi     
} #end --confNetwork
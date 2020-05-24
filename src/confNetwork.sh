confNetwork() { #begin --confNetwork
    echo -e "${YELLOW}Configure static address network...${NC}"
    roottest

    if [ $DHCP == "YES" ]; then

        echo -e "${YELLOW}Using DHCP.${NC}"
        FILE="/etc/netctl/$IFACE"

        echo -e "\t${RED}Disable netctl...${NC}"
        systemctl stop netctl.service
        systemctl disable netctl

        echo -e "\t${YELLOW}Stop and disable systemd-networkd service...${NC}"
        systemctl stop systemd-networkd.service
        systemctl disable systemd-networkd.service

        echo -e "\t${RED}Stop dhcpcd service...${NC}"
        systemctl stop dhcpcd
        ip address flush dev $IFACE

        echo "Description='A basic dhcp ethernet connection'" >$FILE
        echo "Interface=$IFACE" >>$FILE
        echo "Connection=ethernet" >>$FILE
        echo "IP=dhcp" >>$FILE
        echo "#DHCPClient=dhcpcd" >>$FILE
        echo "#DHCPReleaseOnStop=no" >>$FILE
        echo "## for DHCPv6" >>$FILE
        echo "#IP6=dhcp" >>$FILE
        echo "#DHCP6Client=dhclient" >>$FILE
        echo "## for IPv6 autoconfiguration" >>$FILE
        echo "#IP6=stateless" >>$FILE

        echo -e "\t${YELLOW}Enable and start dhcpcd service...${NC}"
        systemctl enable dhcpcd
        systemctl start dhcpcd

        sleep 5

        #check if network is up
        if ping -q -c 1 -W 1 google.com >/dev/null; then
            echo -e "\t${YELLOW}The network connection is ok...${NC}"
        else
            echo -e "\t${YELLOW}ERROR: Fail network connection...${NC}"
            echo -e "\t${YELLOW}Check you connection.${NC}"
            exit 1
        fi

    elif [ $DHCP == "NO" ]; then

        echo -e "\t${RED}Disable netctl...${NC}"
        systemctl stop netctl.service
        systemctl disable netctl

        echo -e "\t${RED}Stop and disable dhcp service...${NC}"
        systemctl stop dhcpcd
        systemctl disable dhcpcd

        FILE="/etc/systemd/network/$IFACE.network"
        systemctl stop systemd-networkd.service
        ip address flush dev $IFACE

        echo -e "\t${YELLOW}Configure static IP with networkd.${NC}"
        echo "[Match]" >$FILE
        echo "Name=$IFACE" >>$FILE
        echo "" >>$FILE
        echo "[Network]" >>$FILE
        echo "Address=$IP" >>$FILE
        echo "Gateway=$GW" >>$FILE
        echo "DNS=$DNS" >>$FILE
        echo "DNS=8.8.8.8" >>$FILE

        echo -e "\t${YELLOW}Enable and start systemd-networkd service...${NC}"
        systemctl enable systemd-networkd.service
        systemctl start systemd-networkd.service

        sleep 5
        
        #check if network is up
        if ping -q -c 1 -W 1 google.com >/dev/null; then
            echo -e "\t${YELLOW}The network connection is ok...${NC}"
        else
            echo -e "\t${YELLOW}ERROR: Fail network connection...${NC}"
            echo -e "\t${YELLOW}Check you connection.${NC}"
            exit 1
        fi

    fi

}

#end --confNetwork

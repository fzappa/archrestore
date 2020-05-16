confNetwork(){ #begin --confNetwork
    echo -e "${YELLOW}Configure Network...${NC}"
    roottest
      
    if [ $DHCP == "NO" ]; then 
        systemctl stop NetworkManager.service
        systemctl disable NetworkManager.service

        echo -e "${YELLOW}Configure static IP with Netctl.${NC}"
        echo "Description='A basic static ethernet connection'" > /etc/netctl/$IFACE
        echo "Interface=$IFACE" >> /etc/netctl/$IFACE
        echo "Connection=ethernet" >> /etc/netctl/$IFACE
        echo "IP=static" >> /etc/netctl/$IFACE
        echo "Address=('$IP')" >> /etc/netctl/$IFACE
        echo "#Routes=('192.168.0.0/24 via 192.168.1.2')" >> /etc/netctl/$IFACE
        echo "Gateway='$GW'" >> /etc/netctl/$IFACE
        echo "DNS=('$DNS')" >> /etc/netctl/$IFACE

        systemctl start netctl.service
        systemctl enable netctl.service

    else
        echo -e "${YELLOW}Using DHCP.${NC}"
    fi     
} #end --confNetwork
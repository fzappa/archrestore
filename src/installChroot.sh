installChroot(){ #begin --installChroot

    echo -e "${YELLOW}Install inside arch-chroot...${NC}"
    testmbr
    roottest

    echo -e "${YELLOW}Configure timezone${NC}"
    loadkeys $KEYBOARD
    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
    
    echo -e "${YELLOW}Synchronize clock${NC}"
    pacman -S --needed --noconfirm ntp
    sed -i 's/0.arch.pool.ntp.org.*/a.st1.ntp.br/' /etc/ntp.conf
    sed -i 's/1.arch.pool.ntp.org.*/b.st1.ntp.br/' /etc/ntp.conf
    sed -i 's/2.arch.pool.ntp.org.*/c.st1.ntp.br/' /etc/ntp.conf
    sed -i 's/3.arch.pool.ntp.org.*/d.st1.ntp.br/' /etc/ntp.conf
    systemctl start ntpd
    systemctl enable ntpd

    echo -e "${YELLOW}Configure /etc/locale.gen${NC}"
    echo ${LANG[*]} >> /etc/locale.gen
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen

    echo -e "${YELLOW}Create /etc/locale.conf${NC}"
    export LANG=${LANG[0]}
    touch /etc/locale.conf
    echo "LANG=${LANG[0]}" > /etc/locale.conf
    echo "LC_ADDRESS=${LANG[0]}" >> /etc/locale.conf
    echo "LC_IDENTIFICATION=${LANG[0]}" >> /etc/locale.conf
    echo "LC_MEASUREMENT=${LANG[0]}" >> /etc/locale.conf
    echo "LC_MONETARY=${LANG[0]}" >> /etc/locale.conf
    echo "LC_NAME=${LANG[0]}" >> /etc/locale.conf
    echo "LC_NUMERIC=${LANG[0]}" >> /etc/locale.conf
    echo "LC_PAPER=${LANG[0]}" >> /etc/locale.conf
    echo "LC_TELEPHONE=${LANG[0]}" >> /etc/locale.conf
    echo "LC_TIME=${LANG[0]}" >> /etc/locale.conf

    cp /etc/locale.conf /etc/default/locale
    
    echo "KEYMAP=$KEYBOARD" > /etc/vconsole.conf

    echo "# KEYBOARD CONFIGURATION FILE" > /etc/default/keyboard
    echo "# Consult the keyboard(5) manual page." >> /etc/default/keyboard
    echo "XKBMODEL=\"abnt2\"" >> /etc/default/keyboard
    echo "XKBLAYOUT=\"br\"" >> /etc/default/keyboard
    echo "XKBVARIANT=\"abnt2\"" >> /etc/default/keyboard
    echo "XKBOPTIONS=\"terminate:ctrl_alt_bksp\"" >> /etc/default/keyboard
    echo "BACKSPACE=\"guess\"" >> /etc/default/keyboard

    echo -e "${YELLOW}Configure hostname and hosts${NC}"
    echo $HOSTNAME > /etc/hostname
    echo "127.0.0.1	localhost.localdomain	localhost" > /etc/hosts
    echo "::1		localhost.localdomain	localhost" >> /etc/hosts
    echo "127.0.1.1	$HOSTNAME.localdomain	$HOSTNAME" >> /etc/hosts

    echo -e "${YELLOW}Add candies to pacman.conf${NC}"
    sed -i 's/.*#Color.*/Color/' /etc/pacman.conf
    sed -i 's/.*#CheckSpace.*/CheckSpace/' /etc/pacman.conf
    sed -i 's/.*#TotalDownload.*/TotalDownload/' /etc/pacman.conf
    sed -i 's/.*\#\[multilib\].*/\[multilib\]/' /etc/pacman.conf
    sed -i '/\[multilib\]/!b;n;cInclude = /etc/pacman.d/mirrorlist' /etc/pacman.conf 

    echo -e "${YELLOW}mkinitcpio -P...${NC}\n"
    mkinitcpio -P

    echo -e "${YELLOW}Define ROOT password:${NC}\n"
    passwd

    echo -e "${YELLOW}Install grub and os-prober${NC}"
    pacman -S --needed --noconfirm grub os-prober
    
    echo -e "\n${YELLOW}grub-install $MBR${NC}"
    grub-install $MBR
    
    echo -e "\n${YELLOW}Configure /etc/default/grub $MBR${NC}"
    sed -i 's/.*GRUB_DEFAULT=.*/GRUB_DEFAULT=saved/' /etc/default/grub
    sed -i 's/.*GRUB_TIMEOUT_STYLE=.*//' /etc/default/grub
    sed -i '3iGRUB_TIMEOUT_STYLE=menu' /etc/default/grub
    sed -i 's/.*GRUB_SAVEDEFAULT=.*//' /etc/default/grub
    sed -i '10iGRUB_SAVEDEFAULT=true' /etc/default/grub
    
    echo -e "\n${YELLOW}grub-mkconfig -o /boot/grub/grub.cfg${YELLOW}"
    grub-mkconfig -o /boot/grub/grub.cfg
  
    echo -e "${YELLOW}Install aditional packages${NC}"
    pacman -S --needed --noconfirm vim netctl

    echo -e "\n${YELLOW}Now${NC}, ${RED}reboot.${NC}"

} #end --installChroot

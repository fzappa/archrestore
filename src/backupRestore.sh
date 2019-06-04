
ARCHPKG="Arch-pkglist.txt"
AURPKG="Aur-pkglist.txt"


backupArch(){ #begin --backupArch
	echo -e "${YELLOW}Backup Arch packages to $ARCHPKG ${NC}"
	pacman -Qqen > $ARCHPKG
} #end --backupArch


backupAur(){ #begin --backupAur
    echo -e "${YELLOW}Backup Aur packages to $AURPKG ${NC}"
	pacman -Qqem > $AURPKG
} #end --backupAur


restoreArch(){ #begin --restoreArch
	if [ -f "$ARCHPKG" ]; then
		sudotest
		echo -e "${YELLOW}Restore Arch packages from $ARCHPKG$... ${NC}"
		sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort $ARCHPKG))
		echo -e "${YELLOW}Reinstalled all Arch packages\n. ${NC}"
	else
		echo -e "${RED}ERRO:${NC} ${YELLOW}$ARCHPKG$ file not found ${NC}"
		echo -e "${YELLOW}Run $0 --backupArch before ${NC}"
		read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
		exit 1
	fi
	exit 0
} #end --restoreArch


restoreAur(){ #begin --restoreAur
	if [ -f "$AURPKG" ]; then
		echo -e "${YELLOW}Restore AUR packages from $AURPKG...${NC}"
		notroottest
		installYay
		yay -S --needed --noconfirm - < $AURPKG
		echo -e "${YELLOW}Reinstalled all Aur packages.\n${NC}"
	else
		echo -e "${RED}ERRO:${NC} ${YELLOW}$AURPKG$ file not found ${NC}"
		echo -e "${YELLOW}Run $0 --backupAur before ${NC}"
		read -p "$(echo -e ${REDB}"Press any key to exit..."${NC})"
		exit 1
	fi
	exit 0
} #end --restoreAur

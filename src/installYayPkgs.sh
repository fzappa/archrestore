installYayPkgs(){ #begin --installYayPkgs
    echo -e "${YELLOW}Install Yay packages...${NC}"
    notroottest
    installYay
    yay -S --needed --noconfirm visual-studio-code-bin
    yay -S --needed --noconfirm latex-beamer
    yay -S --needed --noconfirm spotify
    yay -S --needed --noconfirm obkey
    yay -S --needed --noconfirm obmenu-generator
    yay -S --needed --noconfirm openbox-themes
    yay -S --needed --noconfirm polybar
    yay -S --needed --noconfirm skypeforlinux-stable-bin
    yay -S --needed --noconfirm ttf-ms-fonts
    yay -S --needed --noconfirm ttf-font-logos
    #yay -S quartus-free
} #end --installYayPkgs

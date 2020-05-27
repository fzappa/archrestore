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
    yay -S --needed --noconfirm conky-lua-nv
    yay -S --needed --noconfirm picom
    yay -S --needed --noconfirm polybar
    yay -S --needed --noconfirm ttf-ms-fonts
    yay -S --needed --noconfirm ttf-font-logos
    #yay -S --needed --noconfirm masterpdfeditor-free
    #yay -S --needed --noconfirm microsoft-r-open
    #yay -S --needed --noconfirm skypeforlinux-stable-bin
    #yay -S --needed --noconfirm zoom
    #yay -S --needed --noconfirm geogebra
    #yay -S --needed --noconfirm fritzing
    #yay -S --needed --noconfirm quartus-free
    #yay -S --needed --noconfirm eagle

} #end --installYayPkgs

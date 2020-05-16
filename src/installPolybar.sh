installPolybar(){ #begin --installPolybar
    echo -e "${YELLOW}Install Polybar...${NC}"
    sudotest
    notroottest
    
    git clone https://github.com/polybar/polybar
    cd polybar;mkdir build;cd build
    cmake ..
    make -j6
    sudo make install
    cd ..;cd ..
    rm -rf conky
} #end --installPolybar
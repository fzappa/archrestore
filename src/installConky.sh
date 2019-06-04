installConky(){ #begin --installConky
    echo -e "${YELLOW}Install Conky...${NC}"
    sudotest
    notroottest
    
    git clone https://github.com/brndnmtthws/conky
    cd conky;mkdir build;cd build
    cmake -D CMAKE_BUILD_TYPE=Release -D MAINTAINER_MODE=ON -D BUILD_CURL=ON -D BUILD_LUA_RSVG=ON -D BUILD_LUA_CAIRO=ON -D BUILD_LUA_IMLIB2=ON -D BUILD_IMLIB2=ON -D BUILD_RSS=ON -D BUILD_WEATHER_METAR=ON -D BUILD_WEATHER_XOAP=ON -D BUILD_JOURNAL=ON -D BUILD_WLAN=ON -D BUILD_NVIDIA=ON -D BUILD_XDBE=ON -D BUILD_XSHAPE=ON -D CMAKE_INSTALL_PREFIX=/usr ..
    make -j6
    sudo make install
    cd ..;cd ..
    rm -rf conky
  } #end --installConky
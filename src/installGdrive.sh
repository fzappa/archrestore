installGdrive(){ #begin --installGdrive
    # https://github.com/odeke-em/drive#
    echo -e "${YELLOW}Install drive for Google Drive...${NC}"
    notroottest
    installYay # just to check if has Go and Git installed...
    echo -e "${YELLOW}Install github.com/odeke-em/drive/...${NC}"
    export GOPATH=/home/$USER/gopath
    go get -u github.com/odeke-em/drive/cmd/drive
  } #end --installGdrive
install(){ #begin --install

    rootpasswd(){
        echo -ne "\n${YELLOW}Define password for root: ${NC}"
        read -s PASS1
        echo -ne "\n${YELLOW}Retype password for root: ${NC}"
        read -s PASS2
        if [ $PASS1 == $PASS2 ]; then
            arch-chroot /mnt sh -c "echo 'root:$PASS1' | chpasswd"
            echo -e "\n"
        else
            echo -e "\n${REDB}Password not match... ${NC}"
            rootpasswd
        fi
    }

    confLiveCD
    installLiveCD
    arch-chroot /mnt /bin/bash <<"END" 
cd /install;
./ArchRestore.sh --installChroot 
END
  
    rootpasswd    
    exit 0
} #end --install

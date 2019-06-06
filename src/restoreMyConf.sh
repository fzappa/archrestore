restoreMyConf(){ #begin --restoreMyConf
    echo -e "${YELLOW}Restore my configs (restoreMyConf.sh)...${NC}"
    notroottest
    if [ -d "src/mybackup" ]; then
    
        for f in src/mybackup/restoreMy*; do 
            source $f; 
        done

        # call your functions here

    else
        echo -e "${YELLOW}Restore configs not found...${NC}"
    fi

    exit 0
} #end --restoreMyConf
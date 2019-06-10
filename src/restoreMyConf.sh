restoreMyConf(){ #begin --restoreMyConf
    echo -e "${YELLOW}Restore my configs (restoreMyConf.sh)...${NC}"
    notroottest
    if [ -d "src/restoreMy" ]; then
    
        for f in src/restoreMy/restoreMy*.sh; do 
            source $f; 
        done

        # call your functions here
        restoreMyExample

    else
        echo -e "${YELLOW}Restore configs not found...${NC}"
    fi

    exit 0
} #end --restoreMyConf
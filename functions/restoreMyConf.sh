restoreMyConf(){ #begin --restoreMyConf
  echo -e "${YELLOW}Restore my configs...${NC}"
  notroottest
  if [ -d "functions/mybackup" ]; then
    
    for f in functions/mybackup/restoreMy*; do 
      source $f; 
    done

    # call functions here

  else
    echo -e "${YELLOW}Restore configs not found...${NC}"
  fi

  exit 0

} #end --restoreMyConf
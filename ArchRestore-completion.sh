_ArchRestore(){
	local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="-b -ba -bu -r -ra -ru "
    opts+="--backup --backupArch --backupAur "
    opts+="--restore --restoreArch --restoreAur "
    opts+="--installYay --installYayPkgs --confLiveCD --installLiveCD --installChroot "
    opts+="--installPkgs --confUser --installNvidia --installConky "
    opts+="--restoreMyConf --confMirror --confSys --installLDM "

	if [[ ${cur} == -* ]] ; then
		COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
		return 0
	fi
}

complete -F _ArchRestore ArchRestore.sh

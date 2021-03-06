Arch Linux Restore Script (Shell Script)
============================================

## Script to restore my basic Arch Linux config.
#### Following the K.I.S.S. principle (Keep It Simple, Stupid) ;)
--------------------------------------------------------------------------
Simple way to install Arch Linux.
Ideal for having Arch Linux installed/reinstalled and configured in a few minutes.

Steps to run:

0. Read the script and adapt to your needs
1. Copy the files "ArchRestore.sh", "Packages.txt", "completion.sh" and folder "src" to pen-drive
2. Boot Arch Linux (Live CD)
3. Mount pen-drive and copy those files to /install (e.g)
4. Run ./ArchRestore.sh from /install folder to see the options

Basic usage to install.

```sh
# ./ArchRestore.sh --confLiveCD
# ./ArchRestore.sh --installLiveCD
# arch-chroot /mnt
# source completion.sh #(For bash completion)
# ./ArchRestore.sh --installChroot
# reboot 
```

> **About:**
> 
>- Project made and tested on Arch Linux
>- GPL v3
>

![](prog.gif)

![](basicflowchart.png)

Preparation
-----------
* assign values to variables in environment.sh ( use lsblk to get disk information )

Script execution steps
-----
1. prepare-system.sh
2. arch-chroot /mnt
3. system-setup.sh
4. umount /mnt and reboot
5. window-manager.sh (in user space)
6. local-setup.sh (in user space)

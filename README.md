Preparation
-----------
* assign values to variables in environment.sh ( use lsblk to get disk information )

Script execution steps ( after step 4 execute in user space )
-------------------------------------------------------------
1. prepare-system.sh
2. arch-chroot /mnt
3. system-setup.sh
4. umount /mnt and reboot
5. window-manager.sh
6. local-setup.sh
7. dropbox_setup.sh

Todo
----
* setup nord theme and icons in lxappearance
* neovim pylsp plugin install (pylsp-mypy, pylsp-rope, python-lsp-black, pyls-isort)
* setup github credentials
* setup aws credentials

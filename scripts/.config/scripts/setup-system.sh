#!/bin/sh -e

#Script to setup fresh ArchLinux install
. ./setup-common.sh
. ./setup-paru.sh
. ./setup-chaoticaur.sh
. ./setup-dwm.sh
. ./setup-st.sh
. ./setup-dotfiles.sh
. ./setup-packages.sh

checkEnv
checkEscalationTool
installParu
setupChaoticAUR
installDWM
installSt
installDotfiles
installPackages
wal -i ~/Pictures/Wallpapers/Winter/Ludwig_Lanckow-Winterlicher_verschneiter_Wald_im_Abendrot.png
ln -sf ~/.cache/wal/colors.Xresources ~/.Xresources

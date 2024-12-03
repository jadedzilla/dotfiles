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
. ./random-wallpaper.sh


#!/bin/sh -e

#Script to setup fresh ArchLinux install
. ./setup-common.sh
. ./setup-paru.sh
. ./setup-dwm.sh
. ./setup-st.sh
. ./setup-dotfiles.sh
. ./setup-packages.sh

checkEnv
checkEscalationTool
installParu
installDWM
installSt
installDotfiles
installPackages


#!/bin/sh -e

. ./setup-common.sh

#Script to install and setup my patched dwm

installDWM() {
    case "$PACKAGER" in
    pacman)
        printf "%b\n" "${YELLOW}Installing Xorg...${RC}"
        "$ESCALATION_TOOL" "$PACKAGER" -S --needed --noconfirm xorg-server xorg-xinit xorg-xrandr xorg-xsetroot xorg-xrdb
        printf "%b\n" "${GREEN}Xorg installed${RC}"
        printf "%b\n" "${YELLOW}Installing DWM...${RC}"
        "$ESCALATION_TOOL" "$PACKAGER" -S --needed --noconfirm base-devel git
        cd /opt && "$ESCALATION_TOOL" git clone https://github.com/jadedzilla/jaded-dwm.git && "$ESCALATION_TOOL" chown -R "$USER": ./jaded-dwm
        # cd jaded-dwm && "$ESCALATION_TOOL" make clean install
        printf "%b\n" "${GREEN}DWM installed${RC}"
        ;;
    *)
        printf "%b\n" "${RED}Unsupported package manager: ""$PACKAGER""${RC}"
        ;;
    esac
}
#!/bin/sh -e

. ./setup-common.sh

#Script to install and setup my patched dwm

installSt() {
    case "$PACKAGER" in
    pacman)
        printf "%b\n" "${YELLOW}Installing St (bread)...${RC}"
        "$ESCALATION_TOOL" "$PACKAGER" -S --needed --noconfirm base-devel git
        cd /opt && "$ESCALATION_TOOL" git clone https://github.com/BreadOnPenguins/st.git && "$ESCALATION_TOOL" chown -R "$USER": ./st
        cd st && "$ESCALATION_TOOL" make clean install
        printf "%b\n" "${GREEN}St installed${RC}"
        ;;
    *)
        printf "%b\n" "${RED}Unsupported package manager: ""$PACKAGER""${RC}"
        ;;
    esac
}

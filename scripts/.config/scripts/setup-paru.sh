#!/bin/sh -e

. ./setup-common.sh

installParu() {
    case "$PACKAGER" in
    pacman)
        if ! command_exists paru; then
            printf "%b\n" "${YELLOW}Installing paru as AUR helper...${RC}"
            "$ESCALATION_TOOL" "$PACKAGER" -S --needed --noconfirm base-devel git
            cd /opt && "$ESCALATION_TOOL" git clone https://aur.archlinux.org/paru-bin.git && "$ESCALATION_TOOL" chown -R "$USER": ./paru-bin
            cd paru-bin && makepkg --noconfirm -si
            AUR_HELPER="paru"
            "$AUR_HELPER" -Syy
            printf "%b\n" "${GREEN}Paru installed${RC}"
        else
            printf "%b\n" "${GREEN}Paru already installed${RC}"
        fi
        ;;
    *)
        printf "%b\n" "${RED}Unsupported package manager: ""$PACKAGER""${RC}"
        ;;
    esac
}

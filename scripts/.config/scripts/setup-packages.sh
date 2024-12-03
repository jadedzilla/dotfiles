#!/bin/sh -e

. ./setup-common.sh

installPackages() {
    case "$PACKAGER" in
    pacman)
        printf "%b\n" "${YELLOW}Installing packages...${RC}"
        "$AUR_HELPER" -S --needed --noconfirm firefox neovim goxlr-utility spotify dunst vesktop flameshot obs-studio pywalfox
        printf "%b\n" "${GREEN}All packages installed${RC}"
        ;;
    *)
        printf "%b\n" "${RED}Unsupported package manager: ""$PACKAGER""${RC}"
        ;;
    esac
}
#!/bin/sh -e

. ./setup-common.sh

PACKAGES=(firefox neovim goxlr-utility spotify dunst vesktop flameshot obs-studio)

installPackages() {
    case "$PACKAGER" in
    pacman)
        printf "%b\n" "${YELLOW}Installing packages...${RC}"
        "$ESCALATION_TOOL" "$PACKAGER" -S --needed --noconfirm firefox neovim goxlr-utility spotify dunst vesktop flameshot obs-studio
        printf "%b\n" "${GREEN}All packages installed${RC}"
        ;;
    *)
        printf "%b\n" "${RED}Unsupported package manager: ""$PACKAGER""${RC}"
        ;;
    esac
}
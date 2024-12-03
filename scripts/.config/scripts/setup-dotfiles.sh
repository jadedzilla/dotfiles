#!/bin/sh -e

. ./setup-common.sh

installDotfiles() {
    checkEnv
    checkEscalationTool
    printf "%b\n" "${YELLOW}Gojira Dotfiles Setup${RC}"
    case "$PACKAGER" in
    pacman)
        printf "%b\n" "${YELLOW}Installing GNU Stow...${RC}"
        "$ESCALATION_TOOL" "$PACKAGER" -S --needed --noconfirm stow
        printf "%b\n" "${GREEN}GNU Stow installed${RC}"
        printf "%b\n" "${YELLOW}Installing Gojira dotfiles...${RC}"
        stow -v -R -t "$HOME" -d "$HOME/dotfiles" */
        printf "%b\n" "${GREEN}Gojira dotfiles installed!${RC}"
        ;;
    *)
        printf "%b\n" "${RED}Unsupported package manager: ""$PACKAGER""${RC}"
        ;;
    esac
}

installDotfiles
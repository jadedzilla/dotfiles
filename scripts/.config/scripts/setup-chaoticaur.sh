#!/bin/sh -e

. ./setup-common.sh

setupChaoticAUR() {
    if grep --quiet -x '\[chaotic-aur\]' '/etc/pacman.conf' && grep --quiet -x 'Include = /etc/pacman.d/chaotic-mirrorlist' '/etc/pacman.conf'; then
        echo -e "${Green}Chaotic AUR is already installed!${NC}"
    else
        case "$PACKAGER" in
        pacman)
            printf "%b\n" "${YELLOW}Installing Chaotic AUR...${RC}"
            "$ESCALATION_TOOL" pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
            "$ESCALATION_TOOL" pacman-key --lsign-key 3056513887B78AEB
            "$ESCALATION_TOOL" pacman -U --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
            "$ESCALATION_TOOL" pacman -U --needed 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
            printf "%b\n" "${YELLOW}Adding Chaotic AUR to pacman config...${RC}"
            "$ESCALATION_TOOL" echo -e "#Chaotic-AUR" | sudo tee -a /etc/pacman.conf
            "$ESCALATION_TOOL" echo -e "" | sudo tee -a /etc/pacman.conf
            "$ESCALATION_TOOL" echo -e "[chaotic-aur]" | sudo tee -a /etc/pacman.conf
            "$ESCALATION_TOOL" echo -e "Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
            printf "%b\n" "${GREEN}Chaotic AUR installed${RC}"
            "$AUR_HELPER" -Syy
            ;;
        *)
            printf "%b\n" "${RED}Unsupported package manager: ""$PACKAGER""${RC}"
            ;;
        esac
    fi
}

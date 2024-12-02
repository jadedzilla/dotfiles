# Gojira Dotfiles
### My personal dotfiles for archlinux
Currently using (dependencies):
- [dwm](https://github.com/jadedzilla/jaded-dwm) - started with xorg-xinit
    - https://linustechtips.com/topic/1389260-dwm-and-st-install-guide-arch-linux/
- [st](https://github.com/BreadOnPenguins/st)
- [slstatus](https://github.com/jadedzilla/jaded-slstatus)
- dmenu
- picom
- feh
- rofi
- dex
- fish
- python-pywal
- pywalfox
- xdotool
- dunst
- xdg-user-dirs
- goxlr-utility
- obs-studio

ArchSetup:
- Aur Helper: paru
- Audio Server: pipewire (with all compat layers like pipewire-pulse)
- Graphics Driver: nvidia-dkms & nvidia-utils & lib32-nvidia-utils (full composition pipeline for tearing)
- Browser: Firefox
- Gaming Deps: Installed via linutil
- Build Deps: Installed via linutil

## Guide (for myself):
`git clone https://github.com/jadedzilla/dotfiles`

`sudo pacman -S xorg-server xorg-xinit xorg-xrandr xorg-xsetroot firefox picom feh dmenu rofi dex python-pywal pywalfox xdotool dunst xdg-user-dirs goxlr-utility`

`git clone https://github.com/jadedzilla/jaded-dwm`

`git clone https://github.com/BreadOnPenguins/st`

`git clone https://github.com/jadedzilla/jaded-slstatus`

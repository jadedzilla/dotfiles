#!/bin/sh
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile
xrdb ~/.Xresources
export DESKTOP_SESSION=dwm
exec dwm

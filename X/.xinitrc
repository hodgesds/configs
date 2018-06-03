#!/bin/bash
which feh &>/dev/null && feh --bg-scale $BACKGROUND
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
which nm-applet &>/dev/null && nm-applet &

#i3 -c .config/i3/config
#exec ck-launch-session dbus-launch i3 -c ~/.config/i3/config
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session i3 -c ~/.config/i3/config

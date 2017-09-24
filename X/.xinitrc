#!/bin/bash
feh --bg-scale $BACKGROUND
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

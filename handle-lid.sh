#!/bin/bash

if [ "$(xrandr --listactivemonitors | grep -wc "eDP-1")" = 1 ]; then
    xrandr --output eDP-1 --off
else
    xrandr --output eDP-1 --auto
fi
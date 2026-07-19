#!/bin/bash

############################################################################################
### OUTDATED. Script used for Xfce4 to change wallpaper depending on time using by cron. ###
############################################################################################

export DISPLAY=:0
export GSETTINGS_BACKEND=dconf
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$UID/bus

hour=$(date +%H)

if [ "$hour" -ge "0" ] && [ "$hour" -lt "2" ]; then
    /usr/bin/xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI-0/workspace0/last-image -s "$HOME/Pictures/wallpapers_for_day/00-02.jpg"
elif [ "$hour" -ge "2" ] && [ "$hour" -lt "4" ]; then
    /usr/bin/xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI-0/workspace0/last-image -s "$HOME/Pictures/wallpapers_for_day/02-04.jpg"
elif [ "$hour" -ge "4" ] && [ "$hour" -lt "7" ]; then
    /usr/bin/xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI-0/workspace0/last-image -s "$HOME/Pictures/wallpapers_for_day/04-07.jpg"
elif [ "$hour" -ge "7" ] && [ "$hour" -lt "10" ]; then
    /usr/bin/xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI-0/workspace0/last-image -s "$HOME/Pictures/wallpapers_for_day/07-10.jpg"
elif [ "$hour" -ge "10" ] && [ "$hour" -lt "13" ]; then
    /usr/bin/xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI-0/workspace0/last-image -s "$HOME/Pictures/wallpapers_for_day/10-13.jpg"
elif [ "$hour" -ge "13" ] && [ "$hour" -lt "15" ]; then
    /usr/bin/xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI-0/workspace0/last-image -s "$HOME/Pictures/wallpapers_for_day/13-15.jpg"
elif [ "$hour" -ge "15" ] && [ "$hour" -lt "17" ]; then
    /usr/bin/xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI-0/workspace0/last-image -s "$HOME/Pictures/wallpapers_for_day/15-17.jpg"
elif [ "$hour" -ge "17" ] && [ "$hour" -lt "19" ]; then
    /usr/bin/xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI-0/workspace0/last-image -s "$HOME/Pictures/wallpapers_for_day/17-19.jpg"
elif [ "$hour" -ge "19" ] && [ "$hour" -lt "21" ]; then
    /usr/bin/xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI-0/workspace0/last-image -s "$HOME/Pictures/wallpapers_for_day/19-21.jpg"
elif [ "$hour" -ge "21" ] && [ "$hour" -lt "23" ]; then
    /usr/bin/xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI-0/workspace0/last-image -s "$HOME/Pictures/wallpapers_for_day/21-23.jpg"
elif [ "$hour" -ge "23" ] && [ "$hour" -lt "0" ]; then
    /usr/bin/xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI-0/workspace0/last-image -s "$HOME/Pictures/wallpapers_for_day/23-00.jpg"
else
    /usr/bin/xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI-0/workspace0/last-image -s "$HOME/Pictures/wallpapers_for_day/replace.jpg"
fi

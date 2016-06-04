#!/bin/bash

# returns value between 0 and 100.
function query_vol {
	pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 2 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' | awk '{print $1}'
}

# returns true or false
function query_mute {
	if [[ $(pacmd list-sinks | grep '^[[:space:]]muted' | head -n $(( $SINK + 2 )) | tail -n 1 | sed 's/.*\: //') == "no" ]] ; then
		echo false
	else
		echo true
	fi
}

# returns value between 0 and 100.
function query_bat {
	upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "percentage" | awk '{print substr($2,0,length($2)-1)}'
}

wallpaper=/tmp/wallpaper_ambience/wallpaper
converted=$wallpaper
vol=$(query_vol)
bat=$(query_bat)
bat_thresh=80

# create the file path
mute=false
if [[ $(query_mute) == true ]]; then
	converted=$converted"_mute"
	mute=true
else
	converted=$converted"_"$vol
fi

vpn=false
if [[ -n $(pgrep openvpn) ]]; then
	converted=$converted"_vpn"
	vpn=true
fi

#bat=false
#if [[ $(query_bat) -lt bat_thresh ]]: then
#	converted=$converted"_vpn"
#	bat=true
#fi

# create the file, if it isn't cached
if [[ ! -f $converted ]]; then
	if [[ $mute == true ]]; then
		convert $wallpaper -fill navyblue -colorize 60 $converted
		convert $converted -fill black -colorize 50 $converted
	else
		convert $wallpaper -fill blue -colorize $(((100 - vol) / 2)) $converted
		convert $converted -fill black -colorize $(((100 - vol) / 2)) $converted
	fi

	if [[ $vpn == false ]]; then
		convert $converted -fill red -colorize 50 $converted
	fi

fi

feh --bg-scale $converted

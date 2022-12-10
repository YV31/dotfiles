#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

while true; do ~/.local/bin/status-bar; done &
	wp &
	setxkbmap br & # Solve a wierd problem with xdotool
	exec dwm

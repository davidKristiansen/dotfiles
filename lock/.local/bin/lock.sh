#!/bin/bash


if pgrep "swaylock" > /dev/null 2>&1 ; then
	exit 0
fi

swaylock \
    --screenshots \
    --clock \
    --indicator-idle-visible \
    --indicator-radius 100 \
    --indicator-thickness 7 \
    --effect-blur 7x5 \
    --effect-vignette 0.5:0.5 \
    --effect-pixelate 5 \
    "$@" &


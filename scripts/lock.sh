#!/bin/bash

# swaylock blurred screen inspired by /u/patopop007 and the blog post
# http://plankenau.com/blog/post-10/gaussianlock

# Dependencies:
# grim
# convert
# swaylock

IMAGE=/tmp/lock.png
SCREENSHOT="grim $IMAGE"

# Here are some imagemagick blur types
# Uncomment one to use, if you have multiple, the last one will be used

# All options are here: http://www.imagemagick.org/Usage/blur/#blur_args
#BLURTYPE="0x5" # 7.52s
#BLURTYPE="0x2" # 4.39s
# BLURTYPE="5x2" # 3.80s
# BLURTYPE="2x8" # 2.90s
# BLURTYPE="2x3" # 2.92s
BLURTYPE="3x3"

# Get the screenshot, add the blur and lock the screen with it
# FOCUSED_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select( .focused == true) | .name')
$SCREENSHOT
magick $IMAGE -blur $BLURTYPE $IMAGE
# echo $FOCUSED_MONITOR
# swaylock -n -t -i $FOCUSED_MONITOR:$IMAGE -f
swaylock -n -t -i $IMAGE -f
rm $IMAGE

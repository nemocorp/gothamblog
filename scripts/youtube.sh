#!/bin/bash
#
# Create a compatible youtube video from a fixed image and a mp3 song
# $1: Image file
# $2: Mp3 Song
# 
if [ $# -ne 2 ]
then
    echo "Usage: youtube.sh <cover.png> <music.mp3>"
    exit
fi

convert -resize 250x250 "$1" "$1"
ffmpeg -y -loop 1 -r 1 -i "$1" -i "$2" -acodec mp3 -shortest music-video.mp4

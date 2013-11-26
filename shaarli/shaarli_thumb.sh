#!/usr/bin/bash
yt=`echo $2 | awk 'BEGIN{n=0}/youtube.com/{n=1}{print n}'`
if [ $yt -eq 1 ]
then
    url="http://img.youtube.com/vi/$(echo $2 | awk -Fv\= '{print $2}')/0.jpg"
    wget -O $1 $url
else
    CutyCapt --insecure --url=$2 --out=$1
fi

W=320
H=200
FONTSIZE='96'

convert -resize $W"x" "$1" "$1"
convert -crop "x"$H+0+0 "$1" "$1"
convert "$1" -bordercolor Lavender -background navy -polaroid 0 "$1" 

scp $1 u39468970@id.nemocorp.info:./shaarli/thumbs
rm $1

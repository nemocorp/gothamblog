CutyCapt --insecure --url=$2 --out=$1

BGCOLOR=white

W=320
H=200
BORDER=8
ROUND=16
FONTSIZE='96'
let CX=$W/2
let CY=$H/2
let RX=$W-$BORDER
let RY=$H-$BORDER

# Creation des différents masques et gabarits
# Image de base avec fond coloré pour réglé le problème de centrage
#convert -size $W"x"$H xc:$BGCOLOR mask.png
#convert -size $W"x"$H xc:black -fill white -draw "roundrectangle $BORDER,$BORDER,$RX,$RY $ROUND,$ROUND" -gamma 2.2 \( +clone -blur 0x2 -shade 120x21.78 -normalize  \) +swap -alpha Off -compose CopyOpacity -composite roundrectangle.png
#convert roundrectangle.png -alpha extract roundrectangle_mask.png

convert -resize $W"x" "$1" "$1"
convert -crop "x"$H+0+0 "$1" "$1"
convert "$1" -bordercolor Lavender -background navy -polaroid 0 "$1" 

#composite -gravity center $1 mask.png $1

#convert -resize "x"$H $1 roundrectangle_mask.png -gravity center -alpha Off -compose CopyOpacity -composite tmp.png
#convert roundrectangle.png tmp.png -gravity center -compose overlay -composite $1
#convert $1 \( +clone -channel A -blur 0x2.5 -level 0,50% +channel +level-colors black \) -compose DstOver -composite $1

scp $1 u39468970@id.nemocorp.info:./shaarli/thumbs

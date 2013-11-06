FONT=$(basename "$1" | awk -F\. '{print tolower($1)}' | tr " " "_")
BGCOLOR="#5f7172"
rm -rf "$FONT"
mkdir "$FONT"
cd "$FONT"

W=128
H=128
BORDER=8
ROUND=16
FONTSIZE='96'
let CX=$W/2
let CY=$H/2
let RX=$W-$BORDER
let RY=$H-$BORDER

# Creation des différents masques et gabarits
# Image de base avec fond coloré pour réglé le problème de centrage
convert -size $W"x"$H xc:$BGCOLOR mask.png
convert -size $W"x"$H xc:black -fill white -draw "roundrectangle $BORDER,$BORDER,$RX,$RY $ROUND,$ROUND" -gamma 2.2 \( +clone -blur 0x2 -shade 120x21.78 -normalize  \) +swap -alpha Off -compose CopyOpacity -composite roundrectangle.png
convert roundrectangle.png -alpha extract roundrectangle_mask.png
convert -size $W"x"$H xc:black -fill $BGCOLOR -draw "arc $BORDER,$BORDER,$RX,$RY 0,360" -gamma 2.2 \( +clone -blur 0x2 -shade 120x21.78 -normalize  \) +swap -alpha Off -compose CopyOpacity -composite circle.png
convert circle.png -alpha extract circle_mask.png

for i in {33..126}
do
    CHAR=$(echo "OK" | awk '{printf("%c",n)}' n=$i)
    if [ $i -eq 64 ] || [ $i -eq 92 ]
    then
        CHAR="\\$CHAR"
    fi
    echo "Traitement $i - $CHAR"
    convert -size $FONTSIZE"x"$FONTSIZE -background $BGCOLOR -fill black -font "$1" caption:"$CHAR" -trim $i.png; composite -gravity center $i.png mask.png $i.png
done

# On remove les caractères non pertinents de la police
for f in $(fdupes .)
do
    rm -f "$f"
done

for f in [0-9]*.png
do
    i=$(echo "$f" | awk -F\. '{print $1}')
    echo "Traitement du fichier $f - $i"
    convert -resize x$H $i.png roundrectangle_mask.png -gravity center -alpha Off -compose CopyOpacity -composite tmp.png
    convert roundrectangle.png tmp.png -gravity center -compose overlay -composite box_$i.png
    convert box_$i.png \( +clone -channel A -blur 0x2.5 -level 0,50% +channel +level-colors black \) -compose DstOver -composite box_$i.png

    convert -resize x$H $i.png circle_mask.png -gravity center -alpha Off -compose CopyOpacity -composite tmp.png
    convert circle.png tmp.png -gravity center -compose overlay -composite button_$i.png
    convert button_$i.png \( +clone -channel A -blur 0x2.5 -level 0,50% +channel +level-colors black \) -compose DstOver -composite button_$i.png

done

# Et on crée les cheatsheet
montage -label '%t' \
          -size 128x128 'box_*' -auto-orient \
          -geometry +5+5 -tile 8x  -frame 6  -shadow  box_cheatsheet.html

montage -label '%t' \
          -size 128x128 'button_*' -auto-orient \
          -geometry +5+5 -tile 8x  -frame 6  -shadow  button_cheatsheet.html
          
exit


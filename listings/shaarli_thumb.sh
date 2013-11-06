W=320
H=200

convert -resize $W"x" "$1" "$1"
convert -crop "x"$H+0+0 "$1" "$1"
convert "$1" -bordercolor Lavender -background navy -polaroid 0 "$1" 



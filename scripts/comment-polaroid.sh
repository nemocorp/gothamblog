#convert $1 -background Lavender -font "Oregano" -pointsize 20 -gravity South label:"$2" -append -polaroid 0 $1

convert -caption "$2" $1 -thumbnail '500x500>' \
          -font  'Devonshire-Regular' -pointsize 24 -gravity center -bordercolor Lavender \
          -background navy  -polaroid -0 commented_polaroid.png

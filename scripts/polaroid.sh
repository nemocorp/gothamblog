convert -resize 150x $1 \
     -bordercolor white  -border 6 \
     -bordercolor grey60 -border 1 \
     -bordercolor none  -background  none \
     \( -clone 0 -rotate `convert null: -format '%[fx:rand()*30-15]' info:` \) \
     \( -clone 0 -rotate `convert null: -format '%[fx:rand()*30-15]' info:` \) \
     \( -clone 0 -rotate `convert null: -format '%[fx:rand()*30-15]' info:` \) \
     \( -clone 0 -rotate `convert null: -format '%[fx:rand()*30-15]' info:` \) \
     -delete 0  -border 100x80  -gravity center \
     -crop 350x450+0+0  +repage  -flatten  -trim +repage \
     -background black \( +clone -shadow 60x4+4+4 \) +swap \
     -background none  -flatten \
     postcard.png


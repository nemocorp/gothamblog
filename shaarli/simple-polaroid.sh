if [ $# -eq 3 ]
then
    convert -resize $1 "$2" \
          -bordercolor white  -border 6 \
          -bordercolor grey60 -border 1 \
          -background  none   \
          -background  black  \( +clone -shadow 60x4+4+4 \) +swap \
          -background  none   -flatten \
          $3
else
    echo "simple-polaroid.sh size source dest"
    exit
fi


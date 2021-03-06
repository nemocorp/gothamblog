#!/bin/bash
cur_letter="0"

echo "Jeux de Société"
echo "---------------"
echo
echo ".. raw:: html"
echo
echo "    <div class='gallery_container row'>"

for i in $(grep -l "^.. galerie: True" posts/*.txt)
do
    slug=$(awk '/.. slug:/{print $3}' $i)
    js_title=$(awk -F\.\.\ js_title\:\  '/js_title/{print $2}' $i)

    echo "        <div class='col-xs-2'><div rel='tooltip' class='gallery-thumb img-rounded' title='' data-toggle='tooltip' data-original-title='$js_title' style='background-image: url(/../galleries/cover/$slug.png);'><a href='/../galleries/$slug/index.html'><img src='/../galleries/cover/$slug.thumbnail.png'></a></div></div>"
done
echo "    </div>"

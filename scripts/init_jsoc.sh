# Script d'initialisation d'une fiche de jeux
 
# Script d'initialisation d'une fiche de jeux

SITE_DIR=~/btsync/dev/gothamblog

if [ $# -ne 3 ]
then
    echo "Usage: init_jsoc.sh <slug> <cover_image.png> <js_title>"
    exit
fi

mkdir -p $SITE_DIR/files/images/jeux/$1
cd $SITE_DIR/files/images/jeux/$1
polaroid.sh $2

mkdir -p $SITE_DIR/galleries/$1
cd $SITE_DIR/galleries/cover
convert -resize 100x $2 $1.png

cd $SITE_DIR/posts

sed -i "7~1d" $1.txt
sed -i "/.. tags/ s/$/draft/g" $1.txt

#echo ".. category: Jeux de Société" >> $1.txt
#echo ".. icon: jeux-de-societe" >> $1.txt
#echo ".. js_title: $3" >> $1.txt
#echo ".. galerie: True" >> $1.txt
#echo >> $1.txt
#echo ".. image:: /images/$1/postcard.png" >> $1.txt
#echo "    :align: left" >> $1.txt
#echo "" >> $1.txt
#echo ".. TEASER_END" >> $1.txt
#echo "" >> $1.txt

cd $SITE_DIR

js_title=$3
echo "\`Voir la Fiche du Jeu [$js_title] </posts/$1.html>\`_" > galleries/$1/index.txt

#Rebuild Gallery Index
sh scripts/gen_gallery_index.sh > $SITE_DIR/galleries/index.txt



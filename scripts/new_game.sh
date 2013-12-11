#!/bin/bash
if [ $# -ne 2 ]
then
    echo "Usage: $0 "Post Title" <ludomania_id>"
    exit
fi

echo "Création d'un post Jeux de Société"
slug_post=$((nikola new_post <<FIN
$1
FIN
) 2>&1 | awk -F\/ '/txt$/{gsub(".txt","",$2);print $2}')

if [ $? -ne 0 ]; then
    echo "Une erreur est survenue pendant la création du post"
    exit
fi

echo "Votre post a été créé avec le slug: $slug_post"
echo "Récupération des infos ludomania pour l'id: $2"
scripts/get_mini_fiche.sh $slug_post $2
slug_jeu=`awk '/^.. slug/{print $3}' posts/$slug_post.txt`
js_title=`awk '/^.. js_title/{print substr($0,index($0,$3))}' posts/$slug_post.txt`
mkdir files/images/jeux/$slug_jeu

echo "Creation du visuel principal"
img_url=`awk '/.. visuel_boite/{print $3}' posts/$slug_post.txt`
wget -O cover $img_url
# On s'assure qu'on a bien un png
polaroid.sh cover
mv postcard.png ./files/images/jeux/$slug_jeu/

echo "Creation de la Galerie"
mkdir galleries/$slug_jeu
echo "\`Voir la Fiche du Jeu [$js_title] </posts/$slug_jeu.html>\`_" > galleries/$slug_jeu/index.txt
# Calcul de l'orientation
identify cover | awk '{split($3,a,"x"); if (a[1]>a[2]) { print "convert -resize x100 cover cover.png" } else { print "convert -resize 100x cover cover.png"}}' | sh
cp cover.png galleries/cover/$slug_jeu.png
# On regenere l'index de la Galerie
scripts/gen_gallery_index.sh > galleries/index.txt

echo "Ajout de l'include de la mini-fiche en tête de post"
awk '/Write/{print (".. include:: ./fiches/" slug_jeu ".rst");print "";print $0;next;}{print $0}' slug_jeu=$slug_jeu posts/$slug_post.txt > tmp_post.txt
mv tmp_post.txt posts/$slug_post.txt
echo "Création terminée"
echo "Post dans posts/$slug_post.txt"


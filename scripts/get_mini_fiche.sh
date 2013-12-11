#/bin/bash
if [ $# -ne 2 ]
then
    echo "Usage: $0 <post> <ludomania_id>"
    exit
fi

curl 127.0.0.1:9000/jeux/$2/mini-fiche > fiche.tmp
slug=`awk '/^.. slug/{ print $3}' fiche.tmp`
awk '/^$/{exit;}{print $0}' fiche.tmp > ./fiches/$slug.meta
awk 'BEGIN{pr=0}{if (pr==1){print $0}}/^$/{pr=1}' fiche.tmp > ./fiches/$slug.rst

# Si la fiche n'existe pas
fiche=`awk '/^.. ludomania/{print $3}' posts/$1.txt`
if [ -z "$fiche" ]; then
    echo "Fiche non trouvée."
    echo "Suppression des metadonnées initiales"
    sed -i "/^.. tags/d;/^.. slug/d" posts/$1.txt
    echo "Ajout des metadonnées du fichier $slug.meta"
    cat ./fiches/$slug.meta posts/$1.txt > tmp_post.txt
else
    echo "Fiche $fiche Trouvée"
    # ATTENTION: galerie doit toujours être la dernière de slug.meta ligne retournée par ludomania
    (cat ./fiches/$slug.meta; awk 'BEGIN{pr=0}{if (pr==1){print $0}}/^.. galerie/{pr=1}' ./posts/$1.txt) > tmp_post.txt
fi
mv tmp_post.txt posts/$1.txt

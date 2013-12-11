#/bin/bash
if [ $# -ne 2 ]
then
    echo "Usage: $0 <slug> <ludomania_id>"
    exit
fi
# TODO: Tester l'existence de la fiche pour recuperer automatiquement l'id ludomania dans la fiche.
#       Ajouter une meta-donnée sur le post contenant l'id ludomania. Attention à la modification des fiches précédentes. Cela nécessite d'ajouter une ligne en début de chaque post
#       Trouver une manière élégante de rajouter des méta-données

curl 127.0.0.1:9000/jeux/$2/mini-fiche > files/fiches/$1.rst && (awk 'NR<7{print $0}' files/fiches/$1.rst; tail -n+7 posts/$1.txt) > tmp.txt && cp tmp.txt posts/$1.txt && rm tmp.txt


# slim_project_esaip
Projet M1 sur la création et la conceptualisation d'une base de données par Bastian et Emir.

Vous allez retrouver dans ce projet :
=> /DATABASE/ avec le fichier de création, un fichier avec nos requêtes ainsi qu'un fichier trigger
=> /SRC/ Une interface web que nous avons essayé de faire mais nous sommes trop mauvais en DEV
=> /WORD/ les énoncés ainsi que le rendu écrit
=> (Racine) Un docker compose pour lancer le projet. Ainsi qu'un script python vous permettant d'exécuter les requêtes de manière plus agréable (une sorte d'interface pas WEB)

## Pour lancer le projet !
Dans un premier temps, il faut exécuter le docker compose.
=> docker compose -f compose.yaml up -d

Ce docker compose est constitué de deux conteneurs :
==> MariaDB : pour la base de données. Avec un script d'initialisation situé dans : /DATABASE/create_dessin_db ainsi que le peuplement. (Il faut attendre quelques minutes pour le peuplement)
==> phpMyAdmin : Un accès pour voir notre base de données.

Puis simplement exécutez le fichier python "main.py" (IL FAUT INSTALLER LE PAQUET "mysql-connector-python")

Puis vous n'avez plus qu'à exécuter nos requêtes dans notre interface minimaliste et efficace !!!

# A propos
Ceci est un projet de mise en place d'un serveur multimédia avec haute disponibilité.
Les scripts d'installation installent docker ainsi que k8's pour rocky linux 8.

# Les dossiers
Le dossier Deploys contient les différents manifestes yaml permettant la création des déploiement ainsi que des services.
A noter que certain déployement nécessitent la création de pv et pvc, donc il est nécessaire de déployer ceux-la en amont.

Le dossier Dockerfile contient le script dockerfile utiliser pour la création du de l'image subsonic, ce même script peut-être 
réutilisé pour des fins de mise à jour de l'image.

Le dossier scripts contient les différents scripts utilisés pour le projet.

# Commentaires sur les scripts
Le script d'installation de docker ajoute l'utilisateur exécutant le script dans le group docker, à noter qui ci celui
ci est éxécuter en root (le scrip) il faut penser à rajouter son utilisateur 
manuellement dans le groupe docker.

Le script install minikube demande à décommenter manuellement deux paramètre dans le fichier de configuration libvirtd.

Le stockage utilisé de la solution subsonic est un serveur NFS, il faut penser à installer celui ci en exécutant le scrip nécessaire.


Nous avons également le fichier de configuration d'un deploy nginx, il s'agit d'un deploy basic qui n'affiche que le contenu de la page web
par défaut de nginx.

# SoundBuzz
Ceci est un projet de mise en place d'un serveur multimédia avec haute disponibilité.
Les scripts d'installation installent docker ainsi que k8's pour rocky linux 8.

Le scrip d'installation de docker ajoute l'utilisateur exécutant le script dans le group docker, à noter qui ci celui
ci est éxécuter en root (le scrip) il faut penser à rajouter son utilisateur 
manuellement dans le groupe docker.

Le script install minikube demande à décommenter manuellement deux paramètre dans le fichier de configuration libvirtd.

Le stockage utilisé de la solution subsonic est un serveur NFS, il faut penser à installer celui ci en exécutant le scrip nécessaire.

Le subsonic.yaml n'a pas de réel utilité, il sera supprimé prochainement. Seul subdeploy et subservice sont nécessaire afin de déployer l'app.

Nous avons également le fichier de configuration d'un deploy nginx, il s'agit d'un deploy basic qui n'affiche que le contenu de la page web
par défaut de nginx.

#!/bin/sh

dnf -y upgrade

#Cette commande désactive temporairement l'application du mode d'exécution renforcée SELinux.
setenforce 0

#Cette commande utilise l'utilitaire sed pour modifier le fichier /etc/sysconfig/selinux et désactiver SELinux en remplaçant la valeur enforcing par disabled.
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

#Cette commande charge le module du noyau br_netfilter nécessaire pour le réseau dans Kubernetes.
modprobe br_netfilter

#Cette commande ajoute une règle de masquerade au pare-feu pour permettre aux paquets d'être transmis à travers le nœud Kubernetes.
firewall-cmd --add-masquerade --permanent  

firewall-cmd --reload

#Cette partie du code utilise la redirection des entrées pour écrire le contenu entre cat <<EOF et EOF dans le fichier /etc/sysctl.d/k8s.conf. Les lignes de configuration ajoutées ajustent certains paramètres réseau pour le fonctionnement de Kubernetes.
cat < /etc/sysctl.d/k8s.conf  
net.bridge.bridge-nf-call-ip6tables = 1  
net.bridge.bridge-nf-call-iptables = 1  
EOF

sysctl --system

#Cette commande désactive l'utilisation de l'espace d'échange (swap) sur le système.
swapoff -a

#Cette commande commente la ligne contenant l'utilisation de swap dans le fichier /etc/fstab pour empêcher son utilisation au démarrage.
sudo sed -i '/ swap / s/^(.*)$/#\1/g' /etc/fstab

dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

dnf install -y https://download.docker.com/linux/centos/9/x86_64/stable/Packages/containerd.io-1.6.12-3.1.el9.x86_64.rpm --allowerasing

dnf install -y https://download.docker.com/linux/centos/8/x86_64/stable/Packages/containerd.io-1.6.12-3.1.el8.x86_64.rpm --allowerasing

dnf install docker-ce -y

# Créer le répertoire /etc/docker s'il n'existe pas déjà
mkdir -p /etc/docker

# Écrire la configuration dans le fichier /etc/docker/daemon.json
echo '{
  "exec-opts": ["native.cgroupdriver=systemd"]
}' > /etc/docker/daemon.json

# Activer le service Docker pour qu'il démarre automatiquement au démarrage du système
systemctl enable docker --now

# Afficher la version de Docker installée
docker version

# Exécuter un conteneur Docker de test (hello-world)
docker run hello-world

# Créer un groupe d'utilisateurs appelé "docker"
groupadd docker

# Extraire la quatrième colonne du fichier /etc/group pour obtenir les informations sur le groupe "docker"
awk -F':' '/docker/{print $4}' /etc/group

# Ajouter l'utilisateur actuel au groupe "docker"
usermod -aG docker $USER

# Définir les permissions sur le fichier /var/run/docker.sock
chmod 666 /var/run/docker.sock


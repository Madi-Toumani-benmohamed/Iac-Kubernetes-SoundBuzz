#!/bin/sh

#change le hostname
hostnamectl set-hostname "kubernetes"

#ajout des dépendances
dnf -y install libvirt qemu-kvm virt-install virt-top libguestfs-tools bridge-utils wget


# vi /etc/libvirt/libvirtd.conf 
# il faut décommenter les deux lignes manuellement
# unix_sock_group = lib
# unix_sock_rw_perms = 0770 '

usermod -aG libvirt $USER

systemctl enable libvirtd --now

systemctl start libvirtd

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 

chmod +x minikube

mv minikube /usr/local/bin/minikube

minikube version

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl


chmod +x kubectl 
 
mv kubectl /usr/local/bin/

# minikube start --force (si nous sommes en root)
# minikube start --driver=none (si besoin)

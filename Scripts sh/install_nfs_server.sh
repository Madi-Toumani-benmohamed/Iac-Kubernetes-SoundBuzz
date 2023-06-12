sudo dnf install nfs-utils -y

sudo sed -i '/^#Domain/s/^#//;/Domain = /s/=.*/= control-node/' /etc/idmapd.conf

#export des fichiers de conf
export host


sudo mkdir /var/nfs/share -p
sudo mkdir /srv/nfs/share -p

sudo chown nobody:nobody /var/nfs/share
sudo chown nobody:nobody /srv/nfs/share

#ajout rule d autorisation de la rule permettant a tout les reseau de se connecter a ce dossier ci
echo "/srv/nfs/share  *(rw,sync,no_subtree_check,no_root_squash,insecure)" >> /etc/exports

echo "/var/nfs/share  *(rw,sync,no_subtree_check,no_root_squash,insecure)" >> /etc/exports

#Ajout des differentes rules et auto activation du serveur au boot
sudo firewall-cmd --add-service={nfs,nfs3,mountd,rpc-bind} --permanent
sudo firewall-cmd --reload

sudo systemctl enable --now nfs-server rpcbind

#on reload la conf nfs
sudo exportfs -ra


#On regarde si le fichier de conf nsf a bien été configuré
sudo exportfs -v

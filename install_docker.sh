#!/bin/sh

dnf -y upgrade

setenforce 0

sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

modprobe br_netfilter

firewall-cmd --add-masquerade --permanent  

firewall-cmd --reload

cat < /etc/sysctl.d/k8s.conf  
net.bridge.bridge-nf-call-ip6tables = 1  
net.bridge.bridge-nf-call-iptables = 1  
EOF

sysctl --system

swapoff -a

sudo sed -i '/ swap / s/^(.*)$/#\1/g' /etc/fstab

dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

dnf install -y https://download.docker.com/linux/centos/9/x86_64/stable/Packages/containerd.io-1.6.12-3.1.el9.x86_64.rpm --allowerasing

dnf install -y https://download.docker.com/linux/centos/8/x86_64/stable/Packages/containerd.io-1.6.12-3.1.el8.x86_64.rpm --allowerasing

dnf install docker-ce -y

mkdir -p /etc/docker

echo '{
  "exec-opts": ["native.cgroupdriver=systemd"]
}' > /etc/docker/daemon.json

systemctl enable docker --now

docker version

docker run hello-world

groupadd docker

awk -F':' '/docker/{print $4}' /etc/group

usermod -aG docker $USER

chmod 666 /var/run/docker.sock

service docker restart

docker run --rm hello-world

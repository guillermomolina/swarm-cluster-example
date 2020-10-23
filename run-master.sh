apt install -y git
curl https://get.docker.com | sudo bash

mkdir -p /srv/nfs
mkdir -p /opt/docker
#	Configurar NFS
echo 'instance-1:/srv/nfs /opt/docker nfs defaults,nfsvers=3 0 0' >> /etc/fstab
echo '/srv/nfs instance-1(rw,no_root_squash,no_subtree_check) instance-2(rw,no_root_squash,no_subtree_check) instance-3(rw,no_root_squash,no_subtree_check)' >> /etc/exports
apt install -y nfs-kernel-server
systemctl enable nfs-kernel-server
systemctl start nfs-kernel-server
mount -a

docker swarm init 
docker swarm join-token manager|grep join  > /opt/docker/join.sh
chmod +x $!

docker network create proxy -d overlay
#docker network create portainer_agent -d overlay


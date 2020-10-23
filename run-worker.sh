apt install -y git
curl https://get.docker.com | sudo bash

mkdir -p /opt/docker
#	Configurar NFS
echo 'node-1:/srv/nfs /opt/docker nfs defaults,nfsvers=3 0 0' >> /etc/fstab
apt install -y nfs-common
mount -a

/opt/docker/join.sh



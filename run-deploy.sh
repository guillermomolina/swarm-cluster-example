#!/bin/bash

IP1=$(curl ifconfig.me)
IP2=$(getent hosts instance-2 | awk '{print $1}')
IP3=$(getent hosts instance-3 | awk '{print $1}')
export IP1 IP2 IP3
export REMOTE_MOUNT="/opt/docker/data"

BASEDIR=$(dirname $0)
docker stack deploy -c ${BASEDIR}/traefik/docker-compose.yml traefik

if [ ! -d /opt/docker/portainer/volumes/portainer ]; then
    mkdir -p /opt/docker/portainer/volumes/portainer
fi
docker stack deploy -c ${BASEDIR}/portainer/docker-compose.yml portainer

#docker stack deploy -c ${BASEDIR}/consul-cluster/docker-compose.yml consul-cluster
#docker stack deploy -c ${BASEDIR}/comptador/docker-compose.yml comptador

if [ ! -d /opt/docker/wordpress/volumes/database ]; then
    mkdir -p /opt/docker/wordpress/volumes/database
fi
docker stack deploy -c ${BASEDIR}/wordpress/docker-compose.yml wordpress

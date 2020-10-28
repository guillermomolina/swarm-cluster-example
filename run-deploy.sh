#!/bin/bash

IP1=$(getent hosts instance-1 | awk '{print $1}')
IP2=$(getent hosts instance-2 | awk '{print $1}')
IP3=$(getent hosts instance-3 | awk '{print $1}')
export IP1 IP2 IP3
export REMOTE_MOUNT="/opt/docker/data"

BASEDIR=$(dirname $0)
docker stack deploy -c ${BASEDIR}/traefik/docker-compose.yml traefik


docker stack deploy -c ${BASEDIR}/portainer/docker-compose.yml portainer

#docker stack deploy -c ${BASEDIR}/consul-cluster/docker-compose.yml consul-cluster
#docker stack deploy -c ${BASEDIR}/comptador/docker-compose.yml comptador

mkdir -p /opt/docker/wordpress/volumes/database
docker stack deploy -c ${BASEDIR}/wordpress/docker-compose.yml wordpress

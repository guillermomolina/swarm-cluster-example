#!/bin/bash

function create_dir {
    if [ ! -d $1 ]; then
        mkdir -p $1
    fi 
}


IP1=$(curl ifconfig.me)
IP2=$(getent hosts instance-2 | awk '{print $1}')
IP3=$(getent hosts instance-3 | awk '{print $1}')
export IP1 IP2 IP3
export REMOTE_MOUNT="/opt/docker/data"

BASEDIR=$(dirname $0)
docker stack deploy -c ${BASEDIR}/traefik/docker-compose.yml traefik

create_dir /opt/docker/portainer/volumes/portainer
docker stack deploy -c ${BASEDIR}/portainer/docker-compose.yml portainer

#docker stack deploy -c ${BASEDIR}/consul-cluster/docker-compose.yml consul-cluster
#docker stack deploy -c ${BASEDIR}/comptador/docker-compose.yml comptador

create_dir /opt/docker/wordpress/volumes/database
docker stack deploy -c ${BASEDIR}/wordpress/docker-compose.yml wordpress

create_dir /opt/docker/elastic/volumes/elasticsearch
create_dir /opt/docker/elastic/volumes/logstash/config
if [ ! -f /opt/docker/elastic/volumes/logstash/config/logstash.conf ]; then
    cp ${BASEDIR}/elastic/logstash.conf /opt/docker/elastic/volumes/logstash/config
fi
docker stack deploy -c ${BASEDIR}/elastic/docker-compose.yml elastic

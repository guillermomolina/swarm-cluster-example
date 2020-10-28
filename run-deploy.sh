#!/bin/bash

function create_dir {
    if [ ! -d $1 ]; then
        mkdir -p $1
        chmod 177 $1
    fi 
}

function deploy {
    docker stack deploy -c ${BASEDIR}/$1/docker-compose.yml $1
}

IP1=$(curl ifconfig.me)
IP2=$(getent hosts instance-2 | awk '{print $1}')
IP3=$(getent hosts instance-3 | awk '{print $1}')
export IP1 IP2 IP3

BASEDIR=$(dirname $0)

if [ $# -eq 1 ]; then
    deploy $1
    exit 0
fi

deploy traefik

create_dir /opt/docker/portainer/volumes/portainer
deploy portainer

#deploy consul-cluster
#deploy comptador

create_dir /opt/docker/wordpress/volumes/database
deploy wordpress

create_dir /opt/docker/elastic/volumes/elasticsearch
chmod 177 /opt/docker/elastic/volumes/elasticsearch
create_dir /opt/docker/elastic/volumes/logstash
if [ ! -f /opt/docker/elastic/volumes/logstash/logstash.conf ]; then
    cp ${BASEDIR}/elastic/logstash.conf /opt/docker/elastic/volumes/logstash
fi
deploy elastic

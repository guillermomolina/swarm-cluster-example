#!/bin/bash

function create_dir {
    if [ ! -d $1 ]; then
        mkdir -p $1
        chmod -R 1777 $1
    fi 
}

IP1=$(curl ifconfig.me)
IP2=$(getent hosts instance-2 | awk '{print $1}')
IP3=$(getent hosts instance-3 | awk '{print $1}')
export IP1 IP2 IP3

BASEDIR=$(dirname $0)

create_dir /opt/docker/wordpress/volumes/database
docker stack deploy -c ${BASEDIR}/docker-compose.yml wordpress


#!/bin/bash

BASEDIR=$(dirname $0)
SCRIPT_PATH=$( cd ${BASEDIR} >/dev/null 2>&1 ; pwd -P )
STACK_NAME=$(basename ${SCRIPT_PATH})

function get_dns {
    echo "$1.$2.nip.io"
}

function create_dir {
    if [ ! -d $1 ]; then
        mkdir -p $1
        chmod -R 1777 $1
    fi 
}

function join_by { 
    local IFS="$1"
    shift
    echo "$*"
}

declare -a ELASTIC_HOST_NAMES_ARRAY
declare -a KIBANA_HOST_NAMES_ARRAY
if [ $# -gt 0 ]; then
    for IP in $@ ; do
        ELASTIC_HOST_NAMES_ARRAY+=( "$(get_dns "elastic" ${IP})" )
        KIBANA_HOST_NAMES_ARRAY+=( "$(get_dns "kibana" ${IP})" )
    done
else
    MY_IP=$(curl -s ifconfig.me)
    ELASTIC_HOST_NAMES_ARRAY+=$(get_dns "elastic" ${MY_IP})
    KIBANA_HOST_NAMES_ARRAY+=$(get_dns "kibana" ${MY_IP})
fi

ELASTIC_HOST_LIST=$(join_by "," ${ELASTIC_HOST_NAMES_ARRAY[@]})
KIBANA_HOST_LIST=$(join_by "," ${KIBANA_HOST_NAMES_ARRAY[@]})
export ELASTIC_HOST_LIST KIBANA_HOST_LIST
echo "Public DNS list ${ELASTIC_HOST_LIST}"
echo "Public DNS list ${KIBANA_HOST_LIST}"


create_dir /opt/docker/elastic/volumes/elasticsearch
docker stack deploy -c ${BASEDIR}/docker-compose.yml elastic

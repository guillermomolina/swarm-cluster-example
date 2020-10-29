#!/bin/bash

BASEDIR=$(dirname $0)
SCRIPT_PATH=$( cd ${BASEDIR} >/dev/null 2>&1 ; pwd -P )
STACK_NAME=$(basename ${SCRIPT_PATH})

function get_dns {
    echo "${STACK_NAME}.$1.nip.io"
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

declare -a HOST_NAMES_ARRAY
if [ $# -gt 0 ]; then
    for IP in $@ ; do
        HOST_NAMES_ARRAY+=( "$(get_dns ${IP})" )
    done
else
    HOST_NAMES_ARRAY+=$(get_dns $(curl -s ifconfig.me))
fi

HOST_LIST=$(join_by "," ${HOST_NAMES_ARRAY[@]})
export HOST_LIST
echo "Public DNS list ${HOST_LIST}"

create_dir /opt/docker/traefik/volumes/letsencrypt
docker stack deploy -c ${BASEDIR}/docker-compose.yml ${STACK_NAME}


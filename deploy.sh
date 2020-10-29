#!/bin/bash

BASEDIR=$(dirname $0)

function deploy_stack {
    STACK=$1
    shift   
    if [ -x ${BASEDIR}/$1/deploy.sh ]; then
        ${BASEDIR}/$1/deploy.sh $*
        echo "Deployed stack $1"
    else
        echo "Unknown stack $1"
    fi    
}

if [ $# -ge 1 ]; then
    STACK=$1
    shift
    if [ ${STACK} == "all" ]; then
        for ${S} in traefik portainer monitor wordpress elastic; do
            deploy_stack ${S} $*
        done
    else
        deploy_stack ${STACK} $*
    fi
else
    echo "Enter stack name (or all)"
fi


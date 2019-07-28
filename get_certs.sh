#!/bin/bash

if [ -z "$1" ]; then
  echo "Useage : ./get_certs.sh [container_name]"
  exit -1
fi

mkdir -p ./certs
rm ./certs/*.pem
docker cp $1:/etc/certs/ca.pem ./certs/.
docker cp $1:/etc/certs/client-cert.pem ./certs/.
docker cp $1:/etc/certs/client-key.pem ./certs/.

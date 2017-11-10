#!/bin/bash

set -e 

docker stop $(docker ps -q)
docker rm $(docker ps -q --all)
docker rmi $(docker images -q)
cd /var/lib/docker/aufs
rm -rf *
/etc/init.d/docker restart

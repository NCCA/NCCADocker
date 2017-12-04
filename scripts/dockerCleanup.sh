#!/bin/bash


docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi
docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v
docker volume ls -qf dangling=true | xargs -r docker volume rm
#!/bin/sh

docker ps -aq --filter label=docker-mcp=true | xargs docker rm -fv

docker ps -aq --filter label=project=chinook-agent | xargs docker rm -fv

docker network ls -q --filter label=project=chinook-agent | xargs docker network rm
docker volume ls -q --filter label=project=chinook-agent | xargs docker volume rm
docker image ls -q --filter label=project=chinook-agent | xargs docker rmi -f

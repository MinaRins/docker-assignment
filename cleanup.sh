#!/bin/sh
# Remove everything run-system.sh creates so it can be rerun cleanly.

# MCP server container started by the gateway (labelled docker-mcp=true by the gateway itself)
docker ps -aq --filter label=docker-mcp=true | xargs docker rm -fv

# Our labelled containers (database, gateway, leftovers); -v removes their anonymous volumes
docker ps -aq --filter label=project=chinook-agent | xargs docker rm -fv

# Network, volumes and built images
docker network ls -q --filter label=project=chinook-agent | xargs docker network rm
docker volume ls -q --filter label=project=chinook-agent | xargs docker volume rm
docker image ls -q --filter label=project=chinook-agent | xargs docker rmi -f

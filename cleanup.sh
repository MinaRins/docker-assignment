#!/bin/sh
# TODO
#!/bin/sh
# Remove everything run-system.sh creates so it can be rerun cleanly.

# Labelled containers (database, gateway, leftovers). -v also removes their anonymous volumes
docker ps -aq --filter label=project=chinook-agent | xargs docker rm -fv

# MCP server container started by the gateway (no label, so match by image)
docker ps -aq --filter ancestor=mcp/cockroachdb | xargs docker rm -fv

# Network and built images
docker network ls -q --filter label=project=chinook-agent | xargs docker network rm
docker image ls -q --filter label=project=chinook-agent | xargs docker rmi -f

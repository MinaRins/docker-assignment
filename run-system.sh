#!/bin/sh

set -e

docker network create --label project=chinook-agent agent-net

docker run -d --name chinook-db --network agent-net --label project=chinook-agent -e POSTGRES_USER=chinook -e POSTGRES_PASSWORD=chinookpass -e POSTGRES_DB=chinook postgres:16

until docker exec chinook-db pg_isready -h localhost -U chinook; do sleep 1; done

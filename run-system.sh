#!/bin/sh

set -e

docker network create --label project=chinook-agent agent-net

docker run -d --name chinook-db --network agent-net --label project=chinook-agent -e POSTGRES_USER=chinook -e POSTGRES_PASSWORD=chinookpass -e POSTGRES_DB=chinook postgres:16

until docker exec chinook-db pg_isready -h localhost -U chinook; do sleep 1; done

docker build --target seeder --label project=chinook-agent -t chinook-seeder .

docker build --target agent --label project=chinook-agent -t chinook-agent .

docker run --rm --name seeder --network agent-net --label project=chinook-agent -v "$(pwd)/Chinook.db:/app/Chinook.db:ro" -e SQLITE_FILE=/app/Chinook.db -e DATABASE_URL=postgres://chinook:chinookpass@chinook-db:5432/chinook chinook-seeder

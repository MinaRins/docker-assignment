#!/bin/sh

set -e

docker network create --label project=chinook-agent agent-net

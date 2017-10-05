#!/bin/bash

docker-compose down
docker-compose up -d dev
sleep 5
docker-compose run seed_gatekeeper

#!/bin/bash

# use the local modified docker-compose
docker-compose -f docker-compose-from-build.yml up -d
curl 0.0.0.0:5000/hello
docker-compose -f docker-compose-from-build.yml down -v

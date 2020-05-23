#!/bin/bash

docker container stop foodtrucks-web && docker container rm foodtrucks-web
docker container stop es && docker container rm es
docker network rm foodtrucks-net
docker image rm -f prakhar1989/foodtrucks-web

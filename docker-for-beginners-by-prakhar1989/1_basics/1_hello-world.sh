#!/bin/bash

docker run hello-world
docker pull busybox

docker images

docker run busybox # ran an empty command and then exited
docker run busybox echo "hello from busybox" # ran the echo command in our busybox container and then exited it

docker ps # shows you all containers that are currently running
docker ps -a # all containers that we ran

docker run -it busybox sh # -it flags attaches us to an interactive tty in the container
docker rm $(docker ps -a -q -f status=exited) # deletes all containers that have a status of exited. -f filters

docker container prune # == docker rm $(docker ps -a -q -f status=exited)

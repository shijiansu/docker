#!/bin/bash

docker images
docker pull ubuntu:18.04
cd ./docker/flask-app

docker build -t shijiansu/catnip .

# open port 8888, map to container port 5000 (as EXPOSE 5000)
## python app run at container 5000, Dockerfile EXPOSE 5000, docker run map to local 8888
docker run -p 8888:5000 shijiansu/catnip
http://localhost:8888

Ctrl+C

docker login

docker push shijiansu/catnip
docker run -p 8888:5000 shijiansu/catnip

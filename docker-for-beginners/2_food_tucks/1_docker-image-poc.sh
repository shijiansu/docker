#!/bin/bash

# Inspired by "food-trucks" Dockerfile for POC
# Propose: POC and setup container before writing the Dockerfile

# simulate Dockerfile steps
docker container run -it --name foodtrucks-web-poc ubuntu:latest
exit
# docker container stop foodtrucks-web-poc
# docker container rm foodtrucks-web-poc
docker container start foodtrucks-web-poc
# docker container attach foodtrucks-web-poc # if exit, container stops
docker exec -it foodtrucks-web-poc /bin/bash # after exit, container still running

# install system-wide deps for python and node
apt-get -yqq update
## 20200507 - now apt-get there is no python-pip (do not have the pip for Python2)
apt-cache search pip | grep python # only for python3
## install pip for Python2 - https://pip.pypa.io/en/stable/installing/
apt-get -yqq install 
# not working # apt-get -yqq install python3-pip python-dev curl gnupg # update python-pip to python3-pip (20200507)
apt-get -yqq install python-dev curl gnupg
## python pip
python --version
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
## node
curl -sL https://deb.nodesource.com/setup_10.x | bash
apt-get install -yq nodejs

# copy our application code
## in another terminal or exit current container
docker cp flask-app foodtrucks-web-poc:/opt/flask-app
cd /opt/flask-app

# fetch app specific deps
npm install
npm run build
pip install -r requirements.txt
python /opt/flask-app/app.py # using Python2

exit

# save container as image
docker commit foodtrucks-web-poc prakhar1989/foodtrucks-web-poc
docker image ls

# run containers with network - ft container depends on es container
docker network create -d bridge foodtrucks-web-poc
docker container run -d --name es -p 9200:9200 -p 9300:9300 --network foodtrucks-web-poc \
  -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.3.2
docker container run -d --name ft -p 5000:5000 --network foodtrucks-web-poc \
  prakhar1989/foodtrucks-web-poc python /opt/flask-app/app.py # run with Python2

# verify running application
curl http://localhost:5000/
http://localhost:5000/

# clean resource
docker container stop foodtrucks-web-poc && docker container rm foodtrucks-web-poc 
docker container stop ft && docker container rm ft
docker container stop es && docker container rm es
docker network rm foodtrucks-web-poc
docker image rm -f prakhar1989/foodtrucks-web-poc

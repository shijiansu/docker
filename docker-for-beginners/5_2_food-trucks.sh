#!/bin/bash

# Start elasticsearch
docker search elasticsearch
docker search elasticsearch
docker pull docker.elastic.co/elasticsearch/elasticsearch:6.3.2
docker run -d --name es -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.3.2
curl 0.0.0.0:9200

cd ./docker/food-trucks
tree -L 2
docker build -t prakhar1989/foodtrucks-web .
docker run -P --rm prakhar1989/foodtrucks-web # depends on es
# Unable to connect to ES. Retying in 5 secs...
# Unable to connect to ES. Retying in 5 secs...
# Unable to connect to ES. Retying in 5 secs...
# Out of retries. Bailing out...

# connect es
docker container ls
docker network ls
docker network inspect bridge # bridge network is the network in which containers are run by default
# auto get the IP of "es" from "bridge"
## -f name=^es$: only filter es, ^$ are EL pattern
## --no-trunc -q: full container ID
docker container ls -f name=^es$ --no-trunc -q 
## grep -A 6: including 6 line after matched content
docker network inspect bridge | jq '.[0].Containers' | grep -A 6 $(docker container ls -f name=^es$ --no-trunc -q) | grep 'IPv4Address'
## "IPv4Address": "172.17.0.2/16",

## able to connect es
docker run -it --rm prakhar1989/foodtrucks-web bash # get IP from above 
curl 172.17.0.2:9200
exit

# Since the bridge network is shared by every container by default, this method is not secure. How do we isolate our network
docker network create foodtrucks-net
docker network ls
# 55f86b2bd5ce        foodtrucks-net           bridge              local
docker container stop es && docker container rm es
docker run -d --name es --network foodtrucks-net -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.3.2
docker network inspect foodtrucks-net

# docker run -it --rm --net foodtrucks-net prakhar1989/foodtrucks-web bash # --net == --network
docker run -it --rm --network foodtrucks-net prakhar1989/foodtrucks-web bash # now can connect to es by container name because in the same network
curl es:9200
python app.py
exit

docker run -d --network foodtrucks-net -p 5000:5000 --name foodtrucks-web prakhar1989/foodtrucks-web
docker container ls
curl -I 0.0.0.0:5000

# clean resource
docker container stop foodtrucks-web && docker container rm foodtrucks-web
docker container stop es && docker container rm es
docker network rm foodtrucks-net
docker image rm -f prakhar1989/foodtrucks-web

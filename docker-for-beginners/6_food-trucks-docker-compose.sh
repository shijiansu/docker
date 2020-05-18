#!/bin/bash

docker-compose --version
# docker-compose version 1.25.4, build 8d51620a

cd ./docker/food-trucks
docker-compose up

# Swarm mode allows you to create a cluster of Docker Engines. 
# With 1.13, the docker stack deploy command can be used to deploy a Compose file to Swarm mode. 
# Docker Compose gives us multi-container applications, 
# but the applications are still restricted to a single host. 
# And that is a single point of failure.

docker-compose up -d # detech mode
docker-compose ps
#       Name                     Command               State                Ports
# ---------------------------------------------------------------------------------------------
# es                  /usr/local/bin/docker-entr ...   Up      0.0.0.0:9200->9200/tcp, 9300/tcp
# food-trucks_web_1   python app.py                    Up      0.0.0.0:5000->5000/tcp

docker-compose down -v
# Stopping food-trucks_web_1 ... done
# Stopping es                ... done
# Removing food-trucks_web_1 ... done
# Removing es                ... done
# Removing network food-trucks_default
# Removing volume food-trucks_esdata1

docker network rm foodtrucks-net
docker network ls

# up again

docker-compose up -d
docker container ls
# CONTAINER ID        IMAGE                                                 COMMAND                  CREATED             STATUS              PORTS                              NAMES
# 8ae7a3787db1        prakhar1989/foodtrucks-web                            "python app.py"          4 minutes ago       Up 4 minutes        0.0.0.0:5000->5000/tcp             food-trucks_web_1
# ee74f8ea4e1c        docker.elastic.co/elasticsearch/elasticsearch:6.3.2   "/usr/local/bin/dock…"   4 minutes ago       Up 4 minutes        0.0.0.0:9200->9200/tcp, 9300/tcp   es
docker network ls
docker ps
# CONTAINER ID        IMAGE                                                 COMMAND                  CREATED             STATUS              PORTS                              NAMES
# 8ae7a3787db1        prakhar1989/foodtrucks-web                            "python app.py"          5 minutes ago       Up 5 minutes        0.0.0.0:5000->5000/tcp             food-trucks_web_1
# ee74f8ea4e1c        docker.elastic.co/elasticsearch/elasticsearch:6.3.2   "/usr/local/bin/dock…"   5 minutes ago       Up 5 minutes        0.0.0.0:9200->9200/tcp, 9300/tcp   es
docker network inspect food-trucks_default
# [
#     {
#         "Name": "food-trucks_default",
#         "Id": "ecd8b12f3881e307734d06e91012f10eac3b909af7c0326a5bd352073292ff50",
#         "Created": "2020-05-11T16:54:33.3993517Z",
#         "Scope": "local",
#         "Driver": "bridge",
#         "EnableIPv6": false,
#         "IPAM": {
#             "Driver": "default",
#             "Options": null,
#             "Config": [
#                 {
#                     "Subnet": "172.22.0.0/16",
#                     "Gateway": "172.22.0.1"
#                 }
#             ]
#         },
#         "Internal": false,
#         "Attachable": true,
#         "Ingress": false,
#         "ConfigFrom": {
#             "Network": ""
#         },
#         "ConfigOnly": false,
#         "Containers": {
#             "8ae7a3787db1ecaabbd670ba157612435802254c194a25c95b4bf539c2e9ff3c": {
#                 "Name": "food-trucks_web_1",
#                 "EndpointID": "707f982a7b1780627433273b458591b947a9e94449fc74c3c71d6c4779e13077",
#                 "MacAddress": "02:42:ac:16:00:03",
#                 "IPv4Address": "172.22.0.3/16",
#                 "IPv6Address": ""
#             },
#             "ee74f8ea4e1cdce1d5f15b5e91e6722e8f843bb12c2003ac09de6754469f3541": {
#                 "Name": "es",
#                 "EndpointID": "f0376f5d0bf60b077a819cfd837b4503b9bd5d1dbbc3fa8e8f83274c46ef8b51",
#                 "MacAddress": "02:42:ac:16:00:02",
#                 "IPv4Address": "172.22.0.2/16",
#                 "IPv6Address": ""
#             }
#         },
#         "Options": {},
#         "Labels": {
#             "com.docker.compose.network": "default",
#             "com.docker.compose.project": "food-trucks",
#             "com.docker.compose.version": "1.25.4"
#         }
#     }
# ]

# only start web, and execute bash command
docker-compose run web bash

# run by the local build from docker-compose
docker-compose down -v

# use the local modified docker-compose
docker-compose -f docker-compose-from-build.yml up -d
curl 0.0.0.0:5000/hello
docker-compose -f docker-compose-from-build.yml down -v

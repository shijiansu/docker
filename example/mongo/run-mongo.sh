#!/bin/bash

# 准备
https://hub.docker.com/_/mongo?tab=tags&page=1
docker search mongo
docker pull mongo:latest
docker pull mongo:3.6.19-xenial

docker images | grep mongo

# 运行
## --auth启动认证模式
docker run -itd --name mongo-first-try -p 27017:27017 mongo:3.6.19-xenial --auth
docker exec -it mongo-first-try mongo admin
## 使用密码 123456
> db.createUser({ user:'admin',pwd:'123456',roles:[ { role:'userAdminAnyDatabase', db: 'admin'}]});
> db.auth('admin', '123456')
> exit

docker container stop mongo-first-try
docker container rm mongo-first-try

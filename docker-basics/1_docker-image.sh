#!/bin/bash

docker pull registry.hub.docker.com/ubuntu:18.04

docker image pull [OPTIONS] NAME[:TAG|@DIGEST]
# -a, --all-tags: 拉取镜像的所有标签

docker image ls

docker [image] inspect [OPTIONS] IMAGE [IMAGE...] # 镜像详细信息
docker image inspect ubuntu:latest

docker [image] history [OPTIONS] IMAGE # 每层创建的历史
docker history nginx

docker [image] tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG] # 添加镜像标签
docker tag nginx:latest mynginx:0.1

docker search [OPTIONS] TERM # 搜索镜像
docker search --filter stars=50 nginx

docker image rm NAME[:TAG] # 使用标签删除镜像
docker image rm ID # 根据镜像id删除镜像
docker image rm $(docker image ls -a -q) # 移除所有镜像
docker image prune [OPTIONS] # 清理一段时间过后的临时镜像和不再使用的镜像
# -a, --all: 删除所有无用镜像，不只是临时镜像

# 创建镜像
## 1 基于已有容器创建
docker [container] commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
## 2 基于本地模板导入
docker [image] import [OPTIONS] file|URL - [REPOSITORY[:TAG]]
## 3 基于Dockerfile创建

# 存储和载入镜像
docker [image] save -o FILE NAME[:TAG] # 镜像存储
docker image save -o hello-world.tar.gz hello-world
docker [image] load [OPTIONS] FILE # 镜像载入
docker image load -i hello-world.tar.gz

# 镜像共享
docker login # 登录Docker hub
docker [image] push [REGISTRY_HOST[:REGISTRY_PORT] / ]NAME[:TAG]
docker push username/repository:tag # 上传镜像           
docker push belonk/get-started:part2

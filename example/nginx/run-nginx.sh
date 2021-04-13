#!/bin/bash

# 准备
https://hub.docker.com/_/nginx?tab=tags
docker search nginx
docker pull nginx:latest
docker pull nginx:1.19.2-alpine

docker images | grep nginx

# 运行
docker -d run --name nginx-first-try -p 8080:80 nginx:1.19.2
open http://localhost:8080/
docker container stop nginx-first-try
docker container rm nginx-first-try

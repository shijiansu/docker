#!/bin/bash

# 准备
https://hub.docker.com/_/redis?tab=tags
docker search redis
docker pull redis:latest
docker pull redis:6.0.7-alpine

docker images | grep redis

# 运行
docker run -itd --name redis-first-try -p 6379:6379 redis
docker exec -it redis-test /bin/bash

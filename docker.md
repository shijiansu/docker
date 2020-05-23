
```shell
# docker commands
docker ps
docker build
docker pull [image name]
docker run
docker push

# container commands
docker stats [container name/ID] [container name/ID]
docker logs [-f] [container name/ID]
docker inspect [container name/ID]
docker port [container name/ID]
docker exec [-i] [-t] [container name/ID]
```



http://hanqunfeng.iteye.com/blog/2331648
https://docs.docker.com/samples/library/mysql/#-via-docker-stack-deploy-or-docker-compose
https://severalnines.com/blog/mysql-docker-composing-stack




https://eksworkshop.com/cleanup/workspace/
https://eksworkshop.com/cleanup/workspace/
https://github.com/docker/labs

https://docker-k8s-lab.readthedocs.io/en/latest/

- Docker Hub [重要]: https://hub.docker.com/
  - sonatype/nexus3: https://hub.docker.com/r/sonatype/nexus3/



- https://blog.csdn.net/u010246789/article/details/53955485

```shell
docker info
docker create centos:latest # 创建容
docker run: # 创建并启动容器
# 交互型容器
## -i容器标准输入; -t建立一个命令行终端; /bin/bash告诉docker要在容器里面执行此命令
docker run -i -t --name=docker_run centos /bin/bash
# 后台型容器
## 只有调用docker stop、docker kill命令才能使容器停止
docker run -d --name=docker_run_b centos /bin/bash -c "while true: do echo Hello world; sleep 1; done"
docker ps
```


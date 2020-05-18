
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


# Cluster环境下的概念

- Swarm
  - App: App根据复杂程度, 可以使用Single stack或者Multiple stacks
  - Stack: 一个Stack是一组相互关联的services, 这组service共享依赖, 可被安排在一起运行和扩展
  - Service: Services实际上是"containers in production". 一个service只能运行一个image, 但是可以运行出同一个image的多个containers. service模式运行一个container和独立运行container相比, 可以在不手工重启container状况下, 通过service更新container的网络, volume等配置
  - Task && Container: task是swarm中的原子调度单元, 对应运行在一个service中的单个container (理论上Task也可以对应到非container的执行单元如进程上, 但是目前只对应container). 每个Task中有一个对应的container
- AWS EC2
  - Task (definition): A task is a logical group of one or more Docker containers that are deployed with specified settings. Define application containers - Image URL, CPU, memory requirement, launch type, network configuration, etc. A running instantiation of a task definition; create before create service
  - Service: Launch type, network configuration, load balancer, etc. Maintain n running copies (desired count); integrated with ELB, Unhealthy tasks automatically replaced.

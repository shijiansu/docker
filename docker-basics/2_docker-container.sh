#!/bin/bash

docker container ls [OPTIONS] # docker ps [OPTIONS]
# -a, --all：显示所有的容器（不加此选项则仅显示运行中的）
# -f, --filter：按照条件过滤查询
# --format string: 格式化输出信息
# -n, --last int: 仅显示最后的n个容器(所有状态)
# -l, --latest: 仅显示最近创建的容器(所有状态)
# --no-trunc: 不截断输出信息
# -q, --quiet: 仅输出容器id
# -s, --size: 设置显示的总数

docker [container] inspect [OPTIONS] CONTAINER [CONTAINER...] # 详细信息
docker inspect c711

docker [container] top CONTAINER [ps OPTIONS] # 容器内的进程信息
docker top c711

docker [container] stats [OPTIONS] CONTAINER # 统计信息
docker stats --no-stream c711
# -a, --all: 输出所有容器统计信息，默认仅在运行中
# --format string: 格式化输出信息
# --no-stream: 不持续输出信息，默认为自动更新
# --no-trunc: 不截断输出信息，默认文本信息超过为自动截断

# 创建容器
docker [container] create [OPTIONS] IMAGE [COMMAND] [ARG...] # 创建容器, 容器并没有运行
docker create --help
# -a, --attach list: 绑定到STDIN、STDOUT或STDERR
# -e, --env list: 设置环境变量
# -h, --hostname string: 配置容器hostname
# -i, --interactive: 打开交互终端STDIN
# -t, --tty：为容器分配伪终端
# --ip string: 配置IPV4(e.g., 172.30.100.104)
# -l, --label list：设置容器的元数据（key=value的形式）
# --log-driver string：设置容器的日志驱动，包括：json-file(默认)、syslog、journald、gelf、fluentd、awslogs、splunk、etwlogs、gcplogs、none
# -m, --memory bytes: 设置容器内存大小
# --name string: 为容器设置名称
# --mount mount: 为容器挂载宿主机文件或目录
# -p, --publish list: 为容器指定发布的端口映射
# -P, --publish-all：发布容器端口到宿主机的可用随机端口
# --restart string：容器退出的重启策略，包括no、on-failure[:max-retry]、always、unless-stopped等，(default "no")
# -v, --volume list 挂载主机的数据卷
# --volume-driver string 设置数据卷驱动
# --volumes-from list 挂载数据卷容器
# -w, --workdir string 设置容器的工作目录

docker container create nginx # 创建
docker container ls -a
docker create --name mynginx nginx # 创建并使用容器名字
docker [container] start CONTAINER # 启动
docker container start 2fe6e
docker [container] run IMAGE[:TAG] # 创建+启动
docker run -it ubuntu /bin/bash # i 表示开发容器的标准输入（STDIN），t 则为容器创建一个命令行终端
docker run nginx /bin/echo 'hello docker'
docker [container] run -d # -d, --detach：后台运行容器
docker run -d nginx /bin/echo 'hello docker'
docker run --name nginx-dev -d -p 8080:80 nginx # 宿主机的端口和容器的端口进行映射
docker [container] logs [OPTION] CONTAINER # 容器日志
# -details : 打印详细信息;
# -f, --follow: 保持输出日志
# --since string: 输出从某个时间开始的日志
# --tail string : 输出最近的若干日志
# -t, --timestamps: 显示时间戳信息
# --until string: 输出某个时间之前的日志
docker logs 837
docker logs -f 837

# 停止容器
## 暂停
docker [container] pause CONTAINER
docker [container] unpause CONTAINER
docker ps
docker container pause 2fe # 调用 pause 命令后，STATUS 变成了 Paused 状态
docker ps
docker unpause 2fe
docker ps
# 停止
docker [container] stop [-t | --time[=10]] [CONTAINER...]
# -t, --time 参数用于指定停止容器的超时时间，默认为10s。

# 进入容器
docker [container] exec [-d|--detach] [--detach-keys[=[]]] [-i|--interactive] [--pfivileged] [-t|--tty] [-u|--user[=USER]] CONTAINER COMMAND [ARG...]
# -d, --detach: 在容器中后台执行命令
# --detach-keys="": 指定将容器切回后台的按键
# -e, --env=[]: 指定环境变量列表
# -i, --interactive=true|false: 打开标准输入接受用户输入命令， 默认值为false
# --privileged=true|false: 是否给执行命令以高权限，默认值为 false
# -t, --tty=true|false: 分配伪终端，默认值为 false
# -u, --user="": 执行命令的用户名或 ID
docker container exec -it 8e9 /bin/bash

# 删除容器
docker [container] rm [-f|--force] [-l|--link] [-v|--volumns] CONTAINER [CONTAINER ...]
# -f, --force: 是否强制删除容器
# -l, --link: 删除容器的连接，但保留容器
# -v, --volumns: 删除容器挂载的数据卷
docker rm -f 244

# 导入和导出容器
docker [container] export [-o|--output=[FILE]] CONTAINER # 导出容器
docker [container] export CONTAINER > FILE # 导出容器
docker export -o hello.tar 91d
docker import [OPTIONS] file|URL|- [REPOSITORY[:TAG]] # 导入容器

docker import [OPTIONS] file|URL|- [REPOSITORY[:TAG]] # 导入容器
# -c,--change list: 导入的同时执行修改容器的Dockerfile文件
# -m,--message string: 设置commit信息
# 多种导入模式
docker import http://example.com/exampleimage.tgz # 导入远程文件
cat exampleimage.tgz | docker import - exampleimagelocal:new # 导入本地文件 - 通过 pipe 和 STDIN 导入本地文件
cat exampleimage.tgz | docker import --message "New image imported from tarball" - exampleimagelocal:new # 导入本地文件并设置 commit message
docker import /path/to/exampleimage.tgz # 通过文件路径导入本地文件
sudo tar -c . | docker import - exampleimagedir # 从本地目录导入
sudo tar -c . | docker import --change "ENV DEBUG true" - exampleimagedir # 从本地目录导入并设置新的参数

# 导入镜像存储文件: docker load - 将保存完整记录
# 导入一个容器快照: docker import - 将丢弃所有的历史记录和元数据信息 (即仅保存容器当时的快照状态), 可以重新指定标签等元数据信息

# 复制文件
## container cp命令支持在容器和宿主机之间复制文件
docker [container] cp [OPTIONS] CONTAINER:SRC_PATH DEST_PATH|-
docker [container] cp [OPTIONS] SRC_PATH|- CONTAINER:DEST_PATH
touch text
docker ps
# CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
# c7117b649a39        nginx               "nginx -g 'daemon of…"   3 hours ago         Up 3 hours          80/tcp              objective_lederberg
docker container cp test objective_lederberg:/root # 本地文件复制到容器
docker exec -it c711 /bin/bash
ls cd /root/
docker container cp objective_lederberg:/root/test . # 容器文件复制到主机

# 查看变更
docker [container] diff CONTAINER # 相对于容器创建时的文件变化
docker container diff objective_lederberg

docker [container] port:port CONTAINER # 查看端口映射
docker run -d -p 8080:80 nginx

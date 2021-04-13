#!/bin/bash

# 准备
https://hub.docker.com/_/mysql?tab=tags
docker search mysql
docker pull mysql:latest
docker pull mysql:8.0.21

docker images | grep mysql

# 运行
docker run -itd --name mysql-first-try -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql:8.0.21 # 密码123456
docker exec -it mysql-first-try bash
> mysql -u root -p
> exit
exit
## 安装mysql shell以后, 使用mysql shell连接
mysqlsh
> \connect root:123456@localhost:3306
> \sql
> select @@port;
> \quit

# docker stop mysql-first-try
# docker rm mysql-first-try
# 以下是docker为整理旧语法, 多出来container
docker container stop mysql-first-try
docker container rm mysql-first-try


# 错误集
## Error: ER_NOT_SUPPORTED_AUTH_MODE:
## 高版本的MySQL默认使用新的密码算法
mysql -h localhost -u root -p
> ALTER USER 'root'@'localhost' IDENTIFIED BY '123456'; # 修改加密方式
> ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123456'; # 重新修改密码
## ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/tmp/mysql.sock'
## 原因: 可能没权限写入临时文件
mysql -h localhost -P 3306 -u root -p # 会遇到以上的错误
mysql -h 127.0.0.1 -P 3306 -u root -p # 是可以连接的, 需要brew install mysql安装客户端(也连同服务器端, 但不使用)

## 新建用户
> CREATE USER 'root2'@'%' IDENTIFIED WITH mysql_native_password BY '123456'; # 新建用户
> GRANT ALL PRIVILEGES ON *.* TO 'root2'@'%'; 
> FLUSH PRIVILEGES; # 刷新

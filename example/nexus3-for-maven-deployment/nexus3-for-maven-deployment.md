# README

Sonatype Nexus3 Docker: sonatype/nexus3

- https://hub.docker.com/r/sonatype/nexus3/

## 例子执行

```shell
# 制作docker和nexus
bash ./src/shell/main/create_docker.sh
# 制作maven项目
## bash ./src/shell/main/create_maven_project.sh 'shijian.su' 'nexus-test' '0.0.1-SNAPSHOT'

# 测试maven
## 项目1
mvn -f nexus-test/pom.xml -s settings.xml clean install
### 每一次deploy Snapshot版本到Nexus, Nexus生成一个拥有时间戳文件名的jar, e.g。 0.0.1-20180826.051842-1
mvn -f nexus-test/pom.xml -s settings.xml clean deploy \
  -Dnexus.admin.username=admin \
  -Dnexus.admin.password=admin123
## 项目2
mvn -f nexus-test2/pom.xml -s settings.xml clean install
```

## 分解步骤介绍

```shell
# 拉取Docker镜像
sudo docker pull sonatype/nexus3
# 本地目录
## 参照下面"使用Volumne"建立"nexus"用户
mkdir -p $(pwd)/data/docker/nexus3/nexus-data && sudo chown -R :nexus $(pwd)/data
# 运行镜像
docker run -d -p 8081:8081 --name nexus -v $(pwd)/data/docker/nexus3/nexus-data:/nexus-data sonatype/nexus3
# 启动需要2-3 minutes, 可查看日志
docker logs -f nexus
# 访问
http://localhost:8081
```

## 使用Volumne使用介绍及分析

```shell
## 方法1 - 虽然官网不推荐, 但本地可选用
### 这里有遇到一个permission的问题. 由于该镜像运行时的用户是nexus
#### 查看该镜像运行时的用户情况
docker run -it --rm sonatype/nexus3 bash
id nexus # uid=200(nexus) gid=200(nexus) groups=200(nexus)
### 解决办法
#### (1) - chmod: mkdir /some/dir/nexus-data && chomod -R 777 /some/dir/nexus-data
#### (2) - 以root方式启动: docker run -u 0
#### (3) - 官网推荐https://hub.docker.com/r/sonatype/nexus3/ - Persistent Data
##### chown -R 200 /some/dir/nexus-data # 这个在Mac不可, 因为Mac的200已被占用是属于_softwareupdate
#### (4) - 建立nexus用户 (亲测可用, 我用)
##### Linux
sudo groupadd nexus
##### Mac
System preferences -> Users & Groups -> "+" (as if you were adding new account) -> Under "New account" select "Group" -> Type in group name： nexus -> "Create group"
## 方法2
### docker volume create --name nexus-data
### docker run -d -p 8081:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3
```

## 镜像默认值

- Default credentials: admin/admin123
- Installation of Nexus: /opt/sonatype/nexus

## Maven的setting.xml文档

- https://maven.apache.org/ref/3.5.4/maven-settings/settings.html

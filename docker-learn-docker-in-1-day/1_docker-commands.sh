#!/bin/bash

docker run -it centos /bin/bash
ls
ps -ef
cat /etc/redhat-release

# old approach
docker iamges
docker pull nginx # latest
docker pull nginx:1.12
docker history nginx:1.12

# docker image
docker --help
docker image --help
docker image ls # docker iamges
docker image history nginx:1.12
docker image inspect nginx:1.12
docker image rm nginx:1.12
docker image pull nginx:1.11

docker tag nginx:1.11 nginx:v1
docker image ls
docker image save nginx1.11 >nginx1.11.tar # export image
du -sh nginx1.11.tar
docker image load <nginx1.11.tar # import image

docker ps
docker run -itd busybox
docker ps
docker export b3d4a7fdc67e >busybox.tar # export container
docker iamge import busybox.tar busybox:self # import container

# container

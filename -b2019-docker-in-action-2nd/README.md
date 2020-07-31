# Some docker command for lib

```shell script
# container
docker ps --no-trunc # see all running containers with full info
docker ps --no-trunc -a # see all containers with full info
docker stop $(docker ps -q) # stop all dockers
docker stop ch6_wordpress && docker rm ch6_wordpress # stop and remove
docker container rm -vf ch6_wordpress # forced kill and also clean volumes

# resource
docker system df # show used space, similar to the unix tool df
docker system prune # remove all dangling ((not associated with a container)) resources.
docker system prune -a # remove any stopped containers and all unused images

# service
docker service ls
docker service remove $(docker service ls -q)
```

# Execute all tests in repo

`/bin/bash run-repo-test.sh`

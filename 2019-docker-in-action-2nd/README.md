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

#  Download source code
## Option 1 (version 2019)

```bash
git clone https://github.com/dockerinaction/ch10_patterns-for-building-images.git
git clone https://github.com/dockerinaction/ch3_myotherapp.git
git clone https://github.com/dockerinaction/ch3_myapp.git
git clone https://github.com/dockerinaction/ch6_ipc.git
git clone https://github.com/dockerinaction/ch12_greetings.git
git clone https://github.com/dockerinaction/ch13_multi_tier_app.git
git clone https://github.com/dockerinaction/ch11_coffee_api.git
git clone https://github.com/dockerinaction/ch8_multi_stage_build.git
git clone https://github.com/dockerinaction/materials.git
git clone https://github.com/dockerinaction/ch11_notifications.git
git clone https://github.com/dockerinaction/ch6_stresser.git
git clone https://github.com/dockerinaction/ch6_htop.git
git clone https://github.com/dockerinaction/ch12_coffee_api.git
git clone https://github.com/dockerinaction/ch12_coffee_proxy.git
git clone https://github.com/dockerinaction/ch12_coffee.git
git clone https://github.com/dockerinaction/ch12_painted.git
git clone https://github.com/dockerinaction/ch12_coffee_tests.git
git clone https://github.com/dockerinaction/ch11_wp_environment.git
git clone https://github.com/dockerinaction/ch10_calaca.git
git clone https://github.com/dockerinaction/ch10_webhook_es_pump.git
git clone https://github.com/dockerinaction/ch10_htpasswd.git
git clone https://github.com/dockerinaction/ch10_curl.git
git clone https://github.com/dockerinaction/ch10_webhook_listener.git
git clone https://github.com/dockerinaction/ch9_registry_bound.git
git clone https://github.com/dockerinaction/ch9_ftp_client.git
git clone https://github.com/dockerinaction/ch9_ftpd.git
git clone https://github.com/dockerinaction/ch4_polyapp.git
git clone https://github.com/dockerinaction/ch4_ia.git
git clone https://github.com/dockerinaction/ch4_packed_config.git
git clone https://github.com/dockerinaction/ch4_tools.git
git clone https://github.com/dockerinaction/ch4_packed.git
git clone https://github.com/dockerinaction/ch4_writers.git
git clone https://github.com/dockerinaction/ch3_ex2_huntanswer.git
git clone https://github.com/dockerinaction/ch3_ex2_hunt.git
git clone https://github.com/dockerinaction/ch2_mailer.git
git clone https://github.com/dockerinaction/ch2_agent.git
git clone https://github.com/dockerinaction/ch3_dockerfile.git
git clone https://github.com/dockerinaction/ch3_hello_registry.git
git clone https://github.com/dockerinaction/ch5_expose.git
git clone https://github.com/dockerinaction/ch5_nmap.git
git clone https://github.com/dockerinaction/ch5_ff.git
git clone https://github.com/dockerinaction/busybox.git
git clone https://github.com/dockerinaction/hello_world.git
```

## Option 2 (version 2016)

- https://www.manning.com/books/docker-in-action

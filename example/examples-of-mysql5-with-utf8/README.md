# Environment

- Nacos docker - https://nacos.io/zh-cn/docs/quick-start-docker.html
  - download form nacos docker github and use the standalone version
- Nacos - http://localhost:8848/ - in docker-compose.yml
- Grafana - http://localhost:3000/ - admin/admin - in docker-compose.yml
- Prometheus - http://localhost:9090/ - in docker-compose.yml

# Java development environment

`sdk list java && sdk current java`

# Setup Maven wrapper

- https://github.com/takari/maven-wrapper

`mvn -N io.takari:maven:0.7.7:wrapper -Dmaven=3.5.4`

# Script step by step

```shell script
./mvnw clean spring-boot:run
```

# One stop script
```shell script
/bin/bash run.sh
/bin/bash run-test.sh
/bin/bash run-stop.sh
```

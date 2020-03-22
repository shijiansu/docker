#!/bin/bash

### 每一次deploy Snapshot版本到Nexus, Nexus生成一个拥有时间戳文件名的jar, e.g。 0.0.1-20180826.051842-1
mvn -f nexus-test/pom.xml -s settings.xml clean deploy \
  -Dnexus.admin.username=admin \
  -Dnexus.admin.password=admin123

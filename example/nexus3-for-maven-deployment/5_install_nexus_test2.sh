#!/bin/bash

# 依赖于nexus-test, 
mvn -f nexus-test2/pom.xml -s settings.xml clean install

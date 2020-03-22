#!/bin/bash

sudo docker pull sonatype/nexus3
mkdir -p $(pwd)/data/docker/nexus3/nexus-data && sudo chown -R :nexus $(pwd)/data
docker run -d -p 8081:8081 --name nexus -v $(pwd)/data/docker/nexus3/nexus-data:/nexus-data sonatype/nexus3
docker logs -f nexus

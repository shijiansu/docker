#!/bin/bash
/bin/bash run-stop.sh
# need to update the syntax from docker-compose to docker stack
# docker-compose -f docker-compose.yml up --remove-orphans &
docker-compose up --remove-orphans &

#!/bin/bash

container_name="$1"

# clean up postgres container
docker container stop "${container_name}"
docker container rm "${container_name}"

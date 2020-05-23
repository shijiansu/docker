#!/bin/bash

docker run --rm prakhar1989/static-site

docker run -d -P --name static-site prakhar1989/static-site # -d will detach our terminal
docker port static-site # see the ports

# http://localhost:32769

docker run -p 8888:80 prakhar1989/static-site # custom port
docker stop static-site

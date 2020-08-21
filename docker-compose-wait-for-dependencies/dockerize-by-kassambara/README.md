
- https://www.datanovia.com/en/courses/docker-compose-wait-for-dependencies/

``` bash
# Download a template
git clone https://github.com/kassambara/docker-compose-wait-for-container.git

# Build the demo application
cd docker-compose-wait-for-container/ex02-using-dockerize-tool
docker-compose build
# Running your app
docker-compose run my_super_app

# Stopping containers and cleaning
docker-compose down
rm -rf mysql
```

#!/bin/bash
# 20200524
# define variables
application_name="ntu-claims-approval-system"
container_name="${application_name}-mysql"
database_name="ntu_claims_approval_system"
database_password="root"

# clean up mysql container
docker container stop "${container_name}"
docker container rm "${container_name}"

# start mysql container
docker container run --restart always -p 3306:3306 -d \
  --name "${container_name}" \
  -e MYSQL_DATABASE="${database_name}" \
  -e MYSQL_ROOT_PASSWORD="${database_password}" \
  mysql:8.0.20

sleep 30s

# access to mysql
## docker container exec -it ntu-claims-approval-system-mysql /bin/bash
## mysql -u root -p # or
## mysql --user="root" --password="root" --database="ntu_claims_approval_system"

# initiate database and data
docker cp ./database/init.sql "${container_name}":/tmp/init.sql
docker container exec -it "${container_name}" \
  mysql --user="root" --password="${database_password}" --database="${database_name}" \
  -e "source /tmp/init.sql" # source: load data file; -e: execute command in mysql

# verify setup
docker container exec -it "${container_name}" \
  mysql --user="root" --password="${database_password}" --database="${database_name}" \
  -e "show databases; use ${database_name}; show tables;"

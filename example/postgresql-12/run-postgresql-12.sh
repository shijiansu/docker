#!/bin/bash
# 20200615
# define variables
application_name="macos"
container_name="${application_name}-postgres"
database_username="postgres"
database_password="abcd1234"

/bin/bash run-postgresql-stop.sh "${container_name}"

# start postgres container
docker container run --restart always -p 5432:5432 -d \
  --name "${container_name}" \
  -e POSTGRES_USER="${database_username}" \
  -e POSTGRES_PASSWORD="${database_password}" \
  postgres:12.3

# if want to persist database data even kill the container
## put below parameters into above command
# -e PGDATA=/var/lib/postgresql/data/pgdata \
# -v ./data:/var/lib/postgresql/data/pgdata
# -v /custom/mount:/var/lib/postgresql/data \

# how to access to postgres
docker container exec -it "${container_name}" /bin/bash
psql -U postgres -h localhost -p 5432
CREATE SCHEMA liquibase_first_try_cli; # Create Schema
# DROP SCHEMA liquibase_first_try_cli CASCADE;

# examples of admin SQL
## show all databases
SELECT datname FROM	pg_database;
## show all tables
SELECT * FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema';

#!/bin/bash

# reference: https://sort.veritas.com/public/documents/HSC/2.0/linux/productguides/html/hfc_install/ch03s08s02.htm

# Create a profile using your access key and secret key
# AWS_ACCESS_KEY_ID=
# AWS_SECRET_ACCESS_KEY=
ecs-cli configure profile --profile-name ecs-foodtrucks --access-key $AWS_ACCESS_KEY_ID --secret-key $AWS_SECRET_ACCESS_KEY
## information store at: $HOME/.ecs/credentials
## use further with parameter: --ecs-profile

# Create a cluster configuration.
# ecs-cli configure --region us-east-1 --cluster foodtrucks # not prefect, because it set as default (globally use)
ecs-cli configure --region us-east-1 --cluster foodtrucks --config-name config-foodtrucks
## information store at: $HOME/.ecs/config
## use further with parameter: --cluster-config

# Create key pair to login ec2 instance (only for ecs - ec2)
EC2 Console -> create a new keypair as named "ecs_lab" in "us-east-1" region (pem format)

# Create the cluster - cli create CloudFormation Stacks -> create ECS cluster
## Need AWS Cloudformation permission
## Need AWS IAM CreateRole permission
## --capability-iam: create IAM resources
# ecs-cli up --keypair ecs_lab --capability-iam --size 1 --instance-type t2.medium # not prefect, because it take from default
ecs-cli up --capability-iam --size 1 --instance-type t2.medium --verbose \
  --keypair ecs_lab \
  --ecs-profile ecs-foodtrucks \
  --cluster-config config-foodtrucks
# INFO[0002] Using recommended Amazon Linux 2 AMI with ECS Agent 1.39.0 and Docker version 19.03.6-ce
# INFO[0004] Created cluster                               cluster=foodtrucks region=us-east-1
# DEBU[0009] Cloudformation create stack call succeeded    stackId=0xc00032e148
# VPC created: vpc-03c64406db7307fd6
# Security Group created: sg-0fa8172a2a6b5de85
# Subnet created: subnet-0d2079b366e79b22a
# Subnet created: subnet-00f5fa727dc0599a4
# Cluster creation succeeded.

VPC created: vpc-05226f80bb4f3716a
Security Group created: sg-0889482ac5eb95482
Subnet created: subnet-05f2be4658b3fcab7
Subnet created: subnet-0d628c1d0901a718b
Cluster creation succeeded.

open image/aws-ecs-cloudformation.png
# the cluster is with vpc and all env, for ecs ""

# Manually create CloudWatch log group
CloudWatch -> Log groups -> Actions -> Create log group -> foodtrucks

# Go to compose files folder
cd docker/food-trucks/ecs-ec2

# Create Task definition
ecs-cli compose --project-name food-trucks \
  --file ecs-docker-compose.yml \
  --ecs-params ecs-params.yml \
  up \
  --ecs-profile ecs-foodtrucks \
  --cluster-config config-foodtrucks
# INFO[0001] Using ECS task definition                     TaskDefinition="food-trucks:2"
# INFO[0002] Starting container...                         container=0a552d9e-388c-4990-b50a-6ed31ab69ef8/es
# INFO[0002] Starting container...                         container=0a552d9e-388c-4990-b50a-6ed31ab69ef8/web
# INFO[0003] Describe ECS container status                 container=0a552d9e-388c-4990-b50a-6ed31ab69ef8/es desiredStatus=RUNNING lastStatus=PENDING taskDefinition="food-trucks:2"
# INFO[0003] Describe ECS container status                 container=0a552d9e-388c-4990-b50a-6ed31ab69ef8/web desiredStatus=RUNNING lastStatus=PENDING taskDefinition="food-trucks:2"
# INFO[0022] Describe ECS container status                 container=0a552d9e-388c-4990-b50a-6ed31ab69ef8/es desiredStatus=RUNNING lastStatus=PENDING taskDefinition="food-trucks:2"
# INFO[0022] Describe ECS container status                 container=0a552d9e-388c-4990-b50a-6ed31ab69ef8/web desiredStatus=RUNNING lastStatus=PENDING taskDefinition="food-trucks:2"
# INFO[0037] Started container...                          container=0a552d9e-388c-4990-b50a-6ed31ab69ef8/es desiredStatus=RUNNING lastStatus=RUNNING taskDefinition="food-trucks:2"
# INFO[0037] Started container...                          container=0a552d9e-388c-4990-b50a-6ed31ab69ef8/web desiredStatus=RUNNING lastStatus=RUNNING taskDefinition="food-trucks:2"

## Execute again it will update the Task Definition version
## When re-execute, it will stop the previous container
# INFO[0002] Using ECS task definition                     TaskDefinition="food-trucks:5"
# INFO[0002] Found existing ECS tasks for project          CountOfTasks=1 ProjectName=food-trucks
# INFO[0002] Updating to new task definition               taskDefinition="arn:aws:ecs:us-east-1:042045718634:task-definition/food-trucks:5"
# INFO[0004] Describe ECS container status                 container=920aab1b-433c-4d2d-bb93-735f38f84b3f/web desiredStatus=STOPPED lastStatus=RUNNING taskDefinition="food-trucks:4"
# INFO[0004] Describe ECS container status                 container=920aab1b-433c-4d2d-bb93-735f38f84b3f/es desiredStatus=STOPPED lastStatus=RUNNING taskDefinition="food-trucks:4"
# INFO[0004] Describe ECS container status                 container=3f53bb18-4489-486a-a534-cf7961467963/web desiredStatus=RUNNING lastStatus=PENDING taskDefinition="food-trucks:5"
# INFO[0004] Describe ECS container status                 container=3f53bb18-4489-486a-a534-cf7961467963/es desiredStatus=RUNNING lastStatus=PENDING taskDefinition="food-trucks:5"
# INFO[0018] Describe ECS container status                 container=920aab1b-433c-4d2d-bb93-735f38f84b3f/web desiredStatus=STOPPED lastStatus=RUNNING taskDefinition="food-trucks:4"
# INFO[0018] Describe ECS container status                 container=920aab1b-433c-4d2d-bb93-735f38f84b3f/es desiredStatus=STOPPED lastStatus=RUNNING taskDefinition="food-trucks:4"
# INFO[0018] Describe ECS container status                 container=3f53bb18-4489-486a-a534-cf7961467963/web desiredStatus=RUNNING lastStatus=PENDING taskDefinition="food-trucks:5"
# INFO[0018] Describe ECS container status                 container=3f53bb18-4489-486a-a534-cf7961467963/es desiredStatus=RUNNING lastStatus=PENDING taskDefinition="food-trucks:5"
# INFO[0032] Describe ECS container status                 container=920aab1b-433c-4d2d-bb93-735f38f84b3f/web desiredStatus=STOPPED lastStatus=RUNNING taskDefinition="food-trucks:4"
# INFO[0032] Describe ECS container status                 container=920aab1b-433c-4d2d-bb93-735f38f84b3f/es desiredStatus=STOPPED lastStatus=RUNNING taskDefinition="food-trucks:4"
# INFO[0032] Describe ECS container status                 container=3f53bb18-4489-486a-a534-cf7961467963/web desiredStatus=RUNNING lastStatus=PENDING taskDefinition="food-trucks:5"
# INFO[0032] Describe ECS container status                 container=3f53bb18-4489-486a-a534-cf7961467963/es desiredStatus=RUNNING lastStatus=PENDING taskDefinition="food-trucks:5"
# INFO[0039] Stopped container...                          container=920aab1b-433c-4d2d-bb93-735f38f84b3f/web desiredStatus=STOPPED lastStatus=STOPPED taskDefinition="food-trucks:4"
# INFO[0039] Stopped container...                          container=920aab1b-433c-4d2d-bb93-735f38f84b3f/es desiredStatus=STOPPED lastStatus=STOPPED taskDefinition="food-trucks:4"
# INFO[0039] Started container...                          container=3f53bb18-4489-486a-a534-cf7961467963/web desiredStatus=RUNNING lastStatus=RUNNING taskDefinition="food-trucks:5"
# INFO[0039] Started container...                          container=3f53bb18-4489-486a-a534-cf7961467963/es desiredStatus=RUNNING lastStatus=RUNNING taskDefinition="food-trucks:5"

open image/aws-ecs-task.png
open image/aws-ecs-task-ec2-instance.png

# Test from HTTP
ecs-cli ps # most default one
ecs-cli ps --ecs-profile ecs-foodtrucks --cluster-config config-foodtrucks # possible with profile and config
ecs-cli ps --desired-status RUNNING # only checking RUNNING
# Name                                      State    Ports                      TaskDefinition  Health
# 0a552d9e-388c-4990-b50a-6ed31ab69ef8/es   RUNNING                             food-trucks:2   UNKNOWN
# 0a552d9e-388c-4990-b50a-6ed31ab69ef8/web  RUNNING  54.221.73.14:80->5000/tcp  food-trucks:2   UNKNOWN
# curl http://<<url with the port>>
curl 54.221.73.14:80

# Shutdown Task
ecs-cli compose --project-name food-trucks \
  --file ecs-docker-compose.yml \
  --ecs-params ecs-params.yml \
  down \
  --ecs-profile ecs-foodtrucks \
  --cluster-config config-foodtrucks

# Create Service to manage Task (Service is with more features e.g. load balancer and auto scaling)
ecs-cli compose --project-name food-trucks \
  --file ecs-docker-compose.yml \
  --ecs-params ecs-params.yml \
  service up \
  --ecs-profile ecs-foodtrucks \
  --cluster-config config-foodtrucks

# Remove Service
ecs-cli compose --project-name food-trucks \
  --file ecs-docker-compose.yml \
  --ecs-params ecs-params.yml \
  service rm \
  --ecs-profile ecs-foodtrucks \
  --cluster-config config-foodtrucks

# Delete the cluster - via delete the Cloudformation stack
## Need AWS ec2:DeleteRouteTable permission <- "AmazonVPCFullAccess"
ecs-cli down --force \
  --ecs-profile ecs-foodtrucks \
  --cluster-config config-foodtrucks
# INFO[0003] Waiting for your cluster resources to be deleted...
# INFO[0004] Cloudformation stack status                   stackStatus=DELETE_IN_PROGRESS
# INFO[0069] Deleted cluster                               cluster=foodtrucks

# Manually remove aws resources and local setup
ECS -> Clusters -> Task Definitions -> Click the tash definitions -> Select task definitions -> Actions -> Deregister
EC2 -> Key pairs -> Select key -> Actions -> Delete
IAM -> Users -> Select user -> Delete user
IAM -> Policies -> Customized_ECS_FullActions -> Policy actions -> Delete (only applicable when you have the customized policy)
CloudWatch -> Log groups -> Select log group -> Actions -> Delete log group

Local -> Remove setup of $HOME/.aws/config and $HOME/.aws/credentials
Local -> Remove setup of $HOME/.ecs

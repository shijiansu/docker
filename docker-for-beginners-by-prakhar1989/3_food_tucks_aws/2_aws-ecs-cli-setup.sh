#!/bin/bash

# install aws ecs-cli
## https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ECS_CLI_installation.html
## macos
## Step 1: Download the Amazon ECS CLI
sudo curl -o /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-darwin-amd64-latest
## Step 2: Verify the Amazon ECS CLI
### Verify Using the MD5 Sum
curl -s https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-darwin-amd64-latest.md5 && md5 -q /usr/local/bin/ecs-cli
### Verify Using the PGP Signature
brew install gnupg
gpg --keyserver hkp://keys.gnupg.net --recv BCE9D9A42D51784F
# gpg: key BCE9D9A42D51784F: public key "Amazon ECS <ecs-security@amazon.com>" imported
# gpg: Total number processed: 1
# gpg:               imported: 1                                                                                                                                   /2.4s
curl -o ecs-cli.asc https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-darwin-amd64-latest.asc # Download the Amazon ECS CLI signatures
gpg --verify ecs-cli.asc /usr/local/bin/ecs-cli # Verify the signature
### Step 3: Apply Execute Permissions to the Binary
sudo chmod +x /usr/local/bin/ecs-cli
### Step 4: Complete the Installation
ecs-cli --version

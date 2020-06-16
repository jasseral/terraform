#!/bin/bash
echo "Running scripts"
sudo apt-get update
sudo apt-get install -y docker.io
sudo curl -L https://github.com/docker/compose/releases/download/1.23.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker-compose -f /tmp/docker-compose.yml up -d

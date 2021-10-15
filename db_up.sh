#!/bin/bash
unset GREP_OPTIONS
sudo docker-compose -f db_stack.yml up -d
docker_id=$(sudo docker ps -a | egrep " mongo " | cut -d ' ' -f1 -)
export DOCKER_IMG_IP=$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $docker_id)
echo "DB ip address: $DOCKER_IMG_IP"
#(mongo "mongodb://testUser:testPass@$DOCKER_IMG_IP:27017/?authSource=admin")

#!/bin/bash
unset GREP_OPTIONS

#set the database address to the NAT address of the local machine
export MYSQL_DB_ADDRESS=$(hostname -I | awk '{print $1}') 

#write the database address to the .env file
sed -i "s/MYSQL_DB_ADDRESS=.*/MYSQL_DB_ADDRESS=$MYSQL_DB_ADDRESS/" .env

#bring up docker containers
cd ~/TS/docker-compose/
docker-compose up -d

#print out docker ps -a
watch -n 1 "sudo docker ps -a"
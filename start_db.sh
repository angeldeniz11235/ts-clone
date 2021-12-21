#!/bin/bash
unset GREP_OPTIONS

#set the database address to the NAT address of the local machine
export MYSQL_DB_ADDRESS=$(hostname -I | awk '{print $1}') 

#write the database address to the .env file
sed -i "s/MYSQL_DB_ADDRESS=.*/MYSQL_DB_ADDRESS=$MYSQL_DB_ADDRESS/" .env

cd /home/j3rk/Desktop/programming.local/TeamSnap_Clone/docker-compose/

#check if arg no-api is set, else start db_stack.yml
if [ "$1" = "no-api" ]; then
    echo "Starting DB stack without API"
    #start the db stack without the api
    sudo docker-compose -f db_stack.yml start mysql_db_container adminer_container 
    #wait for the db to be ready
    sleep 10
    #open new kitty terminal in working directory ../NodeJS/mysqldb-NodeJS-API in the new terminal and start the API
    echo "Starting API in new terminal..."
    kitty --detach -d=/home/j3rk/Desktop/programming.local/TeamSnap_Clone/NodeJS/mysqldb-NodeJS-API npm run prod &
    echo "Done."

else
    echo "Starting DB stack with API"
    #start the docker contariners
    sudo docker-compose -f db_stack.yml start 
    echo "DB ip address: $MYSQL_DB_ADDRESS"
fi



#pause the script to allow the containers to start
sleep 5

#run watch  command to print out docker ps -a
watch -n 1 "sudo docker ps -a"



#docker_id=$(sudo docker ps -a | egrep ".*mysql_db_container.*" | cut -d ' ' -f1 -)
#export DOCKER_IMG_IP=$(sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $docker_id)




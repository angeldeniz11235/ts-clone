#!/bin/bash
#check if argument 'no-api' was passed in. if it was, comment out the nodejs-api section in db_stack.yml 
if [ "$1" == "no-api" ]; then
    sed -i "s/^  - nodejs-api$/#  - nodejs-api/" db_stack.yml
fi

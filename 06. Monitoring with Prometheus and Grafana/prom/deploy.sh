#!/bin/bash
 
if [ "$(systemctl is-active docker)" != "active" ]; then 
    counter=0
    sudo systemctl restart docker
    echo "### Checking docker deamon status..."
    while true ; do
        sleep 5
        if [ "$(systemctl is-active docker)" = "active" ]; then 
            echo "Docker deamon is up! Checking status..."
            systemctl status docker
            break
        else
            counter=$((counter+1))
            if [ $((counter%2)) -eq 0 ]; then
            echo "Restart docker ($counter)....."
            sudo systemctl restart docker
            fi
        fi
    done
fi

DIR="${PWD}/prom"
if [ -d "$DIR" ]; then
    FILE_NAME="docker-compose"
    COMPOSE_FILE="$DIR/$FILE_NAME.yaml"
    if [ -f "$COMPOSE_FILE" ]; then 
        echo "File'$COMPOSE_FILE' detected..."
    else
        echo "File'$COMPOSE_FILE' not found! Search for *.yml..."
        COMPOSE_FILE="$DIR/$FILE_NAME.yml"
    fi
    
    if [ -f "$COMPOSE_FILE" ]; then
        echo "### Deploying prometheus stack...."
        docker-compose -f $COMPOSE_FILE down || true
        docker-compose build --no-cache 
        docker-compose -f $COMPOSE_FILE up -d
    else
        echo "File'$COMPOSE_FILE' not found!"
    fi
else
    echo "Shared directory '$DIR' not found"
fi

echo "### Listing active docker containers:"
docker container ls

#!/bin/bash

echo "### Deploying first goprom worker on port 8081:8080...."
docker container run -d --name worker1 -p 8081:8080 shekeriev/goprom

echo "### Deploying second goprom worker on port 8082:8080...."
docker container run -d --name worker2 -p 8082:8080 shekeriev/goprom 

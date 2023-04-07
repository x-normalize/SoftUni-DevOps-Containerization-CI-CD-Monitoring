#!/bin/bash

docker build -t prometheus .
docker run -p 9090:9090 --name prom -d prometheus

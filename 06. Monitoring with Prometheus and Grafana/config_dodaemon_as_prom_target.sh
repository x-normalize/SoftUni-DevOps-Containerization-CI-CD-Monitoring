#!/bin/bash

# https://docs.docker.com/config/daemon/prometheus/

# To configure the Docker daemon as a Prometheus target, you need to specify the metrics-address. 
# The best way to do this is via the daemon.json, which is located at one of the following locations by default. If the file does not exist, create it
# Linux: /etc/docker/daemon.json
# Windows Server: C:\ProgramData\docker\config\daemon.json
# Docker Desktop for Mac / Docker Desktop for Windows: Click the Docker icon in the toolbar, select Preferences, then select Daemon. Click Advanced.
# If the file is not empty, add those two keys, making sure that the resulting file is valid JSON. Be careful that every line ends with a comma (,) except for the last line.
# Restart Docker. The Docker now will exposes Prometheus-compatible metrics on port 9323.

FILE="/etc/docker/daemon.json"
[ -f "$FILE" ] || sudo touch $FILE

METRICS_ADDR="127.0.0.1:9323"
EXPERIMENTAL=true
if [ -s "$FILE" ]; then 
    echo "The file '$FILE' is NOT EMPTY and should be edited... for more information please visit 'https://docs.docker.com/config/daemon/prometheus/'."
else
    sudo touch $FILE
    JSON_STRING=$( jq -n \
                  --arg bmetrics-addr "$METRICS_ADDR" \
                  --arg experimental "$EXPERIMENTAL" \
                  '$ARGS.named' )
                  
    echo $JSON_STRING | jq | sudo tee $FILE
fi

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
        
        if [ $((counter%2)) -eq 0 ]; then
        sudo systemctl restart docker
        fi
    fi
done

#!/bin/bash

echo "* Doker-Compose - Starting Gitea"
sudo docker-compose -f /vagrant/src/docker-compose-gitea.yml up -d
#!/bin/bash

echo "* Update System"
sudo apt-get -y update

echo "* Install Docker"
sudo apt-get -y install ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/debian/gpg \
	  | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
	    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get -y update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io

echo "* Add Docker Permissions"
sudo usermod -aG docker vagrant

echo "* Add Jenkins - Docker group"
echo 'jenkins ALL=(ALL)    NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo
sudo usermod -aG docker jenkins

echo "* Adding Docker-Compose"
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

echo "* Doker-Compose - Starting Gitea"
sudo docker-compose -f /vagrant/src/docker-compose-gitea.yml up -d

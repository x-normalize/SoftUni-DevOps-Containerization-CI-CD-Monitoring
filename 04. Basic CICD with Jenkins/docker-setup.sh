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

echo "* Add Docker-Vagrant-Jenkins Permissions"
sudo usermod -aG docker vagrant
sudo usermod -aG docker jenkins

echo "* Restart Jenkins"
sudo systemctl restart jenkins
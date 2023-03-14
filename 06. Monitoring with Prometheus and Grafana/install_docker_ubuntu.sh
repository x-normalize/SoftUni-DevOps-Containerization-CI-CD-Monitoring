#!/bin/bash

sudo apt-get remove docker docker-engine docker.io containerd runc || true

echo "### Update repositories and install common packages"
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release

echo "### Add the GPG key for the official Docker repository to your system"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "### Add Docker repository"
# ID=${awk -F= '$1=="ID" { print $2 ;}' /etc/os-release}
ID=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')
VERSION=$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"')
ARCH=$(dpkg --print-architecture)

echo "deb [arch=$ARCH signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/$ID $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Make sure you are about to install from the Docker repo instead of the default Ubuntu repo"
apt-cache policy docker-ce

echo "* Install Docker"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

echo "* Adjust group membership"
sudo usermod -aG docker vagrant

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
        sudo systemctl restart docker
        fi
    fi
done

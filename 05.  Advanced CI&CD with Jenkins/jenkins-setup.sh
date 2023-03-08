#!/bin/bash

echo "* Update System"
sudo apt-get -y update

echo "* Install Java"
sudo apt-get -y install fontconfig openjdk-11-jre

echo "* Get Jenkins Repo Keys"
sudo curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "* Add Jenkins Repository"
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "* Install Jenkins"
sudo apt-get -y update
sudo apt-get -y install jenkins

echo "* Add Passwd to Jenkins"
echo -e "Password1\nPassword1" | sudo passwd jenkins



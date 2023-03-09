#!/bin/bash

echo "* Install Software ..."
sudo apt-get -y install git fontconfig openjdk-11-jre

echo "Setup Jenkins User"
sudo useradd -m -p $(echo Password1 | openssl passwd -1 -stdin) -s /bin/bash jenkins


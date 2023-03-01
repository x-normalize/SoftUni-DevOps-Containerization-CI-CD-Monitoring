#!/bin/bash

echo "* Add hosts ..."
echo "192.168.99.100 jenkins.do1.lab jenkins" >> /etc/hosts

echo "* Install Software ..."
sudo apt-get -y install git
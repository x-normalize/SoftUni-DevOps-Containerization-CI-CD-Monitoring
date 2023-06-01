#!/bin/bash

#firewalld is pre-installed in centos 7 so....
INSTALLED_FIREWALLD=$(rpm -qa firewalld)
[ -z "$INSTALLED_FIREWALLD" ] && echo "### Installing firewalld..." && sudo yum install -y firewalld

FIREWALLD_LOAD_STATUS=$(echo $(systemctl status firewalld | grep "Loaded") | awk  '{print $2}')
[ "masked" = $FIREWALLD_LOAD_STATUS ] && sudo systemctl unmask --now firewalld

FIREWALLD_ACTIVE_STATUS=$(systemctl is-active firewalld)
if [ "inactive" = "$FIREWALLD_ACTIVE_STATUS" ]; then
    echo "Starting and enabling the firewalld...";
    sudo systemctl start firewalld
    sudo systemctl restart firewalld
    sudo systemctl enable firewalld
fi

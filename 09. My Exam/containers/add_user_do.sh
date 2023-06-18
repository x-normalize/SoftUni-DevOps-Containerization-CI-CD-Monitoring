#!/bin/bash

if [ $(id -u) -eq 0 ]; then
	USERNAME="jenkins"
	PASSWORD="Password1"
	egrep "^$USERNAME" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$USERNAME exists!"
		exit 1
	else
		useradd -m -p "$PASSWORD" "$USERNAME"
		[ $? -eq 0 ] && echo "User has been added!" || echo "Failed to add a user!"
	fi
else
	echo "Only root may add a user to the system."
	exit 2
fi 
sudo chpasswd <<<"$USERNAME:$PASSWORD"

echo "### Adding the $USERNAME user to the sudoers list..."
sudo sh -c "echo \"$USERNAME ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers"

sleep 5
echo "### Adding the $USERNAME user to the docker group..."
sudo usermod -aG docker jenkins
#sudo usermod -aG root jenkins

counter=0
sudo systemctl restart docker
echo "### Checking docker deamon status..."
while true ; do
    sleep 5
    if [ "$(systemctl is-active docker)" = "active" ]; then
        echo "Docker deamon is up! Checking status..."
        systemctl status docker
        echo "Docker group users::"
        grep /etc/group -e "docker"
        break
    else
        counter=$((counter+1))
        if [ $((counter%2)) -eq 0 ]; then
        sudo systemctl restart docker
        fi
    fi
done

#!/bin/bash

echo "### Downloading the repository information..."
sudo wget https://pkg.jenkins.io/redhat/jenkins.repo -O /etc/yum.repos.d/jenkins.repo

echo "### Importing the repository’s key..."
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

echo "### Updating/Refreshing repository info and list all available versions:::..."
sudo dnf update #&& dnf list --showduplicates jenkins

echo "### Installing latest Jenkins version..."
sudo dnf install -y jenkins

echo "### Disabling the Jenkins repository after the installation..."
sudo dnf config-manager --disablerepo jenkins

echo "### Installed Java 11 (recommended) ..."
sudo dnf install -y java-11-openjdk git
java -version

echo "### Starting the Jenkins service..."
sudo systemctl start jenkins

echo "### Checking Jenkins service status..."
systemctl status jenkins

echo "### Enabling the service to start automatically on boot..."
sudo systemctl enable jenkins

echo "### Checking created jenkins user..."
cat /etc/passwd | grep jenkins

echo "### Adding sudo user 'jenkins' to the Docker group, to be able to work with docker without the need to use always sudo..."
sudo usermod -aG jenkins

echo "### Change jenkin's shell from '/bin/false' to '/bin/bash'"
JENKINS_USER=$(cat /etc/passwd | grep jenkins)
[[ "$JENKINS_USER" == *bin/false ]] && sudo usermod -s /bin/bash jenkins

echo "### Adding the jenkins user to the sudoers list..."
sudo sh -c "echo \"jenkins ALL=(ALL) NOPASSWD: ALL\" >> /etc/sudoers"

echo "### Disabling Jenkins security to prevent unlocking..."
sudo sed -i 's/<useSecurity>true<\/useSecurity>/<useSecurity>false<\/useSecurity>/g' /var/lib/jenkins/config.xml
sudo ex +g/useSecurity/d +g/authorizationStrategy/d -scwq /var/lib/jenkins/config.xml

echo "### Restarting jenkins service..."
sudo systemctl restart jenkins

echo "### Checking jenkins status..."
while true ; do
    sleep 5
    if [ "$(systemctl is-active jenkins)" = "active" ]; then 
        echo "Jenkins service is up! Checking jenkins status..."
        systemctl status jenkins
        break
    fi
done

echo "### Chnage jenkins user password..."
sudo chpasswd <<<"jenkins:Password1"

#sudo su - jenkins
#create key ssh-keygen -t rsa -m PEM
#copy the key to the jenkins host ssh-copy-id jenkins@jenkins.m5.hw
#copy the key to all hosts u need ssh-copy-id jenkins@<HOST> (make sure this hosts have created jenkins user!!!)


HOSTNAME_IP=$(hostname -i | awk '{print $2}')
[ -z "$HOSTNAME_IP" ] && HOSTNAME_IP=$(hostname -i | awk '{print $1}')
echo "### Download Jenkins CLI .jar..."
wget http://$HOSTNAME_IP:8080/jnlpJars/jenkins-cli.jar || true

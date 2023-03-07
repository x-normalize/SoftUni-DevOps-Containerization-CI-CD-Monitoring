# Homework steps

vagrant up

1. Setup Jenkins - Docker communication

vagrant ssh jenkins
su - jenkins
ssh-keygen -t rsa -m PEM
ssh-copy-id jenkins@docker.do1.lab

2. Setup Jenkins Agent - Docker 

- setup jenkins install
- setup ssh credentials 
- sudo cat /var/lib/jenkins/.ssh/id_rsa
- create jenkins agent

3. Setting up gitea
4. Creating giteaccount
5. Creating repository at gitea
6. Commit project to repository
7. Enable webhooks

8. Creating Jenkins Gitea Credentials
9. Create Docker Hub Api Token
10. Add Docker Hub Credentials to Jenkins 
11. Create Job in jenkins
12. Build Job or Commit to repository

14. Install Jenkins CLI on docker -  wget http://192.168.99.100:8080/jnlpJars/jenkins-cli.jar
15. Get the job 
- java -jar jenkins-cli.jar -s http://192.168.99.100:8080/ -auth admin:password get-job Homework_Testing/Pipelines/Homework-Pipeline > /home/vagrant/homework-jenkins-pe-job.xml
16. Commit it to Gitea
17. Remove job from Jenkins UI
18. Import early created job and run it
- java -jar jenkins-cli.jar -s http://192.168.99.100:8080/ -auth admin:password create-job HomeworkPipeline < /home/vagrant/homework-jenkins-pipepipeline-job.xml
- java -jar jenkins-cli.jar -s http://192.168.99.100:8080/ -auth admin:password build HomeworkPipeline -f -v

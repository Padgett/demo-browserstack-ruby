# Demo-BrowserStack-Ruby

## Usage

### Build the image:

`docker build -t demo-bstack-jenkins .`

### Create a docker network for jenkins:

`docker network create jenkins`

### Start the container:
```
docker run -d --name demo-bstack-jenkins \
  --privileged \
  --network jenkins \
  --network-alias docker \
  -p 8080:8080 -p 50000:50000 \
  demo-bstack-jenkins
```

Copy initial password from:
`sudo docker exec demo-bstack-jenkins cat /var/jenkins_home/secrets/initialAdminPassword`

Navigate to `http://localhost:8080`. Unlock Jenkins using the password.

Install suggested plugins.

Finish configuration

### Add BrowserStack credentials to Jenkins
Manage > System > BrowserStack

### Create New Pipeline from Jenkinsfile
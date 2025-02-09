FROM jenkins/jenkins:lts-jdk17
EXPOSE 8080
EXPOSE 50000
USER root

# basics
RUN apt-get update
RUN apt-get install -y openssl curl git gpg build-essential zlib1g libc6
RUN gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

# # install RVM, Ruby, and Bundler
USER jenkins
RUN \curl -L https://get.rvm.io | bash
USER root
RUN /bin/bash -l -c "/var/jenkins_home/.rvm/bin/rvm requirements"
USER jenkins
RUN /bin/bash -l -c "rvm install 3.4.1"
RUN /bin/bash -l -c "gem install bundler --no-document"

# Jenkins plugin setup
RUN jenkins-plugin-cli --plugins workflow-aggregator docker-plugin browserstack-integration

#!/bin/bash

# debug model
set -x

# Install Jdk17
sudo apt update -y
sudo apt install fontconfig openjdk-17-jre -y
java -version

# install Docker
sudo apt-get update
sudo apt-get install docker.io -y
sudo usermod -aG docker ubuntu
newgrp docker

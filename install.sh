#!/bin/bash

# Update system
yum update -y

# Install Docker
yum install docker -y

# Start and enable Docker
systemctl start docker
systemctl enable docker

# Allow ec2-user to run docker without sudo
usermod -aG docker ec2-user

# Install utilitiesasdf
yum install git wget curl -y

# Terminal prompt color
echo "PS1='\e[1;32m\u@\h \w$ \e[m'" >> /home/ec2-user/.bash_profile

# Install Docker Compose standalone
latest_version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest \
  | grep '"tag_name":' \
  | cut -d '"' -f 4)

curl -L \
  "https://github.com/docker/compose/releases/download/${latest_version}/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose
#!/usr/bin/sh

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

sudo yum install docker -y
sudo systemctl start docker

mkdir /root/.aws/
echo "Paste AWS credentials and press 2 CTRL + D"
cat > /root/.aws/credentials

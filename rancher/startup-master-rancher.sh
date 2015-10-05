#!/bin/bash
apt-get update
apt-get upgrade
apt-get install -y curl
curl -sSL https://get.docker.com/ | sh
apt-get install -y docker
curl -L git.io/weave -o /usr/local/bin/weave
chmod a+x /usr/local/bin/weave
weave launch
eval $(weave env)
docker run -d --restart=always -p 8080:8080 rancher/server
wget -O /usr/local/bin/scope \  https://github.com/weaveworks/scope/releases/download/latest_release/scope
chmod a+x /usr/local/bin/scope
scope launch
wget https://github.com/rancher/convoy/releases/download/v0.3/convoy.tar.gz
tar xvf convoy.tar.gz
sudo cp convoy/convoy convoy/convoy-pdata_tools /usr/local/bin/
sudo mkdir -p /etc/docker/plugins/
sudo bash -c 'echo "unix:///var/run/convoy/convoy.sock" > /etc/docker/plugins/convoy.spec'

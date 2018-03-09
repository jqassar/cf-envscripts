#!/bin/bash
# EDIT THIS to match your organization.
proxyhost="proxy.domain:port"
export HTTP_PROXY=http://$proxyhost
export HTTPS_PROXY=https://$proxyhost
export NO_PROXY="localhost,127.0.0.1"

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get install docker-ce

mkdir ~/.docker
echo <<- EOF > ~/.docker/config.json
{
 "proxies":
 {
   "default":
   {
     "httpProxy": "$HTTP_PROXY",
     "noProxy": "$NO_PROXY"
   }
 }
}
EOF

# Edit /lib/systemd/system/docker.service
# TODO: Put in command to append '-H tcp://0.0.0.0:2376' to ExecStart (after '-H fd://')

# Put in proxy settings
SERVDIR=/etc/systemd/system/docker.service.d
sudo mkdir -p $SERVDIR
cat <<- EOF | sudo tee $SERVDIR/http-proxy.conf
[Service]
Environment="HTTP_PROXY=$HTTP_PROXY" "NO_PROXY=$NO_PROXY"
EOF

cat <<- EOF | sudo tee $SERVDIR/https-proxy.conf
[Service]
Environment="HTTPS_PROXY=$HTTPS_PROXY" "NO_PROXY=$NO_PROXY"
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker
sudo ps aux | grep dockerd

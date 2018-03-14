#!/bin/bash

BOSH="./bosh"
CERT_DIR="~/cf-envscripts"
WORKSPACE_DIR="~/bosh-deployment"
DIRECTOR_CIDR="192.168.50.0/24"
DIRECTOR_GW="192.168.50.1"
DIRECTOR_IP="192.168.50.6"
DIRECTOR_DOMAIN=""
#proxyhost="proxy.host:port"
#export HTTP_PROXY="http://$proxyhost"
#export HTTPS_PROXY="https://$proxyhost"
#export NO_PROXY="127.0.0.1,localhost,$DIRECTOR_IP"
#export http_proxy=$HTTP_PROXY
#export https_proxy=$HTTPS_PROXY
#export no_proxy=$NO_PROXY

BARG=""

BCMD="$BOSH create-env $WORKSPACE_DIR/bosh.yml"

BARG="$BARG -o $WORKSPACE_DIR/virtualbox/cpi.yml"
BARG="$BARG -o $WORKSPACE_DIR/virtualbox/outbound-network.yml"
BARG="$BARG -o $WORKSPACE_DIR/bosh-lite.yml"
BARG="$BARG -o $WORKSPACE_DIR/bosh-lite-runc.yml"
BARG="$BARG -o $WORKSPACE_DIR/jumpbox-user.yml"
BARG="$BARG --state=state.json"
BARG="$BARG --vars-store creds.yml"
BARG="$BARG -v director_name=bosh-lite"
BARG="$BARG -v internal_cidr=$DIRECTOR_CIDR"
BARG="$BARG -v internal_gw=$DIRECTOR_GW"
BARG="$BARG -v internal_ip=$DIRECTOR_IP"
BARG="$BARG -v outbound_network_name=NatNetwork"
# Add a proxy if needed:
#BARG="$BARG -o $WORKSPACE_DIR/misc/proxy.yml"
#BARG="$BARG -v http_proxy=$HTTP_PROXY"
#BARG="$BARG -v https_proxy=$HTTPS_PROXY"
#BARG="$BARG -v no_proxy=$NO_PROXY"

echo "Running $BCMD $BARG..."
$BCMD $BARG $*

#!/bin/bash

BOSH="./bosh"
CERT_DIR="/home/jerry/cf-envscripts"
WORKSPACE_DIR="/home/jerry/bosh-deployment"
HTTP_PROXY=""
HTTPS_PROXY=$HTTP_PROXY
NO_PROXY="127.0.0.1,localhost"

BARG=""

BCMD="$BOSH create-env $WORKSPACE_DIR/bosh.yml"

BARG="$BARG -o $WORKSPACE_DIR/virtualbox/cpi.yml"
BARG="$BARG -o $WORKSPACE_DIR/virtualbox/outbound-network.yml"
BARG="$BARG -o $WORKSPACE_DIR/bosh-lite.yml"
BARG="$BARG -o $WORKSPACE_DIR/bosh-lite-runc.yml"
BARG="$BARG -o $WORKSPACE_DIR/jumpbox-user.yml"
# Add a proxy if needed:
BARG="$BARG -o $WORKSPACE_DIR/misc/proxy.yml"
BARG="$BARG --state=state.json"
BARG="$BARG --vars-store creds.yml"
BARG="$BARG -v director_name='Bosh Lite Director'"
BARG="$BARG -v internal_cidr=192.168.50.0/24"
BARG="$BARG -v internal_gw=192.168.50.1"
BARG="$BARG -v internal_ip=192.168.50.6"
BARG="$BARG -v outbound_network_name=NatNetwork"
BARG="$BARG -v http_proxy=$HTTP_PROXY"
BARG="$BARG -v https_proxy=$HTTPS_PROXY"
BARG="$BARG -v no_proxy=$NO_PROXY"

echo "Running $BCMD $BARG..."
$BCMD $BARG

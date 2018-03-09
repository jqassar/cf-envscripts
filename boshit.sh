#!/bin/bash

CERT_DIR="/work"
WORKSPACE_DIR="/work/bosh-deployment"
BARG=""

BCMD="bosh create-env $WORKSPACE_DIR/bosh.yml"

BARG="$BARG -o $WORKSPACE_DIR/docker/cpi.yml"
BARG="$BARG -o $WORKSPACE_DIR/jumpbox-user.yml"
BARG="$BARG --state=state.json"
BARG="$BARG --vars-store creds.yml"
BARG="$BARG -v director_name=docker"
BARG="$BARG -v internal_cidr=10.245.0.0/16"
BARG="$BARG -v internal_gw=10.245.0.1"
BARG="$BARG -v internal_ip=10.245.0.10"
BARG="$BARG -v docker_host=tcp://192.168.99.101:2376"
BARG="$BARG --var-file docker_tls.ca=$CERT_DIR/ca.pem"
BARG="$BARG --var-file docker_tls.certificate=$CERT_DIR/cert.pem"
BARG="$BARG --var-file docker_tls.private_key=$CERT_DIR/key.pem"
BARG="$BARG -v network=net3"

echo "Running $BCMD $BARG..."
$BCMD $BARG


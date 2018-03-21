#!/bin/bash
# Does *not* assume that setenv.sh has already been run!
# It runs the internal route command expected by other scripts, and determines the latest CF release stemcell
# (for bosh-lite).
# Original provided by @fhanik @ Pivotal.

WORKSPACE_HOME=..

set +e
sudo ip route add   10.244.0.0/16 via 192.168.50.6
source ./setenv.sh
set -e

bosh -n -e vbox update-cloud-config $WORKSPACE_HOME/bosh-deployment/warden/cloud-config.yml -v internal_dns=$INTERNAL_DNS

# For Zookeeper example:
#bosh -n -e vbox upload-stemcell https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent?v=3468.21 --fix

# Get the current bosh-lite stemcell version:
export IAAS_INFO=warden-boshlite
export STEMCELL_VERSION=$(bosh interpolate ../cf-deployment/cf-deployment.yml --path=/stemcells/alias=default/version)

bosh -n -e vbox upload-stemcell https://bosh.io/d/stemcells/bosh-${IAAS_INFO}-ubuntu-trusty-go_agent?v=${STEMCELL_VERSION}
bosh -n -e vbox update-cloud-config $WORKSPACE_HOME/cf-deployment/iaas-support/bosh-lite/cloud-config.yml

#!/bin/sh
CFARG=""

WORKSPACE_DIR="~/cf-deployment"
SYSTEM_DOMAIN="bosh-lite.com"

CFCMD="bosh -e vbox -d cf deploy $WORKSPACE_DIR/cf-deployment.yml"

CFARG="$CFARG -o $WORKSPACE_DIR/operations/bosh-lite.yml"
CFARG="$CFARG --vars-store creds.yml"
CFARG="$CFARG -v system_domain=$SYSTEM_DOMAIN"
CFARG="$CFARG -o $WORKSPACE_DIR/operations/scale-to-one-az.yml"
CFARG="$CFARG -o $WORKSPACE_DIR/operations/use-compiled-releases.yml"
CFARG="$CFARG -o $WORKSPACE_DIR/operations/experimental/use-bosh-dns.yml"
#CFARG="$CFARG -o $WORKSPACE_DIR/operations/experimental/skip-consul-cell-registrations.yml"
#CFARG="$CFARG -o $WORKSPACE_DIR/operations/experimental/skip-consul-locks.yml"
#CFARG="$CFARG -o $WORKSPACE_DIR/operations/experimental/disable-consul.yml"
# Only for bosh-lite deployments.
#CFARG="$CFARG -o $WORKSPACE_DIR/operations/experimental/disable-consul-bosh-lite.yml"
# GrootFS is now on by default.
#CFARG="$CFARG -o $WORKSPACE_DIR/operations/experimental/use-grootfs.yml"

echo "Running $CFCMD $CFARG..."
$CFCMD $CFARG

#!/bin/sh
CFARG=""
SYSTEM_DOMAIN="10.245.0.34.sslip.io"

CFCMD="bosh -e acme -d cf deploy cf-deployment/cf-deployment.yml"

CFARG="$CFARG --vars-store creds.yml"
CFARG="$CFARG -v system_domain=$SYSTEM_DOMAIN"
CFARG="$CFARG -o cf-deployment/operations/use-compiled-releases.yml"
CFARG="$CFARG -o cf-deployment/operations/experimental/use-bosh-dns.yml"
CFARG="$CFARG -o cf-deployment/operations/experimental/skip-consul-cell-registrations.yml"
CFARG="$CFARG -o cf-deployment/operations/experimental/skip-consul-locks.yml"
CFARG="$CFARG -o cf-deployment/operations/experimental/disable-consul.yml"
CFARG="$CFARG -o cf-deployment/operations/bosh-lite.yml"
CFARG="$CFARG -o cf-deployment/operations/experimental/disable-consul-bosh-lite.yml"
CFARG="$CFARG -o cf-deployment/operations/experimental/use-grootfs.yml"

echo "Running $CFCMD $CFARG..."
$CFCMD $CFARG

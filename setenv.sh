#!/bin/sh
# A script for preparing to do bosh/CF deployment commands.
# Original was provided courtesy of fhanik @Pivotal.
# Usage: source setenv.sh

# Uncomment for debug purposes:
#set -x

BOSH=bosh

export CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$BOSH int $CUR_DIR/creds.yml --path /director_ssl/ca > $CUR_DIR/rootCA.pem
$BOSH int $CUR_DIR/creds.yml --path /jumpbox_ssh/private_key > $CUR_DIR/jumpbox.key
chmod 600 $CUR_DIR/jumpbox.key


# BOSH_ENV_ALIAS is not an official name.  Change this to whatever is desired
# (commands will be in the form 'bosh -e <alias> -d <deployment> ...')
export BOSH_ENV_ALIAS=vbox

# The following are official bosh environment variables which provide defaults.
export BOSH_ENVIRONMENT=192.168.50.6
export BOSH_DEPLOYMENT=cf
export BOSH_CA_CERT=$CUR_DIR/rootCA.pem
export BOSH_GW_PRIVATE_KEY=$CUR_DIR/jumpbox.key
export BOSH_GW_USER=jumpbox
export BOSH_GW_HOST=$BOSH_ENVIRONMENT
export BOSH_CLIENT=admin
export BOSH_CLIENT_SECRET=`$BOSH int ${CUR_DIR}/creds.yml --path /admin_password`

$BOSH login -n
$BOSH alias-env $BOSH_ENV_ALIAS
$BOSH envs
echo "Current environment:"
$BOSH env

# Uncomment this line to add the internal route (on the host VM only):
#sudo ip route add   10.244.0.0/16 via 192.168.50.6

# Some convenience aliases.
alias bcf="bosh -e $BOSH_ENV_ALIAS -d cf"
alias jb="ssh -l $BOSH_GW_USER $BOSH_ENVIRONMENT -i $BOSH_GW_PRIVATE_KEY"

# Turns off debugging, should it be active.
set +x

BOSH=bosh

export CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$BOSH int $CUR_DIR/creds.yml --path /director_ssl/ca > $CUR_DIR/rootCA.pem
$BOSH int $CUR_DIR/creds.yml --path /jumpbox_ssh/private_key > $CUR_DIR/jumpbox.key
chmod 600 $CUR_DIR/jumpbox.key

export BOSH_ENVIRONMENT=10.245.0.10
export BOSH_DEPLOYMENT=acme
export BOSH_CA_CERT=$CUR_DIR/rootCA.pem
export BOSH_GW_PRIVATE_KEY=$CUR_DIR/jumpbox.key
export BOSH_GW_USER=jumpbox
export BOSH_GW_HOST=$BOSH_ENVIRONMENT
export BOSH_CLIENT=admin
export BOSH_CLIENT_SECRET=`$BOSH int ${CUR_DIR}/creds.yml --path /admin_password`
$BOSH login -n
#$BOSH target --ca-cert $BOSH_CA_CERT  $BOSH_ENVIRONMENT
#$BOSH alias-env vbox
$BOSH envs
echo "Current environment:"
$BOSH env

#sudo ip route add   10.244.0.0/16 via 192.168.50.6

bosh alias-env $BOSH_DEPLOYMENT -e $BOSH_ENVIRONMENT --ca-cert <($BOSH int creds.yml --path /director_ssl/ca)
alias b="bosh -e $BOSH_DEPLOYMENT -d cf"

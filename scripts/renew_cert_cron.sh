#!/bin/bash

set -e

OPENVPN_CONF_DIR="/etc/openvpn"
OPENVPN_KEYS_DIR="${OPENVPN_CONF_DIR}/keys"
OPENVPN_CREDENTIALS_FILE="${OPENVPN_KEYS_DIR}/credentials"
OPENVPN_AUTH_FILE="${OPENVPN_KEYS_DIR}/auth"
OPENVPN_USER_CERT="${OPENVPN_KEYS_DIR}/user.crt"
OPENVPN_USER_KEY="${OPENVPN_KEYS_DIR}/user.key"
OPENVPN_SERVER_CERT="${OPENVPN_KEYS_DIR}/ca-server.crt"
OPENVPN_CONF_TEMPLATE="${OPENVPN_CONF_DIR}/client.conf.tpl"

OPENVPN_CLIENT_LOGS="/var/log/openvpn-client.log"

NEUTRINET_CONF_TEMPLATE="neutrinet_openvpn_config"

if [[ -z $RENEW_CERT_PATH ]]
then
  RENEW_CERT_PATH=$PWD
fi

if [[ -z $RENEW_CERT_PYTHON ]]
then
  RENEW_CERT_PYTHON=$(command -v python3)
fi
RENEW_CERT_SCRIPT="${RENEW_CERT_PATH}/renew.py"

if [[ -f $OPENVPN_CREDENTIALS_FILE ]]
then
  credentials_file=$OPENVPN_CREDENTIALS_FILE
elif [[ -f $OPENVPN_AUTH_FILE ]]
then
  credentials_file=$OPENVPN_AUTH_FILE
else
  >&2 echo "ERROR: Cannot find credentials for Neutrinet VPN since neither ${OPENVPN_CREDENTIALS_FILE} nor ${OPENVPN_AUTH_FILE} exists."
  exit 1
fi

login=$(head -n 1 $credentials_file)
password=$(tail -n 1 $credentials_file)

run_date=$(date +'%Y-%m-%d_%H:%M:%S')
renew_dir="certs_$run_date"

$RENEW_CERT_PYTHON $RENEW_CERT_SCRIPT "$login" -p "$password" -c "$OPENVPN_USER_CERT" -d "$renew_dir" -v

if [[ ! -d $renew_dir || ! -f $renew_dir/ca.crt || ! -f $renew_dir/client.crt || ! -f $renew_dir/client.key ]]
then
  echo "Cleaning $renew_dir directory."
  rm -rf "$renew_dir"
  exit 0
fi

echo "Saving old OpenVPN config"
cp -r $OPENVPN_CONF_DIR{,.old_${run_date}}

echo "Copying new OpenVPN config"
cp "$NEUTRINET_CONF_TEMPLATE" "$OPENVPN_CONF_TEMPLATE"

echo "Copying new certificates"
cp "$renew_dir/ca.crt" "$OPENVPN_SERVER_CERT"
cp "$renew_dir/client.crt" "$OPENVPN_USER_CERT"
cp "$renew_dir/client.key" "$OPENVPN_USER_KEY"

echo "Adding user credentials"
echo -e "$login\n$password" > $OPENVPN_CREDENTIALS_FILE

echo "Updating VPNClient config"
yunohost app setting vpnclient server_name -v "vpn.neutrinet.be"
yunohost app setting vpnclient server_port -v "1195"
yunohost app setting vpnclient server_proto -v "udp"
yunohost app setting vpnclient service_enabled -v "1"
yunohost app setting vpnclient login_user -v "$login"
yunohost app setting vpnclient login_passphrase -v "$password"

echo "Critical part 1: reloading VPNClient"
if ! ynh-vpnclient restart && ynh-vpnclient status
then
  >&2 echo "ERROR: Failed to restart VPNClient"
  tail -n 200 "$OPENVPN_CLIENT_LOGS"
  exit 1
fi

echo "Critical part 2: restarting OpenVPN"
if ! service openvpn restart
then
  >&2 echo "ERROR: Failed to restart OpenVPN"
  journalctl -u openvpn -n 200 --no-pager
  exit 1
fi

sleep 15

if ! command -v ynh-hotspot > /dev/null
then
  exit 0
fi

echo "Few, we're done, let's wait 2min to be sure the VPN is running, then restart hotspot"
sleep 120

echo "Restarting hotspot"
if ! ynh-hotspot restart && ynh-hotspot status
then
  >&2 echo "ERROR: Failed to restart hotspot"
  echo "Since it's not a critical part, let's continue"
fi

#!/bin/bash

set -e

SCRIPT_DIR=$(dirname "$0")

if [[ ! -f /etc/openvpn/keys/credentials ]]
then
  >&2 echo "ERROR: Cannot find credentials for Neutrinet VPN: /etc/openvpn/keys/credentials doesn't exist."
  exit 1
fi

login=$(sed -n 1p "/etc/openvpn/keys/credentials")
password=$(sed -n 2p "/etc/openvpn/keys/credentials")

renew_dir=$(mktemp -d "/tmp/renew-cert-XXX")
renew_params="$@"

/usr/bin/python3 "$SCRIPT_DIR/renew.py" "$login" -p "$password" -c "/etc/openvpn/keys/user.crt" -s "/etc/openvpn/keys/ca-server.crt" -d "$renew_dir" $renew_params

if [[ ! -f $renew_dir/ca.crt || ! -f $renew_dir/client.crt || ! -f $renew_dir/client.key ]]
then
  rm -rf "$renew_dir"
  exit 0
fi

echo "VPN certificate renewed!"
echo "Backuping OpenVPN config"
yunohost backup create -n "renew-cert_$(date +'%Y-%m-%d')" --apps vpnclient

echo "Copying new certificates"
cp "$renew_dir/ca.crt" "/etc/openvpn/keys/ca-server.crt"
cp "$renew_dir/client.crt" "/etc/openvpn/keys/user.crt"
cp "$renew_dir/client.key" "/etc/openvpn/keys/user.key"

echo "Cleaning up files"
rm -rf "$renew_dir"

echo "Critical part: restarting VPNClient"
systemctl restart ynh-vpnclient

if ! ynh-vpnclient status
then
  >&2 echo "ERROR: Failed to restart VPNClient"
  tail -n 200 "/var/log/openvpn-client.log"
  exit 1
fi

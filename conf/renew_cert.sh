#!/bin/bash -e

SCRIPT_DIR=$(dirname "$0")

OPENVPN_KEYS_DIR="/etc/openvpn/keys"
OPENVPN_CREDENTIALS_FILE="/etc/openvpn/keys/credentials"

if [[ ! -f "${OPENVPN_CREDENTIALS_FILE}" ]]; then
  >&2 echo "ERROR: Cannot find credentials for Neutrinet VPN: ${OPENVPN_CREDENTIALS_FILE} doesn't exist."
  exit 1
fi

renew_dir=$(mktemp -d /tmp/renew_cert.XXXXX)

renew_params="$@"
/usr/bin/env python3 $SCRIPT_DIR/renew.py -C "${OPENVPN_CREDENTIALS_FILE}" -d "${renew_dir}" $renew_params

if [[ ! -f "${renew_dir}/ca.crt" || ! -f "${renew_dir}/client.crt" || ! -f "${renew_dir}/client.key" ]]; then
  rm -rf "${renew_dir}"
  exit 0
fi

echo "VPN certificate renewed!"
echo "Backuping OpenVPN config"
yunohost backup create -n "renew-cert_$(date +'%Y-%m-%d')" --apps vpnclient

echo "Copying new certificates"
cp "${renew_dir}/ca.crt" "${OPENVPN_KEYS_DIR}/ca-server.crt"
cp "${renew_dir}/client.crt" "${OPENVPN_KEYS_DIR}/user.crt"
cp "${renew_dir}/client.key" "${OPENVPN_KEYS_DIR}/user.key"

echo "Setting permissions"
chmod 0600 "${OPENVPN_KEYS_DIR}/user.key"
chmod 0600 "${OPENVPN_KEYS_DIR}/credentials"

echo "Cleaning up files"
rm -rf "$renew_dir"

echo "Restarting VPN client to apply new certificate"
yunohost service restart vpnclient

if ! ynh-vpnclient status; then
  >&2 echo "ERROR: Failed to restart VPN client"
  tail -n 200 "/var/log/openvpn-client.log"
  exit 1
fi

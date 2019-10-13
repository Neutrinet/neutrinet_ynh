#!/bin/bash

source /usr/share/yunohost/helpers

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
  ynh_die "Cannot find credentials for Neutrinet VPN since neither ${OPENVPN_CREDENTIALS_FILE} nor ${OPENVPN_AUTH_FILE} exists."
fi

login=$(head -n 1 $credentials_file)
password=$(tail -n 1 $credentials_file)

run_date=$(date +'%Y-%m-%d_%H:%M:%S')
renew_dir="certs_$run_date"

$RENEW_CERT_PYTHON $RENEW_CERT_SCRIPT $login -p $password -c $OPENVPN_USER_CERT -d "$renew_dir" -v

if [[ ! -d $renew_dir || ! -f $renew_dir/ca.crt || ! -f $renew_dir/client.crt || ! -f $renew_dir/client.key ]]
then
  ynh_print_info "Cleaning $renew_dir directory"
  rm -rf $renew_dir
  exit 0
fi

ynh_print_info "Saving old OpenVPN config"
cp -r $OPENVPN_CONF_DIR{,.old_${run_date}}

ynh_print_info "Copying new OpenVPN config"
cp "$NEUTRINET_CONF_TEMPLATE" "$OPENVPN_CONF_TEMPLATE"

ynh_print_info "Copying new certificates"
cp "$renew_dir/ca.crt" "$OPENVPN_SERVER_CERT"
cp "$renew_dir/client.crt" "$OPENVPN_USER_CERT"
cp "$renew_dir/client.key" "$OPENVPN_USER_KEY"

ynh_print_info "Adding user credentials"
echo -e "$login\n$password" > $OPENVPN_CREDENTIALS_FILE

ynh_print_info "Updating VPNClient config"
ynh_app_setting_set vpnclient server_name "vpn.neutrinet.be"
ynh_app_setting_set vpnclient server_port "1195"
ynh_app_setting_set vpnclient server_proto "udp"
ynh_app_setting_set vpnclient service_enabled "1"
ynh_app_setting_set vpnclient login_user "$login"
ynh_app_setting_set vpnclient login_passphrase "$password"

ynh_print_warn "Critical part 1: reloading VPNClient"
if ! ynh-vpnclient restart && ynh-vpnclient status
then
  ynh_print_err "Failed to restart VPNClient"
  tail -n 200 "$OPENVPN_CLIENT_LOGS"
  exit 1
fi

ynh_print_warn "Critical part 2: restarting OpenVPN"
if ! service openvpn restart
then
  ynh_print_err "Failed to restart OpenVPN"
  journalctl -u openvpn -n 200 --no-pager
  exit 1
fi

sleep 15

if ! command -v ynh-hotspot > /dev/null
then
  exit 0
fi

ynh_print_info "Few, we're done, let's wait 2min to be sure the VPN is running, then restart hotspot"
sleep 120

ynh_print_info "Restarting hotspot"
if ! ynh-hotspot restart && ynh-hotspot status
then
  ynh_print_warn "Failed to restart hotspot"
  ynh_print_warn "Since it's not a critical part, let's continue"
fi

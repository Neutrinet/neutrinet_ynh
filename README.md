<!--
N.B.: This README was automatically generated by https://github.com/YunoHost/apps/tree/master/tools/README-generator
It shall NOT be edited by hand.
-->

# Neutrinet for YunoHost

[![Integration level](https://dash.yunohost.org/integration/neutrinet.svg)](https://dash.yunohost.org/appci/app/neutrinet) ![](https://ci-apps.yunohost.org/ci/badges/neutrinet.status.svg) ![](https://ci-apps.yunohost.org/ci/badges/neutrinet.maintain.svg)  
[![Install Neutrinet with YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=neutrinet)

*[Lire ce readme en français.](./README_fr.md)*

> *This package allows you to install Neutrinet quickly and simply on a YunoHost server.
If you don't have YunoHost, please consult [the guide](https://yunohost.org/#/install) to learn how to install it.*

## Overview

The Neutrinet application is for Neutrinet members that have a Neutrinet VPN. It automatically checks and renews the VPN certificates. This package also contains a web page with contact information and other useful links.


**Shipped version:** 0.3.1~ynh5



## Disclaimers / important information

### For contributers
#### Debugging

You can manually run the cron job that attempts to renew the certificates:
```shell
sudo /etc/cron.daily/neutrinet-renew-cert
```

This actually runs the script in `/opt/neutrinet/renew_cert/`:
```shell
cd /opt/neutrinet/renew_cert
sudo ./renew_cert_cron.sh
```

You can increase the verbosity with the option `-v`:
```shell
sudo ./renew_cert_cron.sh -v
```

To install the app without checking for certificates, run `export PACKAGE_CHECK_EXEC=1`.

#### Publish a new version of the app

* Make sure the app passes the package check <https://github.com/YunoHost/package_check>
* Merging to stable will automatically make it available for updating since we used the ref `stable` in <https://github.com/YunoHost/apps/blob/master/apps.json>

## Documentation and resources

* Upstream app code repository: https://git.domainepublic.net/Neutrinet/renew_cert
* Report a bug: https://git.domainepublic.net/Neutrinet/neutrinet_ynh/issues

## Developer info

Please send your pull request to the [unstable branch](https://git.domainepublic.net/Neutrinet/neutrinet_ynh/-/tree/unstable).

To try the unstable branch, please proceed like that.
```sh
git clone https://git.domainepublic.net/Neutrinet/neutrinet_ynh/
cd neutrinet_ynh
git checkout unstable
cd ..
sudo yunohost app install neutrinet_ynh --debug
```
or
```sh
git clone https://git.domainepublic.net/Neutrinet/neutrinet_ynh/
cd neutrinet_ynh
git checkout unstable
cd ..
sudo yunohost app upgrade neutrinet_ynh --debug
```

**More info regarding app packaging:** https://yunohost.org/packaging_apps

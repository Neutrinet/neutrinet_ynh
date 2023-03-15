# Neutrinet pour YunoHost

[![Niveau d'intégration](https://dash.yunohost.org/integration/neutrinet.svg)](https://dash.yunohost.org/appci/app/neutrinet) ![](https://ci-apps.yunohost.org/ci/badges/neutrinet.status.svg) ![](https://ci-apps.yunohost.org/ci/badges/neutrinet.maintain.svg)  
[![Installer Neutrinet avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=neutrinet)

*[Read this readme in english.](./README.md)*
*[Lire ce readme en français.](./README_fr.md)*

> *Ce package vous permet d'installer Neutrinet rapidement et simplement sur un serveur YunoHost.
Si vous n'avez pas YunoHost, regardez [ici](https://yunohost.org/#/install) pour savoir comment l'installer et en profiter.*

## Vue d'ensemble

The Neutrinet application is for Neutrinet members that have a Neutrinet VPN. It automatically checks and renews the VPN certificates. This package also contains a web page with contact information and other useful links.


**Version incluse :** 0.3.1~ynh5



## Avertissements / informations importantes

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

## Documentations et ressources

* Dépôt de code officiel de l'app : https://git.domainepublic.net/Neutrinet/renew_cert
* Signaler un bug : https://git.domainepublic.net/Neutrinet/neutrinet_ynh/issues

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche unstable](https://git.domainepublic.net/Neutrinet/neutrinet_ynh/-/tree/unstable).

Pour essayer la branche testing, procédez comme suit.
```sh
git clone https://git.domainepublic.net/Neutrinet/neutrinet_ynh/
cd neutrinet_ynh
git checkout unstable
cd ..
sudo yunohost app install neutrinet_ynh --debug
```
ou
```sh
git clone https://git.domainepublic.net/Neutrinet/neutrinet_ynh/
cd neutrinet_ynh
git checkout unstable
cd ..
sudo yunohost app upgrade neutrinet_ynh --debug
```

**Plus d'infos sur le packaging d'applications :** https://yunohost.org/packaging_apps

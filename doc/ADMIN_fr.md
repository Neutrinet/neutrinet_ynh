### For contributers
#### Debugging

You can manually run the cron job that attempts to renew the certificates:

```shell
sudo /etc/cron.daily/neutrinet-renew-cert
```

This actually runs the script in `/opt/neutrinet/renew_cert/`:

```shell
cd /opt/neutrinet/renew_cert
sudo ./renew_cert.sh
```

You can increase the verbosity with the option `-v`:

```shell
sudo ./renew_cert.sh -v
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

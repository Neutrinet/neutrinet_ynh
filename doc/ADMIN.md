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

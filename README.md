# Overview

The neutrinet application is for Neutrinet members that have an Internet Cube configured and does 2 things:
* It renews the vpn-certificates
* It adds a webpage with general information about Neutrinet

# Installation

## From the web interface

First make sure you have the neutrinet apps list
1. Go to the admin interface on your cube
2. Click *Tools*
3. In the *Advanced* section, click *Applications lists*
4. Check in the Applications lists section if you have *neutrinet*

If you don't have it, under *Custom applications list*, fill in the form with:
1. Name: *neutrinet*
2. URL: *https://neutrinet.be/apps.json*

Then, click on the *Add* button.

Now, we can install the Neutrinet application:
1. Go to the admin interface
2. Click *Applications*
3. Click *Install* button
4. Select *All apps* on the right
5. Search for *neutrinet*
6. Click *Install*
7. Fill in the form (or just keep the defaults) and click *Install* just like you would install any app from the web interface

## From the CLI

First check if you have a list, probably named *neutrinet*, with *https://neutrinet.be/apps.json* as url.

```shell
yunohost app listlists
```

If you don't have the list yet, you can add it using

```shell
yunohost app fetchlist --name neutrinet -u https://neutrinet.be/apps.json
```

Once you have the list, you can install the app using

```shell
yunohost app install neutrinet --debug
```

## Debugging

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

# For contributers
## Contributing
* Bugs, feature requests and other issues can be logged on the issue tracker at https://git.domainepublic.net/Neutrinet/neutrinet_ynh/issues
* Merge requests should be submitted at https://git.domainepublic.net/Neutrinet/neutrinet_ynh
* Merge requests should be done to the `unstable` branch

## Publish a new version of the app

* Edit the [manifest](manifest.json) file to bump the version
* Edit the [upgrade](scripts/upgrade) script with the needed upgrades for previous installations
* Test the updated version both for new installs and upgrades and make sure the other scripts ([backup](scripts/backup), [remove](scripts/remove) and [upgrade](scripts/upgrade)) also still work
* In the [apps.json](https://neutrinet.be/apps.json) file you must update the `revision` with the current `sha` on the `stable` branch of the package and update the `lastUpdate` field. If you added things to the manifest file, you should add these changes ass well 


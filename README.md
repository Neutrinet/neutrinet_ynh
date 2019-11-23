# Overview

The neutrinet application is for Neutrinet members that have an Internet Cube configured and does 2 things:
* It renews the vpn-certificates
* Adds a webpage with genral information about Neutrinet

# Installation
## From the CLI

First check if you have a list, probably named *neutrinet*, with *https://neutrinet.be/apps.json* as url.

`yunohost app listlists`

If you don't have the list yet, you can add it using

`yunohost app fetchlist --name neutrinet --url https://neutrinet.be/apps.json`

Once you have the list, you can install the app using

`yunohost app install neutrinet --debug`

# For contributers
## Contributing
* Bugs, feature requests and other issues can be logged on the issue tracker at https://git.domainepublic.net/Neutrinet/neutrinet_ynh/issues
* Merge requests should be submitted at https://git.domainepublic.net/Neutrinet/neutrinet_ynh
* Merge requests should be done to the `develop` branch

## Publish a new version of the app

* Edit the [manifest](manifest.json) file to bump the version
* Edit the [upgrade](scripts/upgrade) script with the needed upgrades for previous installations
* Test the updated version both for new installs and upgrades and make sure the other scripts ([backup](scripts/backup), [remove](scripts/remove) and [upgrade](scripts/upgrade)) also still work
* In the [apps.json](https://neutrinet.be/apps.json) file you must update the `revision` with the current `sha` on the `master` branch of the package and update the `lastUpdate` field. If you added things to the manifest file, you should add these changes ass well 


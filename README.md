# Overview

The neutrinet application is for Neutrinet members that have an Internet Cube configured and does 2 things:
* It renews the vpn-certificates
* Adds a webpage with genral information about Neutrinet

# Installation
## From the webinterface

First make sure you have the neutrinet_app list
1. Go to the admin interface on your cube
2. Click *Applications* > *Install* > At the bottom click *Manage application lists* > Check in the Application list if you have *neutrinet*
3. If you don't have it > under Custom applications lists you give *neutrinet* under Name. Under URL you give *https://neutrinet.be/apps.json* > Add

The we can install the application
1. Click *Applications* at the top of the page
2. click *Install* > select *All apps* > search for *neutrinet*> click *Install* > Fill in the form (or just keep the defaults) and press Install just like you would install any app from the webinterface

## From the CLI

First check if you have a list, probably named *neutrinet*, with *https://neutrinet.be/apps.json* as url.

`yunohost app listlists`

If you don't have the list yet, you can add it using

`yunohost app fetchlist --name neutrinet -u https://neutrinet.be/apps.json`

Once you have the list, you can install the app using

`yunohost app install neutrinet --debug`

# For contributers
## Publish a new version of the app

* Edit the [manifest](manifest.json) file to bump the version
* Edit the [upgrade](scripts/upgrade) script with the needed upgrades for previous installations
* Test the updated version both for new installs and upgrades and make sure the other scripts ([backup](scripts/backup), [remove](scripts/remove) and [upgrade](scripts/upgrade)) also still work
* In the [apps.json](https://neutrinet.be/apps.json) file you must update the `revision` with the current `sha` on the `master` branch of the package and update the `lastUpdate` field. If you added things to the manifest file, you should add these changes ass well 


<!--
Ohart ongi: README hau automatikoki sortu da <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>ri esker
EZ editatu eskuz.
-->

# Neutrinet YunoHost-erako

[![Integrazio maila](https://apps.yunohost.org/badge/integration/neutrinet)](https://ci-apps.yunohost.org/ci/apps/neutrinet/)

![Funtzionamendu egoera](https://apps.yunohost.org/badge/state/neutrinet)

![Mantentze egoera](https://apps.yunohost.org/badge/maintained/neutrinet)

[![Instalatu Neutrinet YunoHost-ekin](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=neutrinet)

*[Irakurri README hau beste hizkuntzatan.](./ALL_README.md)*

> *Pakete honek Neutrinet YunoHost zerbitzari batean azkar eta zailtasunik gabe instalatzea ahalbidetzen dizu.*  
> *YunoHost ez baduzu, kontsultatu [gida](https://yunohost.org/install) nola instalatu ikasteko.*

## Aurreikuspena

The Neutrinet application is for Neutrinet members that have a Neutrinet VPN. It automatically checks and renews the VPN certificates. This package also contains a web page with contact information and other useful links.

**Paketatutako bertsioa:** 0.4.2~ynh2

## Dokumentazioa eta baliabideak

* Jatorrizko aplikazioaren kode-gordailua: <https://gitlab.domainepublic.net/Neutrinet/renew_cert>
* YunoHost Denda: <https://apps.yunohost.org/app/neutrinet>
* Eman errore baten berri: <https://gitlab.domainepublic.net/Neutrinet/neutrinet_ynh/issues>

## Garatzaileentzako informazioa

Bidali `pull request` a [ `unstable` abarrera](https://gitlab.domainepublic.net/Neutrinet/neutrinet_ynh/tree/unstable).

`unstable` abarra probatzeko, ondorengoa egin:

```bash
sudo yunohost app install https://gitlab.domainepublic.net/Neutrinet/neutrinet_ynh/tree/unstable --debug
edo
sudo yunohost app upgrade neutrinet -u https://gitlab.domainepublic.net/Neutrinet/neutrinet_ynh/tree/unstable --debug
```

**Informazio gehiago aplikazioaren paketatzeari buruz:** <https://yunohost.org/packaging_apps>

<!--
注意：此 README 由 <https://github.com/YunoHost/apps/tree/master/tools/readme_generator> 自动生成
请勿手动编辑。
-->

# YunoHost 上的 Neutrinet

[![集成程度](https://dash.yunohost.org/integration/neutrinet.svg)](https://dash.yunohost.org/appci/app/neutrinet) ![工作状态](https://ci-apps.yunohost.org/ci/badges/neutrinet.status.svg) ![维护状态](https://ci-apps.yunohost.org/ci/badges/neutrinet.maintain.svg)

[![使用 YunoHost 安装 Neutrinet](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=neutrinet)

*[阅读此 README 的其它语言版本。](./ALL_README.md)*

> *通过此软件包，您可以在 YunoHost 服务器上快速、简单地安装 Neutrinet。*  
> *如果您还没有 YunoHost，请参阅[指南](https://yunohost.org/install)了解如何安装它。*

## 概况

The Neutrinet application is for Neutrinet members that have a Neutrinet VPN. It automatically checks and renews the VPN certificates. This package also contains a web page with contact information and other useful links.


**分发版本：** 0.4.1~ynh1
## 文档与资源

- 上游应用代码库： <https://gitlab.domainepublic.net/Neutrinet/renew_cert>
- YunoHost 商店： <https://apps.yunohost.org/app/neutrinet>
- 报告 bug： <https://gitlab.domainepublic.net/Neutrinet/neutrinet_ynh/issues>

## 开发者信息

请向 [`unstable` 分支](https://gitlab.domainepublic.net/Neutrinet/neutrinet_ynh/tree/unstable) 发送拉取请求。

如要尝试 `unstable` 分支，请这样操作：

```bash
sudo yunohost app install https://gitlab.domainepublic.net/Neutrinet/neutrinet_ynh/tree/unstable --debug
或
sudo yunohost app upgrade neutrinet -u https://gitlab.domainepublic.net/Neutrinet/neutrinet_ynh/tree/unstable --debug
```

**有关应用打包的更多信息：** <https://yunohost.org/packaging_apps>

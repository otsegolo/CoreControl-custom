# CoreControl-custom


## Features

- Everything else in normal corecontrol, plus notifications won't be sent for an app going down until it's been down for at least 30 seconds. This is a buggy wierd implementation of it because I'm not great at these languages but it'll work until the actually good devs adds this feature properly to the main repo. (just saw the v2 branch, i'm excited, hope this feature is added on there)

---

## Deployment

#### This assumes you already know what you're doing with corecontrol. In your docker compose file simple exchange the following:

```
haedlessdev/corecontrol:latest
```

becomes

```
otsegolo/corecontrol-custom:custom
```

#### and 

```
haedlessdev/corecontrol-agent:latest
```

becomes

```
otsegolo/corecontrol-agent-custom:custom
```

---


Licensed under the [MIT License](https://github.com/crocofied/CoreControl/blob/main/LICENSE).


Support the actual dev:
[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/corecontrol)
[![Sponsor](https://img.shields.io/badge/sponsor-30363D?style=for-the-badge&logo=GitHub-Sponsors&logoColor=#white)](https://github.com/sponsors/crocofied)


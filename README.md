# CoreControl-custom


## Features

- Everything else in normal corecontrol, plus notifications wont be sent for an app going down until its been down for at least 30 seconds. this is a buggy wierd implementation of it because i'm not great at these languages but it'll work until the actually good devs adds this feature properly to the main repo.

---

## Deployment

#### this assumes you already know what you're doing with corecontrol. in your docker compose file simple exchange the following:

```
haedlessdev/corecontrol:latest
```

becomes

```
george1717/corecontrol-custom:custom
```

#### and 

```
haedlessdev/corecontrol-agent:latest
```

becomes

```
george1717/corecontrol-agent-custom:custom
```

---


Licensed under the [MIT License](https://github.com/crocofied/CoreControl/blob/main/LICENSE).


support the actual dev:
[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/corecontrol)
[![Sponsor](https://img.shields.io/badge/sponsor-30363D?style=for-the-badge&logo=GitHub-Sponsors&logoColor=#white)](https://github.com/sponsors/crocofied)


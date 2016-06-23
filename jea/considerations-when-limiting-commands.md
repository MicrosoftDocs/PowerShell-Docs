---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-06-22
title:  considerations when limiting commands
ms.technology:  powershell
---

### Considerations When Limiting Commands
There is one important point to make about this step.
It is critical that all capabilities exposed through JEA are located in administrator-restricted areas.
Non-administrator users should not have the capability to modify the scripts used through JEA endpoints.

On a related note, it is critical that you do not give JEA users the ability to overwrite JEA configurations and whitelisted scripts within their JEA sessions.
Be extremely careful when exposing commands like `Copy-Item`!


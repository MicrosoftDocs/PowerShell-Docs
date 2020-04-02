---
title: Using PowerShell in Docker
description: How to use PowerShell that is preinstalled in a Docker image.
ms.devlang: powershell
ms.topic: conceptual
ms.date: 03/03/2020
---

# Using PowerShell in Docker

We publish Docker images with PowerShell preinstalled. This article shows you how to get
started using PowerShell in the Docker container.

## Finding available images

The released images require Docker 17.05 or newer. It is also expected that you are able to run
Docker without `sudo` or local administrative rights. Please follow Docker's official
[instructions][install] to install `docker` correctly.

The release containers derive from the official distribution image, such as `centos:7`, then install
dependencies, and finally install the PowerShell package.

These containers live at [hub.docker.com/r/microsoft/powershell][docker-release].

For more information about these Docker images, visit the [PowerShell-Docker][PowerShell-Docker]
repository on GitHub.

## Using PowerShell in a container

The following steps show the Docker commands required to download the image and start an interactive
PowerShell session.

```console
docker run -it mcr.microsoft.com/powershell
```

### Remove the image when no longer needed

The following command is used to delete the Docker image when you no longer need it.

```console
docker rmi mcr.microsoft.com/powershell
```

## Legal and Licensing

PowerShell is licensed under the [MIT license][].

### Windows Docker File and Image Licenses

By requesting and using the Container OS Image for Windows containers, you acknowledge,
understand, and consent to the Supplemental License Terms available on Docker hub:

- [Window Server Core][Window Server Core]
- [Nano Server][Nano Server]

### Telemetry

By default, PowerShell collects limited telemetry without personally identifiable information to
help aid development of future versions of PowerShell. To opt-out of sending telemetry, create an
environment variable called `POWERSHELL_TELEMETRY_OPTOUT` set to a value of `1` before starting
PowerShell from the installed location. The telemetry we collect falls under the
[Microsoft Privacy Statement][privacy].

<!-- link references -->
[install]: https://docs.docker.com/engine/installation/
[docker-release]: https://hub.docker.com/r/microsoft/powershell/
[appinsights]: https://azure.microsoft.com/services/application-insights/
[MIT license]: https://github.com/PowerShell/PowerShell/tree/master/LICENSE.txt
[PowerShell-Docker]: https://github.com/PowerShell/PowerShell-Docker
[Window Server Core]: https://hub.docker.com/r/microsoft/windowsservercore/
[Nano Server]: https://hub.docker.com/r/microsoft/nanoserver/
[privacy]: https://privacy.microsoft.com/privacystatement/

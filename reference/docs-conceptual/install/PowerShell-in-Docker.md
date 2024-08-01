---
description: How to use PowerShell that's preinstalled in a Docker image.
ms.date: 08/01/2024
ms.devlang: powershell
ms.topic: conceptual
title: Using PowerShell in Docker
---

# Using PowerShell in Docker

We publish Docker images with PowerShell preinstalled. This article shows you how to get
started using PowerShell in the Docker container.

## Finding available images

The released images require Docker 17.05 or newer. It's also expected that you are able to run
Docker without `sudo` or local administrative rights. Please follow Docker's official
[instructions][01] to install `docker` correctly.

The release containers derive from the official distribution image, then install dependencies, and
finally install the PowerShell package.

These containers live at [Microsoft Artifact Registry][05].

For more information about these Docker images, visit the [PowerShell-Docker][02] repository on
GitHub.

## Using PowerShell in a container

The following steps show the Docker commands required to download the image containing the latest
available stable version of PowerShell and start an interactive PowerShell session.

```console
docker run -it mcr.microsoft.com/powershell
```

Use the following command to download and run the image containing the latest available preview
version of PowerShell.

```console
docker run -it mcr.microsoft.com/powershell:preview
```
> [!IMPORTANT]
> The Docker images are built from official operating system (OS) images provide by the OS
> distributor. These images may not have the latest security updates. Microsoft recommends that you
> update the OS packages to the latest version to ensure the latest security updates are applied.

### Remove the image when no longer needed

The following command is used to delete the Docker image when you no longer need it.

```console
docker rmi mcr.microsoft.com/powershell
```

## Legal and Licensing

PowerShell is licensed under the [MIT license][03].

### Windows Docker file and image licenses

By requesting and using the Container OS Image for Windows containers, you acknowledge, understand,
and consent to the Supplemental License Terms available on Docker hub:

- [Window Server Core][06]
- [Nano Server][04]

### Telemetry

By default, PowerShell collects limited telemetry without personally identifiable information to
help aid development of future versions of PowerShell. To opt-out of sending telemetry, create an
environment variable called `POWERSHELL_TELEMETRY_OPTOUT` set to a value of `1` before starting
PowerShell from the installed location. The telemetry we collect falls under the
[Microsoft Privacy Statement][07].

<!-- link references -->
[01]: https://docs.docker.com/engine/installation/
[02]: https://github.com/PowerShell/PowerShell-Docker
[03]: https://github.com/PowerShell/PowerShell/tree/master/LICENSE.txt
[04]: https://mcr.microsoft.com/product/windows/nanoserver
[05]: https://mcr.microsoft.com/product/powershell
[06]: https://mcr.microsoft.com/product/windows/servercore
[07]: https://privacy.microsoft.com/privacystatement/

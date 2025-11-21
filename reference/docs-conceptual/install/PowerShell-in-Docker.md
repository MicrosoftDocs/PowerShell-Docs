---
description: How to use PowerShell in a Docker image.
ms.date: 11/21/2025
ms.devlang: powershell
title: Use PowerShell in Docker
---

# Use PowerShell in Docker

The .NET team publishes Docker images with PowerShell preinstalled. This article shows you how to
get started using PowerShell in the Docker container.

## Find available images

These images require Docker 17.05 or newer. Also, you must be able to run Docker without `sudo` or
local administrative rights. For install instructions, see Docker's official [documentation][02].

The .NET team publishes several Docker images designed for different development scenarios. Only the
image for the .NET SDK contains PowerShell. For more information, see
[Official .NET Docker images][01].

## Use PowerShell in a container

The following command downloads the image containing the latest available stable versions of the
.NET SDK and PowerShell.

```console
docker pull mcr.microsoft.com/dotnet/sdk:9.0
```

Use the following command to start an interactive PowerShell session in the container.

```console
docker run -it mcr.microsoft.com/dotnet/sdk:9.0 pwsh
```

To download and run the latest Long Term Support (LTS) version of PowerShell, change the image name
to `mcr.microsoft.com/dotnet/sdk:8.0`. When you use these image tags, Docker downloads the
appropriate image for your host operating system. If you want an image for a specific operating
system, you can specify the operating system in the image tag. See the
[Microsoft Artifact Registry][07] for a list of available tags.

- For more information about tags, the [Supported tag policy][06]
- For more information about supported operating systems, see the [Supported platforms policy][05]

## Support lifecycle

The [.NET support policy][03] defines how these images are supported. These images are provided for
development and testing purposes only. If you need a production-ready image, you should build your
own images. For more information about these Docker images, visit the [dotnet-docker][04] repository
on GitHub.

The images previously published by the PowerShell team will be marked as deprecated in the Microsoft
Container Registry (MCR).

## Telemetry

By default, PowerShell collects limited telemetry without personal data to help aid development of
future versions of PowerShell. To opt-out of sending telemetry, create an environment variable
called `POWERSHELL_TELEMETRY_OPTOUT` set to a value of `1` before starting PowerShell from the
installed location. The telemetry we collect falls under the [Microsoft Privacy Statement][08].

<!-- link references -->
[01]: /dotnet/architecture/microservices/net-core-net-framework-containers/official-net-docker-images
[02]: https://docs.docker.com/engine/installation/
[03]: https://github.com/dotnet/core/blob/main/support.md
[04]: https://github.com/dotnet/dotnet-docker
[05]: https://github.com/dotnet/dotnet-docker/blob/main/documentation/supported-platforms.md
[06]: https://github.com/dotnet/dotnet-docker/blob/main/documentation/supported-tags.md
[07]: https://mcr.microsoft.com/en-us/artifact/mar/dotnet/sdk/about
[08]: https://privacy.microsoft.com/privacystatement/

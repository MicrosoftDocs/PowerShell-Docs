---
title: Installing PowerShell Core on ARM
description: Installing PowerShell Core on ARM-based systems
ms.date: 08/06/2018
---

# PowerShell Core on ARM

Today, PowerShell Core works on some ARM devices, including Windows 10 ARM32/ARM64 and Raspbian.
PowerShell Core for ARM is an experimental release that is unsupported.

For more information on installing these experimental builds, see the installation instructions for
[Windows 10 IoT](installing-powershell-core-on-windows.md#deploying-on-windows-iot)
and [Raspbian](installing-powershell-core-on-linux.md#raspbian).

# PowerShell Core in Docker, on ARM

You can run PowerShell Core in a Docker container on a ARM device, such as a Raspberry Pi. There is not currently a pre-built container image published to a public repository, such as Docker Hub. However, you can build your own container image by downloading the `Dockerfile` for [PowerShell Core on ARM](https://github.com/PowerShell/PowerShell-Docker/blob/master/release/stable/arm32v7/docker/Dockerfile).

```
# Build the container image, using the current directory as the build context
docker build --tag powershell:arm32v7 .

# Run a new PowerShell Core container
docker run --rm --interactive --tty powershell:arm32v7
```

# ARM 64-bit

More information will be available here as our ARM64 story progresses.

Stay tuned!

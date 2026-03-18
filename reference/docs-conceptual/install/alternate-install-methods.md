---
description: Alternate ways to install PowerShell on non-Windows platforms.
ms.date: 03/18/2026
title: Alternate ways to install PowerShell
---
# Alternate ways to install PowerShell

There are other ways to install PowerShell on non-Windows platforms.

These methods may work but aren't officially supported by Microsoft. You may be able to get support
from the PowerShell Community or the operating system vendor. For support options, see
[Community Support][08].

## Install on macOS using Homebrew

Homebrew is the preferred package manager for macOS. If the `brew` command isn't found, you need to
install Homebrew following [their instructions][12].

> [!IMPORTANT]
> The brew formula is maintained and supported by the Homebrew community. The brew formula builds
> PowerShell from source code rather than installing a package built by Microsoft.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Once `brew` is installed, install PowerShell using the following command:

```sh
brew install powershell
```

If you previously installed PowerShell using the Homebrew cask, you must first uninstall the cask
before you can successfully install using the Homebrew formula. Use the following commands to
uninstall the cask:

```sh
# Uninstall the PowerShell cask instance
brew uninstall --cask powershell
# Uninstall the PowerShell Preview cask instance
brew uninstall --cask powershell-preview
```

### Update PowerShell 7

Run the following commands to update the installed version of PowerShell to the latest release.

```sh
brew update
brew upgrade powershell
```

### Uninstall PowerShell 7

If you installed PowerShell with Homebrew, use the following command to uninstall:

```sh
brew uninstall powershell
```

If you manually installed PowerShell 7, you must manually remove it. The following command removes
the symbolic link and PowerShell files.

```sh
sudo rm -rf /usr/local/bin/pwsh /usr/local/microsoft/powershell
```

Use `sudo rm` to remove any other remaining PowerShell files and folders.

## Install on Linux using a Snap package

Snaps are application packages that are easy to install if your platform supports Snap. You can find
and install Snap packages from the Snap Store.

> [!NOTE]
> The Snap Store contains PowerShell snap packages for many Linux distributions that aren't
> officially supported by Microsoft.

### Getting snapd

The snap daemon, known as `snapd`, is the background service that manages and maintains your snaps.
It needs to be running before a snap can be installed. For instructions on how to install `snapd`,
see the [Snapcraft documentation][14].

### Installation via Snap

There are two PowerShell for Linux is published to the [Snap store][15]: `powershell` and
`powershell-preview`.

Use the following command to install the latest stable version of PowerShell:

```sh
# Install PowerShell
sudo snap install powershell --classic

# Start PowerShell
pwsh
```

If you don't specify the `--channel` parameter, Snap installs the latest stable version. To install
the latest LTS version, use the following method:

```sh
# Install PowerShell
sudo snap install powershell --channel=lts/stable --classic

# Start PowerShell
pwsh
```

To install a preview version, use the following method:

```sh
# Install PowerShell
sudo snap install powershell-preview --classic

# Start PowerShell
pwsh-preview
```

> [!NOTE]
> Microsoft only supports the `latest/stable` and `lts/stable` channels for the `powershell`
> package. Microsoft only supports the `latest/stable` channel for the `powershell-preview` package.
> Do not install packages from the other channels.

After installation, Snap will automatically upgrade. You can trigger an upgrade using
`sudo snap refresh powershell` or `sudo snap refresh powershell-preview`.

> [!IMPORTANT]
> The Snap packages are maintained and supported by Canonical. Snap packages build PowerShell from
> source code rather than installing a package built by Microsoft.

### Uninstall using Snap

```sh
sudo snap remove powershell
```

or

```sh
sudo snap remove powershell-preview
```

## Install from binary archives

PowerShell binary `tar.gz` archives are provided for Linux platforms to enable advanced deployment
scenarios.

> [!NOTE]
> You can use this method to install any version of PowerShell including the latest:
>
> - Stable release: [https://aka.ms/powershell-release?tag=stable][11]
> - LTS release: [https://aka.ms/powershell-release?tag=lts][09]
> - Preview release: [https://aka.ms/powershell-release?tag=preview][10]

### Dependencies

PowerShell builds portable binaries for all supported Linux distributions. But, PowerShell and the
.NET runtime require different dependencies on different distributions.

It's possible that when you install PowerShell, specific dependencies may not be installed, such as
when manually installing from the binary archives. The following list details Linux distributions
that are supported by Microsoft and have dependencies you may need to install. Check the
Linux distribution page for more information:

- [Alpine][01]
- [Debian][02]
- [RHEL][03]
- [SLES][04]
- [Ubuntu][05]

To deploy PowerShell binaries on Linux distributions that aren't officially supported, you need to
install the necessary dependencies for the target OS in separate steps.

> [!IMPORTANT]
> This method can be used to install PowerShell on any version of Linux, including distributions
> that are not officially supported by Microsoft. Be sure to install any necessary dependencies. For
> support, see the list of available [Community Support][08] options.

The following example shows the steps for installing the x64 binary archive. You must choose the
correct binary archive that matches the processor type for your platform.

- `powershell-7.5.5-linux-arm32.tar.gz`
- `powershell-7.5.5-linux-arm64.tar.gz`
- `powershell-7.5.5-linux-x64.tar.gz`

Use the following shell commands to download and install PowerShell from the `tar.gz` binary
archive. Change the URL to match the version of PowerShell you want to install.

```sh
# Download the powershell '.tar.gz' archive
curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.5.5/powershell-7.5.5-linux-x64.tar.gz

# Create the target folder where powershell will be placed
sudo mkdir -p /opt/microsoft/powershell/7

# Expand powershell to the target folder
sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7

# Set execute permissions
sudo chmod +x /opt/microsoft/powershell/7/pwsh

# Create the symbolic link that points to pwsh
sudo ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh
```

### Uninstalling binary archives

```sh
sudo rm -rf /usr/bin/pwsh /opt/microsoft/powershell
```

## Install as a .NET Global tool

If you already have the [.NET Core SDK][06] installed, it's easy to install PowerShell
as a [.NET Global tool][07].

```sh
dotnet tool install --global PowerShell
```

The dotnet tool installer adds `~/.dotnet/tools` to your `PATH` environment variable. However, the
currently running shell doesn't have the updated `PATH`. You should be able to start PowerShell
from a new shell by typing `pwsh`.

The .NET team publishes Docker images containing the .NET SDK with PowerShell already installed. You
can find those images on the [Microsoft Container Registry][13].

<!-- link references -->
[01]: /dotnet/core/install/linux-alpine#dependencies
[02]: /dotnet/core/install/linux-debian#dependencies
[03]: /dotnet/core/install/linux-rhel#dependencies
[04]: /dotnet/core/install/linux-sles#dependencies
[05]: /dotnet/core/install/linux-ubuntu#dependencies
[06]: /dotnet/core/sdk
[07]: /dotnet/core/tools/global-tools
[08]: /powershell/scripting/community/community-support
[09]: https://aka.ms/powershell-release?tag=lts
[10]: https://aka.ms/powershell-release?tag=preview
[11]: https://aka.ms/PowerShell-Release?tag=stable
[12]: https://brew.sh/
[13]: https://mcr.microsoft.com/en-us/artifact/mar/dotnet/sdk/
[14]: https://snapcraft.io/docs/tutorials/install-the-daemon/
[15]: https://snapcraft.io/store

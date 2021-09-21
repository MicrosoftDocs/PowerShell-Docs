---
title: Installing PowerShell on macOS
description: Information about installing PowerShell on macOS
ms.date: 04/26/2021
---

# Installing PowerShell on macOS

PowerShell 7.0 or higher require macOS 10.13 and higher. All packages are available on our GitHub
[releases][releases] page. After the package is installed, run `pwsh` from a terminal.

> [!NOTE]
> PowerShell 7.2 is an in-place upgrade that removes previous versions of PowerShell 6.x and 7.x.
>
> The `/usr/local/microsoft/powershell/6` folder is replaced by `/usr/local/microsoft/powershell/7`.
>
> If you need to run an older version of PowerShell side-by-side with PowerShell 7.2, install
> the version you want using the [binary archive](#binary-archives) method.

## Supported versions of macOS

[!INCLUDE [macOS support](../../includes/macos-support.md)]

## Installation of latest stable release via Homebrew on macOS 10.13 or higher

There are several ways to install PowerShell on macOS. Choose one of the following methods:

- Install using [Homebrew][brew]. Homebrew is the preferred package manager for macOS.
- Install PowerShell via [Direct Download](#installation-via-direct-download)
- Install from [binary archives](#binary-archives).

After installing PowerShell, you should install [OpenSSL](#installing-dependencies). OpenSSL is
needed for PowerShell remoting and CIM operations.

If the `brew` command is not found, you need to install Homebrew following
[their instructions][brew].

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Now, you can install PowerShell:

```sh
brew install --cask powershell
```

Finally, verify that your install is working properly:

```sh
pwsh
```

When new versions of PowerShell are released, update Homebrew's formulae and upgrade PowerShell:

```sh
brew update
brew upgrade powershell --cask
```

> [!NOTE]
> The commands above can be called from within a PowerShell (pwsh) host,
> but then the PowerShell shell must be exited and restarted to complete the upgrade
> and refresh the values shown in `$PSVersionTable`.

[brew]: https://brew.sh/

## Installation of latest preview release via Homebrew on macOS 10.13 or higher

After you've installed Homebrew, you can install PowerShell. First, install the [Cask-Versions][cask-versions]
package that lets you install alternative versions of cask packages:

```sh
brew tap homebrew/cask-versions
```

Now, you can install PowerShell:

```sh
brew install --cask powershell-preview
```

Finally, verify that your install is working properly:

```sh
pwsh-preview
```

When new versions of PowerShell are released, update Homebrew's formulae and upgrade PowerShell:

```sh
brew update
brew upgrade powershell-preview --cask
```

> [!NOTE]
> The commands above can be called from within a PowerShell (pwsh) host,
> but then the PowerShell shell must be exited and restarted to complete the upgrade.
> and refresh the values shown in `$PSVersionTable`.

Installing PowerShell using the Homebrew tap method is also supported for stable and LTS versions.

```sh
brew install powershell/tap/powershell
```

You can now verify your install

```sh
pwsh
```

When new versions of PowerShell are released, simply run the following command.

```sh
brew upgrade powershell
```

> [!NOTE]
> Whether you use the cask or the tap method, when updating to a newer version of PowerShell, use
> the same method you used to initially install PowerShell. If you use a different method, opening a
> new pwsh session will continue to use the older version of PowerShell.
>
> If you do decide to use different methods, there are ways to correct the issue using the
> [Homebrew link method](https://docs.brew.sh/Manpage#link-ln-options-formula).

## Installation via Direct Download

PowerShell 7.2 addes support for the Apple M1 processor. Download the install package from the
[releases][releases] page onto your computer. The links to the current versions are:

- PowerShell 7.2-preview.9
  - x64 processors - `https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.9/powershell-7.2.0-preview.9-osx-x64.pkg`
  - M1 processors - `https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.9/powershell-7.2.0-preview.9-osx-arm64.pkg`
- PowerShell 7.1.4 - `https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/powershell-7.1.4-osx-x64.pkg`
- PowerShell 7.0.7 - `https://github.com/PowerShell/PowerShell/releases/download/v7.0.7/powershell-7.0.7-osx-x64.pkg`

You can double-click the file and follow the prompts, or install it from the terminal using the
following commands. Change the name of the file to match the file you downloaded.

```sh
sudo installer -pkg powershell-7.1.4-osx-x64.pkg -target /
```

Install [OpenSSL](#installing-dependencies). OpenSSL is needed for PowerShell remoting and CIM
operations.

## Install as a .NET Global tool

If you already have the [.NET Core SDK](/dotnet/core/sdk) installed, it's easy to install PowerShell
as a [.NET Global tool](/dotnet/core/tools/global-tools).

```
dotnet tool install --global PowerShell
```

The dotnet tool installer adds `~/.dotnet/tools` to your `PATH` environment variable. However, the
currently running shell does not have the updated `PATH`. You should be able to start PowerShell
from a new shell by typing `pwsh`.

Install [OpenSSL](#installing-dependencies). OpenSSL is needed for PowerShell remoting and CIM
operations.

## Binary Archives

PowerShell binary `tar.gz` archives are provided for the macOS platform to enable advanced
deployment scenarios. When you install using this method you must also manually install any
dependencies.

Install [OpenSSL](#installing-dependencies). OpenSSL is needed for PowerShell remoting and CIM
operations.

> [!NOTE]
> You can use this method to install any version of PowerShell including the latest:
> - Stable release: [https://aka.ms/powershell-release?tag=stable](https://aka.ms/powershell-release?tag=stable)
> - Preview release: [https://aka.ms/powershell-release?tag=preview](https://aka.ms/powershell-release?tag=preview)
> - LTS release: [https://aka.ms/powershell-release?tag=lts](https://aka.ms/powershell-release?tag=lts)

### Installing binary archives on macOS

Download the install package from the [releases][releases] page onto your computer. The links to the
current versions are:

- PowerShell 7.2-preview.9
  - x64 processors - `https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.9/powershell-7.2.0-preview.9-osx-x64.tar.gz`
  - M1 processors - `https://github.com/PowerShell/PowerShell/releases/download/v7.2.0-preview.9/powershell-7.2.0-preview.9-osx-arm64.tar.gz`
- PowerShell 7.1.4 - `https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/powershell-7.1.4-osx-x64.tar.gz`
- PowerShell 7.0.7 - `https://github.com/PowerShell/PowerShell/releases/download/v7.0.7/powershell-7.0.7-osx-x64.tar.gz`

Use the following commands to install PowerShell from the binary archive. Change the download URL to
match the version you want to install.

```sh
# Download the powershell '.tar.gz' archive
curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/powershell-7.1.4-osx-x64.tar.gz

# Create the target folder where powershell will be placed
sudo mkdir -p /usr/local/microsoft/powershell/7.1.4

# Expand powershell to the target folder
sudo tar zxf /tmp/powershell.tar.gz -C /usr/local/microsoft/powershell/7.1.4

# Set execute permissions
sudo chmod +x /usr/local/microsoft/powershell/7.1.4/pwsh

# Create the symbolic link that points to pwsh
sudo ln -s /usr/local/microsoft/powershell/7.1.4/pwsh /usr/local/bin/pwsh
```

## Installing dependencies

OpenSSL is required for PowerShell remoting and CIM operations. You can install OpenSSL via MacPorts
if needed.

> [!NOTE]
> MacPorts and Homebrew can have problems when used to together on the same system. However,
> Homebrew does not have a package for OpenSSL 1.0. For more information, see the
> [MacPorts FAQ](https://trac.macports.org/wiki/FAQ).

1. Install the Xcode command-line tools. The Xcode tools are required by MacPorts.

   ```sh
   xcode-select --install
   ```

1. Install MacPorts. If you need instructions, refer to the
   [installation guide](https://www.macports.org/install.php).
1. Update MacPorts by running `sudo port selfupdate`.
1. Upgrade MacPorts packages by running `sudo port upgrade outdated`.
1. Install OpenSSL by running `sudo port install openssl10`.
1. Link the libraries to make them available to PowerShell:

   ```sh
   sudo mkdir -p /usr/local/opt/openssl
   sudo ln -s /opt/local/lib/openssl-1.0 /usr/local/opt/openssl/lib
   ```

## Uninstalling PowerShell

If you installed PowerShell with Homebrew, use the following command to uninstall:

```sh
brew uninstall --cask powershell
```

If you installed PowerShell via direct download, PowerShell must be removed manually:

```sh
sudo rm -rf /usr/local/bin/pwsh /usr/local/microsoft/powershell
```

To remove the additional PowerShell paths, refer to the [paths](#paths) section in this document
and remove the paths using `sudo rm`.

> [!NOTE]
> This is not necessary if you installed with Homebrew.

## Paths

- `$PSHOME` is `/usr/local/microsoft/powershell/7.1.4/`
- User profiles will be read from `~/.config/powershell/profile.ps1`
- Default profiles will be read from `$PSHOME/profile.ps1`
- User modules will be read from `~/.local/share/powershell/Modules`
- Shared modules will be read from `/usr/local/share/powershell/Modules`
- Default modules will be read from `$PSHOME/Modules`
- PSReadline history will be recorded to `~/.local/share/powershell/PSReadLine/ConsoleHost_history.txt`

The profiles respect PowerShell's per-host configuration. So the default host-specific profile
exists at `Microsoft.PowerShell_profile.ps1` in the same locations.

PowerShell respects the [XDG Base Directory Specification][xdg-bds] on macOS.

Because macOS is a derivation of BSD, the prefix `/usr/local` is used instead of `/opt`. So,
`$PSHOME` is `/usr/local/microsoft/powershell/7.1.4/`, and the symbolic link is placed at
`/usr/local/bin/pwsh`.

## Installation support

Microsoft supports the installation methods in this document. There may be other methods of
installation available from other sources. While those tools and methods may work, Microsoft cannot
support those methods.

## Additional Resources

- [Homebrew Web][brew]
- [Homebrew Github Repository][GitHub]
- [Homebrew-Cask][cask]

[brew]: https://docs.brew.sh/Installation
[Cask]: https://github.com/Homebrew/homebrew-cask
[cask-versions]: https://github.com/Homebrew/homebrew-cask-versions
[GitHub]: https://github.com/Homebrew
[releases]: https://aka.ms/powershell-release?tag=stable
[xdg-bds]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

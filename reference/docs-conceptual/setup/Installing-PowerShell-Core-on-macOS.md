---
title: Installing PowerShell Core on macOS
description: Information about installing PowerShell Core on macOS
ms.date: 08/06/2018
---

# Installing PowerShell Core on macOS

PowerShell Core supports macOS 10.12 and higher.
All packages are available on our GitHub [releases][] page.
Once the package is installed, run `pwsh` from a terminal.

## Installation of latest stable release via Homebrew on macOS 10.12 or higher

[Homebrew][brew] is the preferred package manager for macOS.
If the `brew` command is not found, you need to install Homebrew following [their instructions][brew].

Now, you can install PowerShell:

```sh
brew cask install powershell
```

Finally, verify that your install is working properly:

```sh
pwsh
```

When new versions of PowerShell are released,
simply update Homebrew's formulae and upgrade PowerShell:

```sh
brew update
brew cask upgrade powershell
```

> [!NOTE]
> The commands above can be called from within a PowerShell (pwsh) host,
> but then the PowerShell shell must be exited and restarted to complete the upgrade
> and refresh the values shown in $PSVersionTable.

[brew]: http://brew.sh/

## Installation of latest preview release via Homebrew on macOS 10.12 or higher

[Homebrew][brew] is the preferred package manager for macOS.
If the `brew` command is not found, you need to install Homebrew following [their instructions][brew].

Once you've installed Homebrew, installing PowerShell is easy.
First, install [Cask-Versions][cask-versions] which lets you install alternative versions of cask packages:

```sh
brew tap homebrew/cask-versions
```

Now, you can install PowerShell:

```sh
brew cask install powershell-preview
```

Finally, verify that your install is working properly:

```sh
pwsh-preview
```

When new versions of PowerShell are released,
simply update Homebrew's formulae and upgrade PowerShell:

```sh
brew update
brew cask upgrade powershell-preview
```

> [!NOTE]
> The commands above can be called from within a PowerShell (pwsh) host,
> but then the PowerShell shell must be exited and restarted to complete the upgrade.
> and refresh the values shown in $PSVersionTable.

## Installation via Direct Download

Download the PKG package
`powershell-6.1.0-osx-x64.pkg`
from the [releases][] page onto your macOS machine.

You can double-click the file and follow the prompts,
or install it from the terminal:

```sh
sudo installer -pkg powershell-6.1.0-osx-x64.pkg -target /
```

## Binary Archives

PowerShell binary `tar.gz` archives are provided for the macOS platform
to enable advanced deployment scenarios.

### Installing binary archives on macOS

```sh
# Download the powershell '.tar.gz' archive
curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v6.1.0/powershell-6.1.0-osx-x64.tar.gz

# Create the target folder where powershell will be placed
sudo mkdir -p /usr/local/microsoft/powershell/6.1.0

# Expand powershell to the target folder
sudo tar zxf /tmp/powershell.tar.gz -C /usr/local/microsoft/powershell/6.1.0

# Set execute permissions
sudo chmod +x /usr/local/microsoft/powershell/6.1.0/pwsh

# Create the symbolic link that points to pwsh
sudo ln -s /usr/local/microsoft/powershell/6.1.0/pwsh /usr/local/bin/pwsh
```

## Uninstalling PowerShell Core

If you installed PowerShell with Homebrew, uninstallation is easy:

```sh
brew cask uninstall powershell
```

If you installed PowerShell via direct download, PowerShell must be removed manually:

```sh
sudo rm -rf /usr/local/bin/pwsh /usr/local/microsoft/powershell
```

To remove the additional PowerShell paths, please see the [paths](#paths) section in this document
and remove the desired the paths using `sudo rm`.

> [!NOTE]
> This is not necessary if you installed with Homebrew.

## Paths

* `$PSHOME` is `/usr/local/microsoft/powershell/6.1.0/`
* User profiles will be read from `~/.config/powershell/profile.ps1`
* Default profiles will be read from `$PSHOME/profile.ps1`
* User modules will be read from `~/.local/share/powershell/Modules`
* Shared modules will be read from `/usr/local/share/powershell/Modules`
* Default modules will be read from `$PSHOME/Modules`
* PSReadline history will be recorded to `~/.local/share/powershell/PSReadLine/ConsoleHost_history.txt`

The profiles respect PowerShell's per-host configuration.
So the default host-specific profiles exists at `Microsoft.PowerShell_profile.ps1` in the same locations.

PowerShell respects the [XDG Base Directory Specification][xdg-bds] on macOS.

Because macOS is a derivation of BSD, the prefix `/usr/local` is used instead of `/opt`.
Thus, `$PSHOME` is `/usr/local/microsoft/powershell/6.1.0/`, and the symlink is placed at `/usr/local/bin/pwsh`.

## Additional Resources

* [Homebrew Web][brew]
* [Homebrew Github Repository][GitHub]
* [Homebrew-Cask][cask]

[brew]: http://brew.sh/
[Cask]: https://github.com/Homebrew/homebrew-cask
[cask-versions]: https://github.com/Homebrew/homebrew-cask-versions
[GitHub]: https://github.com/Homebrew
[releases]: https://github.com/PowerShell/PowerShell/releases/latest
[xdg-bds]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

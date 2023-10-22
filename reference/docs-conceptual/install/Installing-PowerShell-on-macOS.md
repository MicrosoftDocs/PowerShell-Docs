---
description: Information about installing PowerShell on macOS
ms.date: 10/12/2023
title: Installing PowerShell on macOS
---

# Installing PowerShell on macOS

PowerShell 7.0 or higher require macOS 10.13 and higher. All packages are available on our GitHub
[releases][10] page. After the package is installed, run `pwsh` from a terminal. Before installing,
check the list of [Supported versions][07] below.

> [!NOTE]
> PowerShell 7.3 is an in-place upgrade that removes previous versions of PowerShell 7. Preview
> versions of PowerShell can be installed side-by-side with other versions of PowerShell. If you
> need to run PowerShell 7.3 side-by-side with a previous version, reinstall the previous version
> using the [binary archive][05] method.

## Install the latest stable release of PowerShell

There are several ways to install PowerShell on macOS. Choose one of the following methods:

- Install using [Homebrew][11]. Homebrew is the preferred package manager for macOS.
- Install PowerShell via [Direct Download][05]
- Install from [binary archives][04].

If the `brew` command isn't found, you need to install Homebrew following [their instructions][11].

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Once `brew` is installed you can install PowerShell.

The following command installs the latest stable release of PowerShell:

```sh
brew install powershell/tap/powershell
```

Finally, verify that your install is working properly:

```sh
pwsh
```

When new versions of PowerShell are released, update Homebrew's formulae and upgrade PowerShell:

```sh
brew update
brew upgrade powershell
```

> [!NOTE]
> The commands above can be called from within a PowerShell (pwsh) host, but then the PowerShell
> shell must be exited and restarted to complete the upgrade and refresh the values shown in
> `$PSVersionTable`.

[brew]: https://brew.sh/

## Install the latest preview release of PowerShell

After you've installed Homebrew, you can install PowerShell.

```sh
brew install powershell/tap/powershell-preview
```

Run the following command to start the preview version of PowerShell:

```sh
pwsh-preview
```

When new versions of PowerShell are released, update Homebrew's formulae and upgrade PowerShell:

```sh
brew update
brew upgrade powershell-preview
```

> [!NOTE]
> The commands above can be called from within a PowerShell (pwsh) host, but then the PowerShell
> shell must be exited and restarted to complete the upgrade. and refresh the values shown in
> `$PSVersionTable`.

## Install the latest LTS release of PowerShell

```sh
brew install powershell/tap/powershell-lts
```

You can now verify your install

```sh
pwsh
```

When new versions of PowerShell are released, run the following command.

```sh
brew upgrade powershell-lts
```

> [!NOTE]
> Whether you use the cask or the tap method, when updating to a newer version of PowerShell, use
> the same method you used to initially install PowerShell. If you use a different method, opening a
> new pwsh session will continue to use the older version of PowerShell.
>
> If you do decide to use different methods, there are ways to correct the issue using the
> [Homebrew link method][12].

## Installation via Direct Download

Starting with version 7.2, PowerShell supports the Apple M1 processor. Download the install package
from the [releases][10] page onto your computer. The links to the current versions are:

- PowerShell 7.3.8
  - x64 processors - [powershell-7.3.8-osx-x64.pkg][22]
  - M1 processors - [powershell-7.3.8-osx-arm64.pkg][20]
- PowerShell 7.2.15 (LTS)
  - x64 processors - [powershell-7.2.15-osx-x64.pkg][18]
  - M1 processors - [powershell-7.2.15-osx-arm64.pkg][16]

You can double-click the file and follow the prompts, or install it from the terminal using the
following commands. Change the name of the file to match the file you downloaded.

```sh
sudo installer -pkg powershell-7.3.8-osx-x64.pkg -target /
```

If you are running on macOS Big Sur 11.5 or higher you may receive the following error message
when installing the package:

> "powershell-7.3.8-osx-x64.pkg" cannot be opened because Apple cannot check it for malicious
> software.

There are two ways to work around this issue:

Using the Finder

1. Find the package in Finder.
1. Control-click (click while pressing the <kbd>Ctrl</kbd> key) on the package.
1. Select **Open** from the context menu.

From the command line

1. Run `sudo xattr -rd com.apple.quarantine powershell-7.3.8-osx-x64.pkg`. If you are using
   PowerShell 7 or higher, you can use the `Unblock-File` cmdlet. Include the full path to the
   `.pkg` file.
1. Install the package as you normally would.

> [!NOTE]
> This is a known issue related to package notarization that will be addressed in the future.

## Install as a .NET Global tool

If you already have the [.NET Core SDK][02] installed, it's easy to install PowerShell as a
[.NET Global tool][03].

```
dotnet tool install --global PowerShell
```

The dotnet tool installer adds `~/.dotnet/tools` to your `PATH` environment variable. However, the
currently running shell doesn't have the updated `PATH`. You should be able to start PowerShell from
a new shell by typing `pwsh`.

## Binary Archives

PowerShell binary `tar.gz` archives are provided for the macOS platform to enable advanced
deployment scenarios. When you install using this method you must also manually install any
dependencies.

> [!NOTE]
> You can use this method to install any version of PowerShell including the latest:
>
> - Stable release: [https://aka.ms/powershell-release?tag=stable][10]
> - LTS release: [https://aka.ms/powershell-release?tag=lts][08]
> - Preview release: [https://aka.ms/powershell-release?tag=preview][09]

### Installing binary archives on macOS

Download the install package from the [releases][10] page onto your computer. The links to the
current versions are:

- PowerShell 7.3.8
  - x64 processors - [powershell-7.3.8-osx-x64.tar.gz][23]
  - M1 processors - [powershell-7.3.8-osx-arm64.tar.gz][21]
- PowerShell 7.2.15
  - x64 processors - [powershell-7.2.15-osx-x64.tar.gz][19]
  - M1 processors - [powershell-7.2.15-osx-arm64.tar.gz][17]

Use the following commands to install PowerShell from the binary archive. Change the download URL to
match the version you want to install.

```sh
# Download the powershell '.tar.gz' archive
curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.3.8/powershell-7.3.8-osx-x64.tar.gz

# Create the target folder where powershell is placed
sudo mkdir -p /usr/local/microsoft/powershell/7.3.8

# Expand powershell to the target folder
sudo tar zxf /tmp/powershell.tar.gz -C /usr/local/microsoft/powershell/7.3.8

# Set execute permissions
sudo chmod +x /usr/local/microsoft/powershell/7.3.8/pwsh

# Create the symbolic link that points to pwsh
sudo ln -s /usr/local/microsoft/powershell/7.3.8/pwsh /usr/local/bin/pwsh
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

To remove the additional PowerShell paths, refer to the [paths][06] section in this document and
remove the paths using `sudo rm`.

> [!NOTE]
> This isn't necessary if you installed with Homebrew.

## Paths

- `$PSHOME` is `/usr/local/microsoft/powershell/7.3.8/`
- User profiles are read from `~/.config/powershell/profile.ps1`
- Default profiles are read from `$PSHOME/profile.ps1`
- User modules are read from `~/.local/share/powershell/Modules`
- Shared modules are read from `/usr/local/share/powershell/Modules`
- Default modules are read from `$PSHOME/Modules`
- PSReadLine history are recorded to `~/.local/share/powershell/PSReadLine/ConsoleHost_history.txt`

The profiles respect PowerShell's per-host configuration. So the default host-specific profile
exists at `Microsoft.PowerShell_profile.ps1` in the same locations.

PowerShell respects the [XDG Base Directory Specification][24] on macOS.

Because macOS is a derivation of BSD, the prefix `/usr/local` is used instead of `/opt`. So,
`$PSHOME` is `/usr/local/microsoft/powershell/7.3.8/`, and the symbolic link is placed at
`/usr/local/bin/pwsh`.

## Supported versions

[!INCLUDE [macOS support](../../includes/macos-support.md)]

## Installation support

Microsoft supports the installation methods in this document. There may be other methods of
installation available from other sources. While those tools and methods may work, Microsoft can't
support those methods.

## Additional Resources

- [Homebrew Web][11]
- [Homebrew GitHub Repository][13]
- [Homebrew-Cask][14]

<!-- link references -->
[02]: /dotnet/core/sdk
[03]: /dotnet/core/tools/global-tools
[04]: #binary-archives
[05]: #installation-via-direct-download
[06]: #paths
[07]: #supported-versions
[08]: https://aka.ms/powershell-release?tag=lts
[09]: https://aka.ms/powershell-release?tag=preview
[10]: https://aka.ms/powershell-release?tag=stable
[11]: https://brew.sh/
[12]: https://docs.brew.sh/Manpage#link-ln-options-formula
[13]: https://github.com/Homebrew
[14]: https://github.com/Homebrew/homebrew-cask
[16]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.15/powershell-7.2.15-osx-arm64.pkg
[17]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.15/powershell-7.2.15-osx-arm64.tar.gz
[18]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.15/powershell-7.2.15-osx-x64.pkg
[19]: https://github.com/PowerShell/PowerShell/releases/download/v7.2.15/powershell-7.2.15-osx-x64.tar.gz
[20]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.8/powershell-7.3.8-osx-arm64.pkg
[21]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.8/powershell-7.3.8-osx-arm64.tar.gz
[22]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.8/powershell-7.3.8-osx-x64.pkg
[23]: https://github.com/PowerShell/PowerShell/releases/download/v7.3.8/powershell-7.3.8-osx-x64.tar.gz
[24]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

---
description: Information about installing PowerShell on macOS
ms.date: 07/03/2025
title: Installing PowerShell on macOS
---

# Installing PowerShell on macOS

PowerShell 7 or higher requires macOS 13 and higher. All packages are available on the GitHub
[releases][09] page for PowerShell. After the package is installed, run `pwsh` from a terminal.
Before installing, check the list of [Supported versions][06].

> [!NOTE]
> PowerShell 7.4 is an in-place upgrade that removes previous versions of PowerShell 7. You can
> install preview versions of PowerShell side-by-side with other versions of PowerShell. If you need
> to run PowerShell 7.4 side-by-side with a previous version, reinstall the previous version using
> the [binary archive][04] method.

[!INCLUDE [Latest version](../../includes/latest-install.md)]

## Install the latest stable release of PowerShell

There are several ways to install PowerShell on macOS. Choose one of the following methods:

- Install using [Homebrew][27]. Homebrew is the preferred package manager for macOS.
- Install via [Direct Download][04].
- Install as [a .NET Global tool][28].
- Install from [binary archives][03].

## Install using Homebrew

If the `brew` command isn't found, you need to install Homebrew following [their instructions][10].

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Once `brew` is installed, install PowerShell.

The following command installs the latest stable release of PowerShell:

```sh
brew install --cask powershell
```

Verify the installation is working correctly:

```sh
pwsh
```

When new versions of PowerShell are released, update Homebrew's formulae and upgrade PowerShell:

```sh
brew update
brew upgrade powershell
```

> [!NOTE]
> You can call the previous commands from within a PowerShell (`pwsh`) session, but then you must
> restart the PowerShell session to complete the upgrade and refresh the values shown in
> `$PSVersionTable`.

[brew]: https://brew.sh/

### Install the latest preview release of PowerShell

The following command installs the latest preview release of PowerShell:

```sh
brew install powershell/tap/powershell-preview
```

Run the following command to start the preview version of PowerShell:

```sh
pwsh-preview
```

When new preview versions of PowerShell are released, update Homebrew's formulae and upgrade to the
latest preview version of PowerShell:

```sh
brew update
brew upgrade powershell-preview
```

> [!NOTE]
> You can call the previous commands from within a PowerShell (`pwsh`) session, but then you must
> restart the PowerShell session to complete the upgrade and refresh the values shown in
> `$PSVersionTable`.

### Install the latest LTS release of PowerShell

The following command installs the latest LTS release of PowerShell:

```sh
brew install powershell/tap/powershell-lts
```

Verify your installation:

```sh
pwsh-lts
```

When new LTS versions of PowerShell are released, run the following commands to update Homebrew's
formulae and upgrade to the latest LTS version of PowerShell:

```sh
brew update
brew upgrade powershell-lts
```

> [!NOTE]
> When updating to a newer version of PowerShell, use the same method, cask or the tap, that you
> used to perform the initial install. If you use a different method, opening a new pwsh session
> continues to use the older version of PowerShell.
>
> If you decide to use different methods, there are ways to correct the issue using the
> [Homebrew link method][11].

## Installation via Direct Download

Starting with version 7.2, PowerShell supports the Apple M-series Arm-based processors. Download the
install package from the [releases][09] page onto your Mac. The links to the current versions are:

- PowerShell 7.5
  - Arm64 processors - [powershell-7.5.2-arm64.pkg][22]
  - x64 processors - [powershell-7.5.2-osx-x64.pkg][24]

- PowerShell 7.4
  - Arm64 processors - [powershell-7.4.10-osx-arm64.pkg][18]
  - x64 processors - [powershell-7.4.10-osx-x64.pkg][20]

There are two ways to install PowerShell using the Direct Download method.

### Using Finder

Install PowerShell using Finder:

1. Open Finder
1. Locate the downloaded package
1. Double-click the file
1. Follow the prompts

You might receive the following error message when installing the package:

> "powershell-7.5.2-osx-arm64.pkg" cannot be opened because Apple cannot check it for malicious
> software.

To work around this issue using Finder:

1. Locate the downloaded package in Finder
1. Control-click (click while pressing the <kbd>Control (or Ctrl)</kbd> key on the package
1. Select **Open** from the context menu

### Using Terminal

Install PowerShell from the terminal. Change the filename to match the package you downloaded.

```sh
sudo installer -pkg ./Downloads/powershell-7.5.2-osx-arm64.pkg -target /
```

You might receive the following error message when installing the package:

> "powershell-7.5.2-osx-arm64.pkg" cannot be opened because Apple cannot check it for malicious
> software.

There are a few different ways to work around this issue from the command line:

- Run the `installer` command with the **allowUntrusted** flag:

  ```sh
  `sudo installer -allowUntrusted -pkg ./Downloads/powershell-7.5.2-osx-arm64.pkg -target /`
  ```

- Or install the package as you normally would after running one of the following commands:

  - Run `sudo xattr -rd com.apple.quarantine ./Downloads/powershell-7.5.2-osx-arm64.pkg`.
  - Use the `Unblock-File` cmdlet if you're using PowerShell. Include the full path to the `.pkg`
    file.

## Install as a .NET Global tool

If you already have the [.NET Core SDK][01] installed, it's easy to install PowerShell as a
[.NET Global tool][02].

```sh
dotnet tool install --global PowerShell
```

The dotnet tool installer adds `~/.dotnet/tools` to your `PATH` environment variable. However, the
currently running shell doesn't have the updated `PATH`. Start PowerShell from a new shell by typing
`pwsh`.

## Binary archives

PowerShell binary `tar.gz` archives are provided for the macOS platform to enable advanced
deployment scenarios. When you install using this method, you must also manually install any
dependencies.

> [!NOTE]
> You can use this method to install any version of PowerShell including the latest:
>
> - Stable release: [https://aka.ms/powershell-release?tag=stable][09]
> - LTS release: [https://aka.ms/powershell-release?tag=lts][07]
> - Preview release: [https://aka.ms/powershell-release?tag=preview][08]

### Installing binary archives on macOS

Download the install package from the [releases][09] page onto your Mac. The links to the current
versions are:

- PowerShell 7.5-preview
  - Arm64 processors - [powershell-7.5.2-osx-arm64.tar.gz][23]
  - x64 processors - [powershell-7.5.2-osx-x64.tar.gz][25]

- PowerShell 7.4 (LTS)
  - Arm64 processors - [powershell-7.4.10-osx-arm64.tar.gz][19]
  - x64 processors - [powershell-7.4.10-osx-x64.tar.gz][21]

Use the following commands to install PowerShell from the binary archive. Change the download URL to
match the version you want to install.

```sh
# Download the powershell '.tar.gz' archive
curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.5.2/powershell-7.5.2-osx-arm64.tar.gz

# Create the target folder where powershell is placed
sudo mkdir -p /usr/local/microsoft/powershell/7

# Expand powershell to the target folder
sudo tar zxf /tmp/powershell.tar.gz -C /usr/local/microsoft/powershell/7

# Set execute permissions
sudo chmod +x /usr/local/microsoft/powershell/7/pwsh

# Create the symbolic link that points to pwsh
sudo ln -s /usr/local/microsoft/powershell/7/pwsh /usr/local/bin/pwsh
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

To remove the extra PowerShell paths, refer to the [paths][05] section in this document and remove
the paths using `sudo rm`.

> [!NOTE]
> This process isn't necessary if you installed with Homebrew.

## Paths

- `$PSHOME` is `/usr/local/microsoft/powershell/7`
  - The macOS install package creates a symbolic link, `/usr/local/bin/pwsh` that points to `pwsh`
    in the `$PSHOME` location.
- User profiles are read from `~/.config/powershell/profile.ps1`
- Default profiles are read from `$PSHOME/profile.ps1`
- User modules are read from `~/.local/share/powershell/Modules`
- Shared modules are read from `/usr/local/share/powershell/Modules`
- Default modules are read from `$PSHOME/Modules`
- PSReadLine history is recorded to `~/.local/share/powershell/PSReadLine/ConsoleHost_history.txt`

PowerShell respects the [XDG Base Directory Specification][26] on macOS.

## Supported versions

[!INCLUDE [macOS support](../../includes/macos-support.md)]

## Installation support

Microsoft supports the installation methods in this document. There might be other methods of
installation available from other sources. While those tools and methods might work, Microsoft can't
support those methods.

## Additional resources

- [Homebrew Web][10]
- [Homebrew GitHub Repository][12]
- [Homebrew-Cask][13]

<!-- link references -->
[01]: /dotnet/core/sdk
[02]: /dotnet/core/tools/global-tools
[03]: #binary-archives
[04]: #installation-via-direct-download
[05]: #paths
[06]: #supported-versions
[07]: https://aka.ms/powershell-release?tag=lts
[08]: https://aka.ms/powershell-release?tag=preview
[09]: https://aka.ms/powershell-release?tag=stable
[10]: https://brew.sh/
[11]: https://docs.brew.sh/Manpage#link-ln-options-formula
[12]: https://github.com/Homebrew
[13]: https://github.com/Homebrew/homebrew-cask
[18]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.10/powershell-7.4.10-osx-arm64.pkg
[19]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.10/powershell-7.4.10-osx-arm64.tar.gz
[20]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.10/powershell-7.4.10-osx-x64.pkg
[21]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.10/powershell-7.4.10-osx-x64.tar.gz
[22]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.2/powershell-7.5.2-osx-arm64.pkg
[23]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.2/powershell-7.5.2-osx-arm64.tar.gz
[24]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.2/powershell-7.5.2-osx-x64.pkg
[25]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.2/powershell-7.5.2-osx-x64.tar.gz
[26]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
[27]: #install-using-homebrew
[28]: #install-as-a-net-global-tool

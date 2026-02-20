---
description: How to install PowerShell on macOS
ms.date: 02/20/2026
title: Install PowerShell on macOS
---

# Install PowerShell on macOS

PowerShell 7 or higher requires macOS 13 and higher. All packages are available on the GitHub
[releases][11] page for PowerShell. After the package is installed, run `pwsh` from a terminal.
Before installing, check the list of [Supported versions][08].

Newer versions of PowerShell 7 replace existing previous versions of PowerShell 7. Preview versions
of PowerShell can be installed side-by-side with other versions of PowerShell. Newer preview
versions replace existing previous preview versions.If you need to run PowerShell 7.5 side-by-side
with a previous version, reinstall the previous version using the [binary archive][03] method.

[!INCLUDE [Latest version](../../includes/latest-install.md)]

## Install the latest stable release of PowerShell

There are several ways to install PowerShell on macOS. Choose one of the following methods:

- Install using [Homebrew][06]. Homebrew is the preferred package manager for macOS.
- Install via [Direct Download][05].
- Install as [a .NET Global tool][04].
- Install from [binary archives][03].

## Install using Homebrew

If the `brew` command isn't found, you need to install Homebrew following [their instructions][12].

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
> [Homebrew link method][13].

## Install the package via Direct Download

Starting with version 7.2, PowerShell supports the Apple M-series Arm-based processors. Download the
install package from the [releases][11] page onto your Mac. The links to the current versions are:

- PowerShell 7.4 (LTS)
  - Arm64 processors - [powershell-7.4.13-osx-arm64.pkg][16]
  - x64 processors - [powershell-7.4.13-osx-x64.pkg][18]
- PowerShell 7.5
  - Arm64 processors - [powershell-7.5.4-arm64.pkg][20]
  - x64 processors - [powershell-7.5.4-osx-x64.pkg][22]
- PowerShell 7.6-preview
  - Arm64 processors - [powershell-7.6.0-rc1-osx-arm64.pkg][24]
  - x64 processors - [powershell-7.6.0-rc1-osx-x64.pkg][26]

There are two ways to install PowerShell using the Direct Download method.

### Using Finder

Install PowerShell using Finder:

1. Open **Finder**
1. Locate the downloaded package
1. Double-click the file

   You will receive the following error message when installing the package:

   > "powershell-7.5.4-osx-arm64.pkg" Not Opened
   >
   > Apple could not verify "powershell-7.5.4-osx-arm64.pkg" is free from malware that may harm
   > your Mac or compromise your privacy.

1. Select the **Done** button to close the prompt.

This error message comes from the Gatekeeper feature of macOS. For more information, see
[Safely open apps on your Mac - Apple Support][29].

After you've tried to open the package, follow these steps:

1. Open **System Settings**.
1. Select **Privacy & Security** and scroll down to the **Security** section.
1. Select the **Open Anyway** button to confirm your intent to install PowerShell.
1. When the warning prompt reappears, select **Open Anyway**.
1. Enter username and password to allow the installation to proceed.

### Using Terminal

To install the PowerShell package from the command line, you must bypass the Gatekeeper checks. Use
one of the following methods to install the package:

- Run the `installer` command with the **allowUntrusted** flag:

  ```sh
  sudo installer -allowUntrusted -pkg ./Downloads/powershell-7.5.4-osx-arm64.pkg -target /
  ```

- Or install the package as you normally would after running one of the following commands:

  - Run `sudo xattr -rd com.apple.quarantine ./Downloads/powershell-7.5.4-osx-arm64.pkg`.
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
> - Stable release: [https://aka.ms/powershell-release?tag=stable][11]
> - LTS release: [https://aka.ms/powershell-release?tag=lts][09]
> - Preview release: [https://aka.ms/powershell-release?tag=preview][10]

### Install binary archives on macOS

Download the install package from the [releases][11] page onto your Mac. The links to the current
versions are:

- PowerShell 7.4 (LTS)
  - Arm64 processors - [powershell-7.4.13-osx-arm64.tar.gz][17]
  - x64 processors - [powershell-7.4.13-osx-x64.tar.gz][19]
- PowerShell 7.5
  - Arm64 processors - [powershell-7.5.4-osx-arm64.tar.gz][21]
  - x64 processors - [powershell-7.5.4-osx-x64.tar.gz][23]
- PowerShell 7.6-preview
  - Arm64 processors - [powershell-7.6.0-rc1-osx-arm64.tar.gz][25]
  - x64 processors - [powershell-7.6.0-rc1-osx-x64.tar.gz][27]

Use the following commands to install PowerShell from the binary archive. Change the download URL to
match the version you want to install.

```sh
# Download the powershell '.tar.gz' archive
curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/powershell-7.5.4-osx-arm64.tar.gz

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

To remove the extra PowerShell paths, refer to the [paths][07] section in this document and remove
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

PowerShell respects the [XDG Base Directory Specification][28] on macOS.

## Supported versions

[!INCLUDE [macOS support](../../includes/macos-support.md)]

## Installation support

Microsoft supports the installation methods in this document. There might be other methods of
installation available from other sources. While those tools and methods might work, Microsoft can't
support those methods.

## Additional resources

- [Homebrew Web][12]
- [Homebrew GitHub Repository][14]
- [Homebrew-Cask][15]

<!-- link references -->
[01]: /dotnet/core/sdk
[02]: /dotnet/core/tools/global-tools
[03]: #binary-archives
[04]: #install-as-a-net-global-tool
[05]: #install-the-package-via-direct-download
[06]: #install-using-homebrew
[07]: #paths
[08]: #supported-versions
[09]: https://aka.ms/powershell-release?tag=lts
[10]: https://aka.ms/powershell-release?tag=preview
[11]: https://aka.ms/powershell-release?tag=stable
[12]: https://brew.sh/
[13]: https://docs.brew.sh/Manpage#link-ln-options-formula
[14]: https://github.com/Homebrew
[15]: https://github.com/Homebrew/homebrew-cask
[16]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.13/powershell-7.4.13-osx-arm64.pkg
[17]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.13/powershell-7.4.13-osx-arm64.tar.gz
[18]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.13/powershell-7.4.13-osx-x64.pkg
[19]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.13/powershell-7.4.13-osx-x64.tar.gz
[20]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/powershell-7.5.4-osx-arm64.pkg
[21]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/powershell-7.5.4-osx-arm64.tar.gz
[22]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/powershell-7.5.4-osx-x64.pkg
[23]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/powershell-7.5.4-osx-x64.tar.gz
[24]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-rc1/powershell-7.6.0-rc1-osx-arm64.pkg
[25]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-rc1/powershell-7.6.0-rc1-osx-arm64.tar.gz
[26]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-rc1/powershell-7.6.0-rc1-osx-x64.pkg
[27]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-rc1/powershell-7.6.0-rc1-osx-x64.tar.gz
[28]: https://specifications.freedesktop.org/basedir/latest/
[29]: https://support.apple.com/102445

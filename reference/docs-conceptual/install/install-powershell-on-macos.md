---
description: How to install PowerShell on macOS
ms.date: 03/18/2026
title: Install PowerShell 7 on macOS
---

# Install PowerShell 7 on macOS

There are multiple package versions of PowerShell 7 that can be installed. This article focuses on
installing the latest stable release package. For more information about the package versions, see
the [PowerShell Support Lifecycle][19] article.

Newer versions of PowerShell 7 replace existing previous versions of PowerShell 7. Preview versions
of PowerShell can be installed side-by-side with other versions of PowerShell. Newer preview
versions replace existing previous preview versions. If you need to run PowerShell 7.5 side-by-side
with a previous version, reinstall the previous version using the binary archive method.

## Choose an installation method

There are several ways to install PowerShell on macOS.

### Manually download and install the package

Download the install package from the [releases][04] page. Select the package version you want to
install.

- PowerShell 7.6 (LTS)
  - Arm64 processors - [powershell-7.6.0-osx-arm64.pkg][13]
  - x64 processors - [powershell-7.6.0-osx-x64.pkg][15]
- PowerShell 7.5
  - Arm64 processors - [powershell-7.5.5-osx-arm64.pkg][09]
  - x64 processors - [powershell-7.5.5-osx-x64.pkg][11]
- PowerShell 7.4 (LTS)
  - Arm64 processors - [powershell-7.4.14-osx-arm64.pkg][05]
  - x64 processors - [powershell-7.4.14-osx-x64.pkg][07]

There are two ways to install PowerShell using the downloaded package.

#### Install the package using Finder

Install PowerShell using Finder:

1. Open **Finder**
1. Locate the downloaded package
1. Double-click the file

   You will receive the following error message when installing the package:

   > "powershell-7.5.5-osx-arm64.pkg" Not Opened
   >
   > Apple could not verify "powershell-7.5.5-osx-arm64.pkg" is free from malware that may harm
   > your Mac or compromise your privacy.

1. Select the **Done** button to close the prompt.

This error message comes from the Gatekeeper feature of macOS. For more information, see
[Safely open apps on your Mac - Apple Support][18].

After you've tried to open the package, follow these steps:

1. Open **System Settings**.
1. Select **Privacy & Security** and scroll down to the **Security** section.
1. Select the **Open Anyway** button to confirm your intent to install PowerShell.
1. When the warning prompt reappears, select **Open Anyway**.
1. Enter username and password to allow the installation to proceed.

#### Install the package from a command shell

To install the PowerShell package from the command line, you must bypass the Gatekeeper checks. Use
one of the following methods to install the package:

- Run the `installer` command with the **allowUntrusted** flag:

  ```sh
  sudo installer -allowUntrusted -pkg ./Downloads/powershell-7.5.5-osx-arm64.pkg -target /
  ```

- Or install the package as you normally would after running one of the following commands:

  - Run `sudo xattr -rd com.apple.quarantine ./Downloads/powershell-7.5.5-osx-arm64.pkg`.
  - Use the `Unblock-File` cmdlet if you're using PowerShell. Include the full path to the `.pkg`
    file.

### Install as a .NET Global tool

If you already have the [.NET Core SDK][01] installed, you can use the [.NET Global tool][02] to
install PowerShell 7.

```sh
dotnet tool install --global PowerShell
```

The dotnet tool installer adds `~/.dotnet/tools` to your `PATH` environment variable. However, the
currently running shell doesn't have the updated `PATH`. Start PowerShell from a new shell by typing
`pwsh`.

### Install PowerShell 7 from a binary archive

PowerShell binary `tar.gz` archives are provided for the macOS platform to enable advanced
deployment scenarios. When you install using this method, you must also manually install any
dependencies.

Download the install package from the [releases][04] page onto your Mac.  Select the archive version
you want to install.

- PowerShell 7.6 (LTS)
  - Arm64 processors - [powershell-7.6.0-osx-arm64.tar.gz][14]
  - x64 processors - [powershell-7.6.0-osx-x64.tar.gz][16]
- PowerShell 7.5
  - Arm64 processors - [powershell-7.5.5-osx-arm64.tar.gz][10]
  - x64 processors - [powershell-7.5.5-osx-x64.tar.gz][12]
- PowerShell 7.4 (LTS)
  - Arm64 processors - [powershell-7.4.14-osx-arm64.tar.gz][06]
  - x64 processors - [powershell-7.4.14-osx-x64.tar.gz][08]

Use the following commands to install PowerShell from the binary archive. Change the download URL to
match the version you want to install.

```sh
# Download the powershell '.tar.gz' archive
curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell-7.6.0-osx-arm64.tar.gz

# Create the target folder where powershell is placed
sudo mkdir -p /usr/local/microsoft/powershell/7

# Expand powershell to the target folder
sudo tar zxf /tmp/powershell.tar.gz -C /usr/local/microsoft/powershell/7

# Set execute permissions
sudo chmod +x /usr/local/microsoft/powershell/7/pwsh

# Create the symbolic link that points to pwsh
sudo ln -s /usr/local/microsoft/powershell/7/pwsh /usr/local/bin/pwsh
```

## Start PowerShell 7

After the package is installed, run `pwsh` from a terminal. If you have installed a Preview package,
run `pwsh-preview`.

- The location of `$PSHOME` varies based on the package you installed.
  - For Stable and LTS packages: `/usr/local/microsoft/powershell/7/`
  - For Preview packages: `/usr/local/microsoft/powershell/7-preview/`
  - The macOS install package creates a symbolic link, `/usr/local/bin/pwsh` that points to `pwsh`
    in the `$PSHOME` location.
- User profiles are read from `~/.config/powershell/profile.ps1`
- Default profiles are read from `$PSHOME/profile.ps1`
- User modules are read from `~/.local/share/powershell/Modules`
- Shared modules are read from `/usr/local/share/powershell/Modules`
- Default modules are read from `$PSHOME/Modules`
- PSReadLine history is recorded to `~/.local/share/powershell/PSReadLine/ConsoleHost_history.txt`

PowerShell respects the [XDG Base Directory Specification][17] on macOS.

## Update PowerShell 7

To update PowerShell, download the new version of the package or binary archive and install it.

## Uninstall PowerShell 7

To uninstall PowerShell you need to delete the application folder and other support files. The
following command removes the symbolic link and PowerShell files.

```sh
sudo rm -rf /usr/local/bin/pwsh /usr/local/microsoft/powershell
```

Use `sudo rm` to remove any other remaining PowerShell files and folders.

## Supported versions of macOS

[!INCLUDE [macOS support](../../includes/macos-support.md)]

## Supported installation methods

Microsoft supports the installation methods in this document. There may be other third-party methods
of installation available from other sources. While those tools and methods may work, Microsoft
can't support those methods. For more information, see [Alternate ways to install PowerShell][03].

<!-- link references -->
[01]: /dotnet/core/sdk
[02]: /dotnet/core/tools/global-tools
[03]: alternate-install-methods.md
[04]: https://aka.ms/powershell-release?tag=stable
[05]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.14/powershell-7.4.14-osx-arm64.pkg
[06]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.14/powershell-7.4.14-osx-arm64.tar.gz
[07]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.14/powershell-7.4.14-osx-x64.pkg
[08]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.14/powershell-7.4.14-osx-x64.tar.gz
[09]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.5/powershell-7.5.5-osx-arm64.pkg
[10]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.5/powershell-7.5.5-osx-arm64.tar.gz
[11]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.5/powershell-7.5.5-osx-x64.pkg
[12]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.5/powershell-7.5.5-osx-x64.tar.gz
[13]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell-7.6.0-osx-arm64.pkg
[14]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell-7.6.0-osx-arm64.tar.gz
[15]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell-7.6.0-osx-x64.pkg
[16]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0/powershell-7.6.0-osx-x64.tar.gz
[17]: https://specifications.freedesktop.org/basedir/latest/
[18]: https://support.apple.com/102445
[19]: PowerShell-Support-Lifecycle.md

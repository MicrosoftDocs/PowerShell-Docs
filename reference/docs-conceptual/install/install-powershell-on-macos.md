---
description: How to install PowerShell on macOS
ms.date: 09/22/2026
title: Install PowerShell 7 on macOS
---

# Install PowerShell 7 on macOS

There are multiple package versions of PowerShell 7 that can be installed. This article focuses on
installing the latest stable release package. For more information about the package versions, see
the [PowerShell Support Lifecycle][25] article.

Newer versions of PowerShell 7 replace existing previous versions of PowerShell 7. Preview versions
of PowerShell can be installed side-by-side with other versions of PowerShell. Newer preview
versions replace existing previous preview versions. If you need to run PowerShell 7 side-by-side
with a previous version, reinstall the previous version using the binary archive method.

## Choose an installation method

There are several ways to install PowerShell on macOS. Choose one:

- [Download and install the package file][03] - this is the preferred method for most users
- [Install as a .NET Global tool][04] - this method is useful developers that already have the .NET
  Core SDK installed
- [Install from a binary archive][05] - this method is useful for advanced users who need more
  control over the installation
- If you previously installed PowerShell using Homebrew, see _Install on macOS using Homebrew_ in
  [Alternate ways to install PowerShell][06].

### Download and install the package file

Beginning with the May 2026 releases of PowerShell, the macOS PKG package is notarized and signed by
Microsoft. To install the package, download the PKG file and open it.

1. Download the install package from the [releases][07] page. Select the package version you want to
   install.

   - PowerShell 7.7-preview
     - Arm64 processors - [powershell-7.7.0-preview.4-osx-arm64.pkg][20]
     - x64 processors - [powershell-7.7.0-preview.4-osx-x64.pkg][22]
   - PowerShell 7.6 (LTS)
     - Arm64 processors - [powershell-7.6.6-osx-arm64.pkg][16]
     - x64 processors - [powershell-7.6.6-osx-x64.pkg][18]
   - PowerShell 7.5
     - Arm64 processors - [powershell-7.5.11-osx-arm64.pkg][12]
     - x64 processors - [powershell-7.5.11-osx-x64.pkg][14]
   - PowerShell 7.4 (LTS)
     - Arm64 processors - [powershell-7.4.20-osx-arm64.pkg][08]
     - x64 processors - [powershell-7.4.20-osx-x64.pkg][10]

   > [!NOTE]
   > Beginning with macOS 27 (Golden Gate), macOS only runs on Apple Silicon (Arm64) processors.

1. Open **Finder**
1. Locate the downloaded package
1. Double-click the file

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

Download the install package from the [releases][07] page. Select the archive version you want to
install.

- PowerShell 7.7-preview
  - Arm64 processors - [powershell-7.7.0-preview.4-osx-arm64.tar.gz][21]
  - x64 processors - [powershell-7.7.0-preview.4-osx-x64.tar.gz][23]
- PowerShell 7.6 (LTS)
  - Arm64 processors - [powershell-7.6.6-osx-arm64.tar.gz][17]
  - x64 processors - [powershell-7.6.6-osx-x64.tar.gz][19]
- PowerShell 7.5
  - Arm64 processors - [powershell-7.5.11-osx-arm64.tar.gz][13]
  - x64 processors - [powershell-7.5.11-osx-x64.tar.gz][15]
- PowerShell 7.4 (LTS)
  - Arm64 processors - [powershell-7.4.20-osx-arm64.tar.gz][09]
  - x64 processors - [powershell-7.4.20-osx-x64.tar.gz][11]

Use the following commands to install PowerShell from the binary archive. Change the download URL to
match the version you want to install.

```sh
# Download the powershell '.tar.gz' archive
curl -L -o /tmp/powershell.tar.gz https://github.com/PowerShell/PowerShell/releases/download/v7.6.6/powershell-7.6.6-osx-arm64.tar.gz

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

PowerShell respects the [XDG Base Directory Specification][24] on macOS.

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
can't support those methods. For more information, see [Alternate ways to install PowerShell][06].

<!-- link references -->
[01]: /dotnet/core/sdk
[02]: /dotnet/core/tools/global-tools
[03]: #download-and-install-the-package-file
[04]: #install-as-a-net-global-tool
[05]: #install-powershell-7-from-a-binary-archive
[06]: alternate-install-methods.md#install-on-macos-using-homebrew
[07]: https://aka.ms/powershell-release?tag=stable
[08]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.20/powershell-7.4.20-osx-arm64.pkg
[09]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.20/powershell-7.4.20-osx-arm64.tar.gz
[10]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.20/powershell-7.4.20-osx-x64.pkg
[11]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.20/powershell-7.4.20-osx-x64.tar.gz
[12]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.11/powershell-7.5.11-osx-arm64.pkg
[13]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.11/powershell-7.5.11-osx-arm64.tar.gz
[14]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.11/powershell-7.5.11-osx-x64.pkg
[15]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.11/powershell-7.5.11-osx-x64.tar.gz
[16]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.6/powershell-7.6.6-osx-arm64.pkg
[17]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.6/powershell-7.6.6-osx-arm64.tar.gz
[18]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.6/powershell-7.6.6-osx-x64.pkg
[19]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.6/powershell-7.6.6-osx-x64.tar.gz
[20]: https://github.com/PowerShell/PowerShell/releases/download/v7.7.0-preview.4/powershell-7.7.0-preview.4-osx-arm64.pkg
[21]: https://github.com/PowerShell/PowerShell/releases/download/v7.7.0-preview.4/powershell-7.7.0-preview.4-osx-arm64.tar.gz
[22]: https://github.com/PowerShell/PowerShell/releases/download/v7.7.0-preview.4/powershell-7.7.0-preview.4-osx-x64.pkg
[23]: https://github.com/PowerShell/PowerShell/releases/download/v7.7.0-preview.4/powershell-7.7.0-preview.4-osx-x64.tar.gz
[24]: https://specifications.freedesktop.org/basedir/latest/
[25]: PowerShell-Support-Lifecycle.md

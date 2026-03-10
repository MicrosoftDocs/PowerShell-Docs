---
description: How to install PowerShell on macOS
ms.date: 03/06/2026
title: Install PowerShell 7 on macOS
---

# Install PowerShell 7 on macOS

There are multiple package versions of PowerShell 7 that can be installed. This article focuses on
installing the latest stable release package. For more information about the package versions, see
the [PowerShell Support Lifecycle][22] article.

Newer versions of PowerShell 7 replace existing previous versions of PowerShell 7. Preview versions
of PowerShell can be installed side-by-side with other versions of PowerShell. Newer preview
versions replace existing previous preview versions. If you need to run PowerShell 7.5 side-by-side
with a previous version, reinstall the previous version using the binary archive method.

## Choose an installation method

There are several ways to install PowerShell on macOS. Homebrew is the preferred installation
method.

### Install PowerShell 7 using Homebrew

Homebrew is the preferred package manager for macOS. If the `brew` command isn't found, you need to
install Homebrew following [their instructions][04].

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Once `brew` is installed, install PowerShell.

The following command installs the latest stable release of PowerShell:

```sh
brew install powershell
```

If you want the LTS or Preview version of PowerShell, you can install it using Homebrew's tap
method. Select tap version you want to install:

- `powershell/tap/powershell-lts`
- `powershell/tap/powershell-preview`

For example, use the following command to install the Preview release:

```sh
brew install powershell/tap/powershell-preview
```

### Manually download and install the package

Download the install package from the [releases][03] page. Select the package version you want to
install.

- PowerShell 7.5
  - Arm64 processors - [powershell-7.5.4-arm64.pkg][12]
  - x64 processors - [powershell-7.5.4-osx-x64.pkg][14]
- PowerShell 7.4 (LTS)
  - Arm64 processors - [powershell-7.4.13-osx-arm64.pkg][08]
  - x64 processors - [powershell-7.4.13-osx-x64.pkg][10]
- PowerShell 7.6-preview
  - Arm64 processors - [powershell-7.6.0-rc1-osx-arm64.pkg][16]
  - x64 processors - [powershell-7.6.0-rc1-osx-x64.pkg][18]

There are two ways to install PowerShell using the downloaded package.

#### Install the package using Finder

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
[Safely open apps on your Mac - Apple Support][21].

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
  sudo installer -allowUntrusted -pkg ./Downloads/powershell-7.5.4-osx-arm64.pkg -target /
  ```

- Or install the package as you normally would after running one of the following commands:

  - Run `sudo xattr -rd com.apple.quarantine ./Downloads/powershell-7.5.4-osx-arm64.pkg`.
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

Download the install package from the [releases][03] page onto your Mac.  Select the archive version
you want to install.

- PowerShell 7.4 (LTS)
  - Arm64 processors - [powershell-7.4.13-osx-arm64.tar.gz][09]
  - x64 processors - [powershell-7.4.13-osx-x64.tar.gz][11]
- PowerShell 7.5
  - Arm64 processors - [powershell-7.5.4-osx-arm64.tar.gz][13]
  - x64 processors - [powershell-7.5.4-osx-x64.tar.gz][15]
- PowerShell 7.6-preview
  - Arm64 processors - [powershell-7.6.0-rc1-osx-arm64.tar.gz][17]
  - x64 processors - [powershell-7.6.0-rc1-osx-x64.tar.gz][19]

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

PowerShell respects the [XDG Base Directory Specification][20] on macOS.

## Update PowerShell 7

Run the following commands to update the installed version of PowerShell to the latest release.

```sh

brew update
brew upgrade powershell
```

> [!NOTE]
> When updating to a newer version of PowerShell, use the same method, cask or the tap, that you
> used to perform the initial install. If you use a different method, opening a new pwsh session
> continues to use the older version of PowerShell.
>
> If you decide to use different methods, there are ways to correct the issue using the
> [Homebrew link method][05].

## Uninstall PowerShell 7

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

## Supported versions of macOS

[!INCLUDE [macOS support](../../includes/macos-support.md)]

## Supported installation methods

Microsoft supports the installation methods in this document. There may be other third-party methods
of installation available from other sources. While those tools and methods may work, Microsoft
can't support those methods.

## Additional resources

- [Homebrew Web][04]
- [Homebrew GitHub Repository][06]
- [Homebrew-Cask][07]

<!-- link references -->
[01]: /dotnet/core/sdk
[02]: /dotnet/core/tools/global-tools
[03]: https://aka.ms/powershell-release?tag=stable
[04]: https://brew.sh/
[05]: https://docs.brew.sh/Manpage#link-ln-options-formula
[06]: https://github.com/Homebrew
[07]: https://github.com/Homebrew/homebrew-cask
[08]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.13/powershell-7.4.13-osx-arm64.pkg
[09]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.13/powershell-7.4.13-osx-arm64.tar.gz
[10]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.13/powershell-7.4.13-osx-x64.pkg
[11]: https://github.com/PowerShell/PowerShell/releases/download/v7.4.13/powershell-7.4.13-osx-x64.tar.gz
[12]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/powershell-7.5.4-osx-arm64.pkg
[13]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/powershell-7.5.4-osx-arm64.tar.gz
[14]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/powershell-7.5.4-osx-x64.pkg
[15]: https://github.com/PowerShell/PowerShell/releases/download/v7.5.4/powershell-7.5.4-osx-x64.tar.gz
[16]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-rc1/powershell-7.6.0-rc1-osx-arm64.pkg
[17]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-rc1/powershell-7.6.0-rc1-osx-arm64.tar.gz
[18]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-rc1/powershell-7.6.0-rc1-osx-x64.pkg
[19]: https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-rc1/powershell-7.6.0-rc1-osx-x64.tar.gz
[20]: https://specifications.freedesktop.org/basedir/latest/
[21]: https://support.apple.com/102445
[22]: PowerShell-Support-Lifecycle.md

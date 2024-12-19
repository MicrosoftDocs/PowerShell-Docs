---
description: This article lists the Linux distributions and package managers that are supported for installing PowerShell.
ms.date: 01/09/2023
title: Install PowerShell on Linux
---
# Install PowerShell on Linux

PowerShell can be installed on several different Linux distributions. Most Linux platforms and
distributions have a major release each year, and provide a package manager that's used to install
PowerShell. PowerShell can be installed on some distributions of Linux that aren't supported by
Microsoft. In those cases, you may find support from the community for PowerShell on those
platforms.

For more information, see the [PowerShell Support Lifecycle][05] documentation.

This article lists the supported Linux distributions and package managers. All PowerShell releases
remain supported until either the version of PowerShell or the version of the Linux distribution
reaches end-of-support.

For the best compatibility, choose a long-term release (LTS) version.

## Alpine

[!INCLUDE [Alpine support](../../includes/alpine-support.md)]

For more information, see [Install PowerShell on Alpine][13].

## Debian

Debian uses APT (Advanced Package Tool) as a package manager.

[!INCLUDE [Debian support](../../includes/debian-support.md)]

For more information, see [Install PowerShell on Debian][14].

## Red Hat Enterprise Linux (RHEL)

RHEL 7 uses yum and RHEL 8 uses the dnf package manager.

[!INCLUDE [RHEL support](../../includes/rhel-support.md)]

For more information, see [Install PowerShell on RHEL][17].

## Ubuntu

Ubuntu uses APT (Advanced Package Tool) as a package manager.

[!INCLUDE [Ubuntu support](../../includes/ubuntu-support.md)]

For more information, see [Install PowerShell on Ubuntu][18].

## Automated Installation Script
The following script automatically detects your Linux distribution, architecture, and installs the latest stable version of PowerShell. It includes:
- Automatic OS and architecture detection
- Latest stable PowerShell version detection
- Interactive prompts for version confirmation
- Comprehensive error handling and logging
- Support for Ubuntu, Debian, RHEL, CentOS, and Fedora
- Support for AMD64 and ARM64 architectures

>[!NOTE] 
>Save this script as `linux_autodetect_install.sh` and enable execution with `chmod +x linux_autodetect_install.sh`

[Download linux_autodetect_install.sh](linux_autodetect_install.sh)

<details>
<summary>Click to view installation script</summary>

```bash
#!/bin/bash

# PowerShell Installation Script for Linux
# Description: Automatically detects system type and installs the latest stable PowerShell release
# Features:
#   - OS and architecture detection
#   - Latest stable version detection
#   - Interactive installation
#   - Comprehensive error handling
#   - Support for major Linux distributions
# Author: Microsoft Corporation
# License: MIT

set -e

# Constants
TEMP_DIR="/tmp"
LOG_PREFIX="[PowerShell Install]"

# Logging function with standardized format
log() {
    local level="$1"
    local message="$2"
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] ${LOG_PREFIX} ${level}: ${message}"
}

# Error handling function
handle_error() {
    local exit_code=$?
    log "ERROR" "An error occurred on line $1"
    exit "$exit_code"
}

# Set up error handling
trap 'handle_error $LINENO' ERR

# System detection functions
get_os_info() {
    if [ -f /etc/os-release ]; then
        # Load OS information
        . /etc/os-release
        OS_NAME="${ID}"
        OS_VERSION="${VERSION_ID}"
        OS_PRETTY_NAME="${PRETTY_NAME}"
    else
        log "ERROR" "Cannot detect OS information"
        exit 1
    }
}

get_architecture() {
    local arch
    arch=$(uname -m)
    case $arch in
        x86_64)
            ARCH="amd64"
            ;;
        aarch64)
            ARCH="arm64"
            ;;
        *)
            log "ERROR" "Unsupported architecture: $arch"
            exit 1
            ;;
    esac
}

setup_package_manager() {
    case $OS_NAME in
        ubuntu|debian)
            PKG_MGR="apt"
            PKG_FORMAT="deb"
            INSTALL_CMD="sudo dpkg -i"
            DEP_CMD="sudo apt-get install -f -y"
            ;;
        rhel|centos|fedora)
            PKG_MGR="dnf"
            PKG_FORMAT="rpm"
            INSTALL_CMD="sudo rpm -i"
            DEP_CMD="sudo dnf install -y"
            ;;
        *)
            log "ERROR" "Unsupported distribution: $OS_NAME"
            exit 1
            ;;
    esac
}

get_download_url() {
    local ps_version_url
    local pattern
    
    case $OS_NAME in
        ubuntu|debian)
            pattern="powershell_.*${ARCH}.deb$"
            ;;
        rhel|centos|fedora)
            pattern="powershell-.*${ARCH}.rpm$"
            ;;
    esac

    ps_version_url=$(curl -s https://api.github.com/repos/PowerShell/PowerShell/releases |
        jq -r --arg pattern "$pattern" '
        [.[] | select(.prerelease == false)] |
        sort_by(.published_at) |
        reverse |
        .[0].assets[] |
        select(.name | test($pattern)) |
        .browser_download_url' |
        head -n 1)

    if [ -z "$ps_version_url" ] || [[ "$ps_version_url" == *"hashes.sha256"* ]]; then
        log "ERROR" "Failed to find PowerShell package for $OS_NAME ($ARCH)"
        log "DEBUG" "Pattern used: $pattern"
        exit 1
    fi

    echo "$ps_version_url"
}

# Main installation logic
main() {
    log "INFO" "Starting PowerShell installation"

    # Detect system information
    log "INFO" "Detecting system information"
    get_os_info
    get_architecture
    setup_package_manager

    log "INFO" "Detected: $OS_PRETTY_NAME ($ARCH)"

    # Check for sudo privileges
    if ! sudo -v; then
        log "ERROR" "This script requires sudo privileges"
        exit 1
    fi

    # Update and install dependencies
    log "INFO" "Installing prerequisites"
    case $PKG_MGR in
        apt)
            sudo apt-get update
            sudo apt-get install -y curl jq wget
            ;;
        dnf)
            sudo dnf check-update
            sudo dnf install -y curl jq wget
            ;;
    esac

    # Check existing installation
    if command -v pwsh &>/dev/null; then
        log "INFO" "PowerShell is already installed:"
        pwsh --version
        read -p "Continue with new installation? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log "INFO" "Installation cancelled by user"
            exit 0
        fi
    fi

    # Get appropriate download URL
    PS_VERSION_URL=$(get_download_url)
    if [[ "$PS_VERSION_URL" == "" ]]; then
        log "ERROR" "Could not determine download URL"
        exit 1
    fi
    
    VERSION=$(echo "$PS_VERSION_URL" | grep -Po '(?<=v)[0-9]+\.[0-9]+\.[0-9]+' || echo "unknown")

    # Display version information
    log "INFO" "Found PowerShell version: $VERSION"
    printf "\n%-50s %-15s\n" "URL" "VERSION"
    printf "%-50s %-15s\n" "$PS_VERSION_URL" "$VERSION"

    # Confirm installation
    read -p "Continue with this version? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log "INFO" "Installation cancelled by user"
        exit 0
    fi

    # Download and install
    local temp_pkg="${TEMP_DIR}/powershell_${VERSION}_${ARCH}.${PKG_FORMAT}"
    log "INFO" "Downloading PowerShell package"
```

## Community supported distributions

PowerShell can be installed on many distributions of Linux that aren't supported by Microsoft. In
those cases, you may find support from the community for PowerShell on those platforms

To be supported by Microsoft, the Linux distribution must meet the following criteria:

- The version and architecture of the distribution is supported by .NET Core.
- The version of the distribution is supported for at least one year.
- The version of the distribution isn't an interim release or equivalent.
- The PowerShell team has tested the version of the distribution.

For more information, see [Community support for PowerShell on Linux][06].

## Alternate installation methods

There are three other ways to install PowerShell on Linux, including Linux distributions that aren't
officially supported. You can try to install PowerShell using the PowerShell Snap Package. You can
also try deploying PowerShell binaries directly using the Linux `tar.gz` package. For more
information, see [Alternate ways to install PowerShell on Linux][15].

<!-- link references -->
[05]: ../PowerShell-Support-Lifecycle.md
[06]: community-support.md
[13]: install-alpine.md
[14]: install-debian.md
[15]: install-other-linux.md
[17]: install-rhel.md
[18]: install-ubuntu.md

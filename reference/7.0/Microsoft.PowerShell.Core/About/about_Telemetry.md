---
description: Describes the telemetry collected in PowerShell and how to opt-out.
Locale: en-US
ms.date: 09/30/2021
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_telemetry?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Telemetry
---
# about_Telemetry

## Short description

Describes the telemetry collected in PowerShell and how to opt-out.

## Long description

PowerShell sends basic telemetry data to Microsoft. This data allows us to
better understand the environments where PowerShell is used and enables us to
prioritize new features and fixes. The telemetry is includes anonymized
information about the host running PowerShell, and information about how
PowerShell is used.

The host-based telemetry data includes:

- OS name
- OS version
- PowerShell version
- The PowerShell distribution channel
- The version of the Application Insights SDK used by PowerShell
- The geographic location of the host, based on the IP address

> [!NOTE]
> Application Insights uses the hosts IP address to determine the geographic location. The IP
> address is never included in the telemetry data or stored in the database.

The following PowerShell activities are recorded:

- Count of PowerShell Starts by type (API vs console)
- Count of unique PowerShell usage
- Count of the following execution types:
  - Application (native commands)
  - ExternalScript
  - Script
  - Function
  - Cmdlet
- Count of enabled Microsoft owned experimental features or experimental
  features shipped with PowerShell
- Count of hosted sessions
- Count of Microsoft owned modules loaded

To opt-out of this telemetry, set the environment variable
`$env:POWERSHELL_TELEMETRY_OPTOUT` to `true`, `yes`, or `1`.

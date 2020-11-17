---
description: Describes the telemetry collected in PowerShell and how to opt-out.
Locale: en-US
ms.date: 08/09/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_telemetry?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Telemetry
---
# About Telemetry

## SHORT DESCRIPTION

Describes the telemetry collected in PowerShell and how to opt-out.

## LONG DESCRIPTION

PowerShell sends basic telemetry data to Microsoft.
This data allows us to better understand the environments where PowerShell is used and enables us to prioritize new features and fixes.
The following telemetry points are recorded:

- Count of PowerShell Starts by type (API vs console)
- Count of unique PowerShell usage
- Count of the following execution types:
  - Application (native commands)
  - ExternalScript
  - Script
  - Function
  - Cmdlet
- Count of enabled Microsoft owned experimental features or experimental features shipped with PowerShell
- Count of hosted sessions
- Count of Microsoft owned modules loaded

This data includes the OS name, OS version, the PowerShell version, and the distribution channel.

To opt-out of this telemetry, set the environment variable POWERSHELL_TELEMETRY_OPTOUT to true, yes, or 1.


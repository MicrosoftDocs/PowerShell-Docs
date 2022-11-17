---
description: Describes the telemetry collected in PowerShell and how to opt-out.
Locale: en-US
ms.date: 11/17/2022
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_telemetry?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about Telemetry
---
# about_Telemetry

## Short description

Describes the telemetry collected in PowerShell and how to opt-out.

## Long description

PowerShell sends basic telemetry data to Microsoft using Application Insights.
This data allows us to better understand the environments where PowerShell is
used and enables us to prioritize new features and fixes. The telemetry
includes anonymized information about the host running PowerShell, and
information about how PowerShell is used.

PowerShell sends the following information at startup:

- The manufacturer, name, and version of the operating system
- The version of PowerShell
- The version of the Application Insights SDK used by PowerShell
- The geographic location of the host, based on the IP address
- A randomly generated GUID representing the user running the instance
- A randomly generated GUID representing the session instance

Startup telemetry data is only collected when starting the `pwsh` executable.
This information isn't sent if the PowerShell engine is embedded in some other
host application.

> [!NOTE]
> Application Insights uses the hosts IP Address to determine the geographic
> location. The IP Address is never included in the telemetry data or stored in
> the database. For more information, see
> [Geolocation and IP address handling][02].

PowerShell sends the following information during the session:

- The count of calls to the `PowerShell.Create()` API
- The names of Microsoft-owned modules loaded
- The names of enabled experimental features
- The count of remote session open operations

This information is sent periodically during the lifetime of the session. This
information is sent regardless of the host application.

To opt-out of this telemetry, set the environment variable
`$env:POWERSHELL_TELEMETRY_OPTOUT` to `true`, `yes`, or `1`.

For more information about these environment variables, see
[about_Environment_Variables][01].

<!-- link references -->
[01]: about_environment_variables.md#powershell-environment-variables
[02]: /azure/azure-monitor/app/ip-collection?tabs=net

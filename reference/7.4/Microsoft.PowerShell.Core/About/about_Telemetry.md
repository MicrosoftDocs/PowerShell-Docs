---
description: Describes the telemetry collected in PowerShell and how to opt-out.
Locale: en-US
ms.date: 04/22/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_telemetry?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Telemetry
---
# about_Telemetry

## Short description

Describes the telemetry collected in PowerShell and how to opt-out.

## Long description

PowerShell sends basic telemetry data to Microsoft using Application Insights.
This data allows us to better understand the environments using PowerShell and
enables us to prioritize new features and fixes. PowerShell anonymizes the
telemetry information before sending.

PowerShell sends the following information at startup:

- The manufacturer, name, and version of the operating system
- The version of PowerShell
- The value of the **POWERSHELL_DISTRIBUTION_CHANNEL** environment variable
- The version of the Application Insights SDK used by PowerShell
- The geographic location of the host, based on the IP address
- The parameters passed to pwsh without the parameter values
- The Execution Policy setting of the current session
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
- The names and versions of Microsoft-owned modules imported
- The count of imported modules that have the `CrescendoBuilt` tag
- The names of enabled experimental features
- The names of disabled experimental features
- Value of `$PSNativeCommandUseErrorActionPreference` preference variable,
  either `true`, `false` or `unset`
- The count of remote session open operations

PowerShell sends this information periodically during the lifetime of the
session for all host applications.

To opt-out of this telemetry, set the environment variable
`$env:POWERSHELL_TELEMETRY_OPTOUT` to `true`, `yes`, or `1`. For this
environment variable to have effect, it must be set before starting the
PowerShell process. For more information, see [about_Environment_Variables][01].

The `$env:POWERSHELL_DISTRIBUTION_CHANNEL` environment variable is set by the
installer packages to record the method and source of installation for
PowerShell. Since this information is included in the telemetry data sent to
Microsoft, users shouldn't change this value.

For more information about these environment variables, see
[about_Environment_Variables][01].

For more information about Microsoft's statement on privacy, see
[Microsoft Privacy Statement][03]

<!-- link references -->
[01]: about_environment_variables.md#powershell-environment-variables
[02]: /azure/azure-monitor/app/ip-collection?tabs=net
[03]: https://privacy.microsoft.com/privacystatement

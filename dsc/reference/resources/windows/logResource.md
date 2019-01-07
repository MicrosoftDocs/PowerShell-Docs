---
ms.date:  06/12/2017
keywords:  dsc,powershell,configuration,setup
title:  DSC Log Resource
---
# DSC Log Resource

> _Applies To: Windows PowerShell 4.0, Windows PowerShell 5.0_

The __Log__ resource in Windows PowerShell Desired State Configuration (DSC) provides a mechanism to write messages to the Microsoft-Windows-Desired State Configuration/Analytic event log.

```
Syntax

Log [string] #ResourceName
{
    Message = [string]
    [ DependsOn = [string[]] ]
}
```

> [!NOTE]
> By default only the Operational logs for DSC are enabled. Before the Analytic log will be available or visible, it must be enabled. For more information, see [Where are DSC Event Logs?](../../../troubleshooting/troubleshooting.md#where-are-dsc-event-logs).

## Properties

| Property | Description |
| --- | --- |
| Message| Indicates the message you want to write to the Microsoft-Windows-Desired State Configuration/Analytic event log.|
| DependsOn | Indicates that the configuration of another resource must run before this log message gets written. For example, if the ID of the resource configuration script block that you want to run first is **ResourceName** and its type is **ResourceType**, the syntax for using this property is `DependsOn = '[ResourceType]ResourceName'`.|

## Example

The following example shows how to include a message in the Microsoft-Windows-Desired State Configuration/Analytic event log.

> [!NOTE]
> If you run [Test-DscConfiguration](https://technet.microsoft.com/en-us/library/dn407382.aspx) with this resource configured, it will always return **$false**.

```powershell
Configuration logResourceTest
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node localhost
    {
        Log LogExample
        {
            Message = 'This message will appear in the Microsoft-Windows-Desired State Configuration/Analytic event log.'
        }
    }
}
```

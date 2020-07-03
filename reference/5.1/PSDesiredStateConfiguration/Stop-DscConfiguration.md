---
external help file: Stop-DscConfiguration.cdxml-help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: PSDesiredStateConfiguration
ms.date: 08/19/2019
online version: https://docs.microsoft.com/powershell/module/psdesiredstateconfiguration/stop-dscconfiguration?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Stop-DscConfiguration
---

# Stop-DscConfiguration

## SYNOPSIS
Stops a configuration job that is running.

## SYNTAX

### All

```
Stop-DscConfiguration [-Force] [-CimSession <CimSession[]>] [-ThrottleLimit <Int32>] [-AsJob]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Stop-DscConfiguration` cmdlet stops a configuration job that is running. Specify which
computers this cmdlet applies to by using Common Information Model (CIM) sessions. If there's no
configuration job running, this cmdlet returns a warning message.

`Stop-DscConfiguration` is only available as part of the
[November 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2](https://support.microsoft.com/kb/3000850)
from the Microsoft Support library. Before you use this cmdlet, review the information in
[What's New in Windows PowerShell 5.0](/powershell/scripting/whats-new/What-s-New-in-Windows-PowerShell-50)

## EXAMPLES

### Example 1: Stop a configuration job

In this example, a CIM session is created using the `New-CimSession` cmdlet. The **CimSession**
object is used to stop a running configuration job.

```powershell
$Session = New-CimSession -ComputerName Server01 -Credential ACCOUNTS\User01
Stop-DscConfiguration -CimSession $Session
```

`New-CimSession` uses the **ComputerName** parameter to specify the Server01 computer. The
**Credential** parameter specifies the user account. The **CimSession** object is stored in the
`$Session` variable. When the command is run, you're prompted for the user account's password.

`Stop-DscConfiguration` uses the **CimSession** parameter and the object stored in `$Session` to
stop the configuration job.

## PARAMETERS

### -AsJob

Indicates that this cmdlet runs the command as a background job. For more information about
PowerShell background jobs, see [about_Jobs](../Microsoft.PowerShell.Core/About/about_Jobs.md) and
[about_Remote_Jobs](../Microsoft.PowerShell.Core/About/about_Remote_Jobs.md).

To use the **AsJob** parameter, the local and remote computers must be configured for remoting. On
Windows Vista and later versions of the Windows operating system, you must open PowerShell with the
**Run as administrator** option. For more information, see
[about_Remote_Requirements](../Microsoft.PowerShell.Core/About/about_Remote_Requirements.md).

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -CimSession

Runs the cmdlet in a remote session or on a remote computer. Enter a computer name or a session
object, such as the output from `New-CimSession` or `Get-CimSession`.

```yaml
Type: Microsoft.Management.Infrastructure.CimSession[]
Parameter Sets: (All)
Aliases: Session

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

`Stop-DscConfiguration` doesn't support the **Confirm** parameter. If the **Confirm** parameter is
used, an error is displayed.

For PowerShell cmdlets that support **Confirm**, using the parameter prompts you for verification
before a command is run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Forces the command to run without asking for user confirmation.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThrottleLimit

Specifies the maximum number of concurrent operations that can be established to run the cmdlet.

If this parameter is omitted or a value of `0` is entered, PowerShell calculates an optimum throttle
limit based on the number of CIM cmdlets that are running on the computer. The throttle limit
applies only to the current cmdlet, not to the session or to the computer.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet isn't run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS

[Get-CimSession](../CimCmdlets/Get-CimSession.md)

[Get-DscConfiguration](Get-DscConfiguration.md)

[Get-DscConfigurationStatus](Get-DscConfigurationStatus.md)

[New-CimSession](../CimCmdlets/New-CimSession.md)

[Restore-DscConfiguration](Restore-DscConfiguration.md)

[Start-DscConfiguration](Start-DscConfiguration.md)

[Test-DscConfiguration](Test-DscConfiguration.md)

[Update-DscConfiguration](Update-DscConfiguration.md)

[Windows PowerShell Desired State Configuration Overview](/powershell/scripting/dsc/overview/overview)

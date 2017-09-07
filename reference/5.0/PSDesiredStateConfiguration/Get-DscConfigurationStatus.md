---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821456
external help file:  Get-DscConfigurationStatus.cdxml-help.xml
title:  Get-DscConfigurationStatus
---

# Get-DscConfigurationStatus

## SYNOPSIS
Retrieves data about completed configuration runs.

## SYNTAX

```
Get-DscConfigurationStatus [-All] [-CimSession <CimSession[]>] [-ThrottleLimit <Int32>] [-AsJob]
 [<CommonParameters>]
```

## DESCRIPTION
The **Get-DscConfigurationStatus** cmdlet retrieves detailed information about completed configuration runs on the system.
By default, it returns the information about the last configuration run.
This cmdlet is useful for finding historical information about configuration runs, such as when the configurations were run, the status of the runs, the number of resources in the configurations, and which resources succeeded or failed.

## EXAMPLES

### Example 1: Get information on the last configuration run
```
PS C:\> Get-DscConfigurationStatus
```

This command gets information on the last configuration run.

### Example 2: Get information on all configurations
```
PS C:\> Get-DscConfigurationStatus -All
```

This command gets information about all the configurations that were run on the system, including the Windows PowerShell Desired State Configuration (DSC) consistency check.

### Example 3: Get information on the configuration run on a remote computer
```
PS C:\> Get-DscConfigurationStaus -CimSession "Server01"
```

This command gets the configuration run details of the remote computer named Server01.
This uses the WSMan transport to connect to the remote computer and requires that the connecting user be an administrator on the remote computer.

## PARAMETERS

### -All
Indicates that this cmdlet retrieves information about all the configuration runs on the computer, including the configuration application and the consistency check.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsJob
Indicates that this cmdlet runs the command as a background job.

If you specify the *AsJob* parameter, the command returns an object that represents the job, and then displays the command prompt.
You can continue to work in the session until the job finishes.
The job is created on the local computer and the results from remote computers are automatically returned to the local computer.
To manage the job, use the Job cmdlets.
To get the job results, use the Receive-Job cmdlet.

To use this parameter, the local and remote computers must be configured for remoting, and on Windows Vista and later versions of the Windows operating system, you must open Windows PowerShell with the Run as administrator option.
For more information, see about_Remote_Requirementshttp://go.microsoft.com/fwlink/?LinkId=623526 (http://go.microsoft.com/fwlink/?LinkId=623526).

For more information about Windows PowerShell background jobs, see [about_Jobs](../Microsoft.PowerShell.Core/About/about_Jobs.md) and [about_Remote_Jobs](../Microsoft.PowerShell.Core/About/about_Remote_Jobs.md).

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CimSession
Runs the cmdlet in a remote session or on a remote computer.
Enter a computer name or a session object, such as the output of a [New-CimSession](http://go.microsoft.com/fwlink/?LinkId=227967) or [Get-CimSession](http://go.microsoft.com/fwlink/?LinkId=227966) cmdlet.
The default is the current session on the local computer.

```yaml
Type: CimSession[]
Parameter Sets: (All)
Aliases: Session

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThrottleLimit
Specifies the maximum number of concurrent operations that can be established to run the cmdlet.
If this parameter is omitted or a value of `0` is entered, then Windows PowerShell® calculates an optimum throttle limit for the cmdlet based on the number of CIM cmdlets that are running on the computer.
The throttle limit applies only to the current cmdlet, not to the session or to the computer.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Windows PowerShell Desired State Configuration Overview](http://go.microsoft.com/fwlink/?LinkID=311940)

[Get-DscConfiguration](Get-DscConfiguration.md)

[Get-DscLocalConfigurationManager](Get-DscLocalConfigurationManager.md)

[Restore-DscConfiguration](Restore-DscConfiguration.md)

[Start-DscConfiguration](Start-DscConfiguration.md)

[Test-DscConfiguration](Test-DscConfiguration.md)


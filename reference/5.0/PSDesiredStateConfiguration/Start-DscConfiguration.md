---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821465
external help file:  Microsoft.Windows.DSC.CoreConfProviders.dll-Help.xml
title:  Start-DscConfiguration
---

# Start-DscConfiguration

## SYNOPSIS
Applies configuration to nodes.

## SYNTAX

### ComputerNameAndPathSet (Default)
```
Start-DscConfiguration [-Wait] [-Force] [[-Path] <String>] [[-ComputerName] <String[]>]
 [-Credential <PSCredential>] [-ThrottleLimit <Int32>] [-JobName <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### CimSessionAndPathSet
```
Start-DscConfiguration [-Wait] [-Force] [[-Path] <String>] -CimSession <CimSession[]> [-ThrottleLimit <Int32>]
 [-JobName <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ComputerNameAndUseExistingSet
```
Start-DscConfiguration [-Wait] [-Force] [[-ComputerName] <String[]>] [-Credential <PSCredential>]
 [-ThrottleLimit <Int32>] [-UseExisting] [-JobName <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### CimSessionAndUseExistingSet
```
Start-DscConfiguration [-Wait] [-Force] -CimSession <CimSession[]> [-ThrottleLimit <Int32>] [-UseExisting]
 [-JobName <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Start-DscConfiguration** cmdlet applies configuration to nodes.
When used with the *UseExisting* parameter, the existing configuration on the target computer is applied.
Specify which computers that you want to apply configuration to by specifying computer names or by using Common Information Model (CIM) sessions.

By default, this cmdlet creates a job and returns a **Job** object.
For more information about background jobs, type `Get-Help about_Jobs`.
To use this cmdlet interactively, specify the *Wait* parameter.

Specify the *Verbose* parameter to see details of what the cmdlet does when it applies configuration settings.

## EXAMPLES

### Example 1: Apply configuration settings
```
PS C:\> Start-DscConfiguration -Path "C:\DSC\Configurations\"
```

This command applies the configuration settings from C:\DSC\Configurations\ to the every computer that has settings in that folder.
The command returns **Job** objects for each target node deployed to.

### Example 2: Apply configuration settings and wait for configuration to complete
```
PS C:\> Start-DscConfiguration -Path "C:\DSC\Configurations\" -Wait -Verbose
```

This command applies the configuration from C:\DSC\Configurations\ to the local computer.
The command returns **Job** objects for each target node deployed to, in this case, just the local computer.
This example specifies the *Verbose* parameter.
Therefore, the command sends messages to the console as it proceeds.
The command includes the *Wait* parameter.
Therefore, you cannot use the console until the command finishes all configuration tasks.

### Example 3: Apply configuration settings by using a CIM session
```
PS C:\> $Session = New-CimSession -ComputerName "Server01" -Credential ACCOUNTS\PattiFuller
PS C:\> Start-DscConfiguration -Path "C:\DSC\Configurations\" -CimSession $Session
```

This example applies configuration settings to a specified computer.
The example creates a CIM session for a computer named Server01 for use with the cmdlet.
Alternatively, create an array of CIM sessions to apply the cmdlet to multiple specified computers.

The first command creates a CIM session by using the **New-CimSession** cmdlet, and then stores the **CimSession** object in the $Session variable.
The command prompts you for a password.
For more information, type `Get-Help NewCimSession`.

The second command applies the configuration settings from C:\DSC\Configurations\ to the computers identified by the **CimSession** objects stored in the $Session variable.
In this example, the $Session variable contains a CIM session only for the computer named Server01.
The command applies the configuration.
The command creates **Job** objects for each configured computer.

## PARAMETERS

### -CimSession
Runs the cmdlet in a remote session or on a remote computer.
Enter a computer name or a session object, such as the output of a [New-CimSession](https://docs.microsoft.com/powershell/module/cimcmdlets/new-cimsession) or [Get-CimSession](https://docs.microsoft.com/powershell/module/cimcmdlets/get-cimsession) cmdlet.
The default is the current session on the local computer.

```yaml
Type: CimSession[]
Parameter Sets: CimSessionAndPathSet, CimSessionAndUseExistingSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ComputerName
Specifies an array of computer names.
This parameter restricts the computers that have configuration documents in the *Path* parameter to those specified in the array.

```yaml
Type: String[]
Parameter Sets: ComputerNameAndPathSet, ComputerNameAndUseExistingSet
Aliases: CN, ServerName

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user name and password, as a **PSCredential** object, for the target computer.
To obtain a **PSCredential** object, use the Get-Credential cmdlet.
For more information, type `Get-Help Get-Credential`.

```yaml
Type: PSCredential
Parameter Sets: ComputerNameAndPathSet, ComputerNameAndUseExistingSet
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Stops the configuration operation currently running on the target computer and begins the new Start-Configuration operation.
If the **RefreshMode** property of the Local Configuration Manager is set to **Pull**, specifying this parameter changes it to **Push**.

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

### -JobName
Specifies a friendly name for a job.
If you specify this parameter, the cmdlet runs as a job, and it returns a **Job** object.

By default, Windows PowerShell assigns the name JobN where N is an integer.

If you specify the *Wait* parameter, do not specify this parameter.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies a file path of a folder that contains configuration settings files.
This cmdlet publishes and applies these configuration settings to computers that have settings files in the specified path.
Each target node must have a settings file of the following format: NetBIOS Name.mof.

```yaml
Type: String
Parameter Sets: ComputerNameAndPathSet, CimSessionAndPathSet
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ThrottleLimit
Specifies the maximum number of concurrent operations that can be established to run the cmdlet.
If this parameter is omitted or a value of `0` is entered, then Windows PowerShell calculates an optimum throttle limit for the cmdlet based on the number of CIM cmdlets that are running on the computer.
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

### -UseExisting
Indicates that this cmdlet applies the existing configuration.
The configuration can exist on the target computer by enactment using **Start-DscConfiguration** or by publication using the Publish-DscConfiguration cmdlet.

Before you specify this parameter for this cmdlet, review the information in [What's New in Windows PowerShell 5.0](https://docs.microsoft.com//powershell/scripting/whats-new/what-s-new-in-windows-powershell-50)


```yaml
Type: SwitchParameter
Parameter Sets: ComputerNameAndUseExistingSet, CimSessionAndUseExistingSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Wait
Indicates that the cmdlet blocks the console until it finishes all configuration tasks.

If you specify this parameter, do not specify the *JobName* parameter.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Windows PowerShell Desired State Configuration Overview](/powershell/dsc/overview/overview)

[Get-DscConfiguration](Get-DscConfiguration.md)

[Get-DscConfigurationStatus](Get-DscConfigurationStatus.md)

[Restore-DscConfiguration](Restore-DscConfiguration.md)

[Stop-DscConfiguration](Stop-DscConfiguration.md)

[Test-DscConfiguration](Test-DscConfiguration.md)

[Update-DscConfiguration](Update-DscConfiguration.md)
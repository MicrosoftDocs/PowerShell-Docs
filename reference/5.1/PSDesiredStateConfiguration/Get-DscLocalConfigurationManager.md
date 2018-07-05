---
external help file: Get-DSCLocalConfigurationManager.cdxml-help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: PSDesiredStateConfiguration
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821457
schema: 2.0.0
title: Get-DscLocalConfigurationManager
---

# Get-DscLocalConfigurationManager

## SYNOPSIS
Gets LCM settings and states for the node.

## SYNTAX

```
Get-DscLocalConfigurationManager [-CimSession <CimSession[]>] [-ThrottleLimit <Int32>] [-AsJob]
 [<CommonParameters>]
```

## DESCRIPTION
The **Get-DscLocalConfigurationManager** cmdlet gets Local Configuration Manager (LCM) settings, or meta-configuration, and the states of LCM for the node.
Specify computers by using Common Information Model (CIM) sessions.
If you do not specify a target computer, the cmdlet gets the configuration settings from the local computer.

## EXAMPLES

### Example 1: Get LCM settings for the local computer
```
PS C:\> Get-DscLocalConfigurationManager
```

This command gets LCM settings for the local computer.

### Example 2: Get LCM settings for a specified computer
```
PS C:\> $Session = New-CimSession -ComputerName "Server01" -Credential ACCOUNTS\PattiFuller
PS C:\> Get-DscLocalConfigurationManager -CimSession $Session
```

This example gets LCM settings for a computer specified by a CIM session.
The example creates a CIM session for a computer named Server01 for use with the cmdlet.
Alternatively, create an array of CIM sessions to apply the cmdlet to multiple specified computers.

The first command creates a CIM session by using the **New-CimSession** cmdlet, and then stores the **CimSession** object in the $Session variable.
The command prompts you for a password.
For more information, type `Get-Help New-CimSession`.

The second command gets Local Configuration Manager settings for the computers identified by the **CimSession** objects stored in the $Session variable, in this case, the computer named Server01.

## PARAMETERS

### -AsJob
Indicates that this cmdlet runs the command as a background job.

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
Enter a computer name or a session object, such as the output of a **New-CimSession** or **Get-CimSession** cmdlet.

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

[Set-DscLocalConfigurationManager](Set-DscLocalConfigurationManager.md)
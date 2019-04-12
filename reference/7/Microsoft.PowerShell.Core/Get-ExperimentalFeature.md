---
external help file: System.Management.Automation.dll-Help.xml
Module Name: Microsoft.PowerShell.Core
online version: https://go.microsoft.com/fwlink/?linkid=2007351
schema: 2.0.0
ms.date: 03/01/2019
---

# Get-ExperimentalFeature

## SYNOPSIS
Gets experimental features.

## SYNTAX

```
Get-ExperimentalFeature [[-Name] <String[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-ExperimentalFeature` cmdlet returns all experimental features discovered by PowerShell.
Experimental features can come from modules or the PowerShell engine. Experimental features allow
users to safely test new features and provide feedback (typically via GitHub) before the design is
considered complete and any changes can become a breaking change.

## EXAMPLES

### Example 1

Gets the list of currently registered experimental features and their current state.

```powershell
PS C:\> Get-ExperimentalFeature
```

```Output
Name                         Enabled Source      Description
----                         ------- ------      -----------
PSImplicitRemotingBatching   False PSEngine      Batch implicit remoting proxy commands to improve performance
```

## PARAMETERS

### -Name

Name or names of specific experimental features to return.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

Name or names of experimental features to return.

## OUTPUTS

### ExperimentalFeature

Returns instances that match the requested names or all experimental features if no name is
specified.

## RELATED LINKS

[Disable-ExperimentalFeature](Disable-ExperimentalFeature.md)

[Enable-ExperimentalFeature](Enable-ExperimentalFeature.md)

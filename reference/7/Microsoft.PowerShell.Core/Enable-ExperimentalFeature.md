---
external help file: System.Management.Automation.dll-Help.xml
Module Name: Microsoft.PowerShell.Core
online version:
schema: 2.0.0
---

# Enable-ExperimentalFeature

## SYNOPSIS
Enable an experimental feature on startup of new instance of PowerShell.

## SYNTAX

```
Enable-ExperimentalFeature [-Name] <String[]> [-Scope <ConfigScope>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Enable-ExperimentalFeature` cmdlet enables experimental features by adding the named
experimental features to the `powershell.config.json` settings file read on PowerShell startup.

> [!NOTE]
> Any changes to experimental feature state only takes effect on restart of PowerShell

## EXAMPLES

### Example 1: Enable an experimental feature

In this example, if this experimental feature was previously disabled, then the `powershell.config.json`
file is updated for the user to enable that feature once PowerShell is restarted.
Upon success nothing is output to the pipeline and only a warning message is displayed.

```powershell
PS C:\> Enable-ExperimentalFeature PSImplicitRemotingBatching
```

```Output
WARNING: Enabling and disabling experimental features do not take effect until next start of PowerShell.
```

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name

The name or names of the experimental features to enable.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Scope

Determines which `powershell.config.json` to update whether it affects all users or
just the current user.

```yaml
Type: ConfigScope
Parameter Sets: (All)
Aliases:
Accepted values: AllUsers, CurrentUser

Required: False
Position: Named
Default value: CurrentUser
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
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### ExperimentalFeature

Pipe instances of ExperimentalFeature from `Get-ExperimentalFeature` cmdlet to enable.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

Changes to state of an experimental feature only take effect on restart of PowerShell.

## RELATED LINKS

[Disable-ExperimentalFeature](Disable-ExperimentalFeature.md)

[Get-ExperimentalFeature](Get-ExperimentalFeature.md)

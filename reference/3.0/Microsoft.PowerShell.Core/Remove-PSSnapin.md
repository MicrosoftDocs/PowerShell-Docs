---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=113378
external help file:  System.Management.Automation.dll-Help.xml
title:  Remove-PSSnapin
---
# Remove-PSSnapin

## SYNOPSIS

Removes Windows PowerShell snap-ins from the current session.

## SYNTAX

```
Remove-PSSnapin [-Name] <String[]> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The Remove-PSSnapin cmdlet removes a Windows PowerShell snap-in from the current session.
You can use it to remove snap-ins that you have added to Windows PowerShell, but you cannot use it to remove the snap-ins that are installed with Windows PowerShell.

After a snap-in is removed from the current session, it is still loaded, but the cmdlets and providers in the snap-in are no longer available in the session.

## EXAMPLES

### Example 1

```
PS> remove-pssnapin -name Microsoft.Exchange
```

This command removes the Microsoft.Exchange snap-in from the current session.
When the command is complete, the cmdlets and providers that the snap-in supported are not available in the session.

### Example 2

```
PS> get-PSSnapIn smp* | remove-PSSnapIn
```

This command removes the Windows PowerShell snap-ins that have names beginning with "smp" from the current session.

The command uses the Get-PSSnapin cmdlet to get objects representing the snap-ins.
The pipeline operator (|) sends the results to the Remove-PSSnapin cmdlet, which removes them from the session.
The providers and cmdlets that this snap-in supports are no longer available in the session.

When you pipe objects to Remove-PSSnapin, the names of the objects are associated with the Name parameter, which accepts objects from the pipeline that have a Name property.

### Example 3

```
PS> remove-pssnapin -name *event*
```

This command removes all Windows PowerShell snap-ins that have names that include "event".
This command specifies the "Name" parameter name, but the parameter name can be omitted because it is optional.

## PARAMETERS

### -Name

Specifies the names of Windows PowerShell snap-ins to remove from the current session.
The parameter name ("Name") is optional, and wildcard characters (*) are permitted in the value.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -PassThru

Returns an object representing the snap-in.
By default, this cmdlet does not generate any output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).

## INPUTS

### System.Management.Automation.PSSnapInInfo

You can pipe a snap-in object to Remove-PSSnapin.

## OUTPUTS

### None or System.Management.Automation.PSSnapInInfo

By default, Remove-PsSnapin does not generate any output.
However, if you use the PassThru parameter, it generates a System.Management.Automation.PSSnapInInfo object representing the snap-in.

## NOTES

- You can also refer to Remove-PSSnapin by its built-in alias, "rsnp". For more information, see [about_Aliases](./About/about_Aliases.md).

  Remove-PSSnapin does not check the version of Windows PowerShell before removing a snap-in from the session.
If a snap-in cannot be removed, a warning appears and the command fails.

  Remove-PSSnapin affects only the current session.
If you have added an Add-PSSnapin command to your Windows PowerShell profile, you should delete the command to remove the snap-in from future sessions.
For instructions, see [about_Profiles](./About/about_profiles.md).

- 

## RELATED LINKS

[Add-PSSnapin](Add-PSSnapin.md)

[Get-PSSnapin](Get-PSSnapin.md)

[about_Profiles](About/about_profiles.md)
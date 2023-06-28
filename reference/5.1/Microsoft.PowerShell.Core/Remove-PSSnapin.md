---
external help file: System.Management.Automation.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Core
ms.date: 09/28/2021
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/remove-pssnapin?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-PSSnapin
---

# Remove-PSSnapin

## SYNOPSIS
Removes Windows PowerShell snap-ins from the current session.

## SYNTAX

```
Remove-PSSnapin [-Name] <String[]> [-PassThru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Remove-PSSnapin` cmdlet removes a Windows PowerShell snap-in from the current session. You can
use it to remove snap-ins that you have added to Windows PowerShell You cannot use this cmdlet to
remove the snap-ins that are installed with Windows PowerShell.

After you remove a snap-in from the current session, the snap-in is still loaded, but the cmdlets
and providers in the snap-in are no longer available in the session.

## EXAMPLES

### Example 1: Remove a snap-in

```powershell
Remove-PSSnapin -Name Microsoft.Exchange
```

This command removes the **Microsoft.Exchange** snap-in from the current session. When the command
is complete, the cmdlets and providers that the snap-in supported are not available in the session.

### Example 2: Remove snap-ins by using names with the pipeline

```powershell
Get-PSSnapIn smp* | Remove-PSSnapIn
```

This command removes the Windows PowerShell snap-ins that have names that start with smp from the
current session.

The command uses the `Get-PSSnapin` cmdlet to get objects that represent the snap-ins. The pipeline
operator (`|`) sends the results to the `Remove-PSSnapin` cmdlet, which removes them from the
session. The providers and cmdlets that this snap-in supports are no longer available in the
session.

When you pipe objects to `Remove-PSSnapin`, the names of the objects are associated with the
**Name** parameter, which accepts objects from the pipeline that have a **Name** property.

### Example 3: Remove snap-ins by using names

```powershell
Remove-PSSnapin -Name *event*
```

This command removes all Windows PowerShell snap-ins that have names that include event.

## PARAMETERS

### -Name

Specifies the names of Windows PowerShell snap-ins to remove from the current session.
Wildcard characters (`*`) are permitted.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru

Returns an object that represents the snap-in. By default, this cmdlet does not generate any output.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

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

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### System.Management.Automation.PSSnapInInfo

You can pipe a snap-in object to this cmdlet.

## OUTPUTS

### None, System.Management.Automation.PSSnapInInfo

This cmdlet generates a **System.Management.Automation.PSSnapInInfo** object that represents the
snap-in, if you specify the **PassThru** parameter. By default, `Remove-PSSnapin` does not generate
any output.

## NOTES

Windows PowerShell includes the following aliases for `Remove-PSSnapin`:

- `rsnp`

`Remove-PSSnapin` does not check the version of Windows PowerShell before removing a snap-in from
the session. If a snap-in cannot be removed, a warning appears and the command fails.

`Remove-PSSnapin` affects only the current session. If you have added an `Add-PSSnapin` command to
your Windows PowerShell profile, you should delete the command to remove the snap-in from future
sessions. For instructions, type `Get-Help about_Profiles`.

## RELATED LINKS

[Add-PSSnapin](Add-PSSnapin.md)

[Get-PSSnapin](Get-PSSnapin.md)

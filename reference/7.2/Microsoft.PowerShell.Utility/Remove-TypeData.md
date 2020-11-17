---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 04/27/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/remove-typedata?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Remove-TypeData
---

# Remove-TypeData

## Synopsis
Deletes extended types from the current session.

## Syntax

### RemoveTypeDataSet (Default)

```
Remove-TypeData -TypeData <TypeData> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### RemoveTypeSet

```
Remove-TypeData [-TypeName] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### RemoveFileSet

```
Remove-TypeData -Path <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Remove-TypeData` cmdlet deletes extended type data from the current session. This cmdlet
affects only the current session and sessions that are created in the current session.

You can add properties and methods to objects in PowerShell by defining them in `Update-TypeData`
commands and `Types.ps1xml` files. `Remove-TypeData` deletes those extended properties and methods
from the current session. `Remove-TypeData` does not delete the `Types.ps1xml` files or delete any
extended type definitions from the `Types.ps1xml` files. For more information about `Types.ps1xml`
files, see [about_Types.ps1xml](../Microsoft.PowerShell.Core/about/about_Types.ps1xml.md).

This cmdlet was introduced in Windows PowerShell 3.0.

## Examples

### Example 1: Remove type data for a specified type

This example deletes all type data for the **System.Array** type  from the session, including type
data that was added by a `Types.ps1xml` file and dynamic type data that was added to the session by
using the `Update-TypeData` cmdlet.

```powershell
Remove-TypeData -TypeName System.Array
```

### Example 2: Remove an extended data type from a session

This example shows the effect of removing extended type data from a session. The first
`Get-TypeData` gets extended type data for the **System.DateTime** type. The output shows that a
**DateTime** property has been added to all **System.DateTime** objects in PowerShell. The
`Get-Date` cmdlet returns a **System.DateTime** object. The command uses dot notation to get the
value of the **DateTime** property of the **System.DateTime** object that `Get-Date` returns.

```powershell
Get-TypeData System.DateTime
(Get-Date).DateTime
Get-TypeData System.DateTime | Remove-TypeData
(Get-Date).DateTime
```

```Output
TypeName        Members
--------        -------
System.DateTime {[DateTime, System.Management.Automation.Runspaces.ScriptPropertyData]}

Friday, January 20, 2012 9:01:00 PM
```

The next `Get-TypeData` cmdlet to get all extended type data for the **System.DateTime** type and
pipes that to the `Remove-TypeData` cmdlet to delete the extended type data. The last `Get-Date`
cmdlet shows the effect of deleting the extended type data for the **System.DateTime** type. Because
the **System.DateTime** property no longer exists, a command to get its value returns nothing.

### Example 3: Remove extended types for modules

This example removes all extended type data for module objects. When you pipe an object to
`Remove-TypeData`, `Remove-TypeData` gets the name of the object type and removes all type data for
all objects of that type.

```powershell
Get-Module | Remove-TypeData
```

### Example 4: Remove extended types from specified modules

This example uses the **Path** parameter of the `Remove-TypeData` cmdlet to remove the extended
types that are defined in the `Types.ps1xml` files that are added by the **PSScheduledJob** and
**PSWorkflow** modules. This command does not affect dynamic type data that is added by using the
`Update-TypeData` cmdlet. The command succeeds only when the modules have been imported into the
current session.

```powershell
Remove-TypeData -Path "$PSHOME\Modules\PSScheduledJob", "$PSHOME\Modules\PSWorkflow\PSWorkflow.types.ps1xml"
```

For more information about modules, see [about_Modules](../Microsoft.PowerShell.Core/About/about_Modules.md).

### Example 5: Remove extended types from a remote session

This example removes extended types from a remote session. The command uses the `Invoke-Command`
cmdlet to remove extended type data for all CIM types in the sessions in the `$S` variable.

```powershell
Invoke-Command -Session $S {Get-TypeData -TypeName *CIM* | Remove-TypeData}
```

## Parameters

### -Path

Specifies an array of files that this cmdlet deletes from the session extended type data. This
parameter is required.

Enter the paths and file names of one or more `Types.ps1xml` files. Wildcards are not supported. If
you omit the path, the default location is the current directory.

```yaml
Type: System.String[]
Parameter Sets: RemoveFileSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypeData

Specifies the type data that this cmdlet deletes from the session. This parameter is required. Enter
a variable that contains **TypeData** objects (**System.Management.Automation.Runspaces.TypeData**)
or a command that gets **TypeData** objects, such as a `Get-TypeData` command. You can also pipe
**TypeData** objects to `Remove-TypeData`.

```yaml
Type: System.Management.Automation.Runspaces.TypeData
Parameter Sets: RemoveTypeDataSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -TypeName

Specifies the types that this cmdlet deletes all extended type data for. For types in the System
namespace, enter the short name. Otherwise, the full type name is required. Wildcards are not
supported.

You can pipe type names to `Remove-TypeData`. When you pipe an object to `Remove-TypeData`,
`Remove-TypeData` gets the type name of the object and removes all type data for the object type.

```yaml
Type: System.String
Parameter Sets: RemoveTypeSet
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.Management.Automation.Runspaces.TypeData

You can pipe **TypeData** object, such as the ones that the `Get-TypeData` cmdlet returns, to
`Remove-TypeData`.

### System.String

You can pipe the type names to `Remove-TypeData`. When you pipe an object to `Remove-TypeData`,
`Remove-TypeData` gets the type name of the object and removes all type data for the object type.

## Outputs

### None

This cmdlet does not generate any output.

## Notes

`Remove-TypeData` can remove only the extended type data in the current session. It cannot remove
extended type data that is on the computer, but has not been added to the current session, such as
extended types that are defined in modules that have not been imported into the current session.

## Related links

[Get-TypeData](Get-TypeData.md)

[Update-TypeData](Update-TypeData.md)


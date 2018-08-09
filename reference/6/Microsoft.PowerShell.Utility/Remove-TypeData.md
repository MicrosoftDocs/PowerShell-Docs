---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821849
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
title:  Remove-TypeData
---

# Remove-TypeData

## SYNOPSIS
Deletes extended types from the current session.

## SYNTAX

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
The **Remove-TypeData** cmdlet deletes extended type data from the current session.
This cmdlet affects only the current session and sessions that are created in the current session.

You can add properties and methods to objects in PowerShell by defining them in Update-TypeData commands and Types.ps1xml files.
**Remove-TypeData** deletes those extended properties and methods from the current session.
**Remove-TypeData** does not delete the Types.ps1xml files or delete any extended type definitions from the Types.ps1xml files.
For more information about Types.ps1xml files, see about_Types.ps1xml (http://go.microsoft.com/fwlink/?LinkID=113274).

This cmdlet was introduced in Windows PowerShell 3.0.

## EXAMPLES

### Example 1: Remove type data for a specified type
```
PS C:\> Remove-TypeData -TypeName System.Array
```

This command deletes from the session all type data for the **System.Array** type, including type data that was added by a Types.ps1xml file and dynamic type data that was added to the session by using the Update-TypeData cmdlet.

### Example 2: Remove an extended data type from a session
```
The first command uses the Get-TypeData cmdlet to get extended type data for the **System.DateTime** type.The output shows that a **DateTime** property has been added to all **System.DateTime** objects in PowerShell.
PS C:\> Get-TypeData System.DateTime
TypeName        Members
--------        -------
System.DateTime {[DateTime, System.Management.Automation.Runspaces.ScriptPropertyData]}

The second command uses the Get-Date cmdlet, which returns a **System.DateTime** object. The command uses dot notation to get the value of the DateTime property of the **System.DateTime** object that **Get-Date** returns.
PS C:\> (Get-Date).DateTime
Friday, January 20, 2012 9:01:00 PM

The third command uses the Get-TypeData cmdlet to get all extended type data for the **System.DateTime** type and the **Remove-TypeData** cmdlet to delete the extended type data.
PS C:\> Get-TypeData System.DateTime | Remove-TypeData

The fourth command shows the effect of deleting the extended type data for the System.DateTime type. The command repeats the second command. However, because the System.DateTime property no longer exists, a command to get its value returns nothing.
PS C:\> (Get-Date).DateTime
```

This command shows the effect of removing extended type data from a session.

### Example 3: Remove extended types for modules
```
PS C:\> Get-Module | Remove-TypeData
```

This command removes all extended type data for module objects.
When you pipe an object to **Remove-TypeData**, **Remove-TypeData** gets the name of the object type and removes all type data for all objects of that type.

### Example 4: Remove extended types from specified modules
```
PS C:\> Remove-TypeData -Path "C:\WINDOWS\System32\WindowsPowerShell\v1.0\Modules\PSScheduledJob, C:\WINDOWS\System32\WindowsPowerShell\v1.0\Modules\PSWorkflow\PSWorkflow.types.ps1xml"
```

This command uses the *Path* parameter of the **Remove-TypeData** cmdlet to remove the extended types that are defined in the Types.ps1xml files that are added by the **PSScheduledJob** and **PSWorkflow** modules.
This command does not affect dynamic type data that is added by using the Update-TypeData cmdlet.
The command succeeds only when the modules have been imported into the current session.

For more information about modules, see about_Modules (http://go.microsoft.com/fwlink/?LinkID=144311).

### Example 5: Remove extended types from a remote session
```
PS C:\> Invoke-Command -Session $S {Get-TypeData -TypeName *CIM* | Remove-TypeData}
```

This command removes extended types from a remote session.
The command uses the Invoke-Command cmdlet to remove extended type data for all CIM types in the sessions in the $S variable.

## PARAMETERS

### -Path
Specifies an array of files that this cmdlet deletes from the session extended type data.
This parameter is required.

Enter the paths and file names of one or more Types.ps1xml files.
Wildcards are not supported.
If you omit the path, the default location is the current directory.

```yaml
Type: String[]
Parameter Sets: RemoveFileSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TypeData
Specifies the type data that this cmdlet deletes from the session.
This parameter is required.
Enter a variable that contains **TypeData** objects (**System.Management.Automation.Runspaces.TypeData**) or a command that gets **TypeData** objects, such as a **Get-TypeData** command.
You can also pipe **TypeData** objects to **Remove-TypeData**.

```yaml
Type: TypeData
Parameter Sets: RemoveTypeDataSet
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -TypeName
Specifies the types that this cmdlet deletes all extended type data for.
For For types in the System namespace, enter the short name.
Otherwise, the full type name is required.
Wildcards are not supported.

You can pipe type names to **Remove-TypeData**.
When you pipe an object to **Remove-TypeData**, **Remove-TypeData** gets the type name of the object and removes all type data for the object type.

```yaml
Type: String
Parameter Sets: RemoveTypeSet
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.Runspaces.TypeData
You can pipe **TypeData** object, such as the ones that the Get-TypeData cmdlet returns, to **Remove-TypeData**.

### System.String
You can pipe the type names to **Remove-TypeData**.
When you pipe an object to **Remove-TypeData**, **Remove-TypeData** gets the type name of the object and removes all type data for the object type.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES
* **Remove-TypeData** can remove only the extended type data in the current session. It cannot remove extended type data that is on the computer, but has not been added to the current session, such as extended types that are defined in modules that have not been imported into the current session.

## RELATED LINKS

[Get-TypeData](Get-TypeData.md)

[Update-TypeData](Update-TypeData.md)
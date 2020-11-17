---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 04/27/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/get-typedata?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-TypeData
---
# Get-TypeData

## Synopsis
Gets the extended type data in the current session.

## Syntax

```
Get-TypeData [[-TypeName] <String[]>] [<CommonParameters>]
```

## Description

The `Get-TypeData` cmdlet gets the extended type data in the current session. This includes type
data that was added to the session by `Types.ps1xml` file and dynamic type data that was added by
using the parameter of the `Update-TypeData` cmdlet.

You can use the extended type data that `Get-TypeData` returns to examine the type data in the
session and send it to the `Update-TypeData` and `Remove-TypeData` cmdlets.

Extended type data adds properties and methods to objects in PowerShell. You can use the added
properties and methods in the same ways that you would use the properties and methods that are
defined in the object type. However, when writing scripts, be aware that the added properties and
methods might not be present in every PowerShell session.

For more information about `Types.ps1xml` files, see
[about_Types.ps1xml](../Microsoft.PowerShell.Core/About/about_Types.ps1xml.md). For more information
about dynamic type data that the `Update-TypeData` cmdlet adds, see `Update-TypeData`.

This cmdlet was introduced in Windows PowerShell 3.0.

## Examples

### Example 1: Get all extended type data

This example gets all extended type data in the current session.

 ```powershell
Get-TypeData
```

### Example 2: Get types by name

This example gets all types in the current session that have names that contain Eventing.

 ```powershell
"*Eventing*" | Get-TypeData
```

```Output
TypeName                                                  Members
--------                                                  -------
System.Diagnostics.Eventing.Reader.EventLogConfiguration  {}System.Diagnostics.Eventing.Reader.EventLogRecord
                                                          {}System.Diagnostics.Eventing.Reader.ProviderMetadata
                                                          {[ProviderName, System.Management.Automation.Runspaces.AliasProper...
```

### Example 3: Get the script block that creates a property value

This example gets the script block that creates the value of the **EventID** property of
**EventLogEntry** objects.

 ```powershell
(Get-TypeData *EventLogEntry*).Members.EventID
```

```Output
GetScriptBlock                     SetScriptBlock     IsHidden Name
--------------                     --------------     -------- ----
$this.get_EventID() -band 0xFFFF                         False EventID
```

### Example 4: Get the script block that defines a property for a specified object

This example gets the script block that defines the **DateTime** property of **System.DateTime**
objects in PowerShell.

 ```powershell
(Get-TypeData -TypeName System.DateTime).Members["DateTime"].GetScriptBlock
if ((& { Set-StrictMode -Version 1; $this.DisplayHint }) -ieq  "Date") {
    "{0}" -f $this.ToLongDateString()
}
elseif ((& { Set-StrictMode -Version 1; $this.DisplayHint }) -ieq "Time") {
    "{0}" -f  $this.ToLongTimeString()
}
else {
    "{0} {1}" -f $this.ToLongDateString(), $this.ToLongTimeString()
}
```

The command uses the `Get-TypeData` cmdlet to get the extended type data for the **System.DataTime**
type. The command gets the **Members** property of the **TypeData** object.

The **Members** property contains a hash table of properties and methods that are defined by extended
type data. Each key in the Members hash table is a property or method name and each value is the
definition of the property or method value.

The command gets the **DateTime** key in **Members** and its **GetScriptBlock** property value.

The output shows the script block that creates the value of the **DateTime** property of every
**System.DateTime** object in PowerShell.

## Parameters

### -TypeName

Specifies type data as an array only for the types with the specified names. By default,
`Get-TypeData` gets all types in the session.

Enter type names or a name patterns. Full names, or name patterns with wildcard characters are
required, even for types in the System namespace. Wildcards are supported and the parameter name
**TypeName** is optional. You can also pipe type names to `Get-TypeData`.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: True
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## Inputs

### System.String

You can pipe type names to `Get-TypeData`.

## Outputs

### System.Management.Automation.Runspaces.TypeData

## Notes

`Get-TypeData` gets only the extended type data in the current session. It does not get extended
type data that is on the computer, but has not been added to the current session, such as extended
types that are defined in modules that have not been imported into the current session.

## Related links

[about_Types.ps1xml](../Microsoft.PowerShell.Core/About/about_Types.ps1xml.md)

[Remove-TypeData](Remove-TypeData.md)

[Update-TypeData](Update-TypeData.md)


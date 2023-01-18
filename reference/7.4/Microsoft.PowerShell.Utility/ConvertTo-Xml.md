---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 01/18/2023
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/convertto-xml?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: ConvertTo-Xml
---

# ConvertTo-Xml

## SYNOPSIS
Creates an XML-based representation of an object.

## SYNTAX

```
ConvertTo-Xml [-Depth <Int32>] [-InputObject] <PSObject> [-NoTypeInformation] [-As <String>]
 [<CommonParameters>]
```

## DESCRIPTION

The `ConvertTo-Xml` cmdlet creates an [XML-based](/dotnet/api/system.xml.xmldocument) representation
of one or more .NET objects. To use this cmdlet, pipe one or more objects to the cmdlet, or use the
**InputObject** parameter to specify the object.

When you pipe multiple objects to `ConvertTo-Xml` or use the **InputObject** parameter to submit
multiple objects, `ConvertTo-Xml` returns a single, in-memory XML document that includes
representations of all the objects.

This cmdlet is similar to [Export-Clixml](./Export-Clixml.md) except that `Export-Clixml` stores the
resulting XML in a
[Common Language Infrastructure (CLI)](https://www.ecma-international.org/publications-and-standards/standards/ecma-335/)
file that can be reimported as objects with [Import-Clixml](./Import-Clixml.md). `ConvertTo-Xml`
returns an in-memory representation of an XML document, so you can continue to process it in
PowerShell. `ConvertTo-Xml` doesn't have an option to convert objects to CLI XML.

## EXAMPLES

### Example 1: Convert a date to XML

```powershell
Get-Date | ConvertTo-Xml
```

This command converts the current date (a **DateTime** object) to XML.

### Example 2: Convert processes to XML

```powershell
ConvertTo-Xml -As "Document" -InputObject (Get-Process) -Depth 3
```

This command converts the process objects that represent all the processes on the computer into an
XML document. The objects are expanded to a depth of three levels.

## PARAMETERS

### -As

Determines the output format. The acceptable values for this parameter are:

- `String` - Returns a single string.
- `Stream` - Returns an array of strings.
- `Document` - Returns an **XmlDocument** object.

The default value is `Document`.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Stream, String, Document

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Depth

Specifies how many levels of contained objects are included in the XML representation. The default
value is 1.

For example, if the object's properties also contain objects, to save an XML representation of the
properties of the contained objects, you must specify a depth of 2.

The default value can be overridden for the object type in the Types.ps1xml files. For more
information, see [about_Types.ps1xml](../Microsoft.PowerShell.Core/About/about_Types.ps1xml.md).

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject

Specifies the object to be converted. Enter a variable that contains the objects, or type a command
or expression that gets the objects. You can also pipe objects to `ConvertTo-XML`.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -NoTypeInformation

Omits the Type attribute from the object nodes.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject

You can pipe any object to this cmdlet

## OUTPUTS

### System.String

When you use the **As** parameter and set the value to `string`, this cmdlet returns the XML as a
string. When the value is `stream`, this cmdlet returns an array of strings.

### System.Xml.XmlDocument

By default, this cmdlet returns an XML document.

## NOTES

## RELATED LINKS

[ConvertTo-Csv](ConvertTo-Csv.md)

[ConvertTo-Html](ConvertTo-Html.md)

[Export-Clixml](Export-Clixml.md)

[Get-Date](Get-Date.md)

[Import-Clixml](Import-Clixml.md)

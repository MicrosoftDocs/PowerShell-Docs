---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  ConvertTo Xml
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/?LinkID=135204
external help file:   Microsoft.PowerShell.Commands.Utility.dll-Help.xml
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
The ConvertTo-Xml cmdlet creates an XML-based representation of one or more Microsoft .NET Framework objects.
To use this cmdlet, pipe one or more objects to the cmdlet, or use the InputObject parameter to specify the object.

When you pipe multiple objects to ConvertTo-XML or use the InputObject parameter to submit multiple objects, ConvertTo-XML returns a single XML document that includes representations of all of the objects.

This cmdlet is similar to Export-Clixml except that Export-Clixml stores the resulting XML in a file.
ConvertTo-XML returns the XML, so you can continue to process it in Windows PowerShell.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> get-date | convertto-xml
```

This command converts the current date (a DateTime object) to XML.
### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> convertto-xml -as Document -inputObject (get-process) -depth 3
```

This command converts the process objects that represent all of the processes on the computer into an XML document.
The objects are expanded to a depth of three levels.
## PARAMETERS

### -As
Determines the output format.
Valid values are:

- String:  Returns a single string.
- Stream:  Returns an array of strings.
- Document:  Returns an XmlDocument object.

The default is Document.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Document
Accept pipeline input: False
Accept wildcard characters: False
```

### -Depth
Specifies how many levels of contained objects are included in the XML representation.
The default value is 1.

For example, if the object's properties also contain objects, to save an XML representation of the properties of the contained objects, you must specify a depth of 2.

The default value can be overridden for the object type in the Types.ps1xml files.
For more information, see about_Types.ps1xml.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the object to be converted.
Enter a variable that contains the objects, or type a command or expression that gets the objects.
You can also pipe objects to ConvertTo-XML.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: True
```

### -NoTypeInformation
Omits the Type attribute from the object nodes.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### System.Management.Automation.PSObject
You can pipe any object to ConvertTo-XML.
## OUTPUTS

### System.String or System.Xml.XmlDocument
The value of the As parameter determines the type of object that ConvertTo-XML returns.
## NOTES

## RELATED LINKS

[ConvertTo-Csv](ConvertTo-Csv.md)

[ConvertTo-Html](ConvertTo-Html.md)

[Export-Clixml](Export-Clixml.md)

[Import-Clixml](Import-Clixml.md)


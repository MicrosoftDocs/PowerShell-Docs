---
external help file: PSITPro4_Utility.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293952
schema: 2.0.0
---

# ConvertTo-Xml
## SYNOPSIS
Creates an XML-based representation of an object.

## SYNTAX

```
ConvertTo-Xml [-InputObject] <PSObject> [-As <String>] [-Depth <Int32>] [-NoTypeInformation]
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
PS C:\>get-date | convertto-xml
```

This command converts the current date (a DateTime object) to XML.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>convertto-xml -as Document -inputObject (get-process) -depth 3
```

This command converts the process objects that represent all of the processes on the computer into an XML document.
The objects are expanded to a depth of three levels.

## PARAMETERS

### -As
Determines the output format.
Valid values are:

-- String:  Returns a single string.
-- Stream:  Returns an array of strings.
-- Document:  Returns an XmlDocument object.

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

## INPUTS

### System.Management.Automation.PSObject
You can pipe any object to ConvertTo-XML.

## OUTPUTS

### System.String or System.Xml.XmlDocument
The value of the As parameter determines the type of object that ConvertTo-XML returns.

## NOTES

## RELATED LINKS

[ConvertTo-Csv](02cf7085-f243-45ed-b803-da0466fd6085)

[ConvertTo-Html](bfe17e25-d90c-4fca-bfb4-0ef3928067d8)

[Export-Clixml](685168d4-9831-4f08-9452-2478a98172fb)

[Import-Clixml](467b491a-3e6e-4e10-8853-0fae970b10c5)


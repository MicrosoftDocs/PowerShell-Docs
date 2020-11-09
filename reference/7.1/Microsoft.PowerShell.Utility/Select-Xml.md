---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/select-xml?view=powershell-7.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Select-Xml
---
# Select-Xml

## SYNOPSIS
Finds text in an XML string or document.

## SYNTAX

### Xml (Default)

```
Select-Xml [-Xml] <XmlNode[]> [-XPath] <String> [-Namespace <Hashtable>] [<CommonParameters>]
```

### Path

```
Select-Xml [-Path] <String[]> [-XPath] <String> [-Namespace <Hashtable>] [<CommonParameters>]
```

### LiteralPath

```
Select-Xml -LiteralPath <String[]> [-XPath] <String> [-Namespace <Hashtable>] [<CommonParameters>]
```

### Content

```
Select-Xml -Content <String[]> [-XPath] <String> [-Namespace <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION

The **Select-Xml** cmdlet lets you use XPath queries to search for text in XML strings and documents.
Enter an XPath query, and use the *Content*, *Path*, or *Xml* parameter to specify the XML to be searched.

## EXAMPLES

### Example 1: Select AliasProperty nodes

```
PS C:\> $Path = "$Pshome\Types.ps1xml"
PS C:\> $XPath = "/Types/Type/Members/AliasProperty"
PS C:\> Select-Xml -Path $Path -XPath $Xpath | Select-Object -ExpandProperty Node
Name                 ReferencedMemberName
----                 --------------------
Count                Length
Name                 Key
Name                 ServiceName
RequiredServices     ServicesDependedOn
ProcessName          Name
Handles              Handlecount
VM                   VirtualSize
WS                   WorkingSetSize
Name                 ProcessName
Handles              Handlecount
VM                   VirtualMemorySize
WS                   WorkingSet
PM                   PagedMemorySize
NPM                  NonpagedSystemMemorySize
Name                 __Class
Namespace            ModuleName
```

This example gets the alias properties in the Types.ps1xml.
(For information about this file, see about_Types.ps1xml.)

The first command saves the path to the Types.ps1xml file in the $Path variable.

The second command saves the XML path to the AliasProperty node in the $XPath variable.

The third command uses the **Select-Xml** cmdlet to get the AliasProperty nodes that are identified by the XPath statement from the Types.ps1xml file.
The command uses a pipeline operator to send the AliasProperty nodes to the Select-Object cmdlet.
The *ExpandProperty* parameter expands the **Node** object and returns its Name and ReferencedMemberName properties.

The result shows the Name and ReferencedMemberName of each alias property in the Types.ps1xml file.
For example, there is a **Count** property that is an alias of the **Length** property.

### Example 2: Input an XML document

```
PS C:\> [xml]$Types = Get-Content $Pshome\Types.ps1xml
PS C:\> Select-Xml -Xml $Types -XPath "//MethodName"
```

This example shows how to use the *XML* parameter to provide an XML document to the **Select-Xml** cmdlet.

The first command uses the Get-Content cmdlet to get the content of the Types.ps1xml file and save it in the $Types variable.
The \[xml\] casts the variable as an XML object.

The second command uses the **Select-Xml** cmdlet to get the MethodName nodes in the Types.ps1xml file.
The command uses the *Xml* parameter to specify the XML content in the $Types variable and the *XPath* parameter to specify the path to the MethodName node.

### Example 3: Search PowerShell Help files

```
PS C:\> $Namespace = @{command = "http://schemas.microsoft.com/maml/dev/command/2004/10"; maml = "http://schemas.microsoft.com/maml/2004/10"; dev = "http://schemas.microsoft.com/maml/dev/2004/10"}

The second command saves the path to the help files in the $Path variable.If there are no help files in this path on your computer, use the Update-Help cmdlet to download the help files. For more information about Updatable Help, see about_Updatable_Help (https://go.microsoft.com/fwlink/?LinkId=235801).
PS C:\> $Path = "$Pshome\en-us\*dll-Help.xml"

The third command uses the **Select-Xml** cmdlet to search the XML for cmdlet names by finding Command:Name element anywhere in the files. It saves the results in the $Xml variable.**Select-Xml** returns a **SelectXmlInfo** object that has a Node property, which is a **System.Xml.XmlElement** object. The Node property has an InnerXML property, which contains the actual XML that is retrieved.
PS C:\> $Xml = Select-Xml -Path $Path -Namespace $Namespace -XPath "//command:name"

The fourth command sends the XML in the $Xml variable to the Format-Table cmdlet. The **Format-Table** command uses a calculated property to get the Node.InnerXML property of each object in the $Xml variable, trim the white space before and after the text, and display it in the table, along with the path to the source file.
PS C:\> $Xml | Format-Table @{Label="Name"; Expression= {($_.node.innerxml).trim()}}, Path -AutoSize

Name                    Path
----                    ----
Export-Counter          C:\Windows\system32\WindowsPowerShell\v1.0\en-us\Microsoft.PowerShell.Commands.Diagnostics.dll-Help.xml
Get-Counter             C:\Windows\system32\WindowsPowerShell\v1.0\en-us\Microsoft.PowerShell.Commands.Diagnostics.dll-Help.xml
Get-WinEvent            C:\Windows\system32\WindowsPowerShell\v1.0\en-us\Microsoft.PowerShell.Commands.Diagnostics.dll-Help.xml
Import-Counter          C:\Windows\system32\WindowsPowerShell\v1.0\en-us\Microsoft.PowerShell.Commands.Diagnostics.dll-Help.xml
Add-Computer            C:\Windows\system32\WindowsPowerShell\v1.0\en-us\Microsoft.PowerShell.Commands.Management.dll-Help.xml
Add-Content             C:\Windows\system32\WindowsPowerShell\v1.0\en-us\Microsoft.PowerShell.Commands.Management.dll-Help.xml
Checkpoint-Computer     C:\Windows\system32\WindowsPowerShell\v1.0\en-us\Microsoft.PowerShell.Commands.Management.dll-Help.xml
...
```

This example shows how to use the **Select-Xml** cmdlet to search the PowerShell XML-based cmdlet help files.
In this example, we'll search for the cmdlet name that serves as a title for each help file and the path to the help file.

The first command creates a hash table that represents the XML namespace that is used for the help files and saves it in the $Namespace variable.

### Example 4: Different ways to input XML

```
PS C:\> $Xml = @"
<?xml version="1.0" encoding="utf-8"?>
<Book>
  <projects>
    <project name="Book1" date="2009-01-20">
      <editions>
        <edition language="English">En.Book1.com</edition>
        <edition language="German">Ge.Book1.Com</edition>
        <edition language="French">Fr.Book1.com</edition>
        <edition language="Polish">Pl.Book1.com</edition>
      </editions>
    </project>
  </projects>
</Book>
"@

The second command uses the *Content* parameter of **Select-Xml** to specify the XML in the $Xml variable.
PS C:\> Select-Xml -Content $Xml -XPath "//edition" | foreach {$_.node.InnerXML}

En.Book1.com
Ge.Book1.Com
Fr.Book1.com
Pl.Book1.com

The third command is equivalent to the second. It uses a pipeline operator (|) to send the XML in the $Xml variable to the **Select-Xml** cmdlet.
PS C:\> $Xml | Select-Xml -XPath "//edition" | foreach {$_.node.InnerXML}

En.Book1.com
Ge.Book1.Com
Fr.Book1.com
Pl.Book1.com
```

This example shows two different ways to send XML to the **Select-Xml** cmdlet.

The first command saves a here-string that contains XML in the $Xml variable.
(For more information about here-strings, see about_Quoting_Rules.)

### Example 5: Use the default xmlns namespace

```
PS C:\> $SnippetNamespace = @{snip = "http://schemas.microsoft.com/PowerShell/Snippets"}

The second command uses the **Select-Xml** cmdlet to get the content of the Title element of each snippet. It uses the *Path* parameter to specify the Snippets directory and the *Namespace* parameter to specify the namespace in the $SnippetNamespace variable. The value of the *XPath* parameter is the "snip" namespace key, a colon (:), and the name of the Title element.The command uses a pipeline operator (|) to send each **Node** property that **Select-Xml** returns to the ForEach-Object cmdlet, which gets the title in the value of the **InnerXml** property of the node.
PS C:\> Select-Xml -Path $Home\Documents\WindowsPowerShell\Snippets -Namespace $SnippetNamespace -XPath "//snip:Title" | foreach {$_.Node.Innerxml}
```

This example shows how to use the **Select-Xml** cmdlet with XML documents that use the default xmlns namespace.
The example gets the titles of Windows PowerShell ISE user-created snippet files.
For information about snippets, see New-IseSnippet.

The first command creates a hash table for the default namespace that snippet XML files use and assigns it to the $SnippetNamespace variable.
The hash table value is the XMLNS schema URI in the snippet XML.
The hash table key name, snip, is arbitrary.
You can use any name that is not reserved, but you cannot use xmlns.

## PARAMETERS

### -Content

Specifies a string that contains the XML to search.
You can also pipe strings to **Select-Xml**.

```yaml
Type: System.String[]
Parameter Sets: Content
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -LiteralPath

Specifies the paths and file names of the XML files to search.
Unlike *Path*, the value of the *LiteralPath* parameter is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell PowerShell not to interpret any characters as escape sequences.

```yaml
Type: System.String[]
Parameter Sets: LiteralPath
Aliases: PSPath, LP

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Namespace

Specifies a hash table of the namespaces used in the XML.
Use the format @{\<namespaceName\> = \<namespaceValue\>}.

When the XML uses the default namespace, which begins with xmlns, use an arbitrary key for the namespace name.
You cannot use xmlns.
In the XPath statement, prefix each node name with the namespace name and a colon, such as //namespaceName:Node.

```yaml
Type: System.Collections.Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the path and file names of the XML files to search.
Wildcard characters are permitted.

```yaml
Type: System.String[]
Parameter Sets: Path
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -Xml

Specifies one or more XML nodes.

An XML document will be processed as a collection of XML nodes.
If you pipe an XML document to **Select-Xml**, each document node will be searched separately as it comes through the pipeline.

```yaml
Type: System.Xml.XmlNode[]
Parameter Sets: Xml
Aliases: Node

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -XPath

Specifies an XPath search query.
The query language is case-sensitive.
This parameter is required.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
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

### System.String or System.Xml.XmlNode

You can pipe a path or XML node to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.Commands.SelectXmlInfo

## NOTES

XPath is a standard language that is designed to identify parts of an XML document. For more
information about the XPath language, see
[XPath Reference](/dotnet/standard/data/xml/select-nodes-using-xpath-navigation) and the Selection
Filters section of [Event Selection](/previous-versions//aa385231(v=vs.85)).

## RELATED LINKS

[ConvertTo-Xml](ConvertTo-Xml.md)

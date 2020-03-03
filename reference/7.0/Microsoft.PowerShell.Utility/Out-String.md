---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Utility
ms.date: 12/13/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/out-string?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Out-String
---

# Out-String

## SYNOPSIS
Sends objects to the host as a series of strings.

## SYNTAX

### NoNewLineFormatting (Default)

```
Out-String [-Width <Int32>] [-NoNewline] [-InputObject <PSObject>] [<CommonParameters>]
```

### StreamFormatting

```
Out-String [-Stream] [-Width <Int32>] [-InputObject <PSObject>] [<CommonParameters>]
```

## DESCRIPTION

The `Out-String` cmdlet converts the objects that PowerShell manages into an array of strings. By
default, `Out-String` accumulates the strings and returns them as a single string, but you can use
the **Stream** parameter to direct `Out-String` to return one string at a time. This cmdlet lets you
search and manipulate string output as you would in traditional shells when object manipulation is
less convenient.

## EXAMPLES

### Example 1: Output text to the console as a string

This example sends a file's contents to the `Out-String` cmdlet and displays it in the PowerShell
console.

```powershell
Get-Content -Path C:\Test\Testfile.txt | Out-String
```

`Get-Content` sends the contents of the `Testfile.txt` file down the pipeline. Each line of the file
has its own properties. `Out-String` converts the objects into an array of strings and then displays
the contents as one string in the PowerShell console.

> [!NOTE]
> To compare the differences about how `Get-Content` and `Out-String` display the properties:
>
> `Get-Content -Path C:\Test\Testfile.txt | Select-Object -Property *`
>
> `Get-Content -Path C:\Test\Testfile.txt | Out-String | Select-Object -Property *`

### Example 2: Get the current culture and convert the data to strings

This example gets the regional settings for the current user and converts the object data to
strings.

```powershell
$C = Get-Culture | Select-Object -Property *
Out-String -InputObject $C -Width 100
```

The `$C` variable stores a **Selected.System.Globalization.CultureInfo** object. The object is the
result of `Get-Culture` sending output down the pipeline to `Select-Object`. The **Property**
parameter uses an asterisk (`*`) wildcard to specify all properties are contained in the object.

`Out-String` uses the **InputObject** parameter to specify the **CultureInfo** object stored in the
`$C` variable. The objects in `$C` are converted to a string. The **Width** parameter is set to 100
characters per line to prevent truncation.

> [!NOTE]
> To view the `Out-String` array, store the output to a variable and use an array index to view the
> elements. For more information about the array index, see
> [about_Arrays](../microsoft.powershell.core/about/about_arrays.md).
>
> `$str = Out-String -InputObject $C -Width 100`

### Example 3: Working with objects

This example demonstrates the difference between working with objects and working with strings. The
command displays an alias that includes the text **gcm**, the alias for `Get-Command`.

```powershell
Get-Alias | Out-String -Stream | Select-String -Pattern "gcm"
```

```Output
Alias           gcm -> Get-Command
```

`Get-Alias` gets the **System.Management.Automation.AliasInfo** objects, one for each alias, and
sends the objects down the pipeline. `Out-String` uses the **Stream** parameter to convert each
object to a string rather concatenating all the objects into a single string. The **System.String**
objects are sent down the pipeline and `Select-String` uses the **Pattern** parameter to find
matches for the text **gcm**.

> [!NOTE]
> If you omit the **Stream** parameter, the command displays all the aliases because `Select-String`
> finds the text **gcm** in the single string that `Out-String` returns.

### Example 4: Using the NoNewLine parameter

This example shows how the **NoNewLine** parameter removes new lines that are created by the
PowerShell formatter. New lines that are part of the string objects created with `Out-String` aren't
removed.

The example uses a special character (`` `n ``) to create a new line. For more information, see
[about_Special_Characters](/microsoft.powershell.core/about/about_special_characters).

```
PS> "a", "b`n", "c", "d" | Out-String
a
b

c
d

PS> "a", "b`n", "c", "d" | Out-String -NoNewline
ab
cd

PS> @{key='value'} | Out-String

Name   Value
----   -----
key    value

PS> @{key='value'} | Out-String -NoNewLine

Name    Value----     -----key     value
```

A string of characters is sent down the pipeline to `Out-String`. The default formatter displays the
output that includes new lines. The `` "b`n" `` includes the new line special character. When the
**NoNewline** parameter is used, the new lines created by the formatter are removed. But, the new
line created with the special character is preserved.

The key/value pair is an example of how `Out-String` uses the default formatter to add new lines.
When the **NoNewline** parameter is used, the new lines created by the formatter are removed.

## PARAMETERS

### -InputObject

Specifies the objects to be written to a string. Enter a variable that contains the objects, or type
a command or expression that gets the objects.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -NoNewline

Removes all newlines from output generated by the PowerShell formatter. Newlines that are part of
the string objects are preserved.

This parameter was introduced in PowerShell 6.0.

```yaml
Type: SwitchParameter
Parameter Sets: NoNewLineFormatting
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Stream

Indicates that the cmdlet sends a separate string for each object. By default, the strings for each
object are accumulated and sent as a single string.

```yaml
Type: SwitchParameter
Parameter Sets: StreamFormatting
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Width

Specifies the number of characters in each line of output. Any additional characters are truncated,
not wrapped. The **Width** parameter applies only to objects that are being formatted. If you omit
this parameter, the width is determined by the characteristics of the host program. The default
value for the PowerShell console is 80 characters.

```yaml
Type: Int32
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

You can send objects down the pipeline to `Out-String`.

## OUTPUTS

### System.String

`Out-String` returns the string that it creates from the input object.

## NOTES

The cmdlets that contain the `Out` verb don't format objects. The `Out` cmdlets send objects to the
formatter for the specified display destination.

The `Out` cmdlets don't have parameters that accept names or file paths. To send the output of a
PowerShell command to an `Out` cmdlet, use the pipeline. Or, you can store data in a variable and
use the **InputObject** parameter to pass the data to the cmdlet.

## RELATED LINKS

[Out-Default](../Microsoft.PowerShell.Core/Out-Default.md)

[Out-File](Out-File.md)

[Out-Host](../Microsoft.PowerShell.Core/Out-Host.md)

[Out-Null](../Microsoft.PowerShell.Core/Out-Null.md)

[Out-GridView](Out-GridView.md)

[Out-Printer](Out-Printer.md)

---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 09/29/2020
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/out-string?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Out-String
---

# Out-String

## SYNOPSIS
Outputs input objects as a strings.

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

The `Out-String` cmdlet converts input objects into strings. By default, `Out-String`
accumulates the strings and returns them as a single string, but you can use the **Stream**
parameter to direct `Out-String` to return one line at a time or create and array of strings. This
cmdlet lets you search and manipulate string output as you would in traditional shells when object
manipulation is less convenient.

## EXAMPLES

### Example 1: Get the current culture and convert the data to strings

This example gets the regional settings for the current user and converts the object data to
strings.

```powershell
$C = Get-Culture | Select-Object -Property *
Out-String -InputObject $C -Width 100
```

```Output
Parent                         : en
LCID                           : 1033
KeyboardLayoutId               : 1033
Name                           : en-US
IetfLanguageTag                : en-US
DisplayName                    : English (United States)
NativeName                     : English (United States)
EnglishName                    : English (United States)
TwoLetterISOLanguageName       : en
ThreeLetterISOLanguageName     : eng
ThreeLetterWindowsLanguageName : ENU
CompareInfo                    : CompareInfo - en-US
TextInfo                       : TextInfo - en-US
IsNeutralCulture               : False
CultureTypes                   : SpecificCultures, InstalledWin32Cultures, FrameworkCultures
NumberFormat                   : System.Globalization.NumberFormatInfo
DateTimeFormat                 : System.Globalization.DateTimeFormatInfo
Calendar                       : System.Globalization.GregorianCalendar
OptionalCalendars              : {System.Globalization.GregorianCalendar,
                                 System.Globalization.GregorianCalendar}
UseUserOverride                : True
IsReadOnly                     : False
```

The `$C` variable stores a **Selected.System.Globalization.CultureInfo** object. The object is the
result of `Get-Culture` sending output down the pipeline to `Select-Object`. The **Property**
parameter uses an asterisk (`*`) wildcard to specify all properties are contained in the object.

`Out-String` uses the **InputObject** parameter to specify the **CultureInfo** object stored in the
`$C` variable. The objects in `$C` are converted to a string.

> [!NOTE]
> To view the `Out-String` array, store the output to a variable and use an array index to view the
> elements. For more information about the array index, see
> [about_Arrays](../microsoft.powershell.core/about/about_arrays.md).
>
> `$str = Out-String -InputObject $C -Width 100`

### Example 2: Working with objects

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

### Example 3: Use the Width parameter to prevent truncation.

While most output from `Out-String` is wrapped to the next line, there are scenarios where the
output is truncated by the formatting system before being passed to `Out-String`. You can avoid
truncation using the **Width** parameter.

```powershell
PS> @{TestKey = ('x' * 200)} | Out-String
Name                           Value
----                           -----
TestKey                        xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx...

PS> @{TestKey = ('x' * 200)} | Out-String -Width 250

Name                           Value
----                           -----
TestKey                        xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

## PARAMETERS

### -InputObject

Specifies the objects to be written to a string. Enter a variable that contains the objects, or type
a command or expression that gets the objects.

```yaml
Type: System.Management.Automation.PSObject
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: NoNewLineFormatting
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Stream

Indicates that the cmdlet sends a separate string for each line of an input object. By default, the
strings for each object are accumulated and sent as a single string.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: StreamFormatting
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Width

Specifies the number of characters in each line of output. Any additional characters are wrapped to
the next line or truncated depending on the formatter cmdlet used. The **Width** parameter applies
only to objects that are being formatted. If you omit this parameter, the width is determined by the
characteristics of the host program. In terminal (console) windows, the current window width is used
as the default value. PowerShell console windows default to a width of 80 characters on
installation.

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

## RELATED LINKS

[about_Formatting](../Microsoft.PowerShell.Core/About/about_Format.ps1xml.md)

[Out-Default](../Microsoft.PowerShell.Core/Out-Default.md)

[Out-File](Out-File.md)

[Out-Host](../Microsoft.PowerShell.Core/Out-Host.md)

[Out-Null](../Microsoft.PowerShell.Core/Out-Null.md)

[Out-GridView](Out-GridView.md)

[Out-Printer](Out-Printer.md)

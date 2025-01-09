---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 01/09/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.utility/convertfrom-stringdata?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: ConvertFrom-StringData
---

# ConvertFrom-StringData

## SYNOPSIS
Converts a string containing one or more key and value pairs to a hash table.

## SYNTAX

```
ConvertFrom-StringData [-StringData] <String> [<CommonParameters>]
```

## DESCRIPTION

The `ConvertFrom-StringData` cmdlet converts a string that contains one or more key and value pairs
into a hash table. Because each key-value pair must be on a separate line, here-strings are often
used as the input format. By default, the **key** must be separated from the **value** by an equals
sign (`=`) character.

The `ConvertFrom-StringData` cmdlet is considered to be a safe cmdlet that can be used in the
**DATA** section of a script or function. When used in a **DATA** section, the contents of the
string must conform to the rules for a **DATA** section. For more information, see
[about_Data_Sections](../Microsoft.PowerShell.Core/About/about_Data_Sections.md).

`ConvertFrom-StringData` supports escape character sequences that are allowed by conventional
machine translation tools. That is, the cmdlet can interpret backslashes (`\`) as escape characters
in the string data by using the
[Regex.Unescape Method](/dotnet/api/system.text.regularexpressions.regex.unescape), instead of the
PowerShell backtick character (`` ` ``) that would normally signal the end of a line in a script.
Inside the here-string, the backtick character doesn't work. You can also preserve a literal
backslash in your results by escaping it with a preceding backslash, like this: `\\`. Unescaped
backslash characters, such as those that are commonly used in file paths, can render as illegal
escape sequences in your results.

## EXAMPLES

### Example 1: Convert a single-quoted here-string to a hash table

This example converts a single-quoted here-string of user messages into a hash table. In a
single-quoted string, values aren't substituted for variables and expressions aren't evaluated.
The `ConvertFrom-StringData` cmdlet converts the value in the `$Here` variable to a hash table.

```powershell
$Here = @'
Msg1 = The string parameter is required.
Msg2 = Credentials are required for this command.
Msg3 = The specified variable doesn't exist.
'@
ConvertFrom-StringData -StringData $Here
```

```Output
Name                           Value
----                           -----
Msg3                           The specified variable doesn't exist.
Msg2                           Credentials are required for this command.
Msg1                           The string parameter is required.
```

### Example 2: Convert a here-string containing a comment

This example converts a here-string that contains a comment and multiple key-value pairs into a hash
table.

```powershell
ConvertFrom-StringData -StringData @'
Name = Disks.ps1

# Category is optional.

Category = Storage
Cost = Free
'@
```

```Output
Name                           Value
----                           -----
Cost                           Free
Category                       Storage
Name                           Disks.ps1
```

The value of the **StringData** parameter is a here-string, instead of a variable that contains a
here-string. Either format is valid. The here-string includes a comment about one of the strings.
`ConvertFrom-StringData` ignores single-line comments, but the hash character (`#`) must be the
first non-whitespace character on the line.

### Example 3: Convert a string to a hash table

This example converts a regular double-quoted string (not a here-string) into a hash table and saves
it in the `$A` variable.

```powershell
$A = ConvertFrom-StringData -StringData "Top = Red `n Bottom = Blue"
$A
```

```Output
Name             Value
----             -----
Bottom           Blue
Top              Red
```

To satisfy the condition that each key-value pair must be on a separate line, the string uses the
PowerShell newline character (`` `n ``) to separate the pairs.

### Example 4: Use in the `DATA` section of a script

This example shows a `ConvertFrom-StringData` command used in the `DATA` section of a script.
The statements below the **DATA** section display the text to the user.

```powershell
$TextMsgs = DATA {
ConvertFrom-StringData @'
Text001 = The $Notebook variable contains the name of the user's system notebook.
Text002 = The $MyNotebook variable contains the name of the user's private notebook.
'@
}
$TextMsgs
```

```Output
Name             Value
----             -----
Text001          The $Notebook variable contains the name of the user's system notebook.
Text002          The $MyNotebook variable contains the name of the user's private notebook.
```

Because the text includes variable names, it must be enclosed in a single-quoted string so that the
variables are interpreted literally and not expanded. Variables aren't permitted in the `DATA`
section.

### Example 5: Use the pipeline operator to pass a string

This example shows that you can use a pipeline operator (`|`) to send a string to
`ConvertFrom-StringData`. The value of the `$Here` variable is piped to `ConvertFrom-StringData`
and the result in the `$Hash` variable.

```powershell
$Here = @'
Msg1 = The string parameter is required.
Msg2 = Credentials are required for this command.
Msg3 = The specified variable doesn't exist.
'@
$Hash = $Here | ConvertFrom-StringData
$Hash
```

```Output
Name     Value
----     -----
Msg3     The specified variable doesn't exist.
Msg2     Credentials are required for this command.
Msg1     The string parameter is required.
```

### Example 6: Use escape characters to add new lines and return characters

This example shows the use of escape characters to create new lines and return characters in source
data. The escape sequence `\n` is used to create new lines within a block of text that's associated
with a name or item in the resulting hash table.

```powershell
ConvertFrom-StringData @"
Vincentio = Heaven doth with us as we with torches do,\nNot light them for themselves; for if our virtues\nDid not go forth of us, 'twere all alike\nAs if we had them not.
Angelo = Let there be some more test made of my metal,\nBefore so noble and so great a figure\nBe stamp'd upon it.
"@ | Format-List
```

```Output
Name  : Angelo
Value : Let there be some more test made of my metal,
        Before so noble and so great a figure
        Be stamp'd upon it.

Name  : Vincentio
Value : Heaven doth with us as we with torches do,
        Not light them for themselves; for if our virtues
        Didn't go forth of us, 'twere all alike
        As if we had them not.
```

### Example 7: Use backslash escape character to correctly render a file path

This example shows how to use of the backslash escape character in the string data to allow a file
path to render correctly in the resulting `ConvertFrom-StringData` hash table. The double backslash
ensures that the literal backslash characters render correctly in the hash table output.

```powershell
ConvertFrom-StringData "Message=Look in c:\\Windows\\System32"
```

```Output
Name                           Value
----                           -----
Message                        Look in c:\Windows\System32
```

## PARAMETERS

### -StringData

Specifies the string to be converted. You can use this parameter or pipe a string to
`ConvertFrom-StringData`. The parameter name is optional.

The value of this parameter must be a string that contains one or more key-value pairs. Each
key-value pair must be on a separate line, or each pair must be separated by newline characters
(`` `n ``).

You can include comments in the string, but the comments can't be on the same line as a key-value
pair. `ConvertFrom-StringData` ignores single-line comments. The hash character (`#`) must be the
first non-whitespace character on the line. All characters on the line after the hash character
(`#`) are ignored. The comments aren't included in the hash table.

A here-string is a string consisting of one or more lines. Quotation marks within the here-string
are interpreted literally as part of the string data. For more information, see
[about_Quoting_Rules](../Microsoft.PowerShell.Core/About/about_Quoting_Rules.md).

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](../Microsoft.PowerShell.Core/About/about_CommonParameters.md).

## INPUTS

### System.String

You can pipe a string containing a key-value pair to this cmdlet.

## OUTPUTS

### System.Collections.Hashtable

This cmdlet returns a hash table that it creates from the key-value pairs.

## NOTES

A here-string is a string consisting of one or more lines within which quotation marks are
interpreted literally.

This cmdlet can be useful in scripts that display user messages in multiple spoken languages. You
can use the dictionary-style hash tables to isolate text strings from code, such as in resource
files, and to format the text strings for use in translation tools.

## RELATED LINKS

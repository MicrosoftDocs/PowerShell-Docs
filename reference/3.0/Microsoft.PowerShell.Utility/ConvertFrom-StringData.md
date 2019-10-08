---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
ms.date: 06/09/2017
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/convertfrom-stringdata?view=powershell-3.0&WT.mc_id=ps-gethelp
schema: 2.0.0
title: ConvertFrom-StringData
---
# ConvertFrom-StringData

## SYNOPSIS

Converts a string containing one or more key/value pairs to a hash table.

## SYNTAX

```
ConvertFrom-StringData [-StringData] <String> [<CommonParameters>]
```

## DESCRIPTION

The ConvertFrom-StringData cmdlet converts a string that contains one or more key/value pairs into a hash table.
Because each key/value pair must be on a separate line, here-strings are often used as the input format.

The ConvertFrom-StringData cmdlet is considered to be a safe cmdlet that can be used in the DATA section of a script or function.
When used in a DATA section, the contents of the string must conform to the rules for a DATA section.
For more information, see about_Data_Sections.

ConvertFrom-StringData supports escape character sequences that are allowed by conventional machine translation tools.
That is, the cmdlet can interpret backslashes (\\) as escape characters in the string data by using the [Regex.Unescape Method](https://msdn.microsoft.com/library/system.text.regularexpressions.regex.unescape), instead of the Windows PowerShell backtick character (\`) that would normally signal the end of a line in a script.
Inside the here-string, the backtick character does not work.
You can also preserve a literal backslash in your results by escaping it with a preceding backslash, like this:  \\\\.
Unescaped backslash characters, such as those that are commonly used in file paths, can render as illegal escape sequences in your results.

## EXAMPLES

### Example 1

```
PS> $here = @'
Msg1 = The string parameter is required.
Msg2 = Credentials are required for this command.
Msg3 = The specified variable does not exist.
'@
PS> convertfrom-stringdata -stringdata $here

Name                           Value
----                           -----
Msg3                           The specified variable does not exist.
Msg2                           Credentials are required for this command.
Msg1                           The string parameter is required.
```

These commands convert a single-quoted here-string of user messages into a hash table.
In a single-quoted string, values are not substituted for variables and expressions are not evaluated.

The first command creates a here-string and saves it in the $here variable.

The second command uses the ConvertFrom-StringData cmdlet to convert the here-string in the $here variable to a hash table.

### Example 2

```
PS> $p = @"
ISE = Windows PowerShell Integrated Scripting Environment
"@
PS> $p | get-member
TypeName: System.String

Name             MemberType            Definition
----             ----------            ----------
Clone            Method                System.Object Clone()

PS> $hash = convertfrom-stringdata -stringdata $p
PS> $hash | get-member
TypeName: System.Collections.Hashtable

Name              MemberType            Definition
----              ----------            ----------
Add               Method                System.Void Add(Object key, Object

```

These commands demonstrate that ConvertFrom-StringData actually converts a here-string to a hash table.

The first command creates a double-quoted here-string that includes one key/value" pair and saves it in the $p variable.

The second command uses a pipeline operator (|) to send the $p variable to the Get-Member cmdlet.
The result shows that $p is a string (System.String).

The third command uses the ConvertFrom-StringData cmdlet to convert the here-string in $p to a hash table.
The command stores the result in the $hash variable.

The final command uses a pipeline operator (|) to send the $hash variable to the Get-Member cmdlet.
The result shows that the content of the $hash variable is a hash table (System.Collections.Hashtable).

### Example 3

```
PS> convertfrom-stringdata -stringdata @'
Name = Disks.ps1

# Category is optional.

Category = Storage
Cost = Free
'@

Name                           Value
----                           -----
Cost                           Free
Category                       Storage
Name                           Disks.ps1
```

This command converts a single-quoted here-string that contains multiple key/value pairs into a hash table.

In this command, the value of the StringData parameter is a here-string, instead of a variable that contains a here-string.
Either format is valid.

The here-string includes a comment about one of the strings.
Comments are valid in strings, provided that the comment is on a different line than a key/value pair.

### Example 4

```
PS> $a = convertfrom-stringdata -stringdata "Top = Red `n Bottom = Blue"
PS> "Top = " + $a.Top
Top = Red
PS> "Bottom = " + $a.Bottom
Bottom = Blue
```

This example converts a regular double-quoted string (not a here-string) into a hash table and saves it in the $a variable.

To satisfy the condition that each key/value pair must be on a separate line, it uses the Windows PowerShell newline character (\`n) to separate the pairs.

The result is a hash table of the input.
The remaining commands display the output.

### Example 5

```
PS> $TextMsgs = DATA {
ConvertFrom-StringData @'
Text001 = The $Notebook variable contains the name of the user's system notebook.
Text002 = The $MyNotebook variable contains the name of the user's private notebook.
'@
}
PS> $TextMsgs.Text001
The $Notebook variable contains the name of the user's system notebook.
PS> $TextMsgs.Text002
The $MyNotebook variable contains the name of the user's private notebook.
```

This example shows a ConvertFrom-StringData command used in the DATA section of a script.
The statements below the DATA section display the text to the user.

Because the text includes variable names, it must be enclosed in a single-quoted string so that the variables are interpreted literally and not expanded.
Variables are not permitted in the DATA section.

### Example 6

```
PS> $here = @'
Msg1 = The string parameter is required.
Msg2 = Credentials are required for this command.
Msg3 = The specified variable does not exist.
'@
PS> $hash = $here | convertfrom-stringdata
PS> $hash

Name     Value
----     -----
Msg3     The specified variable does not exist.
Msg2     Credentials are required for this command.
Msg1     The string parameter is required.
```

This example shows that you can use a pipeline operator (|) to send a string to ConvertFrom-StringData.

The first command saves a here-string in the $here variable.
The second command uses a pipeline operator (|) to send the $here variable to ConvertFrom-StringData.
The command saves the result in the $hash variable.

The final command displays the contents of the $hash variable.

### Example 7

```
PS> ConvertFrom-StringData @"
Vincentio = Heaven doth with us as we with torches do,\nNot light them for themselves; for if our virtues\nDid not go forth of us, 'twere all alike\nAs if we had them not.
Angelo = Let there be some more test made of my metal,\nBefore so noble and so great a figure\nBe stamp'd upon it.
"@ | Format-List

Name  : Angelo

Value : Let there be some more test made of my metal,
        Before so noble and so great a figure
        Be stamp'd upon it.

Name  : Vincentio
Value : Heaven doth with us as we with torches do,
        Not light them for themselves; for if our virtues
        Did not go forth of us, 'twere all alike
        As if we had them not.
```

This example shows the use of escape characters to create new lines and return characters in ConvertFrom-StringData.
In this example, the escape sequence **\n** is used to create new lines within a block of text (the value, in the resulting hash table) that is associated with a name or item (the name, in the resulting hash table).

### Example 8

```
PS> ConvertFrom-StringData "Message=Look in c:\\Windows\\System32"
Name                           Value
----                           -----
Message                        Look in c:\Windows\System32
```

This example shows how to use of the backslash escape character in the string data to allow a file path to render correctly in the resulting ConvertFrom-StringData hash table.
The double backslash ensures that the literal backslash characters render correctly in the hash table output.

## PARAMETERS

### -StringData

Specifies the string to be converted.
You can use this parameter or pipe a string to ConvertFrom-StringData.
The parameter name is optional.

The value of this parameter must be a string that is enclosed in single quotation marks (a single-quoted string) or a string that is enclosed in double quotation marks (a double-quoted string) or a here-string containing one or more key/value pairs.
Each key/value pair must be on a separate line, or each pair must be separated by newline characters (\`n).

You can include comments in the string, but the comments cannot be on the same line as a key/value pair.
The comments are not included in the hash table.

A here-string is a string consisting of one or more lines within which quotation marks are interpreted literally.
For more information, see about_Quoting_Rules.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a string containing a key/value pair to ConvertFrom-StringData.

## OUTPUTS

### System.Collections.Hashtable

ConvertFrom-StringData returns a hash table that it creates from the key/value pairs.

## NOTES

- A here-string is a string consisting of one or more lines within which quotation marks are interpreted literally. For more information, see about_Quoting_Rules.

  ConvertFrom-StringData can be useful in scripts that display user messages in multiple spoken languages.
  You can use the dictionary-style hash tables to isolate text strings from code, such as in resource files, and to format the text strings for use in translation tools.

## RELATED LINKS

[about_Quoting_Rules](../Microsoft.PowerShell.Core/About/about_Quoting_Rules.md)

[about_Script_Internationalization](../Microsoft.PowerShell.Core/About/about_Script_Internationalization.md)

[about_Data_Sections](../Microsoft.PowerShell.Core/About/about_Data_Sections.md)



---
description: Explains Data sections, which isolate text strings and other read-only data from script logic. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 04/23/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_data_sections?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Data_Sections
---
# About Data Sections

## Short Description
Explains Data sections, which isolate text strings and other read-only
data from script logic.

## Long Description

Scripts that are designed for PowerShell can have one or more Data sections
that contain only data. You can include one or more Data sections in any
script, function, or advanced function. The content of the Data section is
restricted to a specified subset of the PowerShell scripting language.

Separating data from code logic makes it easier to identify and manage both
logic and data. It lets you have separate string resource files for text, such
as error messages and Help strings. It also isolates the code logic, which
facilitates security and validation tests.

In PowerShell, the Data section is used to support script internationalization.
You can use Data sections to make it easier to isolate, locate, and process
strings that will be translated into many user interface (UI) languages.

The Data section is a PowerShell 2.0 feature. Scripts with Data sections will
not run in PowerShell 1.0 without revision.

### Syntax

The syntax for a Data section is as follows:

```
DATA [<variable-name>] [-supportedCommand <cmdlet-name>] {
    <Permitted content>
}
```

The Data keyword is required. It is not case-sensitive. The permitted content
is limited to the following elements:

- All PowerShell operators, except `-match`
- `If`, `Else`, and `ElseIf` statements
- The following automatic variables: `$PsCulture`, `$PsUICulture`, `$True`,
  `$False`, and `$Null`
- Comments
- Pipelines
- Statements separated by semicolons (`;`)
- Literals, such as the following:

  ```powershell
  a
  1
  1,2,3
  "PowerShell 2.0"
  @( "red", "green", "blue" )
  @{ a = 0x1; b = "great"; c ="script" }
  [XML] @'
  <p> Hello, World </p>
  '@
  ```

- Cmdlets that are permitted in a Data section. By default, only the
  `ConvertFrom-StringData` cmdlet is permitted.
- Cmdlets that you permit in a Data section by using the `-SupportedCommand`
  parameter.

When you use the `ConvertFrom-StringData` cmdlet in a Data section, you can
enclose the key-value pairs in single-quoted or double-quoted strings or in
single-quoted or double-quoted here-strings. However, strings that contain
variables and subexpressions must be enclosed in single-quoted strings or in
single-quoted here-strings so that the variables are not expanded and the
subexpressions are not executable.

### -SupportedCommand

The `-SupportedCommand` parameter allows you to indicate that a cmdlet or
function generates only data. It is designed to allow users to include cmdlets
and functions in a data section that they have written or tested.

The value of `-SupportedCommand` is a comma-separated list of one or more
cmdlet or function names.

For example, the following data section includes a user-written cmdlet,
`Format-XML`, that formats data in an XML file:

```powershell
DATA -supportedCommand Format-Xml
{
    Format-Xml -Strings string1, string2, string3
}
```

### Using a Data Section

To use the content of a Data section, assign it to a variable and use variable
notation to access the content.

For example, the following data section contains a `ConvertFrom-StringData`
command that converts the here-string into a hash table. The hash table is
assigned to the `$TextMsgs` variable.

The `$TextMsgs` variable is not part of the data section.

```powershell
$TextMsgs = DATA {
    ConvertFrom-StringData -StringData @'
Text001 = Windows 7
Text002 = Windows Server 2008 R2
'@
}
```

To access the keys and values in hash table in `$TextMsgs`, use the following
commands.

```powershell
$TextMsgs.Text001
$TextMsgs.Text002
```

Alternately, you can put the variable name in the definition of the Data section. For example:

```powershell
DATA TextMsgs {
    ConvertFrom-StringData -StringData @'
Text001 = Windows 7
Text002 = Windows Server 2008 R2
'@
}

$TextMsgs
```

The result is the same as the previous example.

```Output
Name                           Value
----                           -----
Text001                        Windows 7
Text002                        Windows Server 2008 R2
```

### Examples

Simple data strings.

```powershell
DATA {
    "Thank you for using my PowerShell Organize.pst script."
    "It is provided free of charge to the community."
    "I appreciate your comments and feedback."
}
```

Strings that include permitted variables.

```powershell
DATA {
    if ($null) {
        "To get help for this cmdlet, type get-help new-dictionary."
    }
}
```

A single-quoted here-string that uses the `ConvertFrom-StringData` cmdlet:

```powershell
DATA {
    ConvertFrom-StringData -stringdata @'
Text001 = Windows 7
Text002 = Windows Server 2008 R2
'@
}
```

A double-quoted here-string that uses the `ConvertFrom-StringData` cmdlet:

```powershell
DATA  {
    ConvertFrom-StringData -stringdata @"
Msg1 = To start, press any key.
Msg2 = To exit, type "quit".
"@
}
```

A data section that includes a user-written cmdlet that generates data:

```powershell
DATA -supportedCommand Format-XML {
    Format-Xml -strings string1, string2, string3
}
```

## See Also

[about_Automatic_Variables](about_Automatic_Variables.md)

[about_Comparison_Operators](about_Comparison_Operators.md)

[about_Hash_Tables](about_Hash_Tables.md)

[about_If](about_If.md)

[about_Operators](about_Operators.md)

[about_Quoting_Rules](about_Quoting_Rules.md)

[about_Script_Internationalization](about_Script_Internationalization.md)

[ConvertFrom-StringData](xref:Microsoft.PowerShell.Utility.ConvertFrom-StringData)

[Import-LocalizedData](xref:Microsoft.PowerShell.Utility.Import-LocalizedData)

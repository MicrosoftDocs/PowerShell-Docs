---
description: Explains Data sections, which isolate text strings and other read-only data from script logic.
Locale: en-US
ms.date: 01/09/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_data_sections?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Data_Sections
---
# about_Data_Sections

## Short description

Explains `DATA` sections, which isolate text strings and other read-only
data from script logic.

## Long description

Scripts that are designed for PowerShell can have one or more `DATA` sections
that contain only data. You can include one or more `DATA` sections in any
script, function, or advanced function. The content of the `DATA` section is
restricted to a specified subset of the PowerShell scripting language.

Separating data from code logic makes it easier to identify and manage both
logic and data. It lets you have separate string resource files for text, such
as error messages and Help strings. It also isolates the code logic, which
facilitates security and validation tests.

In PowerShell, you can use the `DATA` section to support script
internationalization. You can use `DATA` sections to make it easier to isolate,
locate, and process strings that can be translated into other languages.

The `DATA` section was added in PowerShell 2.0 feature.

### Syntax

The syntax for a `DATA` section is as follows:

```Syntax
DATA [<variable-name>] [-supportedCommand <cmdlet-name>] {
    <Permitted content>
}
```

The `DATA` keyword is required. It isn't case-sensitive. The permitted content
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

- Cmdlets that are permitted in a `DATA` section. By default, only the
  `ConvertFrom-StringData` cmdlet is permitted.
- Cmdlets that you permit in a `DATA` section by using the `-SupportedCommand`
  parameter.

When you use the `ConvertFrom-StringData` cmdlet in a `DATA` section, you can
enclose the key-value pairs in single-quoted or double-quoted strings or in
single-quoted or double-quoted here-strings. However, strings that contain
variables and subexpressions must be enclosed in single-quoted strings or in
single-quoted here-strings so that the variables aren't expanded and the
subexpressions aren't executable.

### -SupportedCommand

The **SupportedCommand** parameter allows you to indicate that a cmdlet or
function generates only data. It's designed to allow users to include cmdlets
and functions in a `DATA` section that they have written or tested.

The value of **SupportedCommand** is a comma-separated list of one or more
cmdlet or function names.

For example, the following `DATA` section includes a user-written cmdlet,
`Format-Xml`, that formats data in an XML file:

```powershell
DATA -supportedCommand Format-Xml
{
    Format-Xml -Strings string1, string2, string3
}
```

### Using a `DATA` Section

To use the content of a `DATA` section, assign it to a variable and use variable
notation to access the content.

For example, the following `DATA` section contains a `ConvertFrom-StringData`
command that converts the here-string into a hash table. The hash table is
assigned to the `$TextMsgs` variable.

The `$TextMsgs` variable isn't part of the `DATA` section.

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

Alternately, you can put the variable name in the definition of the `DATA`
section. For example:

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

## See also

- [about_Automatic_Variables][01]
- [about_Comparison_Operators][02]
- [about_Hash_Tables][03]
- [about_If][04]
- [about_Operators][05]
- [about_Quoting_Rules][06]
- [about_Script_Internationalization][07]
- [ConvertFrom-StringData][08]
- [Import-LocalizedData][09]

<!-- link references -->
[01]: about_Automatic_Variables.md
[02]: about_Comparison_Operators.md
[03]: about_Hash_Tables.md
[04]: about_If.md
[05]: about_Operators.md
[06]: about_Quoting_Rules.md
[07]: about_Script_Internationalization.md
[08]: xref:Microsoft.PowerShell.Utility.ConvertFrom-StringData
[09]: xref:Microsoft.PowerShell.Utility.Import-LocalizedData

---
description: Describes how to set custom default values for cmdlet parameters and advanced functions.
Locale: en-US
ms.date: 01/02/2025
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_parameters_default_values?view=powershell-7.4&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Parameters_Default_Values
---
# about_Parameters_Default_Values

## Short description

Describes how to set custom default values for cmdlet parameters, advanced
functions, and scripts.

## Long description

The `$PSDefaultParameterValues` preference variable lets you specify custom
default parameter values for any cmdlet, advanced function, or script that uses
the **CmdletBinding** attribute. The defined values are used unless you specify
other values on the command line.

This feature is useful in the following scenarios:

- specifying the same parameter value every time you use the command
- specifying a particular parameter value that's difficult to remember, such as
  an email server name or project GUID

The `$PSDefaultParameterValues` variable has no default value. To save the
settings for use in future sessions, add the variable assignment to your
PowerShell profile.

`$PSDefaultParameterValues` was introduced in PowerShell 3.0.

## Syntax

The `$PSDefaultParameterValues` variable is an object type of
**System.Management.Automation.DefaultParameterDictionary**. The
**DefaultParameterDictionary** type is a hashtable with some extra validation
for the format of the keys. The hashtable contains key-value pairs where:

- the _key_ has the format `CommandName:ParameterName`
- the _value_ is default value for the parameter or a **ScriptBlock** that
  returns the default value

For the _key_, the **CommandName** must be the name of a cmdlet, advanced
function, or script file that uses the **CmdletBinding** attribute. The script
name must match the name as reported by
`(Get-Command -Name .\script.ps1).Name`.

> [!NOTE]
> PowerShell doesn't prevent you from specifying an alias for the
> **CommandName**. However, there are cases where the definition is ignored or
> causes an error. You should avoid defining default values for command
> aliases.

The _value_ can be an object of a type that's compatible with the parameter or
a **ScriptBlock** that returns such a value. When the value is a script block,
PowerShell evaluates the script block and uses the result for the parameter
value. If the specified parameter expects a **ScriptBlock** type, you must
enclose the value in another set of braces. When PowerShell evaluates the outer
**ScriptBlock**, the result is the inner **ScriptBlock**. The inner
**ScriptBlock** becomes the new default parameter value.

For example:

```powershell
$PSDefaultParameterValues = @{
    'Invoke-Command:ScriptBlock' = { {Get-Process} }
}
```

## Examples

Use the `Add()` and `Remove()` methods to add or remove a specific key-value
pair from `$PSDefaultParameterValues` without overwriting other existing
key-value pairs.

```powershell
$PSDefaultParameterValues.Add('CmdletName:ParameterName', 'DefaultValue')
$PSDefaultParameterValues.Remove('CmdletName:ParameterName')
```

Use indexing or member access to change the value of an existing key-value
pair. For example:

```powershell
$PSDefaultParameterValues.'CommandName:ParameterName'='DefaultValue2'
$PSDefaultParameterValues['CommandName:ParameterName']='DefaultValue1'
```

### Assign values to `$PSDefaultParameterValues`

To define default values for cmdlet parameters, assign a hashtable containing
the appropriate key-value pairs to the `$PSDefaultParameterValues` variable.
The hashtable can contain multiple key-value pairs. This example sets default
values for the `Send-MailMessage:SmtpServer` and `Get-WinEvent:LogName` keys.

```powershell
$PSDefaultParameterValues = @{
  'Send-MailMessage:SmtpServer'='Server123'
  'Get-WinEvent:LogName'='Microsoft-Windows-PrintService/Operational'
}
```

The cmdlet and parameter names can contain wildcard characters. Use `$true` and
`$false` to set values for switch parameters, such as **Verbose**. This example
sets the common parameter **Verbose** to `$true` for all commands.

```powershell
$PSDefaultParameterValues = @{'*:Verbose'=$true}
```

If a parameter accepts multiple values, you can provide multiple default values
using an array. This example sets the default value of the
`Invoke-Command:ComputerName` key to an array containing the string values
`Server01` and `Server02`.

```powershell
$PSDefaultParameterValues = @{
  'Invoke-Command:ComputerName' = 'Server01','Server02'
}
```

### View defined values

Consider the following definition of `$PSDefaultParameterValues`:

```powershell
$PSDefaultParameterValues = @{
  'Send-MailMessage:SmtpServer' = 'Server123'
  'Get-WinEvent:LogName' = 'Microsoft-Windows-PrintService/Operational'
  'Get-*:Verbose' = $true
}
```

You can view the defined values by entering `$PSDefaultParameterValues` at the
command prompt.

```powershell
PS> $PSDefaultParameterValues

Name                           Value
----                           -----
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get-*:Verbose                  True
Send-MailMessage:SmtpServer    Server123
```

You can use indexing or member access to get a specific value.

```powershell
PS> $PSDefaultParameterValues['Send-MailMessage:SmtpServer'] # index notation
Server123
PS> $PSDefaultParameterValues.'Get-*:Verbose' # member access notation
True
```

### Use a script block for the default value

You can use a script block to specify different default values for a parameter
under different conditions. PowerShell evaluates the script block and uses the
result as the default parameter value.

The `Format-Table:AutoSize` key sets that switch parameter to a default value
of `$true` The `if` statement contains a condition that the `$Host.Name` must
be `ConsoleHost`.

```powershell
$PSDefaultParameterValues = @{
  'Format-Table:AutoSize' = { if ($Host.Name -eq 'ConsoleHost'){$true} }
}
```

If a parameter accepts a **ScriptBlock** value, enclose the **ScriptBlock** in
another set of braces. When PowerShell evaluates the outer **ScriptBlock**, the
result is the inner **ScriptBlock**. The inner **ScriptBlock** becomes the new
default parameter value.

```powershell
$PSDefaultParameterValues = @{
  'Invoke-Command:ScriptBlock' = { {Get-EventLog -Log System} }
}
```

### Add values to an existing `$PSDefaultParameterValues` variable

To add a value to `$PSDefaultParameterValues`, use the `Add()` method. Adding a
value doesn't affect the hashtable's existing values. Use a comma (`,`) to
separate the _key_ from the _value_.

```powershell
$PSDefaultParameterValues.Add('Get-Process:Name', 'PowerShell')
```

The hashtable created in the prior example is updated with a new key-value
pair.

```powershell
PS> $PSDefaultParameterValues

Name                           Value
----                           -----
Get-Process:Name               PowerShell
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get-*:Verbose                  True
Send-MailMessage:SmtpServer    Server123
```

### Remove a value from `$PSDefaultParameterValues`

To remove a value from `$PSDefaultParameterValues`, use the `Remove()` method.
Removing a value doesn't affect the hashtable's existing values.

This example removes the key-value pair that was added in the previous example.

```powershell
PS> $PSDefaultParameterValues.Remove('Get-Process:Name')
PS> $PSDefaultParameterValues

Name                           Value
----                           -----
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get-*:Verbose                  True
Send-MailMessage:SmtpServer    Server123
```

### Change a value in `$PSDefaultParameterValues`

Use indexing or member access to change the default value of an existing
key-value pair. In this example, the default value for the
`Send-MailMessage:SmtpServer` key is changed to a new value of **ServerXYZ**.

```powershell
PS> $PSDefaultParameterValues['Send-MailMessage:SmtpServer']='ServerXYZ'
PS> $PSDefaultParameterValues

Name                           Value
----                           -----
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get-*:Verbose                  True
Send-MailMessage:SmtpServer    ServerXYZ
```

### Disable or re-enable `$PSDefaultParameterValues`

You can temporarily disable and then re-enable `$PSDefaultParameterValues`.
Disabling `$PSDefaultParameterValues` is useful if you're running scripts that
need different default parameter values.

To disable `$PSDefaultParameterValues`, add a key of `Disabled` with a value of
`$true`. The values in `$PSDefaultParameterValues` are preserved, but aren't
used.

```powershell
PS> $PSDefaultParameterValues.Add('Disabled', $true)
PS> $PSDefaultParameterValues

Name                           Value
----                           -----
Disabled                       True
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get-*:Verbose                  True
Send-MailMessage:SmtpServer    ServerXYZ
```

To re-enable `$PSDefaultParameterValues`, remove the `Disabled` key or change
the value of the `Disabled` key to `$false`.

```powershell
PS> $PSDefaultParameterValues.Disabled = $false
PS> $PSDefaultParameterValues

Name                           Value
----                           -----
Disabled                       False
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get-*:Verbose                  True
Send-MailMessage:SmtpServer    ServerXYZ
```

## See also

- [about_CommonParameters][01]
- [about_Functions_Advanced][02]
- [about_Functions_CmdletBindingAttribute][03]
- [about_Hash_Tables][04]
- [about_Preference_Variables][05]
- [about_Profiles][06]
- [about_Script_Blocks][07]

<!-- link references -->
[01]: about_CommonParameters.md
[02]: about_Functions_Advanced.md
[03]: about_Functions_CmdletBindingAttribute.md
[04]: about_Hash_Tables.md
[05]: about_Preference_Variables.md
[06]: about_Profiles.md
[07]: about_Script_Blocks.md

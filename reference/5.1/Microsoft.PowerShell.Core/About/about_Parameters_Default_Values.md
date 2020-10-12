---
description:  Describes how to set custom default values for cmdlet parameters and advanced functions. 
keywords: powershell,cmdlet
Locale: en-US
ms.date: 5/31/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.core/about/about_parameters_default_values?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Parameters_Default_Values
---
# About Parameters Default Values

## Short description

Describes how to set custom default values for cmdlet parameters and advanced
functions.

## Long description

The `$PSDefaultParameterValues` preference variable lets you specify custom
default values for any cmdlet or advanced function. Cmdlets and advanced
functions use the custom default value unless you specify another value in the
command.

The authors of cmdlets and advanced functions set standard default values for
their parameters. Typically, the standard default values are useful, but they
might not be appropriate for all environments.

This feature is especially useful when you must specify the same alternate
parameter value nearly every time you use the command or when a particular
parameter value is difficult to remember, such as an email server name or
project GUID.

If the desired default value varies predictably, you can specify a script block
that provides different default values for a parameter under different
conditions.

`$PSDefaultParameterValues` was introduced in PowerShell 3.0.

## Syntax

The `$PSDefaultParameterValues` variable is a hash table that validates the
format of keys as an object type of
**System.Management.Automation.DefaultParameterDictionary**. The hash table
contains **Key/Value** pairs. A **Key** is in the format
`CmdletName:ParameterName`. A **Value** is the **DefaultValue** or
**ScriptBlock** assigned to the key.

The syntax of the `$PSDefaultParameterValues` preference variable is as
follows:

```
$PSDefaultParameterValues=@{"CmdletName:ParameterName"="DefaultValue"}

$PSDefaultParameterValues=@{ "CmdletName:ParameterName"={{ScriptBlock}} }

$PSDefaultParameterValues["Disabled"]=$True | $False
```

Wildcard characters are permitted in the **CmdletName** and **ParameterName**
values.

To set, change, add, or remove a specific **Key/Value** pair from
`$PSDefaultParameterValues`, use the methods to edit a standard hash table. For
example, the **Add** and **Remove** methods. These methods don't overwrite
other values in the hash table.

There's another syntax that doesn't overwrite an existing
`$PSDefaultParameterValues` hash table. To add or change a specific
**Key/Value** pair, use the following syntax:

```
$PSDefaultParameterValues["CmdletName:ParameterName"]="DefaultValue"
```

The **CmdletName** must be the name of a cmdlet or the name of an advanced
function that uses the **CmdletBinding** attribute. You can't use
`$PSDefaultParameterValues` to specify default values for scripts or simple
functions.

The **DefaultValue** can be an object or a script block. If the value is a
script block, PowerShell evaluates the script block and uses the result as the
parameter value. When the specified parameter accepts a script block value,
enclose the script block value in a second set of braces, such as:

```powershell
$PSDefaultParameterValues=@{ "Invoke-Command:ScriptBlock"={{Get-Process}} }
```

For more information, see the following documents:

- [about_Hash_Tables](about_Hash_Tables.md)
- [about_Script_Blocks](about_Script_Blocks.md)
- [about_Preference_Variables](about_Preference_Variables.md)

## Examples

### How to set \$PSDefaultParameterValues

`$PSDefaultParameterValues` is a preference variable, so it exists only in the
session in which it's set. It has no default value.

To set `$PSDefaultParameterValues`, type the variable name and one or more
**Key/Value** pairs. If you run another `$PSDefaultParameterValues` command, it
overwrites the existing hash table.

For examples about how to change **Key/Value** pairs without overwriting
existing hash table values, see
[How to add values to \$PSDefaultParameterValues](#how-to-add-values-to-psdefaultparametervalues)
or
[How to change values in \$PSDefaultParameterValues](#how-to-change-values-in-psdefaultparametervalues).

To save `$PSDefaultParameterValues` for future sessions, add a
`$PSDefaultParameterValues` command to your PowerShell profile. For more
information, see [about_Profiles](about_Profiles.md).

#### Set a custom default value

The **Key/Value** pair sets the `Send-MailMessage:SmtpServer` key to a custom
default value of **Server123**.

```powershell
$PSDefaultParameterValues = @{
  "Send-MailMessage:SmtpServer"="Server123"
}
```

#### Set default values for multiple parameters

To set default values for multiple parameters, separate each **Key/Value** pair
with a semicolon (`;`). The `Send-MailMessage:SmtpServer` and
`Get-WinEvent:LogName` keys are set to custom default values.

```powershell
$PSDefaultParameterValues = @{
  "Send-MailMessage:SmtpServer"="Server123";
  "Get-WinEvent:LogName"="Microsoft-Windows-PrintService/Operational"
}
```

#### Use wildcards and switch parameters

The cmdlet and parameter names can contain wildcard characters. Use `$True` and
`$False` to set values for switch parameters, such as **Verbose**. The common
parameter's **Verbose** parameter is set to `$True` for all commands.

```powershell
$PSDefaultParameterValues = @{"*:Verbose"=$True}
```

#### Use an array for the default value

If a parameter can accept multiple values, an array, you can set multiple
values as the default values. The default value of the
`Invoke-Command:ComputerName` key is set to an array value of **Server01** and
**Server02**.

```powershell
$PSDefaultParameterValues = @{
  "Invoke-Command:ComputerName"="Server01","Server02"
}
```

#### Use a script block

You can use a script block to specify different default values for a parameter
under different conditions. PowerShell evaluates the script block and uses the
result as the default parameter value.

The `Format-Table:AutoSize` key sets that switch parameter to a default value
of **True**. The `If` statement contains a condition that the `$host.Name` must
be the PowerShell console, **ConsoleHost**.

```powershell
$PSDefaultParameterValues=@{
  "Format-Table:AutoSize"={if ($host.Name -eq "ConsoleHost"){$True}}
}
```

If a parameter accepts a script block value, enclose the script block in an
extra set of braces. When PowerShell evaluates the outer script block, the
result is the inner script block, and that is set as the default parameter
value.

The `Invoke-Command:ScriptBlock` key set to a default value of the **System
event log** because the script block is enclosed in a second set of braces. The
result of the script block is passed to the `Invoke-Command` cmdlet.

```powershell
$PSDefaultParameterValues=@{
  "Invoke-Command:ScriptBlock"={{Get-EventLog -Log System}}
}
```

### How to get \$PSDefaultParameterValues

The hash table values are displayed by entering `$PSDefaultParameterValues` at
the PowerShell prompt.

A `$PSDefaultParameterValues` hash table is set with three **Key/Value** pairs.
This hash table is used in the following examples that describe how to add,
change, and remove values from `$PSDefaultParameterValues`.

```
PS> $PSDefaultParameterValues = @{
  "Send-MailMessage:SmtpServer"="Server123"
  "Get-WinEvent:LogName"="Microsoft-Windows-PrintService/Operational"
  "Get-*:Verbose"=$True
}

PS> $PSDefaultParameterValues

Name                           Value
----                           -----
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get-*:Verbose                  True
Send-MailMessage:SmtpServer    Server123
```

To get the value of a specific `CmdletName:ParameterName` key, use the
following syntax:

```
$PSDefaultParameterValues["CmdletName:ParameterName"]
```

For example, to get the value for the `Send-MailMessage:SmtpServer` key.

```
PS> $PSDefaultParameterValues["Send-MailMessage:SmtpServer"]
Server123
```

### How to add values to \$PSDefaultParameterValues

To add a value to `$PSDefaultParameterValues`, use the **Add** method. Adding a
value doesn't affect the hash table's existing values.

Use a comma (`,`) to separate the **Key** from the **Value**. The following
syntax shows how to use the **Add** method for `$PSDefaultParameterValues`.

```
PS> $PSDefaultParameterValues.Add("CmdletName:ParameterName", "DefaultValue")
```

The hash table created in the prior example is updated with a new **Key/Value**
pair. The **Add** method sets the `Get-Process:Name` key to the value
**PowerShell**.

```powershell
$PSDefaultParameterValues.Add("Get-Process:Name", "PowerShell")
```

The following syntax accomplishes the same result.

```powershell
$PSDefaultParameterValues["Get-Process:Name"]="PowerShell"
```

The `$PSDefaultParameterValues` variable displays the updated hash table. The
`Get-Process:Name` key was added.

```
PS> $PSDefaultParameterValues

Name                           Value
----                           -----
Get-Process:Name               PowerShell
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get-*:Verbose                  True
Send-MailMessage:SmtpServer    Server123
```

### How to remove values from \$PSDefaultParameterValues

To remove a value from `$PSDefaultParameterValues`, use the **Remove** method
of hash tables. Removing a value doesn't affect the hash table's existing
values.

The following syntax shows how to use the **Remove** method on
`$PSDefaultParameterValues`.

```
PS> $PSDefaultParameterValues.Remove("CmdletName:ParameterName")
```

In this example, the hash table created in the prior example is updated to
remove a **Key/Value** pair. The **Remove** method removes the
`Get-Process:Name` key.

```powershell
$PSDefaultParameterValues.Remove("Get-Process:Name")
```

The `$PSDefaultParameterValues` variable displays the updated hash table. The
`Get-Process:Name` key was removed.

```
PS> $PSDefaultParameterValues

Name                           Value
----                           -----
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get-*:Verbose                  True
Send-MailMessage:SmtpServer    Server123
```

### How to change values in \$PSDefaultParameterValues

Changes to a specific value don't affect existing hash table values. To change
a specific **Key/Value** pair in `$PSDefaultParameterValues`, use the following
syntax:

```
PS> $PSDefaultParameterValues["CmdletName:ParameterName"]="DefaultValue"
```

In this example, the hash table created in the prior example is updated to
change a **Key/Value** pair. The following command changes the
`Send-MailMessage:SmtpServer` key to a new value of **ServerXYZ**.

```powershell
$PSDefaultParameterValues["Send-MailMessage:SmtpServer"]="ServerXYZ"
```

The `$PSDefaultParameterValues` variable displays the updated hash table. The
`Send-MailMessage:SmtpServer` key was changed to a new value.

```
PS> $PSDefaultParameterValues

Name                           Value
----                           -----
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get-*:Verbose                  True
Send-MailMessage:SmtpServer    ServerXYZ
```

### How to disable and re-enable \$PSDefaultParameterValues

You can temporarily disable and then re-enable `$PSDefaultParameterValues`.
Disabling `$PSDefaultParameterValues` is useful if you're running scripts that
need different default parameter values.

To disable `$PSDefaultParameterValues`, add a key of `Disabled` with a value of
**True**. The values in `$PSDefaultParameterValues` are preserved, but aren't
effective.

```
PS> $PSDefaultParameterValues.Add("Disabled", $True)
```

The following syntax accomplishes the same result.

```
PS> $PSDefaultParameterValues["Disabled"]=$True
```

The `$PSDefaultParameterValues` variable displays the updated hash table with
the value for the `Disabled` key.

```
PS> $PSDefaultParameterValues

Name                           Value
----                           -----
Disabled                       True
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get-*:Verbose                  True
Send-MailMessage:SmtpServer    ServerXYZ
```

To re-enable `$PSDefaultParameterValues`, remove the **Disabled** key or change
the value of the **Disabled** key to `$False`. The previous value of
`$PSDefaultParameterValues` is effective again.

```
PS> $PSDefaultParameterValues.Remove("Disabled")
```

The following syntax accomplishes the same result.

```
PS> $PSDefaultParameterValues["Disabled"]=$False
```

The `$PSDefaultParameterValues` variable displays the updated hash table. When
the **Remove** method is used, the `Disabled` key is removed from the output.
If the alternate syntax was used to re-enable `$PSDefaultParameterValues`, the
`Disabled` key is displayed as **False**.

```
PS> $PSDefaultParameterValues

Name                           Value
----                           -----
Disabled                       False
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get-*:Verbose                  True
Send-MailMessage:SmtpServer    ServerXYZ
```

## See also

[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216)

[about_Functions_Advanced](about_Functions_Advanced.md)

[about_Functions_CmdletBindingAttribute](about_Functions_CmdletBindingAttribute.md)

[about_Hash_Tables](about_Hash_Tables.md)

[about_Preference_Variables](about_Preference_Variables.md)

[about_Profiles](about_Profiles.md)

[about_Script_Blocks](about_Script_Blocks.md)

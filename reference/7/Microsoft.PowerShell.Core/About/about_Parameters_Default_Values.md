---
ms.date:  11/30/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Parameters_Default_Values
---
# About Parameters Default Values

## SHORT DESCRIPTION
Describes how to set custom default values for the parameters of cmdlets and
advanced functions.

## LONG DESCRIPTION

The \$PSDefaultParameterValues preference variable lets you specify custom
default values for any cmdlet or advanced function. Cmdlets and functions use
the custom default value unless you specify another value in the command.

The authors of cmdlets and advanced functions set standard default values for
their parameters. Typically, the standard default values are useful, but they
might not be appropriate for all environments.

This feature is especially useful when you must specify the same alternate
parameter value nearly every time you use the command or when a particular
parameter value is difficult to remember, such as an e-mail server name or
project GUID.

If the desired default value varies predictably, you can specify a script
block that provides different default values for a parameter under different
conditions.

\$PSDefaultParameterValues was introduced in  PowerShell 3.0.

## SYNTAX

The syntax of the $PSDefaultParameterValues preference variable is as follows:

```powershell
$PSDefaultParameterValues=@{"<CmdletName>:<ParameterName>"="<DefaultValue>"}

$PSDefaultParameterValues=@{"<CmdletName>:<ParameterName>"={<ScriptBlock>}}

$PSDefaultParameterValues["Disabled"]=$true | $false
```

Wildcard characters are permitted in the CmdletName and ParameterName values.

The value of \$PSDefaultParameterValues is a
System.Management.Automation.DefaultParameterDictionary, a type of hash table
that validates the format of keys. Enter a hash table where the key consists
of the cmdlet name and parameter name separated by a colon (:) and the value
is the custom default value.

To set, change, add, or remove entries from \$PSDefaultParameterValues, use the
methods that you would use to edit a standard hash table.

The \<CmdletName\> must be the name of a cmdlet or the name of an advanced
function that uses the CmdletBinding attribute. You cannot use
$PSDefaultParameterValues to specify default values for scripts or simple
functions.

The default value can be an object or a script block. If the value is a script
block, PowerShell evaluates the script block and uses the result as the
parameter value. When the specified parameter takes a script block value,
enclose the script block value in a second set of braces, such as:

```powershell
$PSDefaultParameterValues=@{ "Invoke-Command:ScriptBlock"={{Get-Process}} }
```

For information about hash tables, see
[about_Hash_Tables](about_Hash_Tables.md). For information about script
blocks, see [about_Script_Blocks](about_Script_Blocks.md). For information
about preference variables, see
[about_Preference_Variables](about_Preference_Variables.md).

## EXAMPLES

The following command sets a custom default value for the SmtpServer parameter
of the Send-MailMessage cmdlet.

```powershell
$PSDefaultParameterValues = @{
  "Send-MailMessage:SmtpServer"="Server01AB234x5"
}
```

To set default values for multiple parameters, use a semi-colon (;) to
separate each Name\=Value pair. The following command adds a custom default
value for the LogName parameter of the `Get-WinEvent` cmdlet.

```powershell
$PSDefaultParameterValues = @{
  "Send-MailMessage:SmtpServer"="Server01AB234x5";
  "Get-WinEvent:LogName"="Microsoft-Windows-PrintService/Operational"
}
```

You can use wildcard characters in the name of the cmdlet and parameter. The
following command sets the Verbose common parameter to \$true in all commands.
Use \$true and \$false to set values for switch parameters, such as
**Verbose**.

```powershell
$PSDefaultParameterValues = @{"*:Verbose"=$true}
```

If a parameter takes multiple values (an array), you can set multiple values
as the default value. The following command sets the default value of the
**ComputerName** parameter of the Invoke-Command cmdlet to "Server01" and
"Server02".

```powershell
$PSDefaultParameterValues = @{
  "Invoke-Command:ComputerName"="Server01","Server02"
}
```

You can use a script block to specify different default values for a parameter
under different conditions. PowerShell evaluates the script block and uses the
result as the default parameter value.

The following command sets the default value of the Autosize parameter of the
Format-Table cmdlet to \$true when the host program is the PowerShell console.

```powershell
$PSDefaultParameterValues=@{
  "Format-Table:AutoSize"={if ($host.Name -eq "ConsoleHost"){$true}}
}
```

If a parameter takes a script block value, enclose the script block in an
extra set of braces. When PowerShell evaluates the outer script block, the
result is the inner script block, which is set as the default parameter value.

The following command sets the default value of the ScriptBlock parameter of
`Invoke-Command`. Because the script block is enclosed in a second set of
braces, the enclosed script block is passed to the `Invoke-Command` cmdlet.

```powershell
$PSDefaultParameterValues=@{
  "Invoke-Command:ScriptBlock"={{Get-EventLog -Log System}}
}
```

### HOW TO SET \$PSDefaultParameterValues

\$PSDefaultParameterValues is a preference variable, so it exists only in the
session in which it is set. It has no default value.

To set \$PSDefaultParameterValues, type the variable name and one or more
key-value pairs at the command line.

If you type another \$PSDefaultParameterValues command, its value replaces the
original value. The original is not retained.

To save \$PSDefaultParameterValues for future sessions, add a
\$PSDefaultParameterValues command to your PowerShell profile. For more
information, see [about_Profiles](about_Profiles.md).

### HOW TO GET \$PSDefaultParameterValues

To get the value of \$PSDefaultParameterValues, at the command prompt, type:

```powershell
$PSDefaultParameterValues
```

For example, the first command sets the value of \$PSDefaultParameterValues.
The second command gets the value of \$PSDefaultParameterValues.

```powershell
PS C:\> $PSDefaultParameterValues = @{
  "Send-MailMessage:SmtpServer"="Server01AB234x5"
  "Get-WinEvent:LogName"="Microsoft-Windows-PrintService/Operational"
  "Get-*:Verbose"=$true
}
```

```powershell
PS C:\> $PSDefaultParameterValues

Name                           Value
----                           -----
Send-MailMessage:SmtpServer    Server01AB234x5
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get*:Verbose                   True
```

To get the value of a \<CmdletName:ParameterName\> key, use the following
command syntax:

```powershell
$PSDefaultParameterValues["<CmdletName:ParameterName>"]
```

For example:

```powershell
PS C:\> $PSDefaultParameterValues["Send-MailMessage:SmtpServer"]
Server01AB234x5
```

### HOW TO ADD VALUES TO PSDefaultParameterValues

To add or remove values from \$PSDefaultParameterValues, use the methods that
you would use for a standard hash table.

For example, to add a value to \$PSDefaultParameterValues without affecting the
existing values, use the Add method of hash tables.

The syntax of the Add method is as follows:

```
<HashTable>.Add(Key, Value)
```

where the Key is "<CmdletName>:<ParameterName>" and the value is the parameter
value.

Use the following command format to call the Add method on
\$PSDefaultParameterValues. Be sure to use a comma (,) to separate the key
from the value, instead of the equal sign (\=).

```powershell
$PSDefaultParameterValues.Add(
  "<CmdletName>:<ParameterName>", "<ParameterValue>"
)
```

For example, the following command adds "PowerShell" as the default value of
the Name parameter of the Get-Process cmdlet.

```powershell
$PSDefaultParameterValues.Add("Get-Process:Name", "PowerShell")
```

The following example shows the effect of this command.

```powershell
PS C:\> $PSDefaultParameterValues

Name                           Value
----                           -----
Send-MailMessage:SmtpServer    Server01AB234x5
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get*:Verbose                   True
```

```powershell
PS C:\> $PSDefaultParameterValues.Add("Get-Process:Name", "PowerShell")
```

```powershell
PS C:\> $PSDefaultParameterValues

Name                           Value
----                           -----
Get-Process:Name               PowerShell
Send-MailMessage:SmtpServer    Server01AB234x5
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get*:Verbose                   True
```

### HOW TO REMOVE VALUES FROM \$PSDefaultParameterValues

To remove a value from \$PSDefaultParameterValues, use the Remove method of
hash tables.

The syntax of the Remove method is as follows:

```powershell
<HashTable>.Remove(Key)
```

Use the following command format to call the Remove method on
\$PSDefaultParameterValues.

```powershell
$PSDefaultParameterValues.Remove("<CmdletName>:<ParameterName>")
```

For example, the following command removes the Name parameter of the
`Get-Process` cmdlet and its values.

```powershell
$PSDefaultParameterValues.Remove("Get-Process:Name")
```

The following example shows the effect of this command.

```powershell
PS C:\> $PSDefaultParameterValues

Name                           Value
----                           -----
Get-Process:Name               PowerShell
Send-MailMessage:SmtpServer    Server01AB234x5
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get*:Verbose                   True
```

```powershell
PS C:\> $PSDefaultParameterValues.Remove("Get-Process:Name")
```

```powershell
PS C:\> $PSDefaultParameterValues

Name                           Value
----                           -----
Send-MailMessage:SmtpServer    Server01AB234x5
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get*:Verbose                   True
```

### HOW TO CHANGE VALUES IN \$PSDefaultParameterValues

To change a value in $PSDefaultParameterValues, use the following command
format.

```powershell
$PSDefaultParameterValues["CmdletName:ParameterName"]="<NewValue>"
```

The following example shows the effect of this command.

```powershell
$PSDefaultParameterValues

Name                           Value
----                           -----
Send-MailMessage:SmtpServer    Server01AB234x5
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get*:Verbose                   True
```

```powershell
$PSDefaultParameterValues["Send-MailMessage:SmtpServer"]="Server0000cabx5"
```

```powershell
$PSDefaultParameterValues

Name                           Value
----                           -----
Send-MailMessage:SmtpServer    Server0000cabx5
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get*:Verbose                   True
```

### HOW TO DISABLE AND RE-ENABLE \$PSDefaultParameterValues

You can temporarily disable and then re-enable \$PSDefaultParameterValues. This
is very useful if you're running scripts that might assume different default
parameter values.

To disable $PSDefaultParameterValues, add a key of "Disabled" with a value of
\$True.

For example,

```powershell
$PSDefaultParameterValues.Add("Disabled", $true)
```

- or -

```powershell
$PSDefaultParameterValues[Disabled]=$true
```

The other values in \$PSDefaultParameterValues are preserved, but not
effective.

```powershell
PS C:\> $PSDefaultParameterValues

Name                           Value
----                           -----
Disabled                       True
Send-MailMessage:SmtpServer    Server0000cabx5
Get-WinEvent:LogName           Microsoft-Windows-PrintService/Operational
Get*:Verbose                   True
```

To re-enable \$PSDefaultParameterValues, remove the Disabled key or change the
value of the Disabled key to \$False.

```powershell
$PSDefaultParameterValues.Remove("Disabled")
```

- or -

```powershell
$PSDefaultParameterValues[Disabled]=$false
```

The previous value of \$PSDefaultParameterValues is effective again.

## KEYWORDS

about_PSDefaultParameterValues

about_Parameters_DefaultValues

about_DefaultValues

## SEE ALSO

[about_Hash_Tables](about_Hash_Tables.md)

[about_Preference_Variables](about_Preference_Variables.md)

[about_Profiles](about_Profiles.md)

[about_Script_Blocks](about_Script_Blocks.md)
---
ms.date:  09/07/2018
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=834942
external help file:  System.Management.Automation.dll-help.xml
title:  Get-Verb
---
# Get-Verb

## SYNOPSIS
Gets approved PowerShell verbs.

## SYNTAX

```
Get-Verb [[-verb] <String[]>]
```

## DESCRIPTION

The `Get-Verb` function gets verbs that are approved for use in PowerShell commands.

PowerShell recommends cmdlet and function names have the Verb-Noun format and include an
approved verb. This practice makes command names more consistent, predictable, and easier to
use.

Commands that use unapproved verbs run in PowerShell. However, when you import a module that
includes a command with an unapproved verb in its name, the `Import-Module` command displays a
warning message.

> [!NOTE]
> The verb list that `Get-Verb` returns might not be complete. For an updated list of approved
> PowerShell verbs with descriptions, see
> [Approved Verbs](/powershell/developer/cmdlet/approved-verbs-for-windows-powershell-commands) in
> the Microsoft Docs.

## EXAMPLES

### Example 1 - Get a list of all verbs

```powershell
Get-Verb
```

### Example 2 - Get a list of approved verbs that begin with "un"

```powershell
Get-Verb un*
```

```Output
Verb                 Group
----                 -----
Undo                 Common
Unlock               Common
Unpublish            Data
Uninstall            Lifecycle
Unregister           Lifecycle
Unblock              Security
Unprotect            Security
```

### Example 3 - Get all approved verbs in the Security group

```powershell
Get-Verb | Where-Object Group -EQ Security
```

```Output
Verb      Group
----      -----
Block     Security
Grant     Security
Protect   Security
Revoke    Security
Unblock   Security
Unprotect Security
```

### Example 4 - Finds all commands in a module that have unapproved verbs

```powershell
Get-Command -Module Microsoft.PowerShell.Utility | Where-Object Verb -NotIn (Get-Verb).Verb
```

```Output
CommandType     Name            Version    Source
-----------     ----            -------    ------
Cmdlet          Sort-Object     3.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Tee-Object      3.1.0.0    Microsoft.PowerShell.Utility
```

## PARAMETERS

### -verb

Gets only the specified verbs.
Enter the name of a verb or a name pattern.
Wildcards are allowed.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: All verbs
Accept pipeline input: True (ByValue)
Accept wildcard characters: True
```

## INPUTS

### None

## OUTPUTS

### Selected.Microsoft.PowerShell.Commands.MemberDefinition

## NOTES

`Get-Verb` returns a modified version of a Microsoft.PowerShell.Commands.MemberDefinition object.
The object does not have the standard properties of a MemberDefinition object.
Instead it has Verb and Group properties.
The Verb property contains a string with the verb name.
The Group property contains a string with the verb group.

PowerShell verbs are assigned to a group based on their most common use.
The groups are designed to make the verbs easy to find and compare, not to restrict their use.
You can use any approved verb for any type of command.

Each PowerShell verb is assigned to one of the following groups.

- Common: Define generic actions that can apply to almost any cmdlet, such as Add.
- Communications:  Define actions that apply to communications, such as Connect.
- Data:  Define actions that apply to data handling, such as Backup.
- Diagnostic: Define actions that apply to diagnostics, such as Debug.
- Lifecycle: Define actions that apply to the lifecycle of a cmdlet, such as Complete.
- Security: Define actions that apply to security, such as Revoke.
- Other: Define other types of actions.

Some of the cmdlets that are installed with PowerShell, such as `Tee-Object` and `Where-Object`, use
unapproved verbs. These cmdlets are historic exceptions and their verbs are classified as
**reserved**.

## RELATED LINKS

[Import-Module](../import-module.md)
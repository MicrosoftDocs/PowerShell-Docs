---
external help file: Microsoft.PowerShell.Commands.Utility.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Utility
ms.date: 09/07/2018
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.utility/get-verb?view=powershell-7.2&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Get-Verb
---
# Get-Verb

## SYNOPSIS
Gets approved PowerShell verbs.

## SYNTAX

```
Get-Verb [[-Verb] <String[]>] [[-Group] <String[]>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-Verb` function gets verbs that are approved for use in PowerShell commands.

It is recommended that PowerShell cmdlet and function names have the `Verb-Noun` format and include
an approved verb. This practice makes command names more consistent, predictable, and easier to use.

Commands that use unapproved verbs, still run in PowerShell. However, when you import a module that
includes a command with an unapproved verb in its name, the `Import-Module` command displays a
warning message.

> [!NOTE]
> The verb list that `Get-Verb` returns might not be complete. For an updated list of approved
> PowerShell verbs with descriptions, see
> [Approved Verbs](../../docs-conceptual/developer/cmdlet/approved-verbs-for-windows-powershell-commands.md) in
> the Microsoft Docs.

## Examples

### Example 1 - Get a list of all verbs

```powershell
Get-Verb
```

### Example 2 - Get a list of approved verbs that begin with "un"

```powershell
Get-Verb un*
```

```Output
Verb       AliasPrefix Group     Description
----       ----------- -----     -----------
Undo       un          Common    Sets a resource to its previous state
Unlock     uk          Common    Releases a resource that was locked
Unpublish  ub          Data      Makes a resource unavailable to others
Uninstall  us          Lifecycle Removes a resource from an indicated location
Unregister ur          Lifecycle Removes the entry for a resource from a repository
Unblock    ul          Security  Removes restrictions to a resource
Unprotect  up          Security  Removes safeguards from a resource that were added to prevent it from attack or loss
```

### Example 3 - Get all approved verbs in the Security group

```powershell
Get-Verb -Group Security
```

```Output
Verb      AliasPrefix Group    Description
----      ----------- -----    -----------
Block     bl          Security Restricts access to a resource
Grant     gr          Security Allows access to a resource
Protect   pt          Security Safeguards a resource from attack or loss
Revoke    rk          Security Specifies an action that does not allow access to a resource
Unblock   ul          Security Removes restrictions to a resource
Unprotect up          Security Removes safeguards from a resource that were added to prevent it from attack or loss
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

### -Verb

Gets only the specified verbs. Enter the name of a verb or a name pattern. Wildcards are allowed.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:
Accepted values: Common, Communications, Data, Diagnostic, Lifecycle, Other, Security

Required: False
Position: 1
Default value: All groups
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### -Group

Gets only the specified groups. Enter the name of a group. Wildcards are not allowed.

This parameter was introduced in PowerShell 6.0.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: All verbs
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see
[about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Management.Automation.VerbInfo

## NOTES

PowerShell verbs are assigned to a group based on their most common use. The groups are designed to
make the verbs easy to find and compare, not to restrict their use. You can use any approved verb
for any type of command.

Each PowerShell verb is assigned to one of the following groups.

- Common: Define generic actions that can apply to almost any cmdlet, such as Add.
- Communications: Define actions that apply to communications, such as Connect.
- Data: Define actions that apply to data handling, such as Backup.
- Diagnostic: Define actions that apply to diagnostics, such as Debug.
- Lifecycle: Define actions that apply to the lifecycle of a cmdlet, such as Complete.
- Security: Define actions that apply to security, such as Revoke.
- Other: Define other types of actions.

Some of the cmdlets that are installed with PowerShell, such as `Tee-Object` and `Where-Object`, use
unapproved verbs. These cmdlets are historic exceptions and their verbs are classified as
**reserved**.

## RELATED LINKS

[Import-Module](../microsoft.powershell.core/import-module.md)


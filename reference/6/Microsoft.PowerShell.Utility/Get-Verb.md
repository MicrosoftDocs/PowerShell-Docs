---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://technet.microsoft.com/library/hh852690(v=wps.630).aspx
external help file:  Microsoft.PowerShell.Commands.Utility.dll-Help.xml
---

# Get-Verb

## SYNOPSIS
Gets approved Windows PowerShell verbs.

## SYNTAX

```powershell
Get-Verb [[-Verb] <String[]>] [[-Group] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The Get-Verb function gets verbs that are approved for use in Windows PowerShell commands.

Windows PowerShell recommends that cmdlet and function names have the Verb-Noun format and include an approved verb.
This practice makes command names more consistent and predictable, and easier to use, especially for users who do not speak English as a first language.

Commands that use unapproved verbs run in Windows PowerShell.
However, when you import a module that includes a command with an unapproved verb in its name, the Import-Module command displays a warning message.

NOTE:   The verb list that Get-Verb returns might not be complete.
For an updated list of approved Windows PowerShell verbs with descriptions, see "Cmdlet Verbs" in MSDN at http://go.microsoft.com/fwlink/?LinkID=160773.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
get-verb
```

Description

-----------

This command gets all approved verbs.

### -------------------------- EXAMPLE 2 --------------------------
```
get-verb un*

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

Description

-----------

This command gets all approved verbs that begin with "un".

### Example 3
```powershell
PS C:\> Get-Verb -Group Security

Verb      AliasPrefix Group    Description
----      ----------- -----    -----------
Block     bl          Security Restricts access to a resource
Grant     gr          Security Allows access to a resource
Protect   pt          Security Safeguards a resource from attack or loss
Revoke    rk          Security Specifies an action that does not allow acc...
Unblock   ul          Security Removes restrictions to a resource
Unprotect up          Security Removes safeguards from a resource that wer...
```

This command gets all approved verbs in the Security group.

### Example 4
```powershell
Get-Command -Module Microsoft.PowerShell.Utility | where Verb -NotIn (Get-Verb).Verb
# CommandType     Name            Version    Source
# -----------     ----            -------    ------
# Cmdlet          Sort-Object     3.1.0.0    Microsoft.PowerShell.Utility
# Cmdlet          Tee-Object      3.1.0.0    Microsoft.PowerShell.Utility
```

This command finds all commands in a module that have unapproved verbs.

## PARAMETERS

### -verb
Gets only the specified verbs.
Enter the name of a verb or a name pattern.
Wildcards are permitted.

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

### -Group
Gets only the specified groups.
Enter the name of a group.
Wildcards are not permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: Common, Communications, Data, Diagnostic, Lifecycle, Other, Security

Required: False
Position: 1
Default value: All groups
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

## INPUTS

### None

## OUTPUTS

### System.Management.Automation.VerbInfo

## NOTES
Windows PowerShell verbs are assigned to a group based on their most common use.
The groups are designed to make the verbs easy to find and compare, not to restrict their use.
You can use any approved verb for any type of command.

Each Windows PowerShell verb is assigned to one of the following groups.
-- Common: Define generic actions that can apply to almost any cmdlet, such as Add.

-- Communications:  Define actions that apply to communications, such as Connect.
-- Data:  Define actions that apply to data handling, such as Backup.
-- Diagnostic: Define actions that apply to diagnostics, such as Debug.
-- Lifecycle: Define actions that apply to the lifecycle of a cmdlet, such as Complete.
-- Security: Define actions that apply to security, such as Revoke.
-- Other: Define other types of actions.

Some of the cmdlets that are installed with Windows PowerShell, such as Tee-Object and Where-Object, use unapproved verbs.
These cmdlets are considered to be historic exceptions and their verbs are classified as "reserved."

## RELATED LINKS

[Import-Module](../microsoft.powershell.core/import-module.md)


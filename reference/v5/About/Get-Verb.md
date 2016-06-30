---
title: Get-Verb
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1b05df26-cbfc-4fca-952d-e7b599f3646f
---
# Get-Verb
Gets approved Windows PowerShell verbs.  
  
## Syntax  
  
```  
Get-Verb [[-Verb] <string[]>] [<CommonParameters>]  
  
```  
  
## Description  
 The Get\-Verb function gets verbs that are approved for use in Windows PowerShell commands.  
  
 Windows PowerShell recommends that cmdlet and function names have the Verb\-Noun format and include an approved verb. This practice makes command names more consistent and predictable, and easier to use, especially for users who do not speak English as a first language.  
  
 Commands that use unapproved verbs run in Windows PowerShell. However, when you import a module that includes a command with an unapproved verb in its name, the [Import-Module](Import-Module.md) command displays a warning message.  
  
 NOTE:   The verb list that Get\-Verb returns might not be complete. For an updated list of approved Windows PowerShell verbs with descriptions, see "Cmdlet Verbs" in MSDN at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=160773.  
  
## Parameters  
  
### \-Verb \<string\[\]\>  
 Gets only the specified verbs. Enter the name of a verb or a name pattern. Wildcards are permitted.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|1|  
|Default Value|All verbs|  
|Accept Pipeline Input?|true \(ByValue\)|  
|Accept Wildcard Characters?|true|  
  
### \<CommonParameters\>  
 This cmdlet supports the common parameters: \-Debug, \-ErrorAction, \-ErrorVariable, \-OutBuffer, \-OutVariable,  \-Verbose, \-WarningAction, and \-WarningVariable. For more information, see [about\_CommonParameters](../Topic/about_CommonParameters.md).  
  
## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  
  
|||  
|-|-|  
|Inputs|None|  
|Outputs|Selected.Microsoft.PowerShell.Commands.MemberDefinition|  
  
## Notes  
 Get\-Verb returns a modified version of a Microsoft.PowerShell.Commands.MemberDefinition object. The object does not have the standard properties of a MemberDefinition object. Instead it has Verb and Group properties. The Verb property contains a string with the verb name. The Group property contains a string with the verb group.  
  
 Windows PowerShell verbs are assigned to a group based on their most common use. The groups are designed to make the verbs easy to find and compare, not to restrict their use. You can use any approved verb for any type of command.  
  
 Each Windows PowerShell verb is assigned to one of the following groups.  
  
 \-\- Common: Define generic actions that can apply to almost any cmdlet, such as Add.  
  
 \-\- Communications:  Define actions that apply to communications, such as Connect.  
  
 \-\- Data:  Define actions that apply to data handling, such as Backup.  
  
 \-\- Diagnostic: Define actions that apply to diagnostics, such as Debug.  
  
 \-\- Lifecycle: Define actions that apply to the lifecycle of a cmdlet, such as Complete.  
  
 \-\- Security: Define actions that apply to security, such as Revoke.  
  
 \-\- Other: Define other types of actions.  
  
 Some of the cmdlets that are installed with Windows PowerShell, such as [Tee-Object](Tee-Object.md) and [Where-Object](Where-Object.md), use unapproved verbs. These cmdlets are considered to be historic exceptions and their verbs are classified as "reserved."  
  
## Example 1  
  
```  
C:\PS>get-verb  
  
Description  
-----------  
This command gets all approved verbs.  
  
```  
  
## Example 2  
  
```  
C:\PS>get-verb un*  
  
Verb                 Group  
----                 -----  
Undo                 Common  
Unlock               Common  
Unpublish            Data  
Uninstall            Lifecycle  
Unregister           Lifecycle  
Unblock              Security  
Unprotect            Security  
  
Description  
-----------  
This command gets all approved verbs that begin with "un".  
  
```  
  
## Example 3  
  
```  
C:\PS>get-verb | where-object {$_.Group -eq "Security"}  
  
Verb                 Group  
----                 -----  
Block                Security  
Grant                Security  
Protect              Security  
Revoke               Security  
Unblock              Security  
Unprotect            Security  
  
Description  
-----------  
This command gets all approved verbs in the Security group.  
  
```  
  
## Example 4  
  
```  
C:\PS>get-command -module MyModule | where { (get-verb $_.Verb) -eq $null }  
  
Description  
-----------  
This command finds all commands in a module that have unapproved verbs.  
  
```  
  
## Example 5  
  
```  
C:\PS>$approvedVerbs = get-verb | foreach {$_.verb}  
  
C:\PS> $myVerbs = get-command -module MyModule | foreach {$_.verb}  
  
# Does MyModule export functions with unapproved verbs?  
C:\PS> ($myVerbs | foreach {$approvedVerbs -contains $_}) -contains $false  
True  
  
# Which unapproved verbs are used in MyModule?  
C:\PS>  ($myverbs | where {$approvedVerbs -notcontains $_})  
ForEach  
Sort  
Tee  
Where  
  
Description  
-----------  
These commands detect unapproved verbs in a module and tell which unapproved verbs were detected in the module.  
  
```  
  
## See Also  
 [Import-Module](Import-Module.md)
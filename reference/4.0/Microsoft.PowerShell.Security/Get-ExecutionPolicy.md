---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=293937
external help file:  Microsoft.PowerShell.Security.dll-Help.xml
title:  Get-ExecutionPolicy
---

# Get-ExecutionPolicy

## SYNOPSIS
Gets the execution policies for the current session.

## SYNTAX

```
Get-ExecutionPolicy [[-Scope] <ExecutionPolicyScope>] [-List] [<CommonParameters>]
```

## DESCRIPTION
The **Get-ExecutionPolicy** cmdlet gets the execution policies for the current session.

The execution policy is determined by execution policies that you set by using Set-ExecutionPolicy and the Group Policy settings for the Windows PowerShell execution policy.
The default value is "Restricted."

Without parameters, **Get-ExecutionPolicy** gets the execution policy that is effective in the session.
You can use the **List** parameter to get all execution policies that affect the session or the Scope parameter to get the execution policy for a particular scope.

For more information, see about_Execution_Policies (http://go.microsoft.com/fwlink/?LinkID=135170).

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-ExecutionPolicy
Restricted
```

This command gets the current execution policy for the computer.

### Example 2
```powershell
PS C:\> Set-ExecutionPolicy RemoteSigned
PS C:\> Get-ExecutionPolicy
RemoteSigned
```

These commands set a new user preference for the execution policy and then display the effective execution policy.
The commands are separated by a semicolon (;).
In this example, because there is no Group Policy setting, the user preference is the effective policy for the computer.

### Example 3
```powershell
PS C:\> Get-ExecutionPolicy -List

Scope          ExecutionPolicy
-----          ---------------
MachinePolicy  Undefined
UserPolicy     Undefined
Process        Undefined
CurrentUser    AllSigned
LocalMachine   RemoteSigned

PS C:\> Get-ExecutionPolicy
AllSigned
```

These commands get all execution policies in the current session and the effective execution policy.

The first command gets all execution policies that affect the current session.
The policies are listed in precedence order.

The second command gets only the effective execution policy, which is the one set in the CurrentUser scope.

### Example 4
```powershell
The first command uses the **Get-ExecutionPolicy** cmdlet to get the effective execution policy in the current session.
PS C:\> Get-ExecutionPolicy
RemoteSigned

The second command shows what happens when you run a blocked script in a Windows PowerShell session in which the execution policy is **RemoteSigned**. The **RemoteSigned** policy prevents you from running scripts that are downloaded from the Internet unless they are digitally signed.
PS C:\> .\Start-ActivityTracker.ps1

.\Start-ActivityTracker.ps1 : File .\Start-ActivityTracker.ps1 cannot be loaded. The file .\Start-ActivityTracker.ps1 is not digitally signed. The script will not execute on the system. For more information, see about_Execution_Policies at http://go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:1
+ .\Start-ActivityTracker.ps1
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess


The third command uses the Unblock-File cmdlet to unblock the script so it can run in the session.Before running an **Unblock-File** command, read the script contents and verify that it is safe.
PS C:\> Unblock-File -Path Start-ActivityTracker.ps1

This command shows the effect of the **Unblock-File** command. The command does not change the execution policy. However, it unblocks the script so it will run in Windows PowerShell.
PS C:\> Get-ExecutionPolicy
RemoteSigned
PS C:\> Start-ActivityTracker.ps1
Task 1:
```

This example shows the effect of the **RemoteSigned** execution policy, which prevents you from running unsigned scripts that were downloaded from the Internet.
It also shows how to use the Unblock-File cmdlet to unblock scripts, so that you can run them without changing the execution policy.

## PARAMETERS

### -List
Gets all execution policy values for the session listed in precedence order. 
By default, **Get-ExecutionPolicy** gets only the effective execution policy.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope
Gets the execution policy in the specified scope. 
By default, **Get-ExecutionPolicy** gets the effective execution policy for the current session.

Valid values are:

- MachinePolicy: The execution policy set by a Group Policy for all users of the computer.
- UserPolicy: The execution policy set by a Group Policy for the current user of the computer.
- Process: The execution policy that is set for the current Windows PowerShell process.
- CurrentUser: The execution policy that is set for the current user.
- LocalMachine: The execution policy that is set for all users of the computer.

```yaml
Type: ExecutionPolicyScope
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: Effective execution policy
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### Microsoft.PowerShell.ExecutionPolicy

## NOTES
* The execution policy is part of the security strategy of Windows PowerShell. It determines whether you can load configuration files (including your Windows PowerShell profile) and run scripts, and it determines which scripts, if any, must be digitally signed before they will run.

  The effective execution policy is determined by the policies that you set by using the Set-ExecutionPolicy cmdlet and the "Turn on Script Execution" group policies for computers and users.
The precedence order is Computer Group Policy \> User Group Policy \> Process (session) execution policy \> User execution policy \> Computer execution policy.

  For more information about Windows PowerShell execution policy, including definitions of the Windows PowerShell policies, see about_Execution_Policies (http://go.microsoft.com/fwlink/?LinkID=135170).

## RELATED LINKS

[Get-AuthenticodeSignature](Get-AuthenticodeSignature.md)

[Set-AuthenticodeSignature](Set-AuthenticodeSignature.md)

[Set-ExecutionPolicy](Set-ExecutionPolicy.md)

[Unblock-File](../Microsoft.PowerShell.Utility/Unblock-File.md)

[about_Execution_Policies](../Microsoft.PowerShell.Core/About/about_Execution_Policies.md)

[about_Signing](../Microsoft.PowerShell.Core/About/about_Signing.md)


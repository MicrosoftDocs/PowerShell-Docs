---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821719
external help file:  Microsoft.PowerShell.Security.dll-Help.xml
title:  Set-ExecutionPolicy
---

# Set-ExecutionPolicy

## SYNOPSIS
Changes the user preference for the Windows PowerShell execution policy.

## SYNTAX

```
Set-ExecutionPolicy [-ExecutionPolicy] <ExecutionPolicy> [[-Scope] <ExecutionPolicyScope>] [-Force] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The **Set-ExecutionPolicy** cmdlet changes the user preference for the Windows PowerShell execution policy.

The execution policy is part of the security strategy of Windows PowerShell.
It determines whether you can load configuration files (including your Windows PowerShell profile) and run scripts, and it determines which scripts, if any, must be digitally signed before they will run.
For more information, see about_Execution_Policies (http://go.microsoft.com/fwlink/?LinkID=135170).

To change the execution policy for the default (LocalMachine) scope, start Windows PowerShell with the "Run as administrator" option.

## EXAMPLES

### Example 1: Set the shell execution policy
```
PS C:\> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```

This command sets the user preference for the shell execution policy to RemoteSigned.

### Example 2: Set a shell execution policy that conflicts with the group policy
```
PS C:\> Set-ExecutionPolicy -ExecutionPolicy Restricted
Set-ExecutionPolicy : Windows PowerShell updated your local preference successfully, but the setting is 
overridden by the group policy applied to your system. Due to the override, your shell will retain its current 
effective execution policy of "AllSigned". Contact your group policy administrator for more information. 
At line:1 char:20
+ Set-ExecutionPolicy  <<<< restricted
```

This command attempts to set the execution policy for the shell to Restricted.
The Restricted setting is written to the registry, but because it conflicts with a group policy, it is not effective, even though it is more restrictive than the group policy.

### Example 3: Apply the execution policy from a remote computer to the local computer
```
PS C:\> Invoke-Command -ComputerName "Server01" -ScriptBlock {Get-ExecutionPolicy} | Set-ExecutionPolicy -Force
```

This command gets the execution policy from a remote computer and applies that execution policy to the local computer.

The command uses the Invoke-Command cmdlet to send the command to the remote computer.
Because you can pipe an ExecutionPolicy (Microsoft.PowerShell.ExecutionPolicy) object to **Set-ExecutionPolicy**, the **Set-ExecutionPolicy** command does not require an *ExecutionPolicy* parameter.

The command uses the *Force* parameter to suppress the user prompt.

### Example 4: Set the scope for an execution policy
```
PS C:\> Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy AllSigned -Force

The second command uses the *List* parameter of the Get-ExecutionPolicy cmdlet to get the execution policies set in each scope. The results show that the execution policy that is set for the current user differs from the execution policy set for all users of the computer.
PS C:\> Get-ExecutionPolicy -List
Scope            ExecutionPolicy
-----            ---------------
MachinePolicy    Undefined
UserPolicy       Undefined
Process          Undefined
CurrentUser      AllSigned
LocalMachine     RemoteSigned


PS C:\> Get-ExecutionPolicy
AllSigned
```

This example shows how to set an execution policy for a particular scope.

The first command uses the **Set-ExecutionPolicy** cmdlet to set an execution policy of **AllSigned** for the current user.
It uses the *Force* parameter to suppress the user prompt.

### Example 5: Remove the execution policy for the current user
```
PS C:\> Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Undefined
```

This command uses an execution policy value of Undefined to effectively remove the execution policy that is set for the current user scope.
As a result, the execution policy that is set in Group Policy or in the LocalMachine (all users) scope is effective.

If you set the execution policy in all scopes to Undefined and the Group Policy is not set, the default execution policy, Restricted, is effective for all users of the computer.

### Example 6: Set the execution policy for the current session
```
PS C:\> Set-ExecutionPolicy -Scope Process -ExecutionPolicy AllSigned
```

This command sets an execution policy of AllSigned for only the current Windows PowerShell session.
This execution policy is saved in the PSExecutionPolicyPreference environment variable ($env:PSExecutionPolicyPreference), so it does not affect the value in the registry.
The variable and its value are deleted when the current session is closed.

### Example 7: Unblock a script to run it without changing the execution policy
```
The first command uses the **Set-ExecutionPolicy** cmdlet to change the execution policy to RemoteSigned.
PS C:\> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

The second command uses the Get-ExecutionPolicy cmdlet to get the effective execution policy in the session. The output shows that it is RemoteSigned.
PS C:\> Get-ExecutionPolicy
RemoteSigned

The third command shows what happens when you run a blocked script in a Windows PowerShell session in which the execution policy is RemoteSigned. The RemoteSigned policy prevents you from running scripts that are downloaded from the Internet unless they are digitally signed.
PS C:\> .\Start-ActivityTracker.ps1
.\Start-ActivityTracker.ps1 : File .\Start-ActivityTracker.ps1 cannot be loaded. The file .\Start-ActivityTracker.ps1 
is not digitally signed. The script will not execute on the system. For more information, see about_Execution_Policies 
at http://go.microsoft.com/fwlink/?LinkID=135170. 
At line:1 char:1
+ .\Start-ActivityTracker.ps1
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : NotSpecified: (:) [], PSSecurityException
+ FullyQualifiedErrorId : UnauthorizedAccess

The fourth command uses the Unblock-File cmdlet to unblock the script so it can run in the session.Before running an **Unblock-File** command, read the script contents and verify that it is safe.
PS C:\> Unblock-File -Path "Start-ActivityTracker.ps1"

The fifth and sixth commands show the effect of the **Unblock-File** command. The **Unblock-File** command does not change the execution policy. However, it unblocks the script so it will run in Windows PowerShell.
PS C:\> Get-ExecutionPolicy
RemoteSigned
PS C:\> Start-ActivityTracker.ps1
Task 1:
```

This example shows the effect of the RemoteSigned execution policy, which prevents you from running unsigned scripts that were downloaded from the Internet.
It also shows how to use the Unblock-File cmdlet to unblock scripts, so that you can run them without changing the execution policy.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExecutionPolicy
Specifies the new execution policy.
The acceptable values for this parameter are:

- Restricted.
Does not load configuration files or run scripts.
Restricted is the default execution policy.
- AllSigned.
Requires that all scripts and configuration files be signed by a trusted publisher, including scripts that you write on the local computer.
- RemoteSigned.
Requires that all scripts and configuration files downloaded from the Internet be signed by a trusted publisher.
- Unrestricted.
Loads all configuration files and runs all scripts.
If you run an unsigned script that was downloaded from the Internet, you are prompted for permission before it runs.
- Bypass.
Nothing is blocked and there are no warnings or prompts.
- Undefined.
Removes the currently assigned execution policy from the current scope.
This parameter will not remove an execution policy that is set in a Group Policy scope.

```yaml
Type: ExecutionPolicy
Parameter Sets: (All)
Aliases: 
Accepted values: Unrestricted, RemoteSigned, AllSigned, Restricted, Default, Bypass, Undefined

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Force
Suppresses all prompts.
By default, **Set-ExecutionPolicy** displays a warning whenever you change the execution policy.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Scope
Specifies the scope of the execution policy.
The default is LocalMachine.
The acceptable values for this parameter are:

- Process: The execution policy affects only the current Windows PowerShell process.
- CurrentUser: The execution policy affects only the current user.
- LocalMachine: The execution policy affects all users of the computer.

To remove an execution policy from a particular scope, set the execution policy for that scope to Undefined.

When the value of the *Scope* parameter is Process, the execution policy is saved in the PSExecutionPolicyPreference environment variable ($env:PSExecutionPolicyPreference), instead of the registry, and the variable is deleted when the process is closed.
You cannot change the execution policy of the process by editing the variable.

```yaml
Type: ExecutionPolicyScope
Parameter Sets: (All)
Aliases: 
Accepted values: Process, CurrentUser, LocalMachine, UserPolicy, MachinePolicy

Required: False
Position: 1
Default value: LocalMachine
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.PowerShell.ExecutionPolicy, System.String
You can pipe an execution policy object or a string that contains the name of an execution policy to **Set-ExecutionPolicy**.

## OUTPUTS

### None
This cmdlet does not return any output.

## NOTES
* When you use **Set-ExecutionPolicy** in any scope other than Process, the new user preference is saved in the registry and remains unchanged until you change it. When the value of the *Scope* parameter is Process, the user preference is stored in the PSExecutionPolicyPreference environment variable ($env:PSExecutionPolicyPreference), instead of the registry, and it is deleted when the session in which it is effective is closed.

  If the "Turn on Script Execution" group policy is enabled for the computer or user, the user preference is saved, but it is not effective, and Windows PowerShell displays a message explaining the conflict.
You cannot use **Set-ExecutionPolicy** to override a Group Policy, even if the user preference is more restrictive than the policy.

*

## RELATED LINKS

[Get-AuthenticodeSignature](Get-AuthenticodeSignature.md)

[Get-ExecutionPolicy](Get-ExecutionPolicy.md)

[Set-AuthenticodeSignature](Set-AuthenticodeSignature.md)

[about_Execution_Policies](../Microsoft.PowerShell.Core/About/about_Execution_Policies.md)

[about_Signing](../Microsoft.PowerShell.Core/About/about_Signing.md)


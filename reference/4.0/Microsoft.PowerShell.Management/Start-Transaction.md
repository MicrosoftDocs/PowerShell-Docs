---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=293920
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Start-Transaction
---

# Start-Transaction

## SYNOPSIS
Starts a transaction.

## SYNTAX

```
Start-Transaction [-Timeout <Int32>] [-Independent] [-RollbackPreference <RollbackSeverity>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Start-Transaction cmdlet starts a transaction, which is a series of commands that are managed as a unit.
A transaction can be completed ("committed"), or it can be completely undone ("rolled back") so that any data changed by the transaction is restored to its original state.
Because the commands in a transaction are managed as a unit, either all commands are committed or all commands are rolled back.

By default, transactions are rolled back automatically if any command in the transaction generates an error, but you can use the RollbackPreference parameter to change this behavior.

The cmdlets used in a transaction must be designed to support transactions.
Cmdlets that support transactions have a UseTransaction parameter.
To perform transactions in a provider, the provider must support transactions.
The Windows PowerShell Registry provider in Windows Vista and later versions of Windows supports transactions.
You can also use the Microsoft.PowerShell.Commands.Management.TransactedString class to include expressions in transactions on any version of Windows that supports Windows PowerShell.
Other Windows PowerShell providers can also support transactions.

Only one transaction can be active at a time.
If you start a new, independent transaction while a transaction is in progress (neither completed nor undone), the new transaction becomes the active transaction, and you must commit or roll back the new transaction before making any changes to the original transaction.

The Start-Transaction cmdlet is one of a set of cmdlets that support the transactions feature in Windows PowerShell.
For more information, see about_Transactions.

## EXAMPLES

### Example 1
```
PS C:\> cd hkcu:\software
PS HKCU:\software> start-transaction
PS HKCU:\software> new-item MyCompany -UseTransaction
PS HKCU:\software> new-itemproperty MyCompany -name MyKey -value 123 -UseTransaction
PS HKCU:\software> undo-transaction
```

These commands start and then roll back a transaction.
Because the transaction is rolled back, no changes are made to the registry.

### Example 2
```
PS C:\> cd hkcu:\software
PS HKCU:\software> start-transaction
PS HKCU:\software> new-item MyCompany -UseTransaction
PS HKCU:\software> new-itemproperty MyCompany -name MyKey -value 123 -UseTransaction
PS HKCU:\software> complete-transaction
```

These commands start and then complete a transaction.
No changes are made to the registry until the Complete-Transaction command is used.

### Example 3
```
PS C:\> cd HKCU:\software
PS HKCU:\software> start-transaction
PS HKCU:\software> new-item -path NoPath -name MyCompany -UseTransaction
PS HKCU:\software> new-item -path . -name MyCompany -UseTransaction
PS HKCU:\software> start-transaction -RollbackPreference never
PS HKCU:\software> new-item -path NoPath -name MyCompany -UseTransaction
PS HKCU:\software> new-item -path . -name MyCompany -UseTransaction

# Start-Transaction (-rollbackpreference error)

PS HKCU:\software> start-transaction
PS HKCU:\software> new-item -path NoPath -Name MyCompany -UseTransaction
New-Item : The registry key at the specified path does not exist.
At line:1 char:9
+ new-item <<<<  -path NoPath -Name MyCompany -UseTransaction

PS HKCU:\software> new-item -path . -name MyCompany -UseTransaction

New-Item : Cannot use transaction. The transaction has been rolled back or has timed out.
At line:1 char:9
+ new-item <<<<  -path . -name MyCompany -UseTransaction

# Start-Transaction (-rollbackpreference never)

PS HKCU:\software> start-transaction -RollbackPreference never
PS HKCU:\software> new-item -path NoPath -name MyCompany -UseTransaction

New-Item : The registry key at the specified path does not exist.
At line:1 char:9
+ new-item <<<<  -path NoPath -name MyCompany -UseTransaction
PS HKCU:\software> new-item -path . -name MyCompany -UseTransaction

Hive: HKEY_CURRENT_USER\Software
SKC  VC Name                           Property
---  -- ----                           --------
0   0 MyCompany                      {}
PS HKCU:\Software> complete-transaction

# Succeeds
```

This example demonstrates the effect of changing the RollbackPreference parameter value.

In the first set of commands, the Start-Transaction command does not use the RollbackPreference parameter.
As a result, the default value ("Error") is used.
When an error occurs in a transaction command (the specified path does not exist), the transaction is automatically rolled back.

In the second set of commands, the Start-Transaction command uses the RollbackPreference parameter with a value of "Never".
As a result, when an error occurs in a transaction command, the transaction is still active and can be completed successfully.

Because most transactions must be performed without error, the default value of the RollbackPreference parameter is typically preferred.

### Example 4
```
PS C:\> cd HKCU:\software
PS HKCU:\software> start-transaction
PS HKCU:\software> new-item MyCompany -UseTransaction
PS HKCU:\software> start-transaction
PS HKCU:\software> get-transaction
PS HKCU:\software> new-item MyCompany2 -UseTransaction
PS HKCU:\software> complete-transaction
PS HKCU:\software> complete-transaction
PS HKCU:\Software> Get-Transaction

RollbackPreference   SubscriberCount   Status
------------------   ---------------   ------
Error                2                 Active
```

This example shows the effect of using the Start-Transaction command while a transaction is in progress.
The effect is much like joining the transaction in progress.

Although this is a simplified command, this scenario commonly occurs when the transaction involves running a script that includes a complete transaction.

The first Start-Transaction command starts the transaction.
The first New-Item command is part of the transaction.

The second Start-Transaction command adds a new subscriber to the transaction.
The Get-Transaction command now returns a transaction with a subscriber count of 2.
The second New-Item command is part of the same transaction.

No changes are made to the registry until the entire transaction is completed.
To complete the transaction, you must enter two Complete-Transaction commands, one for each subscriber.
If you were to roll back the transaction at any point, the entire transaction would be rolled back for both subscribers.

### Example 5
```
PS C:\> cd HKCU:\software
PS HKCU:\software> start-transaction
PS HKCU:\software> new-item MyCompany -UseTransaction
PS HKCU:\software> start-transaction -independent
PS HKCU:\software> get-transaction
PS HKCU:\software> undo-transaction
PS HKCU:\software> new-itemproperty -path MyCompany -name MyKey -value 123 -UseTransaction
PS HKCU:\software> complete-transaction
PS HKCU:\software> dir my*
PS HKCU:\Software> get-transaction

RollbackPreference   SubscriberCount   Status
------------------   ---------------   ------
Error                1                 Active
PS HKCU:\software> undo-transaction
PS HKCU:\software> new-itemproperty -path MyCompany -name MyKey -value 123 -UseTransaction
MyKey
-----
123
PS HKCU:\software> complete-transaction
PS HKCU:\software> dir my*
Hive: HKEY_CURRENT_USER\Software
SKC  VC Name                           Property
---  -- ----                           --------
0   1 MyCompany                      {MyKey}
```

This example shows the effect of using the Independent parameter of Start-Transaction to start a transaction while another transaction is in progress.
In this case, the new transaction is rolled back without affecting the original transaction.

Although the transactions are logically independent, because only one transaction can be active at a time, you must roll back or commit the newest transaction before resuming work on the original transaction.

The first set of commands starts a transaction.
The New-Item command is part of the first transaction.

In the second set of commands, the Start-Transaction command uses the Independent parameter.
The Get-Transaction command that follows shows the transaction object for the active transaction (the newest one).
The subscriber count is equal to 1, showing that the transactions are unrelated.

When the active transaction is rolled back by using an Undo-Transaction command, the original transaction becomes active again.

The New-ItemProperty command, which is part of the original transaction, completes without error, and the original transaction can be completed by using the Complete-Transaction command.
As a result, the registry is changed.

### Example 6
```
PS C:\> cd hkcu:\software
PS HKCU:\software> start-transaction
PS HKCU:\software> new-item MyCompany1 -UseTransaction
PS HKCU:\software> new-item MyCompany2
PS HKCU:\software> new-item MyCompany3 -UseTransaction
PS HKCU:\software> dir my*
PS HKCU:\software> complete-transaction
PS HKCU:\software> dir my*
PS HKCU:\Software> dir my*

Hive: HKEY_CURRENT_USER\Software
SKC  VC Name                           Property
---  -- ----                           --------
0   0 MyCompany2                     {}

PS HKCU:\Software> complete-transaction
PS HKCU:\Software> dir my*

Hive: HKEY_CURRENT_USER\Software
SKC  VC Name                           Property
---  -- ----                           --------
0   0 MyCompany1                     {}
0   0 MyCompany2                     {}
0   0 MyCompany3                     {}
```

This example demonstrates that commands that are submitted while a transaction is in progress can be included in the transaction or not included.
Only commands that use the UseTransaction parameter are part of the transaction.

The first and third New-Item commands use the UseTransaction parameter.
These commands are part of the transaction.
Because the second New-Item command does not use the UseTransaction parameter, it is not part of the transaction.

The first "dir" command shows the effect.
The second New-Item command is completed immediately, but the first and third New-Item commands are not effective until the transaction is committed.

The Complete-Transaction command commits the transaction.
As a result, the second "dir" command shows that all of the new items are added to the registry.

### Example 7
```
PS C:\> start-transaction -timeout 2

# Wait two minutes...

PS C:\> get-transaction
PS C:\> new-item HKCU:\Software\MyCompany -UseTransaction
PS C:\> start-transaction -timeout 2

# Wait two minutes...

PS C:\> > get-transaction

RollbackPreference   SubscriberCount   Status
------------------   ---------------   -----------
Error                1                 RolledBack

PS C:\> new-item HKCU:\Software\MyCompany -UseTransaction

New-Item : Cannot use transaction. The transaction has been rolled back or has timed out.
At line:1 char:9
+ new-item <<<<  MyCompany -UseTransaction
```

This command uses the Timeout parameter of Start-Transaction to start a transaction that must be completed within two minutes.
If the transaction is not complete when the timeout expires, it is rolled back automatically.

When the timeout expires, you are not notified, but the Status property of the transaction object is set to RolledBack and commands that use the UseTransaction parameter fail.

## PARAMETERS

### -Independent
Starts a transaction that is independent of any transactions in progress.
By default, if you use Start-Transaction while another transaction is in progress, a new subscriber is added to the transaction in progress.
This parameter has an effect only when a transaction is already in progress in the session.

By default, if you use Start-Transaction while a transaction is in progress, the existing transaction object is reused and the subscriber count is incremented.
The effect is much like joining the original transaction.
An Undo-Transaction command rolls back the entire the transaction.
To complete the transaction, you must enter a Complete-Transaction command for each subscriber.
Because most transactions that are in progress at the same time are related, the default is sufficient for most uses.

If you use the Independent parameter, a new transaction is created that can be completed or undone without affecting the original transaction.
However, because only one transaction can be active at a time, you must complete or roll back the new transaction before resuming work on the original transaction.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Reuse the original transaction object.
Accept pipeline input: False
Accept wildcard characters: False
```

### -RollbackPreference
Specifies the conditions under which a transaction is automatically rolled back.
The default value is "Error".

Valid values are:

- Error:  The transaction is rolled back automatically if a terminating or non-terminating error occurs. "Error" is the default.
- Terminating error: The transaction is rolled back automatically if a terminating error occurs.
- Never: The transaction is never rolled back automatically.

```yaml
Type: RollbackSeverity
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Error
Accept pipeline input: False
Accept wildcard characters: False
```

### -Timeout
Specifies the maximum time, in minutes, that the transaction is active.
When the time-out expires, the transaction is automatically rolled back.

By default, there is no time-out for transactions that are started at the command line.
When transactions are started by a script, the default time-out is 30 minutes.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: TimeoutMins

Required: False
Position: Named
Default value: No timeout (infinite)
Accept pipeline input: False
Accept wildcard characters: False
```

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

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### None
This cmdlet does not generate any output.

## NOTES

## RELATED LINKS

[Complete-Transaction](Complete-Transaction.md)

[Get-Transaction](Get-Transaction.md)

[Undo-Transaction](Undo-Transaction.md)

[Use-Transaction](Use-Transaction.md)

[about_Transactions](../Microsoft.PowerShell.Core/About/about_Transactions.md)


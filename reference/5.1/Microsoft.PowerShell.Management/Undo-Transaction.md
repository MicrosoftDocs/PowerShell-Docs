---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 10/01/2021
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/undo-transaction?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Undo-Transaction
---

# Undo-Transaction

## SYNOPSIS
Rolls back the active transaction.

## SYNTAX

```
Undo-Transaction [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Undo-Transaction` cmdlet rolls back the active transaction. When you roll back a transaction,
the changes that were made by the commands in the transaction are discarded and the data is restored
to its original form.

If the transaction includes multiple subscribers, an `Undo-Transaction` command rolls back the whole
transaction for all subscribers.

By default, transactions are rolled back automatically if any command in the transaction generates
an error. However, transactions can be started by using a different rollback preference and you can
use this cmdlet to roll back the active transaction at any time.

The `Undo-Transaction` cmdlet is one of a set of cmdlets that support the transactions feature in
Windows PowerShell. For more information, see [about_Transactions](../Microsoft.PowerShell.Core/About/about_Transactions.md).

## EXAMPLES

### Example 1: Roll back the current transaction

```
Undo-Transaction
```

This command rolls back the current, active, transaction.

### Example 2: Start and roll back a transaction

```powershell
Set-Location hkcu:\software
Start-Transaction
New-Item -Path "ContosoCompany" -UseTransaction
Undo-Transaction
```

This example starts a transaction and then rolls it back. As a result, no changes are made to the
registry.

### Example 3: Roll back a transaction for all subscribers

```powershell
Set-Location hkcu:\software
Start-Transaction
New-Item -Path "ContosoCompany" -UseTransaction
Get-Transaction
```

```Output
RollbackPreference   SubscriberCount   Status
------------------   ---------------   -----
Error                1                 Active
```

```powershell
Start-Transaction
Get-Transaction
```

```Output
RollbackPreference   SubscriberCount   Status
------------------   ---------------   -----
Error                2                 Active
```

```powershell
Undo-Transaction
Get-Transaction
```

```Output
RollbackPreference   SubscriberCount   Status
------------------   ---------------   -----
Error                0                 RolledBack
```

This example demonstrates that when any subscriber rolls back a transaction, the whole transaction
is rolled back for all subscribers.

The first command changes the location to the `HKCU:\Software` registry key.

The second command starts a transaction.

The third command uses the `New-Item` cmdlet to create a new registry key. The command uses the
**UseTransaction** parameter to include the change in the transaction.

The fourth command uses the `Get-Transaction` cmdlet to get the active transaction. Notice that the
status is Active and the subscriber count is 1.

The fifth command uses the `Start-Transaction` command again. Typically, starting a transaction
while another transaction is in progress occurs when a script that is used by the main transaction
includes its own complete transaction. This example is performed interactively so that you can
examine it in stages. When you run a `Start-Transaction` command while another transaction is in
progress, the commands join the existing transaction as a new subscriber and the subscriber count is
incremented.

The sixth command uses the `Get-Transaction` cmdlet to get the active transaction. Notice that the
subscriber count is now 2.

The seventh command uses `Undo-Transaction` to roll back the transaction. This command does not
return any objects.

The final command is a `Get-Transaction` command that gets the active, or in this case, the most
recently active, transaction. The results show that the transaction is rolled back, and that the
subscriber count is 0, showing that the transaction was rolled back for all subscribers.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
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
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters


This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

You cannot pipe input to this cmdlet.

## OUTPUTS

### None

This cmdlet does not return any output.

## NOTES

- You cannot roll back a transaction that has been committed.

  You cannot roll back any transaction other than the active transaction. To roll back a different,
  independent transaction, you must first commit or roll back the active transaction.

  Rolling back the transaction ends the transaction. To use a transaction again, you must start a
  new transaction.

## RELATED LINKS

[Complete-Transaction](Complete-Transaction.md)

[Get-Transaction](Get-Transaction.md)

[Start-Transaction](Start-Transaction.md)

[Use-Transaction](Use-Transaction.md)

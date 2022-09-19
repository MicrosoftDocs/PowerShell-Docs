---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 09/30/2021
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.management/complete-transaction?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Complete-Transaction
---

# Complete-Transaction

## SYNOPSIS
Commits the active transaction.

## SYNTAX

```
Complete-Transaction [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Complete-Transaction` cmdlet commits an active transaction. When you commit a transaction, the
commands in the transaction are finalized and the data affected by the commands is changed.

If the transaction includes multiple subscribers, to commit the transaction, you must enter one
`Complete-Transaction` command for every `Start-Transaction` command.

The `Complete-Transaction` cmdlet is one of a set of cmdlets that support the transactions feature in Windows PowerShell.
For more information, see [about_Transactions](../Microsoft.PowerShell.Core/About/about_Transactions.md).

## EXAMPLES

### Example 1: Commit a transaction

```powershell
Set-Location hkcu:\software
Start-Transaction
New-Item MyCompany -UseTransaction
Get-ChildItem m*
```

```Output
Hive: HKEY_CURRENT_USER\software

SKC  VC Name                           Property
---  -- ----                           --------
82   1 Microsoft                      {(default)}
```

```powershell
Complete-Transaction
Get-ChildItem m*
```

```Output
Hive: HKEY_CURRENT_USER\Software

SKC  VC Name                           Property
---  -- ----                           --------
82   1 Microsoft                      {(default)}
0   0 MyCompany                      {}
```

This example shows what happens when you use the `Complete-Transaction` cmdlet to commit a
transaction.

The `Start-Transaction` command starts the transaction. The New-Item command uses the
**UseTransaction** parameter to include the command in the transaction.

The first `Get-ChildItem` command shows that the new item has not yet been added to the
registry.

The `Complete-Transaction` command commits the transaction, which makes the registry change
effective. As a result, the second `Get-ChildItem` command shows that the registry is changed.

### Example 2: Commit a transaction that has more than one subscriber

```powershell
Set-Location hkcu:\software
Start-Transaction
New-Item MyCompany -UseTransaction
```

```Output
Hive: HKEY_CURRENT_USER\Software

SKC  VC Name                           Property
---  -- ----                           --------
0   0 MyCompany                      {}
```

```powershell
Start-Transaction
Get-Transaction
```

```Output
RollbackPreference   SubscriberCount  Status
------------------   ---------------  ------
Error                2                Active
```

```powershell
New-ItemProperty -Path MyCompany -Name MyKey -Value -UseTransaction
```

```Output
MyKey
-----
123
```

```powershell
Complete-Transaction
Get-Transaction
```

```Output
RollbackPreference   SubscriberCount  Status
------------------   ---------------  ------
Error                1                Active
```

```powershell
Get-ChildItem m*
```

```Output
Hive: HKEY_CURRENT_USER\Software

SKC  VC Name                           Property
---  -- ----                           --------
82   1 Microsoft                      {(default)}
```

```powershell
Complete-Transaction
Get-ChildItem m*
```

```Output
Hive: HKEY_CURRENT_USER\Software

SKC  VC Name                           Property
---  -- ----                           --------
82   1 Microsoft                      {(default)}
0   1 MyCompany                      {MyKey}
```

This example shows how to use `Complete-Transaction` to commit a transaction that has more than one
subscriber.

To commit a multi-subscriber transaction, you must enter one `Complete-Transaction` command for
every `Start-Transaction` command. The data is changed only when the final `Complete-Transaction`
command is submitted.

For demonstration purposes, this example shows a series of commands entered at the command line. In
practice, transactions are likely to be run in scripts, with the secondary transaction being run by
a function or helper script that is called by the main script.

In this example, a `Start-Transaction` command starts the transaction. A `New-Item` command with the
**UseTransaction** parameter adds the MyCompany key to the Software key. Although the `New-Item`
cmdlet returns a key object, the data in the registry is not yet changed.

A second `Start-Transaction` command adds a second subscriber to the existing transaction. The
`Get-Transaction` cmdlet confirms that the subscriber count is 2. A New-ItemProperty command with
the **UseTransaction** parameter adds a registry entry to the new MyCompany key. Again, the command
returns a value, but the registry is not changed.

The first `Complete-Transaction` command reduces the subscriber count by 1. This is confirmed by a
`Get-Transaction` command. However, no data is changed, as evidenced by a `Get-ChildItem m*`
command.

The second `Complete-Transaction` command commits the entire transaction and changes the data in the
registry. This is confirmed by a second `Get-ChildItem m*` command, which shows the changes.

### Example 3: Perform a transaction that does not change any data

```powershell
Set-Location hkcu:\software
Start-Transaction
New-Item MyCompany -UseTransaction
Get-ChildItem m*
```

```Output
Hive: HKEY_CURRENT_USER\Software

SKC  VC Name                           Property
---  -- ----                           --------
82   1 Microsoft                      {(default)}
```

```powershell
Get-ChildItem m* -UseTransaction
```

```Output
Hive: HKEY_CURRENT_USER\Software

SKC  VC Name                           Property
---  -- ----                           --------
82   1 Microsoft                      {(default)}
0   0 MyCompany                      {}
```

```powershell
Complete-Transaction
```

This example shows the value of using Get-\* commands, and other commands that do not change data,
in a transaction. When a `Get-\*` command is used in a transaction, it gets the objects that are
part of the transaction. This allows you to preview the changes in the transaction before the
changes are committed.

In this example, a transaction is started. A New-Item command with the **UseTransaction** parameter
adds a new key to the registry as part of the transaction.

Because the new registry key is not added to the registry until the `Complete-Transaction` command
is run, a simple `Get-ChildItem` command shows the registry without the new key.

However, when you add the **UseTransaction** parameter to the `Get-ChildItem` command, the command
becomes part of the transaction, and it gets the items in the transaction even if they are not yet
added to the data.

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

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

You cannot pipe objects to this cmdlet.

## OUTPUTS

### None

This cmdlet does not generate any output.

## NOTES

- You cannot roll back a transaction that has been committed, or commit a transaction that has been
  rolled back.

  You cannot roll back any transaction other than the active transaction. To roll back a different
  transaction, you must first commit or roll back the active transaction.

  By default, if any part of a transaction cannot be committed, such as when a command in the
  transaction results in an error, the entire transaction is rolled back.

## RELATED LINKS

[Get-Transaction](Get-Transaction.md)

[Start-Transaction](Start-Transaction.md)

[Undo-Transaction](Undo-Transaction.md)

[Use-Transaction](Use-Transaction.md)

[Get-ChildItem](Get-ChildItem.md)

[New-Item](New-Item.md)

[New-ItemProperty](New-ItemProperty.md)

---
description: Describes how to manage transacted operations in PowerShell.
Locale: en-US
ms.date: 09/03/2024
online version: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_transactions?view=powershell-5.1&WT.mc_id=ps-gethelp
schema: 2.0.0
title: about_Transactions
---

# about_Transactions

## Short description

Describes how to manage transacted operations in PowerShell.

## Long description

Transactions are supported in PowerShell beginning in PowerShell 2.0. This
feature enables you to start a transaction, to indicate which commands are part
of the transaction, and to commit or roll back a transaction.

In PowerShell, a transaction is a set of one or more commands that are managed
as a logical unit. A transaction can be completed ("committed"), which changes
data affected by the transaction. Or, a transaction can be completely undone
("rolled back") so that the affected data isn't changed by the transaction.

Because the commands in a transaction are managed as a unit, either all
commands are committed, or all commands are rolled back.

Transactions are widely used in data processing, most notably in database
operations and for financial transactions. Transactions are most often used
when the worst-case scenario for a set of commands isn't that they all fail,
but that some commands succeed while others fail, leaving the system in a
damaged, false, or uninterpretable state that's difficult to repair.

## Transaction cmdlets

PowerShell includes several cmdlets designed for managing transactions.

- `Start-Transaction`: Starts a new transaction.
- `Use-Transaction`: Adds a command or expression to the transaction. The
  command must use transaction-enabled objects.
- `Undo-Transaction`: Rolls back the transaction so that no data is changed by
  the transaction.
- `Complete-Transaction`: Commits the transaction. The data affected by the
  transaction is changed.
- `Get-Transaction`: Gets information about the active transaction.

For a list of transaction cmdlets, type:

```powershell
Get-Command *transaction
```

For detailed information about the cmdlets, type:

```powershell
Get-Help Use-Transaction -Detailed
```

## Transaction-enabled elements

To participate in a transaction, both the cmdlet and the provider must support
transactions. This feature is built into the objects that are affected by the
transaction.

The PowerShell Registry provider supports transactions in Windows. The
**TransactedString** object works with any operating system that runs
PowerShell.

Other PowerShell providers can support transactions. To find the PowerShell
providers in your session that support transactions, use the following command
to find the **Transactions** value in the **Capabilities** property of
providers:

```powershell
Get-PSProvider | Where-Object {$_.Capabilities -like "*transactions*"}
```

For more information about a provider, see the Help for the provider. To get
provider help, type:

```
Get-Help <provider-name>
```

For example, to get Help for the Registry provider, type:

```powershell
Get-Help registry
```

## The **UseTransaction** parameter

Cmdlets that can support transactions have a **UseTransaction** parameter. This
parameter includes the command in the active transaction. You can use the full
parameter name or its alias, **usetx**.

The parameter can be used only when the session contains an active transaction.
If you enter a command with the **UseTransaction** parameter when there is no
active transaction, the command fails.

To find cmdlets with the **UseTransaction** parameter, type:

```powershell
Get-Help * -Parameter UseTransaction
```

In PowerShell core, all the cmdlets designed to work with PowerShell providers
support transactions. As a result, you can use the provider cmdlets to manage
transactions.

For more information about PowerShell providers, see
[about_Providers](about_Providers.md).

## The transaction object

Transactions are represented in PowerShell by a transaction object,
**System.Management.Automation.Transaction**.

The object has the following properties:

- **RollbackPreference**: Contains the rollback preference set for the current
  transaction. You can set the rollback preference when you use
  `Start-Transaction` to start the transaction.

  The rollback preference determines the conditions under which the transaction
  is rolled back automatically. Valid values are `Error`, `TerminatingError`,
  and `Never`. The default value is `Error`.

- **Status**: Contains the current status of the transaction. Valid values are
  `Active`, `Committed`, and `RolledBack`.

- **SubscriberCount**: Contains the number of subscribers to the transaction. A
  subscriber is added to a transaction when you start a transaction while
  another transaction is in progress. The subscriber count is decremented when
  a subscriber commits the transaction.

## Active transactions

In PowerShell, only one transaction is active at a time, and you can manage
only the active transaction. Multiple transactions can be in progress in the
same session at the same time, but only the most-recently started transaction
is active.

As a result, you can't specify a particular transaction when using the
transaction cmdlets. Commands always apply to the active transaction.

This is most evident in the behavior of the `Get-Transaction` cmdlet. When you
enter a `Get-Transaction` command, `Get-Transaction` always gets only one
transaction object. This object is the object that represents the active
transaction.

To manage a different transaction, you must first finish the active
transaction, either by committing it or rolling it back. When you do this, the
previous transaction becomes active automatically. Transactions become active
in the reverse of order of which they're started, so that the most recently
started transaction is always active.

## Subscribers and independent transactions

If you start a transaction while another transaction is in progress, by
default, PowerShell doesn't start a new transaction. Instead, it adds a
"subscriber" to the current transaction.

When a transaction has multiple subscribers, a single `Undo-Transaction`
command at any point rolls back the entire transaction for all subscribers.
However, to commit the transaction, you must enter a `Complete-Transaction`
command for every subscriber.

To find the number of subscribers to a transaction, check the SubscriberCount
property of the transaction object. For example, the following command uses the
`Get-Transaction` cmdlet to get the value of the SubscriberCount property of
the active transaction:

```powershell
(Get-Transaction).SubscriberCount
```

Adding a subscriber is the default behavior because most transactions that are
started while another transaction is in progress are related to the original
transaction. In the typical model, a script that contains a transaction calls a
helper script that contains its own transaction. Because the transactions are
related, they should be rolled back or committed as a unit.

However, you can start a transaction that's independent of the current
transaction by using the Independent parameter of the `Start-Transaction`
cmdlet.

When you start an independent transaction, `Start-Transaction` creates a new
transaction object, and the new transaction becomes the active transaction. The
independent transaction can be committed or rolled back without affecting the
original transaction.

When the independent transaction is finished (committed or rolled back), the
original transaction becomes the active transaction again.

## Changing data

When you use transactions to change data, the data that's affected by the
transaction isn't changed until you commit the transaction. However, the same
data can be changed by commands that aren't part of the transaction.

Keep this in mind when you are using transactions to manage shared data.
Typically, databases have mechanisms that lock the data while you are working
on it, preventing other users, and other commands, scripts, and functions, from
changing it.

However, the lock is a feature of the database. It isn't related to
transactions. If you are working in a transaction-enabled file system or other
data store, the data can be changed while the transaction is in progress.

## Examples

The examples in this section use the PowerShell Registry provider and assume
that you are familiar with it. For information about the Registry provider,
type `Get-Help registry`.

### Example 1: Committing a transaction

To create a transaction, use the `Start-Transaction` cmdlet. The following
command starts a transaction with the default settings.

```powershell
Start-Transaction
```

To include commands in the transaction, use the UseTransaction parameter of the
cmdlet. By default, commands aren't included in the transaction,

For example, the following command, which sets the current location in the
Software key of the `HKCU:` drive, isn't included in the transaction.

```powershell
cd hkcu:\Software
```

The following command, which creates the MyCompany key, uses the
**UseTransaction** parameter of the `New-Item` cmdlet to include the command in
the active transaction.

```powershell
New-Item MyCompany -UseTransaction
```

The command returns an object that represents the new key, but because the
command is part of the transaction, the registry isn't yet changed.

```
Hive: HKEY_CURRENT_USER\Software

SKC  VC Name                           Property
---  -- ----                           --------
  0   0 MyCompany                      {}
```

To commit the transaction, use the `Complete-Transaction` cmdlet. Because it
always affects the active transaction, you can't specify the transaction.

```powershell
Complete-Transaction
```

As a result, the `MyCompany` key is added to the registry.

```powershell
dir m*
```

```output
Hive: HKEY_CURRENT_USER\software

SKC  VC Name                           Property
---  -- ----                           --------
 83   1 Microsoft                      {(default)}
  0   0 MyCompany                      {}
```

### Example 2: Rolling back a transaction

To create a transaction, use the `Start-Transaction` cmdlet. The following
command starts a transaction with the default settings.

```powershell
Start-Transaction
```

The following command, which creates the MyOtherCompany key, uses the
UseTransaction parameter of the `New-Item` cmdlet to include the command in the
active transaction.

```powershell
New-Item MyOtherCompany -UseTransaction
```

The command returns an object that represents the new key, but because the
command is part of the transaction, the registry isn't yet changed.

```
Hive: HKEY_CURRENT_USER\Software

SKC  VC Name                           Property
---  -- ----                           --------
  0   0 MyOtherCompany                 {}
```

To roll back the transaction, use the `Undo-Transaction` cmdlet. Because it
always affects the active transaction, you don't specify the transaction.

```powershell
Undo-Transaction
```

The result is that the `MyOtherCompany` key isn't added to the registry.

```powershell
dir m*
```

```output
Hive: HKEY_CURRENT_USER\software

SKC  VC Name                           Property
---  -- ----                           --------
 83   1 Microsoft                      {(default)}
  0   0 MyCompany                      {}
```

### Example 3: Previewing a transaction

Typically, the commands used in a transaction change data. However, the
commands that get data are useful in a transaction, too, because they get data
inside of the transaction. This provides a preview of the changes that
committing the transaction would cause.

The following example shows how to use the `Get-ChildItem` command (the alias
is `dir`) to preview the changes in a transaction.

The following command starts a transaction.

```powershell
Start-Transaction
```

The following command uses the `New-ItemProperty` cmdlet to add the `MyKey`
registry entry to the MyCompany key. The command uses the UseTransaction
parameter to include the command in the transaction.

```powershell
New-Itemproperty -path MyCompany -Name MyKey -value 123 -UseTransaction
```

The command returns an object representing the new registry entry, but the
registry entry isn't changed.

```
MyKey
-----
123
```

To get the items that are currently in the registry, use a `Get-ChildItem`
command (`dir`) without the UseTransaction parameter. The following command
gets items that begin with "M."

```powershell
dir m*
```

The result shows that no entries have yet been added to the `MyCompany` key.

```output
Hive: HKEY_CURRENT_USER\Software

SKC  VC Name                           Property
---  -- ----                           --------
 83   1 Microsoft                      {(default)}
  0   0 MyCompany                      {}
```

To preview the effect of committing the transaction, enter a `Get-ChildItem`
(`dir`) command with the UseTransaction parameter. This command has a view of
the data from within the transaction.

```powershell
dir m* -useTransaction
```

The result shows that, if the transaction is committed, the `MyKey` entry is
added to the `MyCompany` key.

```output
Hive: HKEY_CURRENT_USER\Software

SKC  VC Name                           Property
---  -- ----                           --------
 83   1 Microsoft                      {(default)}
  0   1 MyCompany                      {MyKey}
```

### Example 4: Combining transacted and non-transacted commands

You can enter non-transacted commands during a transaction. The non-transacted
commands affect the data immediately, but they don't affect the transaction.
The following command starts a transaction in the `HKCU:\Software` registry
key.

```powershell
Start-Transaction
```

The next three commands use the `New-Item` cmdlet to add keys to the registry.
The first and third commands use the UseTransaction parameter to include the
commands in the transaction. The second command omits the parameter. Because
the second command isn't included in the transaction, it's effective
immediately.

```powershell
New-Item MyCompany1 -UseTransaction
New-Item MyCompany2
New-Item MyCompany3 -UseTransaction
```

To view the current state of the registry, use a `Get-ChildItem` (`dir`)
command without the UseTransaction parameter. This command gets items that
begin with `M`.

```powershell
dir m*
```

The result shows that the `MyCompany2` key is added to the registry, but the
`MyCompany1` and `MyCompany3` keys, which are part of the transaction, aren't
added.

```output
Hive: HKEY_CURRENT_USER\Software

SKC  VC Name                           Property
---  -- ----                           --------
 83   1 Microsoft                      {(default)}
  0    0 MyCompany2                     {}
```

The following command commits the transaction.

```powershell
Complete-Transaction
```

Now, the keys that were added as part of the transaction appear in the
registry.

```powershell
dir m*
```

```output
Hive: HKEY_CURRENT_USER\Software

SKC  VC Name                           Property
---  -- ----                           --------
83   1 Microsoft                      {(default)}
0    0 MyCompany1                     {}
0    0 MyCompany2                     {}
0    0 MyCompany3                     {}
```

### Example 5: Using automatic rollback

When a command in a transaction generates an error of any kind, the transaction
is automatically rolled back.

This default behavior is designed for scripts that run transactions. Scripts
are typically well tested and include error-handling logic, so errors aren't
expected and should terminate the transaction.

The first command starts a transaction in the `HKCU:\Software` registry key.

```powershell
Start-Transaction
```

The following command uses the `New-Item` cmdlet to add the `MyCompany` key to
the registry. The command uses the **UseTransaction** parameter (the alias is
**usetx**) to include the command in the transaction.

```powershell
New-Item MyCompany -usetx
```

Because the `MyCompany` key already exists in the registry, the command fails,
and the transaction is rolled back.

```output
New-Item : A key at this path already exists
At line:1 char:9
+ New-Item <<<<  MyCompany -usetx
```

A `Get-Transaction` command confirms that the transaction has been rolled back
and that the SubscriberCount is 0.

```output
RollbackPreference   SubscriberCount   Status
------------------   ---------------   ------
Error                0                 RolledBack
```

### Example 6: Changing the rollback preference

If you want the transaction to be more error tolerant, you can use the
**RollbackPreference** parameter of `Start-Transaction` to change the
preference.

The following command starts a transaction with a rollback preference of
`Never`.

```powershell
Start-Transaction -RollbackPreference Never
```

In this case, when the command fails, the transaction isn't automatically
rolled back.

```powershell
New-Item MyCompany -usetx
```

```output
New-Item : A key at this path already exists
At line:1 char:9
+ New-Item <<<<  MyCompany -usetx
```

Because the transaction is still active, you can resubmit the command as part
of the transaction.

```powershell
New-Item MyOtherCompany -usetx
```

### Example 7: Using the `Use-Transaction` cmdlet

The `Use-Transaction` cmdlet enables you to do direct scripting against
transaction-enabled Microsoft .NET Framework objects. `Use-Transaction` takes a
script block that can only contain commands and expressions that use
transaction-enabled .NET Framework objects, such as instances of the
**Microsoft.PowerShell.Commands.Management.TransactedString** class.

The following command starts a transaction.

```powershell
Start-Transaction
```

The following `New-Object` command creates an instance of the
**TransactedString** class and saves it in the `$t` variable.

```powershell
$t = New-Object Microsoft.PowerShell.Commands.Management.TransactedString
```

The following command uses the Append method of the **TransactedString** object
to add text to the string. Because the command isn't part of the transaction,
the change is effective immediately.

```powershell
$t.append("Windows")
```

The following command uses the same Append method to add text, but it adds the
text as part of the transaction. The command is enclosed in braces, and it's
set as the value of the **ScriptBlock** parameter of `Use-Transaction`. The
**UseTransaction** parameter (**usetx**) is required.

```powershell
Use-Transaction {$t.append(" PowerShell")} -usetx
```

To see the current content of the transacted string in `$t`, use the `ToString`
method of the **TransactedString** object.

```powershell
$t.tostring()
```

The output shows that only the non-transacted changes are effective.

```output
Windows
```

To see the current content of the transacted string in $t from within the
transaction, embed the expression in a `Use-Transaction` command.

```powershell
Use-Transaction {$t.tostring()} -usetx
```

The output shows the transaction view.

```output
PowerShell
```

The following command commits the transaction.

```powershell
Complete-Transaction
```

To see the final string:

```
$t.tostring()
PowerShell
```

### Example 8: Managing multi-subscriber transactions

When you start a transaction while another transaction is in progress,
PowerShell doesn't create a second transaction by default. Instead, it adds a
subscriber to the current transaction.

This example shows how to view and manage a multi-subscriber transaction.

Begin by starting a transaction in the `HKCU:\Software` key.

```powershell
Start-Transaction
```

The following command uses the `Get-Transaction` command to get the active
transaction.

```powershell
Get-Transaction
```

The result shows the object that represents the active transaction.

```output
RollbackPreference   SubscriberCount   Status
------------------   ---------------   ------
Error                1                 Active
```

The following command adds the MyCompany key to the registry. The command uses
the UseTransaction parameter to include the command in the transaction.

```powershell
New-Item MyCompany -UseTransaction
```

The following command uses the `Start-Transaction` command to start a
transaction. Although this command is typed at the command prompt, this
scenario is more likely to happen when you run a script that contains a
transaction.

```powershell
Start-Transaction
```

A `Get-Transaction` command shows that the subscriber count on the transaction
object is incremented. The value is now 2.

```output
RollbackPreference   SubscriberCount   Status
------------------   ---------------   ------
Error                2                 Active
```

The next command uses the `New-ItemProperty` cmdlet to add the MyKey registry
entry to the MyCompany key. It uses the UseTransaction parameter to include
the command in the transaction.

```powershell
New-ItemProperty -path MyCompany -name MyKey -UseTransaction
```

The MyCompany key doesn't exist in the registry, but this command succeeds
because the two commands are part of the same transaction.

The following command commits the transaction. If it rolled back the
transaction, the transaction would be rolled back for all the subscribers.

```powershell
Complete-Transaction
```

A `Get-Transaction` command shows that the subscriber count on the transaction
object is 1, but the value of Status is still Active (not Committed).

```output
RollbackPreference   SubscriberCount   Status
------------------   ---------------   ------
Error                1                 Active
```

To finish committing the transaction, enter a second Complete- Transaction
command. To commit a multi-subscriber transaction, you must enter one
`Complete-Transaction` command for each `Start-Transaction` command.

```powershell
Complete-Transaction
```

Another `Get-Transaction` command shows that the transaction has been committed.

```output
RollbackPreference   SubscriberCount   Status
------------------   ---------------   ------
Error                0                 Committed
```

### Example 9: Managing independent transactions

When you start a transaction while another transaction is in progress, you can
use the **Independent** parameter of `Start-Transaction` to make the new
transaction independent of the original transaction.

When you do, `Start-Transaction` creates a new transaction object and makes the
new transaction the active transaction.

Begin by starting a transaction in the `HKCU:\Software` key.

```powershell
Start-Transaction
```

The following command uses the `Get-Transaction` command to get the active
transaction.

```powershell
Get-Transaction
```

The result shows the object that represents the active transaction.

```output
RollbackPreference   SubscriberCount   Status
------------------   ---------------   ------
Error                1                 Active
```

The following command adds the MyCompany registry key as part of the
transaction. It uses the **UseTransaction** parameter (**usetx**) to include
the command in the active transaction.

```powershell
New-Item MyCompany -use
```

The following command starts a new transaction. The command uses the
Independent parameter to indicate that this transaction isn't a subscriber to
the active transaction.

```powershell
Start-Transaction -Independent
```

When you create an independent transaction, the new (most-recently created)
transaction becomes the active transaction. You can use a `Get-Transaction`
command to get the active transaction.

```powershell
Get-Transaction
```

Note that the SubscriberCount of the transaction is 1, indicating that there
are no other subscribers and that the transaction is new.

```output
RollbackPreference   SubscriberCount   Status
------------------   ---------------   ------
Error                1                 Active
```

The new transaction must be finished (either committed or rolled back) before
you can manage the original transaction.

The following command adds the MyOtherCompany key to the registry. It uses the
**UseTransaction** parameter (**usetx**) to include the command in the active
transaction.

```powershell
New-Item MyOtherCompany -usetx
```

Now, roll back the transaction. If there were a single transaction with two
subscribers, rolling back the transaction would roll back the entire
transaction for all the subscribers.

However, because these transactions are independent, rolling back the newest
transaction cancels the registry changes and makes the original transaction
the active transaction.

```powershell
Undo-Transaction
```

A `Get-Transaction` command confirms that the original transaction is still
active in the session.

```powershell
Get-Transaction
```

```output
RollbackPreference   SubscriberCount   Status
------------------   ---------------   ------
Error                1                 Active
```

The following command commits the active transaction.

```powershell
Complete-Transaction
```

A `Get-ChildItem` command shows that the registry has been changed.

```powershell
dir m*
```

```output
Hive: HKEY_CURRENT_USER\Software

SKC  VC Name                           Property
---  -- ----                           --------
 83   1 Microsoft                      {(default)}
  0   0 MyCompany                      {}
```

## See also

- [about_Providers](about_Providers.md)
- [Get-ChildItem](xref:Microsoft.PowerShell.Management.Get-ChildItem)
- [Get-PSProvider](xref:Microsoft.PowerShell.Management.Get-PSProvider)
- [Complete-Transaction](xref:Microsoft.PowerShell.Management.Complete-Transaction)
- [Get-Transaction](xref:Microsoft.PowerShell.Management.Get-Transaction)
- [Start-Transaction](xref:Microsoft.PowerShell.Management.Start-Transaction)
- [Undo-Transaction](xref:Microsoft.PowerShell.Management.Undo-Transaction)
- [Use-Transaction](xref:Microsoft.PowerShell.Management.Use-Transaction)

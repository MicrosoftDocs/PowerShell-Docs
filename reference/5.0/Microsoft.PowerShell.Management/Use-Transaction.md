---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkId=821649
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Use-Transaction
---
# Use-Transaction

## SYNOPSIS
Adds the script block to the active transaction.

## SYNTAX

```
Use-Transaction [-TransactedScript] <ScriptBlock> [-UseTransaction] [<CommonParameters>]
```

## DESCRIPTION

The **Use-Transaction** cmdlet adds a script block to an active transaction.
This enables you to do transacted scripting by using transaction-enabled Microsoft .NET Framework objects.
The script block can contain only transaction-enabled .NET Framework objects, such as instances of the Microsoft.PowerShell.Commands.Management.TransactedString class.

The *UseTransaction* parameter, which is optional for most cmdlets, is required when you use this cmdlet.

**Use-Transaction** is one of a set of cmdlets that support the transactions feature in Windows PowerShell.
For more information, see about_Transactions.

## EXAMPLES

### Example 1: Script by using a transaction-enabled object

```
PS C:\> Start-Transaction
PS C:\> $transactedString = New-Object Microsoft.PowerShell.Commands.Management.TransactedString
PS C:\> $transactedString.Append("Hello")
PS C:\> Use-Transaction -TransactedScript { $transactedString.Append(", World") } -UseTransaction
PS C:\> $transactedString.ToString()
Hello
PS C:\> Use-Transaction -TransactedScript { $transactedString.ToString() } -UseTransaction
Hello, World
PS C:\> Complete-Transaction
PS C:\> $transactedString.ToString()
Hello, World
```

This example shows how to use **Use-Transaction** to script against a transaction-enabled .NET Framework object.
In this case, the object is a **TransactedString** object.

The first command uses the Start-Transaction cmdlet to start a transaction.

The second command uses the New-Object command to create a **TransactedString** object.
It stores the object in the $TransactedString variable.

The third and fourth commands both use the **Append** method of the **TransactedString** object to add text to the value of $TransactedString.
One command is part of the transaction.
The other command is not.

The third command uses the **Append** method of the transacted string to add Hello to the value of $TransactedString.
Because the command is not part of the transaction, the change is applied immediately.

The fourth command uses **Use-Transaction** to add text to the string in the transaction.
The command uses the **Append** method to add ", World" to the value of $TransactedString.
The command is enclosed in braces ( {} ) to make it a script block.
The *UseTransaction* parameter is required in this command.

The fifth and sixth commands use the **ToString** method of the **TransactedString** object to display the value of the **TransactedString** as a string.
Again, one command is part of the transaction.
The other transaction is not.

The fifth command uses the **ToString** method to display the current value of the $TransactedString variable.
Because it is not part of the transaction, it displays only the current state of the string.

The sixth command uses **Use-Transaction** to run the same command in the transaction.
Because the command is part of the transaction, it displays the current value of the string in the transaction, much like a preview of the transaction changes.

The seventh command uses the Complete-Transaction cmdlet to commit the transaction.

The final command uses the **ToString** method to display the resulting value of the variable as a string.

### Example 2: Roll back a transaction

```
PS C:\> Start-Transaction
PS C:\> $transactedString = New-Object Microsoft.PowerShell.Commands.Management.TransactedString
PS C:\> $transactedString.Append("Hello")
PS C:\> Use-Transaction -TransactedScript { $transactedString.Append(", World") } -UseTransaction
PS C:\> Undo-Transaction
PS C:\> $transactedString.ToString()
Hello
```

This example shows the effect of rolling back a transaction that includes **Use-Transaction** commands.
Like all commands in a transaction, when the transaction is rolled back, the transacted changes are discarded and the data is unchanged.

The first command uses **Start-Transaction** to start a transaction.

The second command uses **New-Object** to create a **TransactedString** object.
It stores the object in the $TransactedString variable.

The third command, which is not part of the transaction, uses the **Append** method to add "Hello" to the value of $TransactedString.

The fourth command uses **Use-Transaction** to run another command that uses the **Append** method in the transaction.
The command uses the **Append** method to add ", World" to the value of $TransactedString.

The fifth command uses the Undo-Transaction cmdlet to roll back the transaction.
As a result, all commands performed in the transaction are reversed.

The final command uses the **ToString** method to display the resulting value of $TransactedString as a string.
The results show that only the changes that were made outside the transaction were applied to the object.

## PARAMETERS

### -TransactedScript

Specifies the script block that is run in the transaction.
Enter any valid script block enclosed in braces ( { } ).
This parameter is required.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseTransaction

Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see about_Transactions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: usetx

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

### PSObject

This cmdlet returns the result of the transaction.

## NOTES

* The *UseTransaction* parameter includes the command in the active transaction. Because the **Use-Transaction** cmdlet is always used in transactions, this parameter is required to make any **Use-Transaction** command effective.

*

## RELATED LINKS

[Complete-Transaction](Complete-Transaction.md)

[Get-Transaction](Get-Transaction.md)

[Start-Transaction](Start-Transaction.md)

[Undo-Transaction](Undo-Transaction.md)
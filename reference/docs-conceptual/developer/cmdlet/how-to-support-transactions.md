---
ms.date: 09/13/2016
ms.topic: reference
title: How to Support Transactions
description: How to Support Transactions
---
# How to Support Transactions

This example shows the basic code elements that add support for transactions to a cmdlet.

> [!IMPORTANT]
> For more information about how Windows PowerShell handles transactions,
> see [About Transactions][about_Transactions].

## To support transactions

1. When you declare the Cmdlet attribute,
   specify that the cmdlet supports transactions.
   When the cmdlet supports transactions,
   Windows PowerShell adds the `UseTransaction` parameter to the cmdlet when it is run.

    ```csharp
    [Cmdlet(VerbsCommunications.Send, "GreetingTx",
            SupportsTransactions=true )]
    ```

2. Within one of the input processing methods,
   add an `if` block to determine if a transaction is available.
   If the `if` statement resolves to `true`,
   the actions within this statement
   can be performed within the context of the current transaction.

    ```csharp
    if (TransactionAvailable())
    {
      using (CurrentPSTransaction)
      {
        WriteObject("Hello " + name + "  from within a transaction.");
      }
    }
    ```

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

<!-- External URLs -->

[about_Transactions]: /powershell/module/Microsoft.PowerShell.Core/About/about_Transactions

---
title: about_Transactions
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e6902e15-3a8c-4fd2-818a-d662de083deb
---
# about_Transactions
## TOPIC  
 about\_Transactions  
  
## SHORT DESCRIPTION  
 Describes how to manage transacted operations in [!INCLUDE[wps_1]()].  
  
## LONG DESCRIPTION  
 Transactions are supported in [!INCLUDE[wps_2]()] beginning in [!INCLUDE[wps_2]()] 2.0. This feature enables you to start a transaction, to indicate which commands are part of the transaction, and to commit or roll back a transaction.  
  
## ABOUT TRANSACTIONS  
 In [!INCLUDE[wps_2]()], a transaction is a set of one or more commands that are managed as a logical unit. A transaction can be completed \("committed"\), which changes data affected by the transaction. Or, a transaction can be completely undone \("rolled back"\) so that the affected data is not changed by the transaction.  
  
 Because the commands in a transaction are managed as a unit, either all commands are committed, or all commands are rolled back.  
  
 Transactions are widely used in data processing, most notably in database operations and for financial transactions. Transactions are most often used when the worst\-case scenario for a set of commands is not that they all fail, but that some commands succeed while others fail, leaving the system in a damaged, false, or uninterpretable state that is difficult to repair.  
  
## TRANSACTION CMDLETS  
 [!INCLUDE[wps_2]()] includes several cmdlets designed for managing transactions.  
  
```  
Cmdlet                 Description  
--------------         ---------------------------------      
Start-Transaction      Starts a new transaction.   
  
Use-Transaction        Adds a command or expression to the  
                       transaction. The command must use  
                       transaction-enabled objects.  
  
Undo-Transaction       Rolls back the transaction so that  
                       no data is changed by the transaction.  
  
Complete-Transaction   Commits the transaction. The data  
                       affected by the transaction is changed.  
  
Get-Transaction        Gets information about the active  
                       transaction.  
```  
  
 For a list of transaction cmdlets, type:  
  
```  
get-command *transaction  
```  
  
 For detailed information about the cmdlets, type:  
  
```  
get-help <cmdlet-name> -detailed  
```  
  
 For example:  
  
```  
get-help use-transaction -detailed  
```  
  
## TRANSACTION\-ENABLED ELEMENTS  
 To participate in a transaction, both the cmdlet and the provider must support transactions. This feature is built in to the objects that are affected by the transaction.  
  
 The [!INCLUDE[wps_2]()] Registry provider supports transactions in Windows Vista. The TransactedString object \(Microsoft.PowerShell.Commands.Management.TransactedString\) works with any operating system that runs [!INCLUDE[wps_2]()].  
  
 Other [!INCLUDE[wps_2]()] providers can support transactions. To find the [!INCLUDE[wps_2]()] providers in your session that support transactions, use the following command to find the "Transactions" value in the Capabilities property of providers:  
  
```  
get-psprovider | where {$_.Capabilities -like "*transactions*"}  
```  
  
 For more information about a provider, see the Help for the provider. To get provider Help, type:  
  
```  
get-help <provider-name>  
```  
  
 For example, to get Help for the Registry provider, type:  
  
```  
get-help registry  
```  
  
## THE USETRANSACTION PARAMETER  
 Cmdlets that can support transactions have a UseTransaction parameter. This parameter includes the command in the active transaction. You can use the full parameter name or its alias, "usetx".  
  
 The parameter can be used only when the session contains an active transaction. If you enter a command with the UseTransaction parameter when there is no active transaction, the command fails.  
  
 To find cmdlets with the UseTransaction parameter, type:  
  
```  
get-help * -parameter UseTransaction  
```  
  
 In [!INCLUDE[wps_2]()] core, all of the cmdlets designed to work with [!INCLUDE[wps_2]()] providers support transactions. As a result, you can use the provider cmdlets to manage transactions.  
  
 For more information about [!INCLUDE[wps_2]()] providers, see about\_Providers.  
  
## THE TRANSACTION OBJECT  
 Transactions are represented in [!INCLUDE[wps_2]()] by a transaction object, System.Management.Automation.Transaction.  
  
 The object has the following properties:  
  
 RollbackPreference:  
  
 Contains the rollback preference set for the current transaction. You can set the rollback preference when you use Start\-Transaction to start the transaction.  
  
 The rollback preference determines the conditions under which the transaction is rolled back automatically. Valid values are Error, TerminatingError, and Never. The default value is Error.  
  
 Status:  
  
 Contains the current status of the transaction. Valid values are Active, Committed, and RolledBack.  
  
 SubscriberCount:  
  
 Contains the number of subscribers to the transaction. A subscriber is added to a transaction when you start a transaction while another transaction is in progress. The subscriber count is decremented when a subscriber commits the transaction.  
  
## ACTIVE TRANSACTIONS  
 In [!INCLUDE[wps_2]()], only one transaction is active at a time, and you can manage only the active transaction. Multiple transactions can be in progress in the same session at the same time, but only the most\-recently started transaction is active.  
  
 As a result, you cannot specify a particular transaction when using the transaction cmdlets. Commands always apply to the active transaction.  
  
 This is most evident in the behavior of the Get\-Transaction cmdlet. When you enter a Get\-Transaction command, Get\-Transaction always gets only one transaction object. This object is the object that represents the active transaction.  
  
 To manage a different transaction, you must first finish the active transaction, either by committing it or rolling it back. When you do this, the previous transaction becomes active automatically. Transactions become active in the reverse of order of which they are started, so that the most recently started transaction is always active.  
  
## SUBSCRIBERS AND INDEPENDENT TRANSACTIONS  
 If you start a transaction while another transaction is in progress, by default, [!INCLUDE[wps_2]()] does not start a new transaction. Instead, it adds a "subscriber" to the current transaction.  
  
 When a transaction has multiple subscribers, a single Undo\-Transaction command at any point rolls back the entire transaction for all subscribers. However, to commit the transaction, you must enter a Complete\-Transaction command for every subscriber.  
  
 To find the number of subscribers to a transaction, check the SubscriberCount property of the transaction object. For example, the following command uses the Get\-Transaction cmdlet to get the value of the SubscriberCount property of the active transaction:  
  
```  
(Get-Transaction).SubscriberCount  
```  
  
 Adding a subscriber is the default behavior because most transactions that are started while another transaction is in progress are related to the original transaction. In the typical model, a script that contains a transaction calls a helper script that contains its own transaction. Because the transactions are related, they should be rolled back or committed as a unit.Insert section body here.  
  
 However, you can start a transaction that is independent of the current transaction by using the Independent parameter of the Start\-Transaction cmdlet.  
  
 When you start an independent transaction, Start\-Transaction creates a new transaction object, and the new transaction becomes the active transaction. The independent transaction can be committed or rolled back without affecting the original transaction.  
  
 When the independent transaction is finished \(committed or rolled back\), the original transaction becomes the active transaction again.  
  
## CHANGING DATA  
 When you use transactions to change data, the data that is affected by the transaction is not changed until you commit the transaction. However, the same data can be changed by commands that are not part of the transaction.  
  
 Keep this in mind when you are using transactions to manage shared data. Typically, databases have mechanisms that lock the data while you are working on it, preventing other users, and other commands, scripts, and functions, from changing it.  
  
 However, the lock is a feature of the database. It is not related to transactions. If you are working in a transaction\-enabled file system or other data store, the data can be changed while the transaction is in progress.  
  
## EXAMPLES  
 The examples in this section use the [!INCLUDE[wps_2]()] Registry provider and assume that you are familiar with it. For information about the Registry provider, type "get\-help registry".  
  
### EXAMPLE 1: COMMITTING A TRANSACTION  
 To create a transaction, use the Start\-Transaction cmdlet. The following command starts a transaction with the default settings.  
  
```  
start-transaction  
```  
  
 To include commands in the transaction, use the UseTransaction parameter of the cmdlet. By default, commands are not included in the transaction,  
  
 For example, the following command, which sets the current location in the Software key of the HKCU: drive, is not included in the transaction.  
  
```  
cd hkcu:\Software  
```  
  
 The following command, which creates the MyCompany key, uses the UseTransaction parameter of the New\-Item cmdlet to include the command in the active transaction.  
  
```  
new-item MyCompany -UseTransaction  
```  
  
 The command returns an object that represents the new key, but because the command is part of the transaction, the registry is not yet changed.  
  
```  
Hive: HKEY_CURRENT_USER\Software  
  
SKC  VC Name                           Property  
---  -- ----                           --------  
  0   0 MyCompany                      {}  
```  
  
 To commit the transaction, use the Complete\-Transaction cmdlet. Because it always affects the active transaction, you cannot specify the transaction.  
  
```  
complete-transaction  
```  
  
 As a result, the MyCompany key is added to the registry.  
  
```  
dir m*  
  
Hive: HKEY_CURRENT_USER\software  
  
SKC  VC Name                           Property  
---  -- ----                           --------  
 83   1 Microsoft                      {(default)}  
  0   0 MyCompany                      {}  
```  
  
### EXAMPLE 2: ROLLING BACK A TRANSACTION  
 To create a transaction, use the Start\-Transaction cmdlet. The following command starts a transaction with the default settings.  
  
```  
start-transaction  
```  
  
 The following command, which creates the MyOtherCompany key, uses the UseTransaction parameter of the New\-Item cmdlet to include the command in the active transaction.  
  
```  
new-item MyOtherCompany -UseTransaction  
```  
  
 The command returns an object that represents the new key, but because the command is part of the transaction, the registry is not yet changed.  
  
```  
Hive: HKEY_CURRENT_USER\Software  
  
SKC  VC Name                           Property  
---  -- ----                           --------  
  0   0 MyOtherCompany                 {}  
```  
  
 To roll back the transaction, use the Undo\-Transaction cmdlet. Because it always affects the active transaction, you do not specify the transaction.  
  
```  
Undo-transaction  
```  
  
 The result is that the MyOtherCompany key is not added to the registry.  
  
```  
dir m*  
  
Hive: HKEY_CURRENT_USER\software  
  
SKC  VC Name                           Property  
---  -- ----                           --------  
 83   1 Microsoft                      {(default)}  
  0   0 MyCompany                      {}  
```  
  
### EXAMPLE 3: PREVIEWING A TRANSACTION  
 Typically, the commands used in a transaction change data. However, the commands that get data are useful in a transaction, too, because they get data inside of the transaction. This provides a preview of the changes that committing the transaction would cause.  
  
 The following example shows how to use the Get\-ChildItem command \(the alias is "dir"\) to preview the changes in a transaction.  
  
 The following command starts a transaction.  
  
```  
start-transaction  
```  
  
 The following command uses the New\-ItemProperty cmdlet to add the MyKey registry entry to the MyCompany key. The command uses the UseTransaction parameter to include the command in the transaction.  
  
```  
new-itemproperty -path MyCompany -Name MyKey -value 123 -UseTransaction  
```  
  
 The command returns an object representing the new registry entry, but the registry entry is not changed.  
  
```  
MyKey  
-----  
123  
```  
  
 To get the items that are currently in the registry, use a Get\-ChildItem command \("dir"\) without the UseTransaction parameter. The following command gets items that begin with "M."  
  
```  
dir m*  
```  
  
 The result shows that no entries have yet been added to the MyCompany key.  
  
```  
Hive: HKEY_CURRENT_USER\Software  
  
SKC  VC Name                           Property  
---  -- ----                           --------  
83   1 Microsoft                      {(default)}  
 0   0 MyCompany                      {}  
```  
  
 To preview the effect of committing the transaction, enter a Get\-ChildItem \("dir"\) command with the UseTransaction parameter. This command has a view of the data from within the transaction.Insert section body here.  
  
```  
dir m* -useTransaction  
```  
  
 The result shows that, if the transaction is committed, the MyKey entry will be added to the MyCompany key.  
  
```  
Hive: HKEY_CURRENT_USER\Software  
  
SKC  VC Name                           Property  
---  -- ----                           --------  
83   1 Microsoft                      {(default)}  
 0   1 MyCompany                      {MyKey}  
```  
  
### EXAMPLE 4: COMBINING TRANSACTED AND NON\-TRANSACTED COMMANDS  
 You can enter non\-transacted commands during a transaction. The non\-transacted commands affect the data immediately, but they do not affect the transaction.  
  
 The following command starts a transaction in the HKCU:\\Software registry key.  
  
```  
start-transaction  
```  
  
 The next three commands use the New\-Item cmdlet to add keys to the registry. The first and third commands use the UseTransaction parameter to include the commands in the transaction. The second command omits the parameter. Because the second command is not included in the transaction, it is effective immediately.  
  
```  
new-item MyCompany1 -UseTransaction  
  
new-item MyCompany2  
  
new-item MyCompany3 -UseTransaction  
```  
  
 To view the current state of the registry, use a Get\-ChildItem \("dir"\) command without the UseTransaction parameter. This command gets items that begin with "M."  
  
```  
dir m*  
```  
  
 The result shows that the MyCompany2 key is added to the registry, but the MyCompany1 and MyCompany3 keys, which are part of the transaction, are not added.  
  
```  
Hive: HKEY_CURRENT_USER\Software  
  
SKC  VC Name                           Property  
---  -- ----                           --------  
83   1 Microsoft                      {(default)}  
0    0 MyCompany2                     {}  
```  
  
 The following command commits the transaction.  
  
```  
complete-transaction  
```  
  
 Now, the keys that were added as part of the transaction appear in the registry.  
  
```  
dir m*  
  
Hive: HKEY_CURRENT_USER\Software  
  
SKC  VC Name                           Property  
---  -- ----                           --------  
83   1 Microsoft                      {(default)}  
0    0 MyCompany1                     {}  
0    0 MyCompany2                     {}  
0    0 MyCompany3                     {}  
```  
  
### EXAMPLE 5: USING AUTOMATIC ROLLBACK  
 When a command in a transaction generates an error of any kind, the transaction is automatically rolled back.  
  
 This default behavior is designed for scripts that run transactions. Scripts are typically well tested and include error\-handling logic, so errors are not expected and should terminate the transaction.  
  
 The first command starts a transaction in the HKCU:\\Software registry key.  
  
```  
start-transaction  
```  
  
 The following command uses the New\-Item cmdlet to add the MyCompany key to the registry. The command uses the UseTransaction parameter \(the alias is "usetx"\) to include the command in the transaction.  
  
```  
New-Item MyCompany -UseTX  
```  
  
 Because the MyCompany key already exists in the registry, the command fails, and the transaction is rolled back.  
  
```  
New-Item : A key at this path already exists  
At line:1 char:9  
+ new-item <<<<  MyCompany -usetx  
```  
  
 A Get\-Transaction command confirms that the transaction has been rolled back and that the SubscriberCount is 0.  
  
```  
RollbackPreference   SubscriberCount   Status  
------------------   ---------------   ------  
Error                0                 RolledBack  
```  
  
### EXAMPLE 6: CHANGING THE ROLLBACK PREFERENCE  
 If you want the transaction to be more error tolerant, you can use the RollbackPreference parameter of Start\-Transaction to change the preference.  
  
 The following command starts a transaction with a rollback preference of "Never".Insert section body here.  
  
```  
start-transaction -rollbackpreference Never  
```  
  
 In this case, when the command fails, the transaction is not automatically rolled back.  
  
```  
New-Item MyCompany -UseTX  
  
New-Item : A key at this path already exists  
At line:1 char:9  
+ new-item <<<<  MyCompany -usetx  
```  
  
 Because the transaction is still active, you can resubmit the command as part of the transaction.  
  
```  
New-Item MyOtherCompany -UseTX  
```  
  
### EXAMPLE 7: USING THE USE\-TRANSACTION CMDLET  
 The Use\-Transaction cmdlet enables you to do direct scripting against transaction\-enabled Microsoft .NET Framework  objects. Use\-Transaction takes a script block that can only contain commands and expressions that use transaction\-enabled .NET Framework objects, such as instances of the Microsoft.PowerShell.Commands.Management.TransactedString class.  
  
 The following command starts a transaction.  
  
```  
start-transaction  
```  
  
 The following New\-Object command creates an instance of the TransactedString class and saves it in the $t variable.  
  
```  
$t = New-Object Microsoft.PowerShell.Commands.Management.TransactedString  
```  
  
 The following command uses the Append method of the TransactedString object to add text to the string. Because the command is not part of the transaction, the change is effective immediately.  
  
```  
$t.append("Windows")  
```  
  
 The following command uses the same Append method to add text, but it adds the text as part of the transaction. The command is enclosed in braces, and it is set as the value of the ScriptBlock parameter of Use\-Transaction. The UseTransaction parameter \(UseTx\) is required.  
  
```  
use-transaction {$t.append(" PowerShell")} -usetx  
```  
  
 To see the current content of the transacted string in $t, use the ToString method of the TransactedString object.  
  
```  
$t.tostring()  
```  
  
 The output shows that only the non\-transacted changes are effective.  
  
```  
Windows  
```  
  
 To see the current content of the transacted string in $t from within the transaction, embed the expression in a Use\-Transaction command.  
  
```  
use-transaction {$s.tostring()} -usetx  
```  
  
 The output shows the transaction view.  
  
```  
Windows PowerShell  
```  
  
 The following command commits the transaction.  
  
```  
complete-transaction  
```  
  
 To see the final string:  
  
```  
$t.tostring()  
  
Windows PowerShell  
```  
  
### EXAMPLE 7: MANAGING MULTI\-SUBSCRIBER TRANSACTIONS  
 When you start a transaction while another transaction is in progress, [!INCLUDE[wps_2]()] does not create a second transaction by default. Instead, it adds a subscriber to the current transaction.  
  
 This example shows how to view and manage a multi\-subscriber transaction.  
  
 Begin by starting a transaction in the HKCU:\\Software key.  
  
```  
start-transaction  
```  
  
 The following command uses the Get\-Transaction command to get the active transaction.  
  
```  
get-transaction  
```  
  
 The result shows the object that represents the active transaction.  
  
```  
RollbackPreference   SubscriberCount   Status  
------------------   ---------------   ------  
Error                1                 Active  
```  
  
 The following command adds the MyCompany key to the registry. The command  uses the UseTransaction parameter to include the command in the transaction.  
  
```  
new-item MyCompany -UseTransaction  
```  
  
 The following command uses the Start\-Transaction command to start a transaction. Although this command is typed at the command prompt, this scenario is more likely to happen when you run a script that contains a transaction.  
  
```  
start-transaction  
```  
  
 A Get\-Transaction command shows that the subscriber count on the transaction object is incremented. The value is now 2.  
  
```  
RollbackPreference   SubscriberCount   Status  
------------------   ---------------   ------  
Error                2                 Active  
```  
  
 The next command uses the New\-ItemProperty cmdlet to add the MyKey registry entry to the MyCompany key. It uses the UseTransaction parameter to include the command in the transaction.  
  
```  
new-itemproperty -path MyCompany -name MyKey -UseTransaction  
```  
  
 The MyCompany key does not exist in the registry, but this command succeeds because the two commands are part of the same transaction.  
  
 The following command commits the transaction. If it rolled back the transaction, the transaction would be rolled back for all the subscribers.  
  
```  
complete-transaction  
```  
  
 A Get\-Transaction command shows that the subscriber count on the transaction object is 1, but the value of Status is still Active \(not Committed\).  
  
```  
RollbackPreference   SubscriberCount   Status  
------------------   ---------------   ------  
Error                1                 Active  
```  
  
 To finish committing the transaction, enter a second Complete\- Transaction command. To commit a multi\-subscriber transaction, you must enter one Complete\-Transaction command for each Start\-Transaction command.  
  
```  
complete-transaction  
```  
  
 Another Get\-Transaction command shows that the transaction has been committed.  
  
```  
RollbackPreference   SubscriberCount   Status  
------------------   ---------------   ------  
Error                0                 Committed  
```  
  
### EXAMPLE 8: MANAGING INDEPENDENT TRANSACTIONS  
 When you start a transaction while another transaction is in progress, you can use the Independent parameter of Start\-Transaction to make the new transaction independent of the original transaction.  
  
 When you do, Start\-Transaction creates a new transaction object and makes the new transaction the active transaction.  
  
 Begin by starting a transaction in the HKCU:\\Software key.  
  
```  
start-transaction  
```  
  
 The following command uses the Get\-Transaction command to get the active transaction.  
  
```  
get-transaction  
```  
  
 The result shows the object that represents the active transaction.  
  
```  
RollbackPreference   SubscriberCount   Status  
------------------   ---------------   ------  
Error                1                 Active  
```  
  
 The following command adds the MyCompany registry key as part of the transaction. It uses the UseTransaction parameter \(UseTx\) to include the command in the active transaction.  
  
```  
new-item MyCompany -use  
```  
  
 The following command starts a new transaction. The command uses the Independent parameter to indicate that this transaction is not a subscriber to the active transaction.  
  
```  
start-transaction -independent  
```  
  
 When you create an independent transaction, the new \(most\-recently created\) transaction becomes the active transaction. You can use a Get\-Transaction command to get the active transaction.  
  
```  
get-transaction  
```  
  
 Note that the SubscriberCount of the transaction is 1, indicating that there are no other subscribers and that the transaction is new.  
  
```  
RollbackPreference   SubscriberCount   Status  
------------------   ---------------   ------  
Error                1                 Active  
```  
  
 The new transaction must be finished \(either committed or rolled back\) before you can manage the original transaction.  
  
 The following command adds the MyOtherCompany key to the registry. It uses the UseTransaction parameter \(UseTx\) to include the command in the active transaction.  
  
```  
new-item MyOtherCompany -usetx  
```  
  
 Now, roll back the transaction. If there were a single transaction with two subscribers, rolling back the transaction would roll back the entire transaction for all the subscribers.  
  
 However, because these transactions are independent, rolling back the newest transaction cancels the registry changes and makes the original transaction the active transaction.  
  
```  
undo-transaction  
```  
  
 A Get\-Transaction command confirms that the original transaction is still active in the session.  
  
```  
get-transaction  
```  
  
```  
RollbackPreference   SubscriberCount   Status  
------------------   ---------------   ------  
Error                1                 Active  
```  
  
 The following command commits the active transaction.  
  
```  
complete-transaction  
```  
  
 A Get\-ChildItem command shows that the registry has been changed.  
  
```  
dir m*  
  
Hive: HKEY_CURRENT_USER\Software  
  
SKC  VC Name                           Property  
---  -- ----                           --------  
83   1 Microsoft                      {(default)}  
 0   0 MyCompany                      {}  
```  
  
## SEE ALSO  
 Start\-Transaction  
  
 Get\-Transaction  
  
 Complete\-Transaction  
  
 Undo\-Transaction  
  
 Use\-Transaction  
  
 Registry \(provider\)  
  
 about\_Providers  
  
 Get\-PSProvider  
  
 Get\-ChildItem
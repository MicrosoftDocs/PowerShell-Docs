---
title: about_PSSessions
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fe2f8185-26c1-44b4-88c1-fa2aa02f013c
---
# about_PSSessions
## TOPIC  
 about\_PSSessions  
  
## SHORT DESCRIPTION  
 Describes [!INCLUDE[wps_1]()] sessions \(PSSessions\) and explains how to establish a persistent connection to a remote computer.  
  
## LONG DESCRIPTION  
 To run [!INCLUDE[wps_2]()] commands on a remote computer, you can use the ComputerName parameter of a cmdlet, or you can create a [!INCLUDE[wps_2]()] session \(PSSession\) and run commands in the PSSession.  
  
 When you create a PSSession, [!INCLUDE[wps_2]()] establishes a persistent connection to the remote computer. Use a PSSession to run a series of related commands on a remote computer. Commands that run in the same PSSession can share data, such as the values of variables, aliases, and functions.  
  
 You can also create a PSSession on the local computer and run commands in it. A local PSSession uses the [!INCLUDE[wps_2]()] remoting infrastructure to create and maintain the PSSession.  
  
 Beginning in [!INCLUDE[wps_2]()] 3.0, PSSessions are independent of the sessions in which they are created. Active PSSessions are maintained on the remote computer \(or the computer at the remote end or "server\-side" of the connection\). As a result, you can disconnect from the PSSession and reconnect to it at a later time from the same computer or from a different computer.  
  
 This topic explains how to create, use, get, and delete PSSessions. For more advanced information, see about\_PSSession\_Details.  
  
> [!NOTE]  
>  PSSessions use the [!INCLUDE[wps_2]()] remoting infrastructure. To use PSSessions, the local and remote computers must be configured for remoting. For more information, see about\_Remote\_Requirements.  
>   
>  In Windows Vista and later versions of Windows, to create a PSSession on a local computer, you must start [!INCLUDE[wps_2]()] with the "Run as administrator" option.  
  
## WHAT IS A SESSION?  
 A session is an environment in which [!INCLUDE[wps_2]()] runs.  
  
 Each time you start [!INCLUDE[wps_2]()], a session is created for you, and you can run commands in the session. You can also add items to your session, such as modules and snap\-ins, and you can create items, such as variables, functions, and aliases. These items exist only in the session and are deleted when the session ends.  
  
 You can also create user\-managed sessions, known as "[!INCLUDE[wps_2]()] sessions" or "PSSessions," on the local computer or on a remote computer. Like the default session, you can run commands in a PSSession and add and create items.  
  
 However, unlike the session that starts automatically, you can control the PSSessions that you create. You can get, create, configure, and remove them, disconnect and reconnect to them, and run multiple commands in the same PSSession. The PSSession remains available until you delete it or it times out.  
  
 Typically, you create a PSSession to run a series of related commands on a remote computer. When you create a PSSession on a remote computer, [!INCLUDE[wps_2]()] establishes a persistent connection to the remote computer to support the session.  
  
 If you use the ComputerName parameter of the Invoke\-Command or Enter\-PSSession cmdlet to run a remote command or to start an interactive session, [!INCLUDE[wps_2]()] creates a temporary session on the remote computer and closes the session as soon as the command is complete or as soon as the interactive session ends. You cannot control these temporary sessions, and you cannot use them for more than a single command or a single interactive session.  
  
 In [!INCLUDE[wps_2]()], the "current session" is the session that you are working in. The "current session" can refer to any session, including a temporary session or a PSSession.  
  
## WHY USE A PSSESSION?  
 Use a PSSession when you need a persistent connection to a remote computer. With a PSSession, you can run a series of commands that share data, such as the value of variables, the contents of a function, or the definition of an alias.  
  
 You can run remote commands without creating a PSSession. Use the ComputerName parameter of remote\-enabled cmdlets to run a single command or a series of unrelated commands on one or many computers.  
  
 When you use the ComputerName parameter of Invoke\-Command or Enter\-PSSession, [!INCLUDE[wps_2]()] establishes a temporary connection to the remote computer and then closes the connection as soon as the command is complete. Any data elements that you create are lost when the connection is closed.  
  
 Other cmdlets that have a ComputerName parameter, such as Get\-Eventlog and Get\-WmiObject, use different remoting technologies to gather data. None create a persistent connection like a PSSession.  
  
## HOW TO CREATE A PSSESSION  
 To create a PSSession, use the New\-PSSession cmdlet. To create the PSSession on a remote computer, use the ComputerName parameter of the New\-PSSession cmdlet.  
  
 For example, the following command creates a new PSSession on the Server01 computer.  
  
```  
New-PSSession -ComputerName Server01  
```  
  
 When you submit the command, New\-PSSession creates the PSSession and returns an object that represents the PSSession. You can save the object in a variable when you create the PSSession, or you can use a Get\-PSSession command to get the PSSession at a later time.  
  
 For example, the following command creates a new PSSession on the Server01 computer and saves the resulting object in the `$ps` variable.  
  
```  
$ps = New-PSSession -ComputerName Server01  
```  
  
## HOW TO CREATE PSSESSIONS ON MULTIPLE COMPUTERS  
 To create PSSessions on multiple computers, use the ComputerName parameter of the New\-PSSession cmdlet. Type the names of the remote computers in a comma\-separated list.  
  
 For example, to create PSSessions on the Server01, Server02, and Server03 computers, type:  
  
```  
New-PSSession -ComputerName Server01, Server02, Server03  
```  
  
 New\-PSSession creates one PSSession on each of the remote computers.  
  
## HOW TO GET PSSESSIONS  
 To get the PSSessions that were created in your current session, use the Get\-PSSession cmdlet without the ComputerName parameter. Get\-PSSession returns the same type of object that New\-PSSession returns.Insert section body here.  
  
 The following command gets all the PSSessions that were created in the current session.  
  
```  
Get-PSSession  
```  
  
 The default display of the PSSessions shows their ID and a default display name. You can assign an alternate display name when you create the session.  
  
```  
Id   Name       ComputerName    State    ConfigurationName  
---  ----       ------------    -----    ---------------------  
1    Session1   Server01        Opened   Microsoft.PowerShell  
2    Session2   Server02        Opened   Microsoft.PowerShell  
3    Session3   Server03        Opened   Microsoft.PowerShell  
```  
  
 You can also save the PSSessions in a variable. The following command gets the PSSessions and saves them in the $ps123 variable.  
  
```  
$ps123 = Get-PSSession  
```  
  
 When using the PSSession cmdlets, you can refer to a PSSession by its ID, by its name, or by its instance ID \(a GUID\). The following command gets a PSSession by its ID and saves it in the $ps01 variable.  
  
```  
$ps01 = Get-PSSession -Id 1  
```  
  
 Beginning in [!INCLUDE[wps_2]()] 3.0, PSSessions are maintained on the remote computer. To get PSSessions that you created on particular remote computers, use the ComputerName parameter of the Get\-PSSession cmdlet. The following command gets the PSSessions that you created on the Server01 remote computer. This includes PSSessions created in the current session and in other sessions on the local computer or other computers.  
  
```  
Get-PSSession -ComputerName Server01  
```  
  
 In [!INCLUDE[wps_2]()] 2.0, Get\-PSSession gets only the PSSessions that were created in the current session. It does not get PSSessions that were created in other sessions or on other computers, even if the sessions are connected to and are running commands on the local computer.  
  
## HOW TO RUN COMMANDS IN A PSSESSION  
 To run a command in one or more PSSessions, use the Invoke\-Command cmdlet. Use the Session parameter to specify the PSSessions and the ScriptBlock parameter to specify the command.  
  
 For example, to run a Get\-ChildItem \("dir"\) command in each of the three PSSessions saved in the $ps123 variable, type:  
  
```  
Invoke-Command -Session $ps123 -ScriptBlock {Get-ChildItem}  
```  
  
## HOW TO DELETE PSSESSIONS  
 When you are finished with the PSSession, use the Remove\-PSSession cmdlet to delete the PSSession and to release the resources that it was using.  
  
```  
Remove-PSSession -Session $ps  
```  
  
 \- or \-  
  
```  
Remove-PSSession -Id 1  
```  
  
 To remove a PSSession from a remote computer, use the ComputerName parameter of the Remove\-PSSession cmdlet.  
  
```  
Remove-PSSession -ComputerName Server01 -Id 1  
```  
  
 If you do not delete the PSSession, the PSSession remains available for use until it times out.  
  
 You can also use the IdleTimeout parameter of the New\-PSSessionOption cmdlet to set an expiration time for an idle PSSession. For more information, see New\-PSSessionOption.  
  
## THE PSSESSION CMDLETS  
  
```  
Cmdlet                Description  
-----------------     ------------------------------------------------------  
New-PSSession         Creates a new PSSession on a local or remote computer.  
  
Get-PSSession         Gets the PSSessions in the current session.  
  
Remove-PSSession      Deletes the PSSessions in the current session.  
  
Enter-PSSession       Starts an interactive session.  
  
Exit-PSSession        Ends an interactive session.  
  
Disconnect-PSSession  Disconnects a PSSession from the current session.  
  
Connect-PSSession     Connects a PSSession to the current session.  
  
Receive-PSSession     Gets the results of commands that ran in a disconnected  
                      session.  
```  
  
 For a list of PSSession cmdlets, type:  
  
```  
get-help *-PSSession  
```  
  
## FOR MORE INFORMATION  
 For more information about PSSessions, see about\_PSSession\_Details.  
  
## SEE ALSO  
 about\_Remote  
  
 about\_Remote\_Disconnected\_Sessions  
  
 about\_Remote\_Requirements  
  
 Connect\-PSSession  
  
 Disconnect\-PSSession  
  
 Enter\-PSSession  
  
 Exit\-PSSession  
  
 Get\-PSSession  
  
 Invoke\-Command  
  
 New\-PSSession  
  
 Remove\-PSSession
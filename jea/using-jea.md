---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet,jea
ms.date:  2016-06-22
title:  using jea
ms.technology:  powershell
---

# Using JEA
This section focuses on understanding the end user experience of *using JEA*.
In the prerequisites section, you created a demo JEA endpoint.
We will use this demo to show JEA in action.
In later sections, the guide will work backwards -- introducing the actions and files that made that end-user experience possible.

## Using JEA as a Non-Administrator
To show JEA in action, you will need to use PowerShell remoting as though you were a non-administrator user.
Run the following command in a new PowerShell window:   

```PowerShell
$NonAdminCred = Get-Credential
```

Enter the credentials for your non-administrator account when prompted.
If you followed the [Set Up Users and Groups](creating-a-domain-controller.md#set-up-users-and-groups) section, they will be:
-	Username = "OperatorUser"
-	Password = "pa$$w0rd"

Next, run the following command to connect to the demo endpoint using the credentials you provided:

```PowerShell
Enter-PSSession -ComputerName . -ConfigurationName JEA_Demo -Credential $NonAdminCred
```

You have now entered an interactive remote PowerShell session on the local machine.
By using the "Credential" parameter, you have connected *as though you were* OperatorUser (or whichever account you used).
The change in the prompt to `[localhost]: PS>` indicates that you are operating against a remote session.  

Run the following in your remote command prompt to show the commands available to you:

```PowerShell
Get-Command
```

As you can tell, this is a very limited subset of the commands available in a normal PowerShell window (which can often include several thousand commands).
Specifically, it only shows the 7 default JEA cmdlets (Clear-Host, Exit-PSSession, Get-Command, Get-FormatData, Get-Help, Measure-Object, Out-Default, Select-Object) and the two commands explicitly included in the maintenance Role Capability file.

Next, let's take a look at the user context this session is operating under by invoking the custom function included in the maintenance Role Capability file:

```PowerShell
Get-UserInfo
```

The output of this function shows the "ConnectedUser" as well as the "RunAsUser."
The connected user is the account that connected to the remote session (e.g. your account).
The connected user does not need to have administrator privileges.
The "Run As" account is the account actually performing the privileged actions.
By connecting as one user, and running as a privileged user, we allow non-privileged users to preform specific administrative tasks without giving them administrative rights.

To demonstrate this in action, run the following command:

```PowerShell
Restart-Service -Name Spooler -Verbose
```

Normally, Restart-Service requires administrator privileges to be run.
With the JEA virtual account, however, we're able to run it using non-privileged credentials.

So, JEA lets you get your job done using the commands you already use.
But what about commands you *shouldn't* be allowed to use?
Try running a different command in the JEA session, like `Restart-Computer`, and notice that JEA prevents such commands from being executed.

```PowerShell
[localhost]: PS> Restart-Computer
The term 'Restart-Computer' is not recognized as the name of a cmdlet, function, script file, or
operable program. Check the spelling of the name, or if a path was included, verify that the path
is correct and try again.
    + CategoryInfo          : ObjectNotFound: (Restart-Computer:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```

Finally, to leave the constrained JEA endpoint, run the following command:

```PowerShell
Exit-PSSession
```

This disconnects you from the remote PowerShell session.


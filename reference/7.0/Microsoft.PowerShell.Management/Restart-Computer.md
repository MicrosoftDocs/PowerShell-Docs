---
external help file: Microsoft.PowerShell.Commands.Management.dll-Help.xml
keywords: powershell,cmdlet
Locale: en-US
Module Name: Microsoft.PowerShell.Management
ms.date: 6/17/2019
online version: https://docs.microsoft.com/powershell/module/microsoft.powershell.management/restart-computer?view=powershell-7&WT.mc_id=ps-gethelp
schema: 2.0.0
title: Restart-Computer
---

# Restart-Computer

## SYNOPSIS
Restarts the operating system on local and remote computers.

## SYNTAX

### DefaultSet (Default)

```
Restart-Computer [-WsmanAuthentication <String>] [[-ComputerName] <String[]>]
 [[-Credential]<PSCredential>] [-Force] [-Wait] [-Timeout <Int32>] [-For <WaitForServiceTypes>]
 [-Delay <Int16>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The `Restart-Computer` cmdlet restarts the operating system on the local and remote computers.

You can use the parameters of `Restart-Computer` to run the restart operations, to specify the
authentication levels and alternate credentials, to limit the operations that run at the same time,
and to force an immediate restart.

Starting in Windows PowerShell 3.0, you can wait for the restart to complete before you run the next
command. Specify a waiting time-out and query interval, and wait for particular services to be
available on the restarted computer. This feature makes it practical to use `Restart-Computer` in
scripts and functions.

## EXAMPLES

### Example 1: Restart the local computer

`Restart-Computer` restarts the local computer.

```powershell
Restart-Computer
```

### Example 2: Restart multiple computers

`Restart-Computer` can restart remote and local computers. The **ComputerName** parameter accepts an
array of computer names.

```powershell
Restart-Computer -ComputerName Server01, Server02, localhost
```

### Example 3: Get computer names from a text file

`Restart-Computer` gets a list of computer names from a text file and restarts the computers. The
**ComputerName** parameter isn't specified. But because it's the first position parameter, it
accepts the computer names from the text file that are sent down the pipeline.

```powershell
Get-Content -Path C:\Domain01.txt | Restart-Computer
```

`Get-Content` uses the **Path** parameter to get a list of computer names from a text file,
**Domain01.txt**. The computer names are sent down the pipeline. `Restart-Computer` restarts each
computer.

### Example 4: Force restart of computers listed in a text file

This example forces an immediate restart of the computers listed in the `Domain01.txt` file. The
computer names from the text file are stored in a variable. The **Force** parameter forces an
immediate restart.

```powershell
$Names = Get-Content -Path C:\Domain01.txt
$Creds = Get-Credential
Restart-Computer -ComputerName $Names -Credential $Creds -Force
```

`Get-Content` uses the **Path** parameter to get a list of computer names from a text file,
**Domain01.txt**. The computer names are stored in the variable `$Names`. `Get-Credential` prompts
you for a username and password and stores the values in the variable `$Creds`. `Restart-Computer`
uses the **ComputerName** and **Credential** parameters with their variables. The **Force**
parameter causes an immediate restart of each computer.

### Example 6: Restart a remote computer and wait for PowerShell

`Restart-Computer` restarts the remote computer and then waits up to 5 minutes (300 seconds) for
PowerShell to become available on the restarted computer before it continues.

```powershell
Restart-Computer -ComputerName Server01 -Wait -For PowerShell -Timeout 300 -Delay 2
```

`Restart-Computer` uses the **ComputerName** parameter to specify **Server01**. The **Wait**
parameter waits for the restart to finish. The **For** specifies that PowerShell can run commands on
the remote computer. The **Timeout** parameter specifies a five-minute wait. The **Delay** parameter
queries the remote computer every two seconds to determine whether it's restarted.

### Example 7: Restart a computer by using WsmanAuthentication

`Restart-Computer` restarts the remote computer using the **WsmanAuthentication** mechanism.
Kerberos authentication determines whether the current user has permission to restart the remote
computer. For more information, see
[AuthenticationMechanism](/dotnet/api/system.management.automation.runspaces.authenticationmechanism).

```powershell
Restart-Computer -ComputerName Server01 -WsmanAuthentication Kerberos
```

`Restart-Computer` uses the **ComputerName** parameter to specify the remote computer, **Server01**.
The **WsmanAuthentication** parameter specifies the authentication method as **Kerberos**.

## PARAMETERS

### -ComputerName

Specifies one computer name or a comma-separated array of computer names. `Restart-Computer` accepts
**ComputerName** objects from the pipeline or variables.

Type the NetBIOS name, an IP address, or a fully qualified domain name of a remote computer. To
specify the local computer, type the computer name, a dot `.`, or localhost.

This parameter doesn't rely on PowerShell remoting. You can use the **ComputerName** parameter even
if your computer isn't configured to run remote commands.

If the **ComputerName** parameter isn't specified, `Restart-Computer` restarts the local computer.

```yaml
Type: System.String[]
Parameter Sets: (All)
Aliases: CN, __SERVER, Server, IPAddress

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Credential

Specifies a user account that has permission to do this action. The default is the current user.

Type a user name, such as **User01** or **Domain01\User01**, or enter a **PSCredential** object
generated by the `Get-Credential` cmdlet. If you type a user name, you're prompted to enter the
password.

Credentials are stored in a [PSCredential](/dotnet/api/system.management.automation.pscredential)
object and the password is stored as a [SecureString](/dotnet/api/system.security.securestring).

> [!NOTE]
> For more information about **SecureString** data protection, see
> [How secure is SecureString?](/dotnet/api/system.security.securestring#how-secure-is-securestring).

```yaml
Type: System.Management.Automation.PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Current user
Accept pipeline input: False
Accept wildcard characters: False
```

### -Delay

Specifies the frequency of queries, in seconds. PowerShell queries the service specified by the
**For** parameter to determine whether the service is available after the computer is restarted.

This parameter is valid only together with the **Wait** and **For** parameters.

This parameter was introduced in Windows PowerShell 3.0.

If the **Delay** parameter isn't specified, `Restart-Computer` uses a five second delay.

```yaml
Type: System.Int16
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -For

Specifies the behavior of PowerShell as it waits for the specified service or feature to become
available after the computer restarts. This parameter is only valid with the **Wait** parameter.

The acceptable values for this parameter are:

- **Default**: Waits for PowerShell to restart.
- **PowerShell**: Can run commands in a PowerShell remote session on the computer.
- **WMI**: Receives a reply to a Win32_ComputerSystem query for the computer.
- **WinRM**: Can establish a remote session to the computer by using WS-Management.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: Microsoft.PowerShell.Commands.WaitForServiceTypes
Parameter Sets: (All)
Aliases:
Accepted values: Wmi, WinRM, PowerShell

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Forces an immediate restart of the computer.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: f

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Timeout

Specifies the duration of the wait, in seconds. When the timeout elapses, `Restart-Computer` returns
to the command prompt, even if the computers aren't restarted.

The **Timeout** parameter is only valid with the **Wait** parameter. **Timeout** overrides the
**Wait** parameter's indefinite waiting period.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Int32
Parameter Sets: (All)
Aliases: TimeoutSec

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Wait

`Restart-Computer` suppresses the PowerShell prompt and blocks the pipeline until the computers have
restarted. You can use this parameter in a script to restart computers and then continue to process
when the restart is finished.

The **Wait** parameter waits indefinitely for the computers to restart. You can use **Timeout** to
adjust the timing and the **For** and **Delay** parameters to wait for particular services to become
available on the restarted computers.

The **Wait** parameter isn't valid when you're restarting the local computer. If the value of the
**ComputerName** parameter contains the names of remote computers and the local computer,
`Restart-Computer` generates a non-terminating error for **Wait** on the local computer, but waits
for the remote computers to restart.

This parameter was introduced in Windows PowerShell 3.0.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WsmanAuthentication

Specifies the mechanism that is used to authenticate the user credentials. This parameter was
introduced in Windows PowerShell 3.0.

The acceptable values for this parameter are: **Basic**, **CredSSP**, **Default**, **Digest**,
**Kerberos**, and **Negotiate**.

For more information, see
[AuthenticationMechanism](/dotnet/api/system.management.automation.runspaces.authenticationmechanism).

> [!WARNING]
> Credential Security Service Provider (CredSSP) authentication, in which the user credentials are
> passed to a remote computer to be authenticated, is designed for commands that require
> authentication on more than one resource, such as accessing a remote network share. This mechanism
> increases the security risk of the remote operation. If the remote computer is compromised, the
> credentials that are passed to it can be used to control the network session.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:
Accepted values: Basic, CredSSP, Default, Digest, Kerberos, Negotiate

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running `Restart-Computer`.

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

Shows what would happen if the `Restart-Computer` runs. The `Restart-Computer` cmdlet isn't run.

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

### System.String

`Restart-Computer` accepts computer names from the pipeline or variables.

## OUTPUTS

### None

`Restart-Computer` doesn't generate any output.

## NOTES

This cmdlet is only available on Windows platforms.

- `Restart-Computer` only works on computers running Windows and requires WinRM and WMI to shutdown
  a system, including the local system.
- `Restart-Computer` uses the [Win32Shutdown method](/windows/desktop/CIMWin32Prov/win32shutdown-method-in-class-win32-operatingsystem)
  of the Windows Management Instrumentation (WMI) [Win32_OperatingSystem](/windows/desktop/CIMWin32Prov/win32-operatingsystem)
  class. This method requires the **SeShutdownPrivilege** privilege be enabled for the user account
  used to restart the machine.

## RELATED LINKS

[About Windows Remote Management](/windows/desktop/WinRM/about-windows-remote-management)

[Get-Credential](../Microsoft.PowerShell.Security/Get-Credential.md)

[WS-Management Protocol](/windows/desktop/WinRM/ws-management-protocol)

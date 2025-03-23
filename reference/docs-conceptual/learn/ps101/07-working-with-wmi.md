---
description: PowerShell included cmdlets for working with WMI since the beginning.
ms.custom: Contributor-mikefrobbins
ms.date: 3/21/2025
ms.reviewer: mirobb
title: Working with WMI
---

# Chapter 7 - Working with WMI

## WMI and CIM

Windows PowerShell ships by default with cmdlets for working with other technologies, such as
Windows Management Instrumentation (WMI). The WMI cmdlets are deprecated and aren't available in
PowerShell 6+, but are covered here as you might encounter them in older scripts running on Windows
PowerShell. For new development, use the CIM cmdlets instead.

Several native WMI cmdlets exist in PowerShell without you having to install any other software or
modules. `Get-Command` can be used to determine what WMI cmdlets exist in Windows PowerShell. The
following results are from a Windows 11 system running PowerShell version 5.1. Your results might
differ depending on the PowerShell version you're running.

```powershell
Get-Command -Noun WMI*
```

```Output
CommandType     Name                                               Version
-----------     ----                                               -------
Cmdlet          Get-WmiObject                                      3.1.0.0
Cmdlet          Invoke-WmiMethod                                   3.1.0.0
Cmdlet          Register-WmiEvent                                  3.1.0.0
Cmdlet          Remove-WmiObject                                   3.1.0.0
Cmdlet          Set-WmiInstance                                    3.1.0.0
```

The Common Information Model (CIM) cmdlets were introduced in PowerShell 3.0 and are available only
on Windows systems.

The CIM cmdlets are all contained within a module. To obtain a list of the CIM cmdlets, use
`Get-Command` with the **Module** parameter, as shown in the following example.

```powershell
Get-Command -Module CimCmdlets
```

```Output
CommandType     Name                                               Version
-----------     ----                                               -------
Cmdlet          Export-BinaryMiLog                                 1.0.0.0
Cmdlet          Get-CimAssociatedInstance                          1.0.0.0
Cmdlet          Get-CimClass                                       1.0.0.0
Cmdlet          Get-CimInstance                                    1.0.0.0
Cmdlet          Get-CimSession                                     1.0.0.0
Cmdlet          Import-BinaryMiLog                                 1.0.0.0
Cmdlet          Invoke-CimMethod                                   1.0.0.0
Cmdlet          New-CimInstance                                    1.0.0.0
Cmdlet          New-CimSession                                     1.0.0.0
Cmdlet          New-CimSessionOption                               1.0.0.0
Cmdlet          Register-CimIndicationEvent                        1.0.0.0
Cmdlet          Remove-CimInstance                                 1.0.0.0
Cmdlet          Remove-CimSession                                  1.0.0.0
Cmdlet          Set-CimInstance                                    1.0.0.0
```

The CIM cmdlets still allow you to work with WMI, so don't be confused when someone states: _"When I
query WMI with the PowerShell CIM cmdlets"_.

As previously mentioned, WMI is a separate technology from PowerShell, and you're just using the CIM
cmdlets to access WMI. You might find an old VBScript that uses WMI Query Language (WQL) to query
WMI, such as in the following example.

```vb
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\CIMV2")

Set colBIOS = objWMIService.ExecQuery _
    ("Select * from Win32_BIOS")

For each objBIOS in colBIOS
    Wscript.Echo "Manufacturer: " & objBIOS.Manufacturer
    Wscript.Echo "Name: " & objBIOS.Name
    Wscript.Echo "Serial Number: " & objBIOS.SerialNumber
    Wscript.Echo "SMBIOS Version: " & objBIOS.SMBIOSBIOSVersion
    Wscript.Echo "Version: " & objBIOS.Version
Next
```

You can take the WQL query from the VBScript and use it with the `Get-CimInstance` cmdlet without
any modifications.

```powershell
Get-CimInstance -Query 'Select * from Win32_BIOS'
```

```Output
SMBIOSBIOSVersion : 090006
Manufacturer      : American Megatrends Inc.
Name              : Intel(R) Xeon(R) CPU E3-1505M v5 @ 2.80GHz
SerialNumber      : 3810-1995-1654-4615-2295-2755-89
Version           : VRTUAL - 4001628
```

The previous example isn't how I typically query WMI with PowerShell. But it works and allows you to
easily migrate existing Visual Basic scripts to PowerShell. When writing a one-liner to query WMI, I
use the following syntax.

```powershell
Get-CimInstance -ClassName Win32_BIOS
```

```Output
SMBIOSBIOSVersion : 090006
Manufacturer      : American Megatrends Inc.
Name              : Intel(R) Xeon(R) CPU E3-1505M v5 @ 2.80GHz
SerialNumber      : 3810-1995-1654-4615-2295-2755-89
Version           : VRTUAL - 4001628
```

If you only want the serial number, pipe the output to `Select-Object` and specify only the
**SerialNumber** property.

```powershell
Get-CimInstance -ClassName Win32_BIOS |
    Select-Object -Property SerialNumber
```

```Output
SerialNumber
------------
3810-1995-1654-4615-2295-2755-89
```

By default, when querying WMI, several properties that are never used are retrieved behind the
scenes. It doesn't matter much when querying WMI on the local computer. But once you start querying
remote computers, it's not only extra processing time to return that information but also more
unnecessary information to send across the network. `Get-CimInstance` has a **Property** parameter
that limits the information retrieved, making the WMI query more efficient.

```powershell
Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber |
    Select-Object -Property SerialNumber
```

```Output
SerialNumber
------------
3810-1995-1654-4615-2295-2755-89
```

The previous results returned an object. To return a string, use the **ExpandProperty** parameter.

```powershell
Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber |
    Select-Object -ExpandProperty SerialNumber
```

```Output
3810-1995-1654-4615-2295-2755-89
```

You could also use the dotted syntax style to return a string, eliminating the need to pipe to
`Select-Object`.

```powershell
(Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber).SerialNumber
```

```Output
3810-1995-1654-4615-2295-2755-89
```

## Query Remote Computers with the CIM cmdlets

You should still be running PowerShell as a local admin and domain user. When you try to query
information from a remote computer using the `Get-CimInstance` cmdlet, you receive an access denied
error message.

```powershell
Get-CimInstance -ComputerName dc01 -ClassName Win32_BIOS
```

```Output
Get-CimInstance : Access is denied.
At line:1 char:1
+ Get-CimInstance -ComputerName dc01 -ClassName Win32_BIOS
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : PermissionDenied: (root\cimv2:Win32_BIOS:Stri
   ng) [Get-CimInstance], CimException
    + FullyQualifiedErrorId : HRESULT 0x80070005,Microsoft.Management.Infra
   structure.CimCmdlets.GetCimInstanceCommand
    + PSComputerName        : dc01
```

Many people have security concerns regarding PowerShell, but you have the same permissions in
PowerShell as in the GUI. No more and no less. The problem in the previous example is that the user
running PowerShell doesn't have rights to query WMI information from the DC01 server. You could
relaunch PowerShell as a domain administrator since `Get-CimInstance` doesn't have a **Credential**
parameter. But that isn't a good idea because anything you run from PowerShell would run as a domain
admin. Depending on the situation, that scenario could be dangerous from a security standpoint.

Using the principle of least privilege, elevate to your domain admin account on a per-command basis
using the **Credential** parameter if a command has one. `Get-CimInstance` doesn't have a
**Credential** parameter, so the solution in this scenario is to create a **CimSession** first.
Then, use the **CimSession** instead of a computer name to query WMI on the remote computer.

```powershell
$CimSession = New-CimSession -ComputerName dc01 -Credential (Get-Credential)
```

```Output
cmdlet Get-Credential at command pipeline position 1
Supply values for the following parameters:
Credential
```

The CIM session was stored in a variable named `$CimSession`. Notice that you also specify the
`Get-Credential` cmdlet in parentheses so that it executes first, prompting for alternate
credentials, before creating the new session. I show you another more efficient way to specify
alternate credentials later in this chapter, but it's important to understand this basic concept
before making it more complicated.

You can now use the CIM session created in the previous example with the `Get-CimInstance` cmdlet to
query the BIOS information from WMI on the remote computer.

```powershell
Get-CimInstance -CimSession $CimSession -ClassName Win32_BIOS
```

```Output
SMBIOSBIOSVersion : 090006
Manufacturer      : American Megatrends Inc.
Name              : Intel(R) Xeon(R) CPU E3-1505M v5 @ 2.80GHz
SerialNumber      : 0986-6980-3916-0512-6608-8243-13
Version           : VRTUAL - 4001628
PSComputerName    : dc01
```

There are several other benefits to using CIM sessions instead of just specifying a computer name.
When you run multiple queries to the same computer, using a CIM session is more efficient than using
the computer name for each query. Creating a CIM session only sets up the connection once. Then,
multiple queries use that same session to retrieve information. Using the computer name requires the
cmdlets to set up and tear down the connection with each query.

The `Get-CimInstance` cmdlet uses the WSMan protocol by default, which means the remote computer
needs PowerShell version 3.0 or higher to connect. It's actually not the PowerShell version that
matters, it's the stack version. The stack version can be determined using the `Test-WSMan` cmdlet.
It needs to be version 3.0, which you find with PowerShell version 3.0 and higher.

```powershell
Test-WSMan -ComputerName dc01
```

```Output
wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentit
                  y.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 0.0.0 SP: 0.0 Stack: 3.0
```

The older WMI cmdlets use the DCOM protocol, which is compatible with older versions of Windows.
However, the firewall typically blocks DCOM on newer versions of Windows. The `New-CimSessionOption`
cmdlet allows you to create a DCOM protocol connection for use with `New-CimSession`. This option
allows the `Get-CimInstance` cmdlet to communicate with versions of Windows as old as Windows Server
2000. This ability also means that PowerShell isn't required on the remote computer when using the
      `Get-CimInstance` cmdlet with a CimSession configured to use the DCOM protocol.

Create the DCOM protocol option using the `New-CimSessionOption` cmdlet and store it in a variable.

```powershell
$DCOM = New-CimSessionOption -Protocol Dcom
```

For efficiency, you can store your domain administrator or elevated credentials in a variable so you
don't have to constantly enter them for each command.

```powershell
$Cred = Get-Credential
```

```Output
cmdlet Get-Credential at command pipeline position 1
Supply values for the following parameters:
Credential
```

I have a server named SQL03 that runs Windows Server 2008 (non-R2). It's the newest Windows Server
operating system that doesn't have PowerShell installed by default.

Create a **CimSession** to SQL03 using the DCOM protocol.

```powershell
$CimSession = New-CimSession -ComputerName sql03 -SessionOption $DCOM -Credential $Cred
```

Notice in the previous command that you specify the variable named `$Cred` as the value for the
**Credential** parameter instead of manually entering your credentials again.

The output of the query is the same regardless of the underlying protocol.

```powershell
Get-CimInstance -CimSession $CimSession -ClassName Win32_BIOS
```

```Output
SMBIOSBIOSVersion : 090006
Manufacturer      : American Megatrends Inc.
Name              : Intel(R) Xeon(R) CPU E3-1505M v5 @ 2.80GHz
SerialNumber      : 7237-7483-8873-8926-7271-5004-86
Version           : VRTUAL - 4001628
PSComputerName    : sql03
```

The `Get-CimSession` cmdlet is used to see what CimSessions are currently connected and what
protocols they use.

```powershell
Get-CimSession
```

```Output
Id           : 1
Name         : CimSession1
InstanceId   : 80742787-e38e-41b1-a7d7-fa1369cf1402
ComputerName : dc01
Protocol     : WSMAN

Id           : 2
Name         : CimSession2
InstanceId   : 8fcabd81-43cf-4682-bd53-ccce1e24aecb
ComputerName : sql03
Protocol     : DCOM
```

Retrieve and store the previously created CimSessions in a variable named `$CimSession`.

```powershell
$CimSession = Get-CimSession
```

Query both computers with one command, one using the WSMan protocol and the other with DCOM.

```powershell
Get-CimInstance -CimSession $CimSession -ClassName Win32_BIOS
```

```Output
SMBIOSBIOSVersion : 090006
Manufacturer      : American Megatrends Inc.
Name              : Intel(R) Xeon(R) CPU E3-1505M v5 @ 2.80GHz
SerialNumber      : 0986-6980-3916-0512-6608-8243-13
Version           : VRTUAL - 4001628
PSComputerName    : dc01

SMBIOSBIOSVersion : 090006
Manufacturer      : American Megatrends Inc.
Name              : Intel(R) Xeon(R) CPU E3-1505M v5 @ 2.80GHz
SerialNumber      : 7237-7483-8873-8926-7271-5004-86
Version           : VRTUAL - 4001628
PSComputerName    : sql03
```

One of my blog articles on WMI and CIM cmdlets features a PowerShell function that automatically
detects whether to use WSMan or DCOM and then sets up the appropriate CIM session for you. For more
information, see
[PowerShell Function to Create CimSessions to Remote Computers with Fallback to Dcom][cimsessions-with-fallback-to-dcom].

When you finish with the CIM sessions, remove them with the `Remove-CimSession` cmdlet. To remove
all CIM sessions, pipe `Get-CimSession` to `Remove-CimSession`.

```powershell
Get-CimSession | Remove-CimSession
```

## Summary

In this chapter, you learned about using PowerShell to work with WMI on local and remote computers.
You also learned how to use the CIM cmdlets to work with remote computers using the WSMan and DCOM
protocols.

## Review

1. What's the difference in the WMI and CIM cmdlets?
1. By default, what protocol does the `Get-CimInstance` cmdlet use?
1. What are some benefits of using a CIM session instead of specifying a computer name with
   `Get-CimInstance`?
1. How do you specify an alternate protocol other than the default one for use with
   `Get-CimInstance`?
1. How do you close or remove CIM sessions?

## References

- [about_WMI][about-wmi]
- [about_WMI_Cmdlets][about-wmi-cmdlets]
- [about_WQL][about-wql]
- [CimCmdlets Module][cimcmdlets-module]
- [Video: Using CIM Cmdlets and CIM Sessions][video-using-cim-cmdlets]

<!-- link references -->

[about-wmi]: /powershell/module/microsoft.powershell.core/about/about_wmi
[about-wmi-cmdlets]: /powershell/module/microsoft.powershell.core/about/about_wmi_cmdlets
[about-wql]: /powershell/module/microsoft.powershell.core/about/about_wql
[cimcmdlets-module]: /powershell/module/cimcmdlets/
[video-using-cim-cmdlets]: https://mikefrobbins.com/2013/09/12/phillyposh-user-group-meeting-presentation-follow-up-powershell-second-hop-problem-with-cimsessions/
[cimsessions-with-fallback-to-dcom]: https://mikefrobbins.com/2014/08/28/powershell-function-to-create-cimsessions-to-remote-computers-with-fallback-to-dcom/

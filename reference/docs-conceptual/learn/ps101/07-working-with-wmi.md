# Chapter 7 - Working with WMI

## WMI and CIM

PowerShell ships by default with cmdlets for working with other technologies such as WMI (Windows
Management Instrumentation). There are a number of native WMI cmdlets that exist in PowerShell
without having to install any additional software or modules.

PowerShell has had cmdlets for working with WMI since its inception. Get-Command can be used to
determine what WMI cmdlets exist in PowerShell. The following results are from my Windows 10 lab
environment computer which is running PowerShell version 5.1. Your results may differ depending on
what PowerShell version you're running.

```powershell
Get-Command -Noun WMI*
```

```powershell
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Get-WmiObject                                      3.1.0.0    Microsof...
Cmdlet          Invoke-WmiMethod                                   3.1.0.0    Microsof...
Cmdlet          Register-WmiEvent                                  3.1.0.0    Microsof...
Cmdlet          Remove-WmiObject                                   3.1.0.0    Microsof...
Cmdlet          Set-WmiInstance                                    3.1.0.0    Microsof...
```

CIM (Common Information Model) cmdlets were introduced in PowerShell version 3.0. The CIM cmdlets
are designed so they can be used on both Windows and non-Windows machines. Moving forward, the WMI
cmdlets will be deprecated so my recommendation is to use the CIM cmdlets instead of the older WMI
ones.

The CIM cmdlets are all contained within a module. To obtain a list of the CIM cmdlets, simply use
Get-Command with the Module parameter as shown in the following example.

```powershell
Get-Command -Module CimCmdlets
```

```powershell
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Export-BinaryMiLog                                 1.0.0.0    CimCmdlets
Cmdlet          Get-CimAssociatedInstance                          1.0.0.0    CimCmdlets
Cmdlet          Get-CimClass                                       1.0.0.0    CimCmdlets
Cmdlet          Get-CimInstance                                    1.0.0.0    CimCmdlets
Cmdlet          Get-CimSession                                     1.0.0.0    CimCmdlets
Cmdlet          Import-BinaryMiLog                                 1.0.0.0    CimCmdlets
Cmdlet          Invoke-CimMethod                                   1.0.0.0    CimCmdlets
Cmdlet          New-CimInstance                                    1.0.0.0    CimCmdlets
Cmdlet          New-CimSession                                     1.0.0.0    CimCmdlets
Cmdlet          New-CimSessionOption                               1.0.0.0    CimCmdlets
Cmdlet          Register-CimIndicationEvent                        1.0.0.0    CimCmdlets
Cmdlet          Remove-CimInstance                                 1.0.0.0    CimCmdlets
Cmdlet          Remove-CimSession                                  1.0.0.0    CimCmdlets
Cmdlet          Set-CimInstance                                    1.0.0.0    CimCmdlets
```

The CIM cmdlets still allow you to work with WMI so don't be confused when someone makes the
statement "When I query WMI with the PowerShell CIM cmdlets."

As I previously mentioned, WMI is a separate technology from PowerShell and you're simply using the
CIM cmdlets for accessing WMI. You may find an old VBScript that uses WQL (Windows Management
Instrumentation Query Language) to query WMI such as in the following example.

```vb
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

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

You can take the WQL query from that VBScript and use it with the Get-CimInstance cmdlet in
PowerShell without any modifications.

```powershell
Get-CimInstance -Query 'Select * from Win32_BIOS'
```

```powershell
SMBIOSBIOSVersion : 090006
Manufacturer      : American Megatrends Inc.
Name              : Intel(R) Xeon(R) CPU E3-1505M v5 @ 2.80GHz
SerialNumber      : 3810-1995-1654-4615-2295-2755-89
Version           : VRTUAL - 4001628
```

That's not how I typically query WMI with PowerShell, but it does work and allows you to easily
migrate existing VBScripts to PowerShell. If I start out writing a one-liner in PowerShell to query
WMI, I'll use the following syntax.

```powershell
Get-CimInstance -ClassName Win32_BIOS
```

```powershell
SMBIOSBIOSVersion : 090006
Manufacturer      : American Megatrends Inc.
Name              : Intel(R) Xeon(R) CPU E3-1505M v5 @ 2.80GHz
SerialNumber      : 3810-1995-1654-4615-2295-2755-89
Version           : VRTUAL - 4001628
```

If I only want the serial number, I can pipe the output to Select-Object and specify only the
SerialNumber property.

```powershell
Get-CimInstance -ClassName Win32_BIOS | Select-Object -Property SerialNumber
```

```powershell
SerialNumber
------------
3810-1995-1654-4615-2295-2755-89
```

By default there are a number of properties that are retrieved behind the scenes that are simply
thrown away. While it may not matter much when querying WMI on the local computer, once you start
querying remote computers, it's not only additional processing time to return that information, but
also additional unnecessary information to have to pull across the network. Get-CimInstance has a
Property parameter which can limit the information that's retrieved in order to minimize the network
traffic if querying a remote computer. This makes the query to WMI more efficient.

```powershell
Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber |
Select-Object -Property SerialNumber
```

```powershell
SerialNumber
------------
3810-1995-1654-4615-2295-2755-89
```

The previous results returned an object. To return a simple string, use the ExpandProperty parameter.

```powershell
Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber |
Select-Object -ExpandProperty SerialNumber
```

```powershell
3810-1995-1654-4615-2295-2755-89
PS C:\>
```

You could also use the dotted notation style of syntax to return a simple string which eliminates
the need to pipe to Select-Object altogether.

```powershell
(Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber).SerialNumber
```

```powershell
3810-1995-1654-4615-2295-2755-89
PS C:\>
```

## Query Remote Computers with the CIM cmdlets

I'm still running PowerShell as a local admin who is a domain user. When I try to query information
from a remote computer using the Get-CimInstance cmdlet, I receive an access denied error message.

```powershell
Get-CimInstance -ComputerName dc01 -ClassName Win32_BIOS
```

```powershell
Get-CimInstance : Access is denied.
At line:1 char:1
+ Get-CimInstance -ComputerName dc01 -ClassName Win32_BIOS
+ ``````````````````````````````````````````````````````~~
    + CategoryInfo          : PermissionDenied: (root\cimv2:Win32_BIOS:String) [Get-CimI
   nstance], CimException
    + FullyQualifiedErrorId : HRESULT 0x80070005,Microsoft.Management.Infrastructure.Cim
   Cmdlets.GetCimInstanceCommand
    + PSComputerName        : dc01
```

Many people have security concerns when it comes to PowerShell, but the truth is you have exactly
the same permissions with PowerShell as you do in the GUI, no more and no less. The problem in the
previous example is the user I'm running PowerShell as doesn't have access to query information from
WMI on the DC01 server. I could relaunch PowerShell as a domain administrator since Get-CimInstance
doesn't have a Credential parameter, but trust me that isn't a good idea because then anything that
I run from PowerShell would be running as a domain admin. That could be bad, worse, or maybe even
ugly from a security standpoint depending on the situation.

Using the principle of least privilege, I elevate to my domain admin account on a per command basis
using the Credential parameter if a command has one. Get-CimInstance doesn't have a Credential
parameter so the solution in this scenario is to create a CimSession first and then use it instead
of a computer name to query WMI on the remote computer.

```powershell
$CimSession = New-CimSession -ComputerName dc01 -Credential (Get-Credential)
```

```powershell
cmdlet Get-Credential at command pipeline position 1
Supply values for the following parameters:
Credential
PS C:\>
```

The CIM session was stored in a variable named CimSession as shown in the previous example. Notice
that I also specified the Get-Credential cmdlet inside of parentheses, so it would be executed first
and prompt me for alternate credentials before running the other portion of the command. I'll show
you another more efficient way to specify alternate credentials later in this chapter, but it's
important to understand this basic concept before making it more complicated.

The CIM session created in the previous example can now be used with the Get-CimInstance cmdlet to
query the BIOS information from WMI on the remote computer.

```powershell
Get-CimInstance -CimSession $CimSession -ClassName Win32_BIOS
```

```powershell
SMBIOSBIOSVersion : 090006
Manufacturer      : American Megatrends Inc.
Name              : Intel(R) Xeon(R) CPU E3-1505M v5 @ 2.80GHz
SerialNumber      : 0986-6980-3916-0512-6608-8243-13
Version           : VRTUAL - 4001628
PSComputerName    : dc01
```

There are several additional benefits to using CIM sessions instead of just specifying a computer
name. When performing multiple queries to the same computer, creating a CIM session is much more
efficient than what's required to setup and teardown a connection for each query. In other words, a
CIM session only setups up the connection once and then numerous queries use that same session to
retrieve information and then it's torn down once instead of setting it up and tearing it down with
each individual query.

The Get-CimInstance cmdlet uses the WSMan protocol by default which means the remote computer needs
PowerShell version 3.0 or higher in order for it to be able to connect. It's actually not the
PowerShell version that matters, it's the stack version. The stack version can be determined using
the Test-WSMan cmdlet. It needs to be version 3.0 and that's the version you'll find with PowerShell
version 3.0 and higher.

```powershell
Test-WSMan -ComputerName dc01
```

```powershell
wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
ProductVersion  : OS: 0.0.0 SP: 0.0 Stack: 3.0
```

The older WMI cmdlets use the DCOM protocol which is compatible with older versions of Windows, but
it's typically blocked by the firewall on newer versions of Windows. There's a New-CimSessionOption
cmdlet that allows you to create a DCOM protocol option for use with the New-CimSession cmdlet. This
allows the Get-CimInstance cmdlet to be used to communicate with versions of Windows as far back as
Windows Server 2000. This also means that PowerShell is not required on the remote computer when
using the Get-CimInstance cmdlet with a CimSession that's configured to use the DCOM protocol.

Create the DCOM protocol option using the New-CimSessionOption cmdlet and store it in a variable.

```powershell
$DCOM = New-CimSessionOption -Protocol Dcom
```

```powershell
PS C:\>
```

Now back to the topic of making the entry of alternate credentials more efficient when they're
specified on a command by command basis. Store your domain administrator or elevated credentials in
a variable so you don't have to constantly enter them manually for each command.

```powershell
$Cred = Get-Credential
```

```powershell
cmdlet Get-Credential at command pipeline position 1
Supply values for the following parameters:
Credential
PS C:\>
```

I have a server named SQL03 which runs Windows Server 2008 (non-R2). It's the newest Windows Server
operating system that doesn't have PowerShell installed by default.

Create a CimSession to SQL03 using the DCOM protocol.

```powershell
$CimSession = New-CimSession -ComputerName sql03 -SessionOption $DCOM -Credential
$Cred
```

```powershell
PS C:\>
```

Notice in the previous command, this time I specified the variable named Cred which contains my
elevated credentials as the value for the Credential parameter instead of having to enter then
manually again.

The output of the command to query WMI for BIOS information is the same regardless of the underlying
protocol that's being used.

```powershell
Get-CimInstance -CimSession $CimSession -ClassName Win32_BIOS
```

```powershell
SMBIOSBIOSVersion : 090006
Manufacturer      : American Megatrends Inc.
Name              : Intel(R) Xeon(R) CPU E3-1505M v5 @ 2.80GHz
SerialNumber      : 7237-7483-8873-8926-7271-5004-86
Version           : VRTUAL - 4001628
PSComputerName    : sql03
```

The Get-CimSession cmdlet is used to see what CimSessions are currently connected and what protocols
they're using.

```powershell
Get-CimSession
```

```powershell
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

Retrieve and store both of the previously created CimSessions in a variable named CimSession.

```powershell
$CimSession = Get-CimSession
```

```powershell
PS C:\>
```

Query both of the computers with one command, one using the WSMan protocol and the other one with
DCOM.

```powershell
Get-CimInstance -CimSession $CimSession -ClassName Win32_BIOS
```

```powershell
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

I've written numerous blog articles about the WMI and CIM cmdlets. One of the most useful ones is
about a function that I created to automatically determine if WSMan or DCOM should be used and setup
the CIM session automatically without having to figure out which one manually. That blog article is
titled
"[PowerShell Function to Create CimSessions to Remote Computers with Fallback to Dcom](http://mikefrobbins.com/2014/08/28/powershell-function-to-create-cimsessions-to-remote-computers-with-fallback-to-dcom/)".

When you're finished with the CIM sessions, you should remove them with the Remove-CimSession
cmdlet. To remove all CIM sessions, simply pipe Get-CimSession to Remove-CimSession.

```powershell
Get-CimSession | Remove-CimSession
```

```powershell
PS C:\>
```

## Summary

In this chapter you've learned about using PowerShell to work with WMI on both local and remote
computers. You've also learned how to use the CIM cmdlets to work with remote computers with both
the WSMan or DCOM protocol.

## Review

1. What is the difference in the WMI and CIM cmdlets?
2. By default, what protocol does the Get-CimInstance cmdlet use?
3. What are some of the benefits of using a CIM session instead of specifying a computer name with
   Get-CimInstance?
4. How do you specify an alternate protocol other than the default one for use with Get-CimInstance?
5. How do you close or remove CIM sessions?

## Recommended Reading

* [about_WMI](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_wmi)
* [about_WMI_Cmdlets](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_wmi_cmdlets)
* [about_WQL](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_wql)
* [CimCmdlets Module](https://technet.microsoft.com/en-us/itpro/powershell/windows/cimcmdlets/cimcmdlets)
* [Video: Using CIM Cmdlets and CIM Sessions](http://mikefrobbins.com/2013/09/12/phillyposh-user-group-meeting-presentation-follow-up-powershell-second-hop-problem-with-cimsessions/)

---
description: There are many different ways to run commands against remote computers in PowerShell.
ms.custom: Contributor-mikefrobbins
ms.date: 03/25/2025
ms.reviewer: mirobb
title: PowerShell remoting
---

# Chapter 8 - PowerShell remoting

PowerShell offers several ways to run commands against remote computers. In the last chapter, you
explored how to remotely query WMI using the CIM cmdlets. PowerShell also includes several cmdlets
that feature a built-in **ComputerName** parameter.

As shown in the following example, you can use `Get-Command` with the **ParameterName** parameter to
identify cmdlets that include a **ComputerName** parameter.

```powershell
Get-Command -ParameterName ComputerName
```

```Output
CommandType Name              Version Source                         
----------- ----              ------- ------                         
Cmdlet      Add-Computer      3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Clear-EventLog    3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Connect-PSSession 3.0.0.0 Microsoft.PowerShell.Core      
Cmdlet      Enter-PSSession   3.0.0.0 Microsoft.PowerShell.Core      
Cmdlet      Get-EventLog      3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Get-HotFix        3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Get-Process       3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Get-PSSession     3.0.0.0 Microsoft.PowerShell.Core      
Cmdlet      Get-Service       3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Get-WmiObject     3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Invoke-Command    3.0.0.0 Microsoft.PowerShell.Core      
Cmdlet      Invoke-WmiMethod  3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Limit-EventLog    3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      New-EventLog      3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      New-PSSession     3.0.0.0 Microsoft.PowerShell.Core      
Cmdlet      Receive-Job       3.0.0.0 Microsoft.PowerShell.Core      
Cmdlet      Receive-PSSession 3.0.0.0 Microsoft.PowerShell.Core      
Cmdlet      Register-WmiEvent 3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Remove-Computer   3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Remove-EventLog   3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Remove-PSSession  3.0.0.0 Microsoft.PowerShell.Core      
Cmdlet      Remove-WmiObject  3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Rename-Computer   3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Restart-Computer  3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Send-MailMessage  3.1.0.0 Microsoft.PowerShell.Utility   
Cmdlet      Set-Service       3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Set-WmiInstance   3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Show-EventLog     3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Stop-Computer     3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Test-Connection   3.1.0.0 Microsoft.PowerShell.Management
Cmdlet      Write-EventLog    3.1.0.0 Microsoft.PowerShell.Management
```

Commands such as `Get-Process` and `Get-HotFix` include a **ComputerName** parameter, but this
approach isn't the long-term direction Microsoft recommends for running commands against remote
systems. Even when you find a command with a **ComputerName** parameter, it often lacks a
**Credential** parameter, making it difficult to specify alternate credentials. Running PowerShell
from an elevated session doesn't guarantee success, as a network firewall can block the request
between your system and the remote computer.

To use the PowerShell remoting commands demonstrated in this chapter, PowerShell remoting must be
enabled on the remote computer. You can enable it by running the `Enable-PSRemoting` cmdlet.

```powershell
Enable-PSRemoting
```

```Output
WinRM has been updated to receive requests.
WinRM service type changed successfully.
WinRM service started.

WinRM has been updated for remote management.
WinRM firewall exception enabled.
```

## One-to-one remoting

If you want an interactive remote session, one-to-one remoting is what you want. This type of
remoting is provided via the `Enter-PSSession` cmdlet.

Store your domain admin credentials in the `$Cred` variable. This approach allows you to enter your
credentials once and reuse them on a per-command basis as long as your current PowerShell session
remains active.

```powershell
$Cred = Get-Credential
```

Establish a one-to-one PowerShell remoting session to the domain controller named dc01.

```powershell
Enter-PSSession -ComputerName dc01 -Credential $Cred
```

Notice the PowerShell prompt is preceded by `[dc01]`. This prefix indicates you're in an interactive
session with the remote computer named dc01. Any commands you run now execute on dc01, not your
local machine.

```Output
[dc01]: PS C:\Users\Administrator\Documents>
```

Remember that you can only access the PowerShell commands and modules installed on the remote
computer. If you installed other modules locally, they aren't available in the remote session.

When connected via a one-to-one interactive remoting session, it's as if you're sitting directly at
the remote machine.

```powershell
[dc01]: Get-Process | Get-Member
```

```Output
   TypeName: System.Diagnostics.Process

Name                       MemberType     Definition
----                       ----------     ----------
Handles                    AliasProperty  Handles = Handlecount
Name                       AliasProperty  Name = ProcessName
NPM                        AliasProperty  NPM = NonpagedSystemMemorySize64
PM                         AliasProperty  PM = PagedMemorySize64
SI                         AliasProperty  SI = SessionId
VM                         AliasProperty  VM = VirtualMemorySize64
WS                         AliasProperty  WS = WorkingSet64
Disposed                   Event          System.EventHandler Disposed(Sy...
ErrorDataReceived          Event          System.Diagnostics.DataReceived...
Exited                     Event          System.EventHandler Exited(Syst...
OutputDataReceived         Event          System.Diagnostics.DataReceived...
BeginErrorReadLine         Method         void BeginErrorReadLine()
BeginOutputReadLine        Method         void BeginOutputReadLine()
CancelErrorRead            Method         void CancelErrorRead()
CancelOutputRead           Method         void CancelOutputRead()
Close                      Method         void Close()
CloseMainWindow            Method         bool CloseMainWindow()
CreateObjRef               Method         System.Runtime.Remoting.ObjRef ...
Dispose                    Method         void Dispose(), void IDisposabl...
Equals                     Method         bool Equals(System.Object obj)
GetHashCode                Method         int GetHashCode()
GetLifetimeService         Method         System.Object GetLifetimeService()
GetType                    Method         type GetType()
InitializeLifetimeService  Method         System.Object InitializeLifetim...
Kill                       Method         void Kill()
Refresh                    Method         void Refresh()
Start                      Method         bool Start()
ToString                   Method         string ToString()
WaitForExit                Method         bool WaitForExit(int millisecon...
WaitForInputIdle           Method         bool WaitForInputIdle(int milli...
__NounName                 NoteProperty   string __NounName=Process
BasePriority               Property       int BasePriority {get;}
Container                  Property       System.ComponentModel.IContaine...
EnableRaisingEvents        Property       bool EnableRaisingEvents {get;s...
ExitCode                   Property       int ExitCode {get;}
ExitTime                   Property       datetime ExitTime {get;}
Handle                     Property       System.IntPtr Handle {get;}
HandleCount                Property       int HandleCount {get;}
HasExited                  Property       bool HasExited {get;}
Id                         Property       int Id {get;}
MachineName                Property       string MachineName {get;}
MainModule                 Property       System.Diagnostics.ProcessModul...
MainWindowHandle           Property       System.IntPtr MainWindowHandle ...
MainWindowTitle            Property       string MainWindowTitle {get;}
MaxWorkingSet              Property       System.IntPtr MaxWorkingSet {ge...
MinWorkingSet              Property       System.IntPtr MinWorkingSet {ge...
Modules                    Property       System.Diagnostics.ProcessModul...
NonpagedSystemMemorySize   Property       int NonpagedSystemMemorySize {g...
NonpagedSystemMemorySize64 Property       long NonpagedSystemMemorySize64...
PagedMemorySize            Property       int PagedMemorySize {get;}
PagedMemorySize64          Property       long PagedMemorySize64 {get;}
PagedSystemMemorySize      Property       int PagedSystemMemorySize {get;}
PagedSystemMemorySize64    Property       long PagedSystemMemorySize64 {g...
PeakPagedMemorySize        Property       int PeakPagedMemorySize {get;}
PeakPagedMemorySize64      Property       long PeakPagedMemorySize64 {get;}
PeakVirtualMemorySize      Property       int PeakVirtualMemorySize {get;}
PeakVirtualMemorySize64    Property       long PeakVirtualMemorySize64 {g...
PeakWorkingSet             Property       int PeakWorkingSet {get;}
PeakWorkingSet64           Property       long PeakWorkingSet64 {get;}
PriorityBoostEnabled       Property       bool PriorityBoostEnabled {get;...
PriorityClass              Property       System.Diagnostics.ProcessPrior...
PrivateMemorySize          Property       int PrivateMemorySize {get;}
PrivateMemorySize64        Property       long PrivateMemorySize64 {get;}
PrivilegedProcessorTime    Property       timespan PrivilegedProcessorTim...
ProcessName                Property       string ProcessName {get;}
ProcessorAffinity          Property       System.IntPtr ProcessorAffinity...
Responding                 Property       bool Responding {get;}
SafeHandle                 Property       Microsoft.Win32.SafeHandles.Saf...
SessionId                  Property       int SessionId {get;}
Site                       Property       System.ComponentModel.ISite Sit...
StandardError              Property       System.IO.StreamReader Standard...
StandardInput              Property       System.IO.StreamWriter Standard...
StandardOutput             Property       System.IO.StreamReader Standard...
StartInfo                  Property       System.Diagnostics.ProcessStart...
StartTime                  Property       datetime StartTime {get;}
SynchronizingObject        Property       System.ComponentModel.ISynchron...
Threads                    Property       System.Diagnostics.ProcessThrea...
TotalProcessorTime         Property       timespan TotalProcessorTime {get;}
UserProcessorTime          Property       timespan UserProcessorTime {get;}
VirtualMemorySize          Property       int VirtualMemorySize {get;}
VirtualMemorySize64        Property       long VirtualMemorySize64 {get;}
WorkingSet                 Property       int WorkingSet {get;}
WorkingSet64               Property       long WorkingSet64 {get;}
PSConfiguration            PropertySet    PSConfiguration {Name, Id, Prio...
PSResources                PropertySet    PSResources {Name, Id, Handleco...
Company                    ScriptProperty System.Object Company {get=$thi...
CPU                        ScriptProperty System.Object CPU {get=$this.To...
Description                ScriptProperty System.Object Description {get=...
FileVersion                ScriptProperty System.Object FileVersion {get=...
Path                       ScriptProperty System.Object Path {get=$this.M...
Product                    ScriptProperty System.Object Product {get=$thi...
ProductVersion             ScriptProperty System.Object ProductVersion {g...
```

When you finish working with the remote computer, run the `Exit-PSSession` cmdlet to end the remote
session.

```powershell
[dc01]:  Exit-PSSession
```

## One-to-many remoting

While you might occasionally need to perform tasks interactively on a remote computer, PowerShell
remoting becomes more powerful when you simultaneously execute commands across multiple remote
systems. Use the `Invoke-Command` cmdlet to run commands on one or more remote computers at the same
time.

In the following example, you query three servers for the status of the Windows Time service. The
`Get-Service` cmdlet is placed inside the script block of `Invoke-Command`, meaning it executes on
each remote computer.

```powershell
Invoke-Command -ComputerName dc01, sql02, web01 {
    Get-Service -Name W32time
} -Credential $Cred
```

The results are returned to your local session as deserialized objects.

```Output
Status   Name        DisplayName       PSComputerName
------   ----        -----------       --------------
Running  W32time     Windows Time      web01
Start... W32time     Windows Time      dc01
Running  W32time     Windows Time      sql02
```

To confirm the returned objects are deserialized, pipe the output to `Get-Member`.

```powershell
Invoke-Command -ComputerName dc01, sql02, web01 {
    Get-Service -Name W32time
} -Credential $Cred | Get-Member
```

```Output
   TypeName: Deserialized.System.ServiceProcess.ServiceController

Name                MemberType   Definition
----                ----------   ----------
GetType             Method       type GetType()
ToString            Method       string ToString(), string ToString(strin...
Name                NoteProperty string Name=W32time
PSComputerName      NoteProperty string PSComputerName=dc01
PSShowComputerName  NoteProperty bool PSShowComputerName=True
RequiredServices    NoteProperty Deserialized.System.ServiceProcess.Servi...
RunspaceId          NoteProperty guid RunspaceId=5ed06925-8037-43ef-9072-...
CanPauseAndContinue Property     System.Boolean {get;set;}
CanShutdown         Property     System.Boolean {get;set;}
CanStop             Property     System.Boolean {get;set;}
Container           Property      {get;set;}
DependentServices   Property     Deserialized.System.ServiceProcess.Servi...
DisplayName         Property     System.String {get;set;}
MachineName         Property     System.String {get;set;}
ServiceHandle       Property     System.String {get;set;}
ServiceName         Property     System.String {get;set;}
ServicesDependedOn  Property     Deserialized.System.ServiceProcess.Servi...
ServiceType         Property     System.String {get;set;}
Site                Property      {get;set;}
StartType           Property     System.String {get;set;}
Status              Property     System.String {get;set;}
```

Notice that most methods are missing from deserialized objects. The methods are missing because
these objects aren't live. They're inert snapshots of the object's state when you execute the
command against the remote computer. For example, you can't start or stop a service using a
deserialized object since it no longer has access to the required methods.

However, this doesn't mean you can't use methods like `Stop()` with `Invoke-Command`. The key is
that you must call the method within the remote session.

To demonstrate, stop the Windows Time service on all three remote servers by invoking the `Stop()`
method remotely.

```powershell
Invoke-Command -ComputerName dc01, sql02, web01 {
    (Get-Service -Name W32time).Stop()
} -Credential $Cred

Invoke-Command -ComputerName dc01, sql02, web01 {
    Get-Service -Name W32time
} -Credential $Cred
```

```Output
Status   Name        DisplayName       PSComputerName
------   ----        -----------       --------------
Stopped  W32time     Windows Time      web01
Stopped  W32time     Windows Time      dc01
Stopped  W32time     Windows Time      sql02
```

As mentioned in an earlier chapter, if there's a cmdlet available to accomplish a task, it's
preferable to use it rather than calling a method directly. For example, use the `Stop-Service`
cmdlet instead of the `Stop()` method to stop a service.

In the previous example, the `Stop()` method is used to make a point. Some people mistakenly believe
that you can't use methods with PowerShell remoting. While it's true that you can't call methods on
deserialized objects returned to your local session, you can, however, invoke them within the remote
session.

## PowerShell sessions

In the final example from the previous section, you ran two commands using the `Invoke-Command`
cmdlet. This scenario resulted in two separate sessions being established and torn down. One for
each command.

Like CIM sessions, a persistent PowerShell session allows you to run multiple commands against a
remote computer without the overhead of creating a new session for each command.

Create a PowerShell session to each of the three computers you're working with in this chapter,
DC01, SQL02, and WEB01.

```powershell
$Session = New-PSSession -ComputerName dc01, sql02, web01 -Credential $Cred
```

Now, use the `$Session` variable to start the Windows Time service by calling its method and then
verify the service status.

```powershell
Invoke-Command -Session $Session {(Get-Service -Name W32time).Start()}
Invoke-Command -Session $Session {Get-Service -Name W32time}
```

```Output
Status   Name        DisplayName       PSComputerName
------   ----        -----------       --------------
Running  W32time     Windows Time      web01
Start... W32time     Windows Time      dc01
Running  W32time     Windows Time      sql02
```

Once you create the session with alternate credentials, you don't need to specify those credentials
again for each command.

Be sure to remove the sessions when you finish using them.

```powershell
Get-PSSession | Remove-PSSession
```

## Summary

In this chapter, you learned the fundamentals of PowerShell remoting, including running commands
interactively on a single remote computer and executing commands across multiple systems using
one-to-many remoting. You also explored the advantages of using persistent PowerShell sessions when
running multiple commands against the same remote computer.

## Review

1. How do you enable PowerShell remoting?
1. What PowerShell command do you use to start an interactive session with a remote computer?
1. What's one benefit of using a PowerShell remoting session instead of specifying the computer name
   with each command?
1. Can you use a PowerShell session in a one-to-one interactive remoting scenario?
1. What's the difference between the objects returned by cmdlets run locally and objects returned
   when the same cmdlets are executed on remote computers using `Invoke-Command`?

## References

- [about_Remote][about-remote]
- [about_Remote_Output][about-remote-output]
- [about_Remote_Requirements][about-remote-requirements]
- [about_Remote_Troubleshooting][about-remote-troubleshooting]
- [about_Remote_Variables][about-remote-variables]
- [PowerShell Remoting FAQ][remoting-faq]

## Next steps

In [Chapter 9][chapter-9], you'll learn how to write reusable PowerShell functions. You'll explore
function design, parameters, pipeline input, error handling, and best practices for turning
one-liners and scripts into reliable tools.

<!-- link references -->

[about-remote]: /powershell/module/microsoft.powershell.core/about/about_remote
[about-remote-output]: /powershell/module/microsoft.powershell.core/about/about_remote_output
[about-remote-requirements]: /powershell/module/microsoft.powershell.core/about/about_remote_requirements
[about-remote-troubleshooting]: /powershell/module/microsoft.powershell.core/about/about_remote_troubleshooting
[about-remote-variables]: /powershell/module/microsoft.powershell.core/about/about_remote_variables
[remoting-faq]: /powershell/scripting/learn/remoting/powershell-remoting-faq
[chapter-9]: 09-functions.md

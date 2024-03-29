---
description: There are many different ways to run commands against remote computers in PowerShell.
ms.custom: Contributor-mikefrobbins
ms.date: 12/08/2022
ms.reviewer: mirobb
title: PowerShell remoting
---
# Chapter 8 - PowerShell remoting

PowerShell has many different ways to run commands against remote computers. In the last chapter,
you saw how to remotely query WMI using the CIM cmdlets. PowerShell also includes several cmdlets
that have a built-in **ComputerName** parameter.

As shown in the following example, `Get-Command` can be used with the **ParameterName** parameter to
determine what commands have a **ComputerName** parameter.

```powershell
Get-Command -ParameterName ComputerName
```

```Output
CommandType     Name                           Version    Source
-----------     ----                           -------    ------
Cmdlet          Add-Computer                   3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Clear-EventLog                 3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Connect-PSSession              3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Enter-PSSession                3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Get-EventLog                   3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Get-HotFix                     3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Get-Process                    3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Get-PSSession                  3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Get-Service                    3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Get-WmiObject                  3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Invoke-Command                 3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Invoke-WmiMethod               3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Limit-EventLog                 3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          New-EventLog                   3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          New-PSSession                  3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Receive-Job                    3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Receive-PSSession              3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Register-WmiEvent              3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Remove-Computer                3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Remove-EventLog                3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Remove-PSSession               3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Remove-WmiObject               3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Rename-Computer                3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Restart-Computer               3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Send-MailMessage               3.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Set-Service                    3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Set-WmiInstance                3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Show-EventLog                  3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Stop-Computer                  3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Test-Connection                3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Write-EventLog                 3.1.0.0    Microsoft.PowerShell.Management
```

Commands such as `Get-Process` and `Get-Hotfix` have a **ComputerName** parameter. This isn't the
long-term direction that Microsoft is heading for running commands against remote computers. Even if
you find a command that has a **ComputerName** parameter, chances are that you'll need to specify
alternate credentials and it won't have a **Credential** parameter. And if you decided to run
PowerShell from an elevated account, a firewall between you and the remote computer can block the
request.

To use the PowerShell remoting commands that are demonstrated in this chapter, PowerShell remoting
must be enabled on the remote computer. Use the `Enable-PSRemoting` cmdlet to enable PowerShell
remoting.

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

## One-To-One Remoting

If you want your remote session to be interactive, then one-to-one remoting is what you want.
This type of remoting is provided via the `Enter-PSSession` cmdlet.

In the last chapter, I stored my domain admin credentials in a variable named `$Cred`. If you
haven't already done so, go ahead and store your domain admin credentials in the `$Cred` variable.

This allows you to enter the credentials once and use them on a per command basis as long as your
current PowerShell session is active.

```powershell
$Cred = Get-Credential
```

Create a one-to-one PowerShell remoting session to the domain controller named dc01.

```powershell
Enter-PSSession -ComputerName dc01 -Credential $Cred
```

```Output
[dc01]: PS C:\Users\Administrator\Documents>
```

Notice that in the previous example that the PowerShell prompt is preceded by `[dc01]`. This means
you're in an interactive PowerShell session to the remote computer named dc01. Any commands you
execute run on dc01, not on your local computer. Also, keep in mind that you only have access to the
PowerShell commands that exist on the remote computer and not the ones on your local computer. In
other words, if you've installed additional modules on your computer, they aren't accessible on the
remote computer.

When you're connected to a remote computer via a one-to-one interactive PowerShell remoting session,
you're effectively sitting at the remote computer. The objects are normal objects just like the ones
you've been working with throughout this entire book.

```powershell
[dc01]:  Get-Process | Get-Member
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
Disposed                   Event          System.EventHandler Disposed(System.Object, ...
ErrorDataReceived          Event          System.Diagnostics.DataReceivedEventHandler ...
Exited                     Event          System.EventHandler Exited(System.Object, Sy...
OutputDataReceived         Event          System.Diagnostics.DataReceivedEventHandler ...
BeginErrorReadLine         Method         void BeginErrorReadLine()
BeginOutputReadLine        Method         void BeginOutputReadLine()
CancelErrorRead            Method         void CancelErrorRead()
CancelOutputRead           Method         void CancelOutputRead()
Close                      Method         void Close()
CloseMainWindow            Method         bool CloseMainWindow()
CreateObjRef               Method         System.Runtime.Remoting.ObjRef CreateObjRef(...
Dispose                    Method         void Dispose(), void IDisposable.Dispose()
Equals                     Method         bool Equals(System.Object obj)
GetHashCode                Method         int GetHashCode()
GetLifetimeService         Method         System.Object GetLifetimeService()
GetType                    Method         type GetType()
InitializeLifetimeService  Method         System.Object InitializeLifetimeService()
Kill                       Method         void Kill()
Refresh                    Method         void Refresh()
Start                      Method         bool Start()
ToString                   Method         string ToString()
WaitForExit                Method         bool WaitForExit(int milliseconds), void Wai...
WaitForInputIdle           Method         bool WaitForInputIdle(int milliseconds), boo...
__NounName                 NoteProperty   string __NounName=Process
BasePriority               Property       int BasePriority {get;}
Container                  Property       System.ComponentModel.IContainer Container {...
EnableRaisingEvents        Property       bool EnableRaisingEvents {get;set;}
ExitCode                   Property       int ExitCode {get;}
ExitTime                   Property       datetime ExitTime {get;}
Handle                     Property       System.IntPtr Handle {get;}
HandleCount                Property       int HandleCount {get;}
HasExited                  Property       bool HasExited {get;}
Id                         Property       int Id {get;}
MachineName                Property       string MachineName {get;}
MainModule                 Property       System.Diagnostics.ProcessModule MainModule ...
MainWindowHandle           Property       System.IntPtr MainWindowHandle {get;}
MainWindowTitle            Property       string MainWindowTitle {get;}
MaxWorkingSet              Property       System.IntPtr MaxWorkingSet {get;set;}
MinWorkingSet              Property       System.IntPtr MinWorkingSet {get;set;}
Modules                    Property       System.Diagnostics.ProcessModuleCollection M...
NonpagedSystemMemorySize   Property       int NonpagedSystemMemorySize {get;}
NonpagedSystemMemorySize64 Property       long NonpagedSystemMemorySize64 {get;}
PagedMemorySize            Property       int PagedMemorySize {get;}
PagedMemorySize64          Property       long PagedMemorySize64 {get;}
PagedSystemMemorySize      Property       int PagedSystemMemorySize {get;}
PagedSystemMemorySize64    Property       long PagedSystemMemorySize64 {get;}
PeakPagedMemorySize        Property       int PeakPagedMemorySize {get;}
PeakPagedMemorySize64      Property       long PeakPagedMemorySize64 {get;}
PeakVirtualMemorySize      Property       int PeakVirtualMemorySize {get;}
PeakVirtualMemorySize64    Property       long PeakVirtualMemorySize64 {get;}
PeakWorkingSet             Property       int PeakWorkingSet {get;}
PeakWorkingSet64           Property       long PeakWorkingSet64 {get;}
PriorityBoostEnabled       Property       bool PriorityBoostEnabled {get;set;}
PriorityClass              Property       System.Diagnostics.ProcessPriorityClass Prio...
PrivateMemorySize          Property       int PrivateMemorySize {get;}
PrivateMemorySize64        Property       long PrivateMemorySize64 {get;}
PrivilegedProcessorTime    Property       timespan PrivilegedProcessorTime {get;}
ProcessName                Property       string ProcessName {get;}
ProcessorAffinity          Property       System.IntPtr ProcessorAffinity {get;set;}
Responding                 Property       bool Responding {get;}
SafeHandle                 Property       Microsoft.Win32.SafeHandles.SafeProcessHandl...
SessionId                  Property       int SessionId {get;}
Site                       Property       System.ComponentModel.ISite Site {get;set;}
StandardError              Property       System.IO.StreamReader StandardError {get;}
StandardInput              Property       System.IO.StreamWriter StandardInput {get;}
StandardOutput             Property       System.IO.StreamReader StandardOutput {get;}
StartInfo                  Property       System.Diagnostics.ProcessStartInfo StartInf...
StartTime                  Property       datetime StartTime {get;}
SynchronizingObject        Property       System.ComponentModel.ISynchronizeInvoke Syn...
Threads                    Property       System.Diagnostics.ProcessThreadCollection T...
TotalProcessorTime         Property       timespan TotalProcessorTime {get;}
UserProcessorTime          Property       timespan UserProcessorTime {get;}
VirtualMemorySize          Property       int VirtualMemorySize {get;}
VirtualMemorySize64        Property       long VirtualMemorySize64 {get;}
WorkingSet                 Property       int WorkingSet {get;}
WorkingSet64               Property       long WorkingSet64 {get;}
PSConfiguration            PropertySet    PSConfiguration {Name, Id, PriorityClass, Fi...
PSResources                PropertySet    PSResources {Name, Id, Handlecount, WorkingS...
Company                    ScriptProperty System.Object Company {get=$this.Mainmodule....
CPU                        ScriptProperty System.Object CPU {get=$this.TotalProcessorT...
Description                ScriptProperty System.Object Description {get=$this.Mainmod...
FileVersion                ScriptProperty System.Object FileVersion {get=$this.Mainmod...
Path                       ScriptProperty System.Object Path {get=$this.Mainmodule.Fil...
Product                    ScriptProperty System.Object Product {get=$this.Mainmodule....
ProductVersion             ScriptProperty System.Object ProductVersion {get=$this.Main...
[dc01]:
```

When you're done working with the remote computer, exit the one-to-one remoting session by using the
`Exit-PSSession` cmdlet.

```powershell
[dc01]:  Exit-PSSession
```

## One-To-Many Remoting

Sometimes you may need to perform a task interactively on a remote computer. But remoting is much
more powerful when performing a task on multiple remote computers at the same time. Use the
`Invoke-Command` cmdlet to run a command against one or more remote computers at the same time.

```powershell
Invoke-Command -ComputerName dc01, sql02, web01 {Get-Service -Name W32time} -Credential $Cred
```

```Output
Status   Name        DisplayName       PSComputerName
------   ----        -----------       --------------
Running  W32time     Windows Time      web01
Start... W32time     Windows Time      dc01
Running  W32time     Windows Time      sql02
```

In the previous example, three servers were queried for the status of the Windows Time service. The
`Get-Service` cmdlet was placed inside the script block of `Invoke-Command`. `Get-Service` actually
runs on the remote computer and the results are returned to your local computer as deserialized
objects.

Piping the previous command to `Get-Member` shows that the results are indeed deserialized objects.

```powershell
Invoke-Command -ComputerName dc01, sql02, web01 {Get-Service -Name W32time} -Credential $Cred | Get-Member
```

```Output
   TypeName: Deserialized.System.ServiceProcess.ServiceController

Name                MemberType   Definition
----                ----------   ----------
GetType             Method       type GetType()
ToString            Method       string ToString(), string ToString(string format, Sys...
Name                NoteProperty string Name=W32time
PSComputerName      NoteProperty string PSComputerName=sql02
PSShowComputerName  NoteProperty bool PSShowComputerName=True
RequiredServices    NoteProperty Deserialized.System.ServiceProcess.ServiceController[...
RunspaceId          NoteProperty guid RunspaceId=570313c4-ac84-4109-bf67-c6b33236af0a
CanPauseAndContinue Property     System.Boolean {get;set;}
CanShutdown         Property     System.Boolean {get;set;}
CanStop             Property     System.Boolean {get;set;}
Container           Property      {get;set;}
DependentServices   Property     Deserialized.System.ServiceProcess.ServiceController[...
DisplayName         Property     System.String {get;set;}
MachineName         Property     System.String {get;set;}
ServiceHandle       Property     System.String {get;set;}
ServiceName         Property     System.String {get;set;}
ServicesDependedOn  Property     Deserialized.System.ServiceProcess.ServiceController[...
ServiceType         Property     System.String {get;set;}
Site                Property      {get;set;}
StartType           Property     System.String {get;set;}
Status              Property     System.String {get;set;}
```

Notice that the majority of the methods are missing on deserialized objects. This means they're not
live objects; they're inert. You can't start or stop a service using a deserialized object because
it's a snapshot of the state of that object the point when the command ran on the remote computer.

That doesn't mean you can't start or stop a service using a method with `Invoke-Command` though. It
just means that the method has to be called in the remote session.

I'll stop the Windows Time service on all three of those remote servers using the **Stop()** method
to prove this point.

```powershell
Invoke-Command -ComputerName dc01, sql02, web01 {(Get-Service -Name W32time).Stop()} -Credential $Cred
Invoke-Command -ComputerName dc01, sql02, web01 {Get-Service -Name W32time} -Credential $Cred
```

```Output
Status   Name        DisplayName       PSComputerName
------   ----        -----------       --------------
Stopped  W32time     Windows Time      web01
Stopped  W32time     Windows Time      dc01
Stopped  W32time     Windows Time      sql02
```

As mentioned in a previous chapter, if a cmdlet exists for accomplishing a task, I recommend using
it instead of using a method. In the previous scenario, I recommend using the `Stop-Service` cmdlet
instead of the stop method. I chose to use the **Stop()** method to prove a point since many people
are under the misconception that methods can't be called when using PowerShell remoting. They can't
be called on the object that's returned because it's deserialized, but they can be called in the
remote session itself.

## PowerShell Sessions

In the last example in the previous section, I ran two commands using the `Invoke-Command` cmdlet.
That means two separate sessions had to be set up and torn down to run those two commands.

Similar to the CIM sessions discussed in Chapter 7, a PowerShell session to a remote computer can be
used to run multiple commands against the remote computer without the overhead of a new session for
each individual command.

Create a PowerShell session to each of the three computers we've been working with in this chapter,
DC01, SQL02, and WEB01.

```powershell
$Session = New-PSSession -ComputerName dc01, sql02, web01 -Credential $Cred
```

Now use the variable named `$Session` to start the Windows Time service using a method and check the
status of the service.

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

Once the session is created using alternate credentials, it's no longer necessary to specify the
credentials each time a command is run.

When you're finished using the sessions, be sure to remove them.

```powershell
Get-PSSession | Remove-PSSession
```

## Summary

In this chapter you've learned about PowerShell remoting, how to run commands in an interactive
session with one remote computer, and how to run commands against multiple computers using
one-to-many remoting. You've also learned the benefits of using a PowerShell session when running
multiple commands against the same remote computer.

## Review

1. How do you enable PowerShell remoting?
1. What is the PowerShell command for starting an interactive session with a remote computer?
1. What is a benefit of using a PowerShell remoting session versus just specifying the computer name
   with each command?
1. Can a PowerShell remoting session be used with a one-to-one remoting session?
1. What is the difference in the type of objects that are returned by cmdlets versus those returned
   when running those same cmdlets against remote computers with `Invoke-Command`?

## Recommended Reading

- [about_Remote][about_Remote]
- [about_Remote_Output][about_Remote_Output]
- [about_Remote_Requirements][about_Remote_Requirements]
- [about_Remote_Troubleshooting][about_Remote_Troubleshooting]
- [about_Remote_Variables][about_Remote_Variables]
- [PowerShell Remoting FAQ][PowerShell Remoting FAQ]

<!-- link references -->
[PowerShell Remoting FAQ]: ../../security/remoting/powershell-remoting-faq.yml
[about_Remote]: /powershell/module/microsoft.powershell.core/about/about_remote
[about_Remote_Output]: /powershell/module/microsoft.powershell.core/about/about_remote_output
[about_Remote_Requirements]: /powershell/module/microsoft.powershell.core/about/about_remote_requirements
[about_Remote_Troubleshooting]: /powershell/module/microsoft.powershell.core/about/about_remote_troubleshooting
[about_Remote_Variables]: /powershell/module/microsoft.powershell.core/about/about_remote_variables

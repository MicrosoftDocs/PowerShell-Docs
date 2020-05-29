# Chapter 8 - PowerShell Remoting

There are many different ways to run commands against remote computers and servers with PowerShell.
In the last chapter you saw how to remotely query WMI using the CIM cmdlets. There are also a number
of cmdlets that have a built-in ComputerName parameter.

As shown in the following example, Get-Command can be used with the ParameterName parameter to
determine what commands have a ComputerName parameter.

```powershell
Get-Command -ParameterName ComputerName
```

```powershell
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Add-Computer                                       3.1.0.0    Microsof...
Cmdlet          Clear-EventLog                                     3.1.0.0    Microsof...
Cmdlet          Connect-PSSession                                  3.0.0.0    Microsof...
Cmdlet          Enter-PSSession                                    3.0.0.0    Microsof...
Cmdlet          Get-EventLog                                       3.1.0.0    Microsof...
Cmdlet          Get-HotFix                                         3.1.0.0    Microsof...
Cmdlet          Get-Process                                        3.1.0.0    Microsof...
Cmdlet          Get-PSSession                                      3.0.0.0    Microsof...
Cmdlet          Get-Service                                        3.1.0.0    Microsof...
Cmdlet          Get-WmiObject                                      3.1.0.0    Microsof...
Cmdlet          Invoke-Command                                     3.0.0.0    Microsof...
Cmdlet          Invoke-WmiMethod                                   3.1.0.0    Microsof...
Cmdlet          Limit-EventLog                                     3.1.0.0    Microsof...
Cmdlet          New-EventLog                                       3.1.0.0    Microsof...
Cmdlet          New-PSSession                                      3.0.0.0    Microsof...
Cmdlet          Receive-Job                                        3.0.0.0    Microsof...
Cmdlet          Receive-PSSession                                  3.0.0.0    Microsof...
Cmdlet          Register-WmiEvent                                  3.1.0.0    Microsof...
Cmdlet          Remove-Computer                                    3.1.0.0    Microsof...
Cmdlet          Remove-EventLog                                    3.1.0.0    Microsof...
Cmdlet          Remove-PSSession                                   3.0.0.0    Microsof...
Cmdlet          Remove-WmiObject                                   3.1.0.0    Microsof...
Cmdlet          Rename-Computer                                    3.1.0.0    Microsof...
Cmdlet          Restart-Computer                                   3.1.0.0    Microsof...
Cmdlet          Send-MailMessage                                   3.1.0.0    Microsof...
Cmdlet          Set-Service                                        3.1.0.0    Microsof...
Cmdlet          Set-WmiInstance                                    3.1.0.0    Microsof...
Cmdlet          Show-EventLog                                      3.1.0.0    Microsof...
Cmdlet          Stop-Computer                                      3.1.0.0    Microsof...
Cmdlet          Test-Connection                                    3.1.0.0    Microsof...
Cmdlet          Write-EventLog                                     3.1.0.0    Microsof...
```

Commands such as Get-Process and Get-Service have a ComputerName parameter. This isn't the long term
direction that Microsoft is heading with being able to run commands against remote computers. Even
if you do find that a command you need to run against a remote computer does have a ComputerName
parameter, chances are that you'll need to specify alternate credentials and it won't have a
Credential parameter. Even if you decided to run PowerShell as an elevated account to work around
that problem, a firewall between your computer and the remote computer or the firewall on the server
itself will probably block the request.

In order to use the PowerShell remoting commands that are demonstrated from this point forward in
this chapter, PowerShell version 2.0 or higher must exist on the remote computer and PowerShell
remoting must be enabled on the remote computer. Table 8-1 shows the default setting of whether or
not PowerShell remoting is enabled or disabled for the currently supported Microsoft operating
systems.

|----------------------------------+----------------------------|
| Windows Operating System Version | PowerShell Remoting        |
|----------------------------------|----------------------------|
| Server 2008                      | Disabled                   |
| Windows 7                        | Disabled                   |
| Server 2008 R2                   | Disabled                   |
| Windows 8                        | Disabled                   |
| Server 2012                      | Enabled                    |
| Windows 8.1                      | Disabled                   |
| Server 2012 R2                   | Enabled                    |
| Windows 10                       | Disabled                   |
| Server 2016                      | Enabled                    |
|==================================+:===========================|
|                          Table 8-1                            |
|----------------------------------+----------------------------|

PowerShell remoting can be enabled or re-enabled using the Enable-PSRemoting cmdlet.

```powershell
 Enable-PSRemoting
```

```powershell
WinRM has been updated to receive requests.
WinRM service type changed successfully.
WinRM service started.

WinRM has been updated for remote management.
WinRM firewall exception enabled.
```

## One-To-One Remoting

If you need to run a PowerShell command against one remote computer and need it to be an interactive
session, then one-to-one remoting is what you're after. This type of remoting is provided via the
Enter-PSSession cmdlet.

In the last chapter, I stored my domain admin credentials in a variable named Cred. If you haven't
already done so, go ahead and store your domain admin credentials in the Cred variable.

```powershell
$Cred = Get-Credential
```

This allows you to enter the credentials one time and use them to elevate on a per command basis
without having to enter them more than once, as long as your current PowerShell console or ISE
session is active.

Create a one-to-one PowerShell remoting session to the domain controller named dc01.

```powershell
 Enter-PSSession -ComputerName dc01 -Credential $Cred
```

```powershell
[dc01]: PS C:\Users\Administrator\Documents>
```

Notice that in the previous example that the PowerShell prompt is preceded by [dc01]. This means
you're in an interactive PowerShell remoting session to a computer named dc01 and any command you
execute is actually run on dc01 and not on your local computer. Also keep in mind that you only have
access to the PowerShell commands that exist on the remote computer and not the ones on your local
computer while in a remoting session. In other words, if you've installed additional modules on your
computer, they won't exist or be accessible on the remote computer.

When you're connected to a remote computer via a one-to-one interactive PowerShell remoting session,
you're effectively sitting at the remote computer. The objects are normal objects just like the ones
you've been working with throughout this entire book.

```powershell
[dc01]:  Get-Process | Get-Member
```

```

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
Exit-PSSession cmdlet.

```powershell
[dc01]:  Exit-PSSession
```

```powershell

```

## One-To-Many Remoting

Sometimes you may need to perform a task interactively on a remote computer, but remoting is much
more powerful when performing a task on multiple remote computers at the same time. The
Invoke-Command cmdlet is used to remotely run a command against one or more remote computers at the
same time.

```powershell
 Invoke-Command -ComputerName dc01, sql02, web01 {Get-Service -Name W32time} -Credential $Cred
```

```powershell
Status   Name               DisplayName                            PSComputerName
------   ----               -----------                            --------------
Running  W32time            Windows Time                           dc01
Running  W32time            Windows Time                           sql02
Running  W32time            Windows Time                           web01
```

In the previous example, three servers were queried for the status of the Windows Time service. The
Get-Service cmdlet was placed inside the script block of Invoke-Command. Get-Service is actually run
on the remote computer and the results are returned to your local computer as deserialized objects.

Piping the previous command to Get-Member shows that the results are indeed deserialized objects.

```powershell
 Invoke-Command -ComputerName dc01, sql02, web01 {Get-Service -Name W32time} -Credential $Cred | Get-Member
```

```

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

Also notice that the majority of the methods are missing on deserialized objects which means they're
not live objects; They're inert. You can't start or stop a service using a deserialized object
because it's a snapshot of the state of that object from the point in time when the command was run
on the remote computer.

That doesn't mean you can't start or stop a service using a method with Invoke-Command though. It
just means that the method has to be called in the remote session.

I'll stop the Windows Time service on all three of those remote servers using the stop method to
prove this point.

```powershell
 Invoke-Command -ComputerName dc01, sql02, web01 {(Get-Service -Name W32time).stop(
)} -Credential $Cred
 Invoke-Command -ComputerName dc01, sql02, web01 {Get-Service -Name W32time} -Crede
ntial $Cred
```

```powershell
Status   Name               DisplayName                            PSComputerName
------   ----               -----------                            --------------
Stopped  W32time            Windows Time                           sql02
Stopped  W32time            Windows Time                           web01
Stopped  W32time            Windows Time                           dc01
```

As mentioned in a previous chapter, if a cmdlet exists for accomplishing a task, I recommend using
it instead of using a method. In the previous scenario, I recommend using the Stop-Service cmdlet
instead of the stop method. I chose to use the stop method to prove a point since many people are
under the misconception that methods can't be called when using PowerShell remoting. They can't be
called on the object that's returned because it's deserialized, but they can be called in the remote
session itself.

## Windows PowerShell Sessions

In the last example in the previous section, I ran two commands using the Invoke-Command cmdlet.
That means two totally separate sessions had to be setup and torn down to run those two commands.

Similarly to how CIM sessions work as discussed in Chapter 7, a PowerShell session can be created to
a remote computer so that multiple commands can be run against the remote computer without the
overhead of setting up and tearing down a session for each individual command.

Create a PowerShell session to each of the three computers we've been working with in this chapter,
DC01, SQL02, and WEB01.

```powershell
 $Session = New-PSSession -ComputerName dc01, sql02, web01 -Credential $Cred
```

```powershell

```

Now use the variable named Session that the PowerShell sessions are stored in to start the Windows
Time service using a method and then check the status of the service.

```powershell
 Invoke-Command -Session $Session {(Get-Service -Name W32time).start()}
 Invoke-Command -Session $Session {Get-Service -Name W32time}
```

```powershell
Status   Name               DisplayName                            PSComputerName
------   ----               -----------                            --------------
Running  W32time            Windows Time                           web01
Start... W32time            Windows Time                           dc01
Running  W32time            Windows Time                           sql02
```

Notice that in the previous example, once the session is created using alternate credentials, it's
no longer necessary to specify the credentials each time a command is run.

When you're finished using the sessions, be sure to remove them.

```powershell
 Get-PSSession | Remove-PSSession
```

```powershell

```

## Summary

In this chapter you've learned about PowerShell remoting and how to run commands in an interactive
session against one remote computer and how to run commands against multiple computers using
one-to-many remoting. You've also learned the benefits of using a PowerShell session when running
multiple commands against the same remote computer.

## Review

1. How do you enable PowerShell remoting?
2. What is the PowerShell command for starting an interactive session with a remote computer?
3. What is one of the benefits of using a PowerShell remoting session versus just specifying the
   computer name with each command?
4. Can a PowerShell remoting session be used with a one-to-one remoting session?
5. What is the difference in the type of objects that are returned by cmdlets versus those returned
   when running those same cmdlets against remote computers with Invoke-Command?

## Recommended Reading

* [about_Remote](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_remote)
* [about_Remote_FAQ](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_remote_faq)
* [about_Remote_Output](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_remote_output)
* [about_Remote_Requirements](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_remote_requirements)
* [about_Remote_Troubleshooting](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_remote_troubleshooting)
* [about_Remote_Variables](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/about/about_remote_variables)

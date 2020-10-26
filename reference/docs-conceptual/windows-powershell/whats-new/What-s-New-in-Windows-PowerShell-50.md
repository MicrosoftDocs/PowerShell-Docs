---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  What's New in Windows PowerShell 5.0
description: These release notes describe the new features and changes in Windows PowerShell 5.x.
---

# What's New in Windows PowerShell 5.0

Windows PowerShell 5.0 includes significant new features that extend its use, improve its usability,
and allow you to control and manage Windows-based environments more easily and comprehensively.

Windows PowerShell 5.0 is backward-compatible. Cmdlets, providers, modules, snap-ins, scripts,
functions, and profiles that were designed for Windows PowerShell 4.0, Windows PowerShell 3.0, and
Windows PowerShell 2.0 generally work in Windows PowerShell 5.0 without changes.

## Installing Windows PowerShell

Windows PowerShell 5.0 is installed by default on Windows Server 2016 Technical Preview and Windows
10.

To install Windows PowerShell 5.0 on Windows Server 2012 R2, Windows 8.1 Enterprise, or Windows 8.1
Pro, download and install [Windows Management Framework 5.0](https://aka.ms/wmf5download). Be sure
to read the download details, and meet all system requirements, before you install Windows
Management Framework 5.0.

## In this topic

- [Windows PowerShell 4.0 DSC updates in KB 3000850](#windows-powershell-40-updates-in-november-2014-update-rollup-kb-3000850)
- [New features in Windows PowerShell 5.0](#new-features-in-windows-powershell-50)
- [New features in Windows PowerShell 4.0](#new-features-in-windows-powershell-40)
- [New features in Windows PowerShell 3.0](#new-features-in-windows-powershell-30)

## Windows PowerShell 4.0 updates in November 2014 update rollup (KB 3000850)

Many updates and improvements to Windows PowerShell Desired State Configuration (DSC) in Windows
PowerShell 4.0 are available in the
[November 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2](https://support.microsoft.com/kb/3000850/)
(KB 3000850). You can determine if KB 3000850 is installed on your system by running
`Get-Hotfix -Id KB3000850` in Windows PowerShell.

- Updates to existing cmdlets in the
  [PSDesiredStateConfiguration](/powershell/module/PSDesiredStateConfiguration)
  module
  - [Get-DscResource](/powershell/module/PSDesiredStateConfiguration) is faster (especially in ISE).
  - [Start-DscConfiguration](/powershell/module/PSDesiredStateConfiguration) has a new
    parameter, -UseExisting, which reapplies the last applied configuration.
  - [Start-DscConfiguration](/powershell/module/PSDesiredStateConfiguration) -Force has been
    fixed.
  - [Get-DscLocalConfigurationManager](/powershell/module/PSDesiredStateConfiguration) displays
    more useful information about the engine state.
  - [Test-DscConfiguration](/powershell/module/PSDesiredStateConfiguration) now returns the
    computer name along with True or False.
  - [New-DscChecksum](/powershell/module/PSDesiredStateConfiguration) now supports UNC paths.

- New cmdlets in the
  [PSDesiredStateConfiguration](/powershell/module/PSDesiredStateConfiguration)
  module
  - [Update-DscConfiguration](/powershell/module/PSDesiredStateConfiguration/Update-DscConfiguration):
    Performs an on-demand pull server check.
  - [Stop-DscConfiguration](/powershell/module/PSDesiredStateConfiguration/Stop-DscConfiguration):
    Stops a configuration that is already running.
  - [Remove-DscConfigurationDocument](/powershell/module/PSDesiredStateConfiguration/Remove-DscConfigurationDocument):
    Lets you remove configuration documents in various stages (pending, previous, or current).

- Language enhancements
  - DependsOn now supports composite resources.
  - DependsOn now supports numbers in resource instance names.
  - Node expressions that evaluate to empty no longer throw errors.
  - An error that occurs if a node expression evaluates to empty has been fixed.
  - Configurations calling configurations now work in the Windows PowerShell console.

- Pull mode enhancements
  - Pull mode now supports all ZIP files.
  - **AllowModuleOverwrite** now works correctly.

- Resiliency improvements
  - New **DebugMode** lets you reload resource modules.
  - If a configuration failure occurs, the pending.mof file is not deleted.
  - The Local Configuration Manager (LCM) is now more resilient when metaconfiguration settings have
    become corrupted.

- Diagnostic improvements
  - A warning is displayed when the LCM sets the timer to different settings than you have
    specified.
  - Error log files now contain the call stack for Windows PowerShell resources.

- Flexibility improvements
  - The LocalConfigurationManager resource has a new property, **ActionAfterReboot**.
    - ContinueConfiguration (default value): Automatically resumes a configuration after a target
      node restarts.
    - StopConfiguration: Do not automatically resume a configuration after a node restarts.
  - A consistency run can now occur more often than a PULL operation, or vice-versa.
  - Versioning support: DSC can now recognize a document that was generated on a newer client
    (included with [WMF 5.0](https://aka.ms/wmf5download)).

- Error prevention improvements
  - Module version is now enforced before a configuration is applied.
  - **DebugPreference** is now set correctly for Get-, Set-, or Test-TargetResource calls.

- Credential handling improvements
  - A certificate is now used, if both **Certificate** and **PSDscAllowPlainTextPassword** are
    specified.
  - Credentials are decrypted, even for Get-TargetResource.
  - Metaconfiguration credentials are encrypted and decrypted.
  - PSCredentials are now decrypted when they are in an embedded object.

- Built-in resource improvements
  - The Package resource
    - No longer installs the wrong package (either from local or web sources).
    - Now supports HTTPS.
  - There is now support for HTTPS in the
    [Package resource](/powershell/scripting/dsc/reference/resources/windows/packageresource).
  - [Archive resource](/powershell/scripting/dsc/reference/resources/windows/archiveresource) now
    supports credentials.

## New features in Windows PowerShell 5.0

- [New features in Windows PowerShell](#new-features-in-windows-powershell)
- [New features in Windows PowerShell Desired State Configuration](#new-features-in-windows-powershell-desired-state-configuration)
- [New features in Windows PowerShell ISE](#new-features-in-windows-powershell-ise)
- [New features in Windows PowerShell Web Services](#new-features-in-windows-powershell-web-services-management-odata-iis-extension)
- [Notable bug fixes in Windows PowerShell 5.0](#notable-bug-fixes-in-windows-powershell-50)

### New features in Windows PowerShell

- Starting in Windows PowerShell 5.0, you can develop by using classes, by using formal syntax and
  semantics that are similar to other object-oriented programming languages. **Class**, **Enum**,
  and other keywords have been added to the Windows PowerShell language to support the new feature.
  For more information about working with classes, see about_Classes.

- Windows PowerShell 5.0 introduces a new, structured information stream that you can use to
  transmit structured data between a script and its callers (or hosting environment). You can now
  use Write-Host to emit output to the information stream. Information streams also work for
  PowerShell.Streams, jobs, scheduled jobs, and workflows. The following features support the
  information stream.
  - A new Write-Information cmdlet that lets you specify how Windows PowerShell handles information
    stream data for a command. Write-Host is a wrapper for Write-Information. Write-Information is
    also a supported workflow activity.
  - Two new common parameters, InformationVariable and InformationAction, let you determine how
    information streams from a command are displayed. Valid values for InformationAction are
    SilentlyContinue, Stop, Continue, Inquire, Ignore, or Suspend, with SilentlyContinue being the
    default. InformationVariable specifies a string as the name of a variable to which you want the
    Write-Host data from a command saved.
  - A new preference variable, InformationPreference, specifies your default preference for
    information stream data in a Windows PowerShell session. The default value is SilentlyContinue.
  - Two new workflow common parameters, PSInformation and InformationAction, have been added.
  - When you use the Format-Table command, table columns are now automatically formatted by
    evaluating the first 300ms of data that passes through the stream.

- In collaboration with [Microsoft Research](https://research.microsoft.com/), a new cmdlet,
  ConvertFrom-String, has been added. ConvertFrom-String lets you extract and parse structured
  objects from the content of text strings. For more information, see ConvertFrom-String.
- A new Convert-String cmdlet automatically formats text based on an example that you provide in an
  -Example parameter.
- A new module, Microsoft.PowerShell.Archive, includes cmdlets that let you compress files and
  folders into archive (also known as ZIP) files, extract files from existing ZIP files, and update
  ZIP files with newer versions of files compressed within them.
- A new module, PackageManagement, lets you discover and install software packages on the Internet.
  The PackageManagement (formerly known as OneGet) module is a manager or multiplexer of existing
  package managers (also called package providers) to unify Windows package management with a single
  Windows PowerShell interface.
- A new module, PowerShellGet, lets you find, install, publish, and update modules and DSC resources
  on the [PowerShell Gallery](https://www.powershellgallery.com/), or on an internal module
  repository that you can set up by running the Register-PSRepository cmdlet.
- A new language keyword, **Hidden**, has been added to specify that a member (a property or a
  method) is not shown by default in Get-Member results (unless you add the -Force parameter).
  Properties or methods that have been marked hidden also do not show up in IntelliSense results,
  unless you are in a context where the member should be visible; for example, the automatic
  variable $This should show hidden members when in the class method.
- New-Item, Remove-Item, and Get-ChildItem have been enhanced to support creating and managing
  [symbolic links](https://en.wikipedia.org/wiki/Symbolic_link). The **-ItemType** parameter for
  New-Item accepts a new value, **SymbolicLink**. Now you can create symbolic links in a single line
  by running the New-Item cmdlet.
- Get-ChildItem also has a new -Depth parameter, which you use with the -Recurse parameter to limit
  the recursion. For example, Get-ChildItem -Recurse -Depth 2 returns results from the current
  folder, all of the child folders within the current folder, and all of the folders within the
  child folders.
- Copy-Item now lets you copy files or folders from one Windows PowerShell session to another,
  meaning that you can copy files to sessions that are connected to remote computers, (including
  computers that are running Nano Server, and thus have no other interface). To copy files, specify
  PSSession IDs as the value of the new -FromSession and -ToSession parameters, and add -Path and
  -Destination to specify origin path and destination, respectively. For example, Copy-Item -Path
  c:\\myFile.txt -ToSession $s -Destination d:\\destinationFolder.
- Windows PowerShell transcription has been improved to apply to all hosting applications (such as
  Windows PowerShell ISE) in addition to the console host (**powershell.exe**). Transcription
  options (including enabling a system-wide transcript) can be configured by enabling the **Turn on
  PowerShell Transcription** Group Policy setting, found in Administrative Templates/Windows
  Components/Windows PowerShell.
- A new detailed script tracing feature lets you enable detailed tracking and analysis of Windows
  PowerShell scripting use on a system. After you enable detailed script tracing, Windows PowerShell
  logs all script blocks to the Event Tracing for Windows (ETW) event log,
  **Microsoft-Windows-PowerShell/Operational**.
- Starting in Windows PowerShell 5.0, new Cryptographic Message Syntax cmdlets support encryption
  and decryption of content by using the IETF standard format for cryptographically protecting
  messages as documented by [RFC5652](https://tools.ietf.org/html/rfc5652). The Get-CmsMessage,
  Protect-CmsMessage, and Unprotect-CmsMessage cmdlets have been added to the
  [Microsoft.PowerShell.Security](/powershell/module/Microsoft.PowerShell.Security) module.
- New cmdlets in the
  [Microsoft.PowerShell.Utility](/powershell/module/Microsoft.PowerShell.Utility) module,
  Get-Runspace, Debug-Runspace, Get-RunspaceDebug, Enable-RunspaceDebug, and Disable-RunspaceDebug,
  let you set debug options on a runspace, and start and stop debugging on a runspace. For debugging
  arbitrary runspaces (that is, runspaces that are not the default runspace for a Windows PowerShell
  console or Windows PowerShell ISE session) Windows PowerShell lets you set breakpoints in a
  script, and have added breakpoints stop the script from running until you can attach a debugger to
  debug the runspace script. Nested debugging support for arbitrary runspaces has been added to the
  Windows PowerShell script debugger for runspaces.
- A new Format-Hex cmdlet has been added to the
  [Microsoft.PowerShell.Utility](/powershell/module/Microsoft.PowerShell.Utility) module.
  Format-Hex lets you view text or binary data in hexadecimal format.
- Get-Clipboard and Set-Clipboard cmdlets have been added to the
  [Microsoft.PowerShell.Utility](/powershell/module/Microsoft.PowerShell.Utility) module; they
  ease the transfer of content to and from a Windows PowerShell session. The Clipboard cmdlets
  support images, audio files, file lists, and text.
- A new cmdlet, Clear-RecycleBin, has been added to the
  [Microsoft.PowerShell.Management](/powershell/module/Microsoft.PowerShell.Management)
  module; this cmdlet empties the Recycle Bin for a fixed drive, which includes external drives. By
  default, you are prompted to confirm a Clear-RecycleBin command, because the ConfirmImpact
  property of the cmdlet is set to ConfirmImpact.High.
- A new cmdlet, New-TemporaryFile, lets you create a temporary file as part of scripting. By
  default, the new temporary file is created in ```C:\Users\<user name>\AppData\Local\Temp```.
- The Out-File, Add-Content, and Set-Content cmdlets now have a new -NoNewline parameter, which
  omits a new line after the output.
- The New-Guid cmdlet leverages the .NET Framework Guid class to generate a GUID, useful when you
  are writing scripts or DSC resources.
- Because file version information can be misleading, particularly after a file is patched, new
  FileVersionRaw and ProductVersionRaw script properties are available for FileInfo objects. For
  example, you can run the following command to display the values of these properties for
  powershell.exe, where $pid contains the process ID for a running session of Windows PowerShell:
  `Get-Process -Id $pid -FileVersionInfo | Format-List *version* -Force`
- New cmdlets Enter-PSHostProcess and Exit-PSHostProcess let you debug Windows PowerShell scripts in
  processes separate from the current process that is running in the Windows PowerShell console. Run
  Enter-PSHostProcess to enter, or attach to, a specific process ID, and then run Get-Runspace to
  return the active runspaces within the process. Run Exit-PSHostProcess to detach from the process
  when you are finished debugging the script within the process.
- A new Wait-Debugger cmdlet has been added to the
  [Microsoft.PowerShell.Utility](/powershell/module/Microsoft.PowerShell.Utility) module. You
  can run Wait-Debugger to stop a script in the debugger before running the next statement in the
  script.
- The Windows PowerShell Workflow debugger now supports command or tab completion, and you can debug
  nested workflow functions. You can now press **Ctrl+Break** to enter the debugger in a running
  script, in both local and remote sessions, and in a workflow script.
- A Debug-Job cmdlet has been added to the
  [Microsoft.PowerShell.Core](/powershell/module/Microsoft.PowerShell.Core) module to debug
  running job scripts for Windows PowerShell Workflow, background, and jobs running in remote
  sessions.
- A new state, AtBreakpoint, has been added for Windows PowerShell jobs. The AtBreakpoint state
  applies when a job is running a script that includes set breakpoints, and the script has hit a
  breakpoint. When a job is stopped at a debug breakpoint, you must debug the job by running the
  Debug-Job cmdlet.
- Windows PowerShell 5.0 implements support for multiple versions of a single Windows PowerShell
  module in the same folder in $PSModulePath. A RequiredVersion property has been added to the
  ModuleSpecification class to help you get the desired version of a module; this property is
  mutually exclusive with the ModuleVersion property. RequiredVersion is now supported as part of
  the value of the FullyQualifiedName parameter of the Get-Module, Import-Module, and Remove-Module
  cmdlets.
- You can now perform module version validation by running the Test-ModuleManifest cmdlet.
- Results of the Get-Command cmdlet now display a Version column; a new Version property has been
  added to the CommandInfo class. Get-Command shows commands from multiple versions of the same
  module. The Version property is also part of derived classes of CmdletInfo: CmdletInfo and
  ApplicationInfo.
- Get-Command has a new parameter, -ShowCommandInfo, that returns ShowCommand information as
  PSObjects. This is especially useful functionality for when Show-Command is run in Windows
  PowerShell ISE by using Windows PowerShell remoting. The -ShowCommandInfo parameter replaces the
  existing Get-SerializedCommand function in the Microsoft.PowerShell.Utility module, but the
  Get-SerializedCommand script is still available to support downlevel scripting.
- A new Get-ItemPropertyValue cmdlet lets you get the value of a property without using dot
  notation. For example, in older releases of Windows PowerShell, you can run the following command
  to get the value of the Application Base property of the PowerShellEngine registry key:
  **(Get-ItemProperty -Path HKLM:\\SOFTWARE\\Microsoft\\PowerShell\\3\\PowerShellEngine -Name
  ApplicationBase).ApplicationBase**. Starting in Windows PowerShell 5.0, you can run
  **Get-ItemPropertyValue -Path HKLM:\\SOFTWARE\\Microsoft\\PowerShell\\3\\PowerShellEngine -Name
  ApplicationBase**.
- The Windows PowerShell console now uses syntax coloring, just as in Windows PowerShell ISE.
- A new NetworkSwitch module contains cmdlets that enable you to apply switch, virtual LAN (VLAN),
  and basic Layer 2 network switch port configuration to Windows Server 2012 R2 logo-certified
  network switches.
- The FullyQualifiedName parameter has been added to Import-Module and Remove-Module cmdlets, to
  support storing multiple versions of a single module.
- Save-Help, Update-Help, Import-PSSession, Export-PSSession, and Get-Command have a new parameter,
  FullyQualifiedModule, of type ModuleSpecification. Add this parameter to specify a module by its
  fully qualified name.
- The value of **$PSVersionTable.PSVersion** has been updated to 5.0.
- WMF 5.0 (PowerShell 5.0) includes the **Pester** module. Pester is a unit testing framework for
  PowerShell. It provides a few simple-to-use keywords that let you create tests for your scripts.

### New features in Windows PowerShell Desired State Configuration

- Windows PowerShell language enhancements let you define Windows PowerShell Desired State
  Configuration (DSC) resources by using classes. Import-DscResource is now a true dynamic keyword;
  Windows PowerShell parses the specified module's root module, searching for classes that contain
  the DscResource attribute. You can now use classes to define DSC resources, in which neither a MOF
  file nor a DSCResource subfolder in the module folder is required. A Windows PowerShell module
  file can contain multiple DSC resource classes.
- A new parameter, ThrottleLimit, has been added to the following cmdlets in the
  PSDesiredStateConfiguration module. Add the ThrottleLimit parameter to specify the number of
  target computers or devices on which you want the command to work at the same time.
  - Get-DscConfiguration
  - Get-DscConfigurationStatus
  - Get-DscLocalConfigurationManager
  - Restore-DscConfiguration
  - Test-DscConfiguration
  - Compare-DscConfiguration
  - Publish-DscConfiguration
  - Set-DscLocalConfigurationManager
  - Start-DscConfiguration
  - Update-DscConfiguration
- With centralized DSC error reporting, rich error information is not only logged in the event log,
  but it can be sent to a central location for later analysis. You can use this central location to
  store DSC configuration errors that have occurred for any server in their environment. After the
  report server is defined in the meta-configuration, all errors are sent to the report server, and
  then stored in a database. You can set up this functionality regardless of whether or not a target
  node is configured to pull configurations from a pull server.
- Improvements to Windows PowerShell ISE ease DSC resource authoring. You can now do the following.
  - List all DSC resources within a **configuration** or **node** block by entering **Ctrl+Space**
    on a blank line within the block.
  - Automatic completion on resource properties of the **enumeration** type.
  - Automatic completion on the **DependsOn** property of DSC resources, based on other resource
    instances in the configuration.
  - Improved tab completion of resource property values.
- A user can now run a resource under a specified set of credentials by adding the
  **PSDscRunAsCredential** attribute to a Node block. For example, PSDscRunAsCredential =
  Get-Credential Contoso\\DscUser. This functionality is useful for creating configurations that run
  Windows Installer and executable installers, access the per-user registry hive, or perform other
  tasks outside the current user context.
- 32-bit (x86-based) support has been added for the **Configuration** keyword.
- Windows PowerShell now includes support for custom help for DSC configurations, defined by adding
  \[CmdletBinding()] to the generated configuration function.
- A new **DscLocalConfigurationManager** attribute designates a configuration block as a
  meta-configuration, which is used to configure the DSC Local Configuration Manager. This attribute
  restricts a configuration to containing only items which configure the DSC Local Configuration
  Manager. During processing, this configuration generates a \*.meta.mof file that is then sent to
  the appropriate target nodes by running the Set-DscLocalConfigurationManager cmdlet.
- Partial configurations are now allowed in Windows PowerShell 5.0. You can deliver configuration
  documents to a node in fragments. For a node to receive multiple fragments of a configuration
  document, the node's Local Configuration Manager must be first set to specify the expected
  fragments
- Cross-computer synchronization is new in DSC in Windows PowerShell 5.0. By using the built-in
  WaitFor\* resources (**WaitForAll**, **WaitForAny**, and **WaitForSome**), you can now specify
  dependencies across computers during configuration runs, without external orchestrations. These
  resources provide node-to-node synchronization by using CIM connections over the WS-Man protocol.
  A configuration can wait for another computer's specific resource state to change.
- Just Enough Administration (JEA), a new delegation security feature, leverages DSC and Windows
  PowerShell constrained runspaces to help secure enterprises from data loss or compromise by
  employees, whether intentional or unintentional. For more information about JEA, including where
  you can download the xJEA DSC resource, see
  [Just Enough Administration](/powershell/scripting/learn/remoting/jea/overview).
- The following new cmdlets have been added to the PSDesiredStateConfiguration module.
  - A new Get-DscConfigurationStatus cmdlet gets high-level information about configuration status
    from a target node. You can obtain the status of the last, or of all configurations.
  - A new Compare-DscConfiguration cmdlet compares a specified configuration with the actual state
    of one or more target nodes.
  - A new Publish-DscConfiguration cmdlet copies a configuration MOF file to a target node, but does
    not apply the configuration. The configuration is applied during the next consistency pass, or
    when you run the Update-DscConfiguration cmdlet.
  - A new Test-DscConfiguration cmdlet lets you verify that a resulting configuration matches the
    desired configuration, returning either True if the configuration matches the desired
    configuration, or False if the actual configuration does not match the desired configuration.
  - A new Update-DscConfiguration cmdlet forces a configuration to be processed. If the Local
    Configuration Manager is in pull mode, the cmdlet gets the configuration from the pull server
    before applying it.

### New features in Windows PowerShell ISE

- You can now edit remote Windows PowerShell scripts and files in a local copy of Windows PowerShell
  ISE, by running Enter-PSSession to start a remote session on the computer that's storing the files
  you want to edit, and then running **PSEdit \<path and file name on the remote computer\>**. This
  feature eases editing Windows PowerShell files that are stored on the Server Core installation
  option of Windows Server, where Windows PowerShell ISE cannot run.
- The Start-Transcript cmdlet is now supported in Windows PowerShell ISE.
- You can now debug remote scripts in Windows PowerShell ISE.
- A new menu command, **Break All** (Ctrl+B), breaks into the debugger for both local and
  remotely-running scripts.

### New features in Windows PowerShell Web Services (Management OData IIS Extension)

- Starting in Windows PowerShell 5.0, you can generate a set of Windows PowerShell cmdlets based on
  the functionality exposed by a given OData endpoint, by running the Export-ODataEndpointProxy
  cmdlet, found in the new [Microsoft.PowerShell.OdataUtils](/powershell/module/microsoft.powershell.odatautils) module.

### Notable bug fixes in Windows PowerShell 5.0

- Windows PowerShell 5.0 includes a new COM implementation, which offers significant performance
  improvements when you are working with COM objects. For a video demonstration of the effect, see
  [Com_Perf_Improvements](https://1drv.ms/1qu3UPZ).
- Significant performance improvements have been made to the first tab completion in a Windows
  PowerShell session, shortening tab completion time by nearly 500 ms.

## New features in Windows PowerShell 4.0

Windows PowerShell 4.0 is backward-compatible. Cmdlets, providers, modules, snap-ins, scripts,
functions, and profiles that were designed for Windows PowerShell 3.0 and Windows PowerShell 2.0
work in Windows PowerShell 4.0 without changes.

Windows PowerShell 4.0 is installed by default on Windows 8.1 and Windows Server 2012 R2. To install
Windows PowerShell 4.0 on Windows 7 with SP1, or Windows Server 2008 R2, download and install
[Windows Management Framework 4.0](https://www.microsoft.com/download/details.aspx?id=40855). Be
sure to read the download details, and meet all system requirements, before you install Windows
Management Framework 4.0.

- [New features in Windows PowerShell](#new-features-in-windows-powershell-1)
- [New features in Windows PowerShell Integrated Scripting Environment (ISE)](#new-features-in-windows-powershell-integrated-scripting-environment-ise)
- [New features in Windows PowerShell Workflow](#new-features-in-windows-powershell-workflow)
- [New features in Windows PowerShell Web Services](#new-features-in-windows-powershell-web-services)
- [New features in Windows PowerShell Web Access](#new-features-in-windows-powershell-web-access)
- [Notable bug fixes in Windows PowerShell 4.0](#notable-bug-fixes-in-windows-powershell-40)

Windows PowerShell 4.0 includes the following new features.

### <a name="new-features-in-windows-powershell-1" />New features in Windows PowerShell

- **Windows PowerShell Desired State Configuration** (DSC) is a new management system in Windows
  PowerShell 4.0 that enables the deployment and management of configuration data for software
  services and the environment in which these services run. For more information about DSC, see
  [Get Started with Windows PowerShell Desired State Configuration](/powershell/scripting/dsc/getting-started/wingettingstarted).
- **Save-Help** now lets you save help for modules that are installed on remote computers. You can
  use Save-Help to download module Help from an Internet-connected client (on which not all of the
  modules for which you want help are necessarily installed), and then copy the saved Help to a
  remote shared folder or a remote computer that does not have Internet access.
- The Windows PowerShell debugger has been enhanced to allow debugging of Windows PowerShell
  workflows, as well as scripts that are running on remote computers. Windows PowerShell workflows
  can now be debugged at the script level from either the Windows PowerShell command line or Windows
  PowerShell ISE. Windows PowerShell scripts, including script workflows, can now be debugged over
  remote sessions. Remote debugging sessions are preserved over Windows PowerShell remote sessions
  that are disconnected and then later reconnected.
- A **RunNow** parameter for **Register-ScheduledJob** and **Set-ScheduledJob** eliminates the need
  to set an immediate start date and time for jobs by using the **Trigger** parameter.
- **Invoke-RestMethod** and **Invoke-WebRequest** now let you set all headers by using the Headers
  parameter. Although this parameter has always existed, it was one of several parameters for the
  web cmdlets that resulted in exceptions or errors.
- **Get-Module** has a new parameter, **FullyQualifiedName**, of the type
  **ModuleSpecification\[]**. The **FullyQualifiedName** parameter of Get-Module now lets you
  specify a module by using the module's name, version, and optionally, its GUID.
- The default execution policy setting on Windows Server 2012 R2 is **RemoteSigned**. On Windows
  8.1, there is no change in default setting.
- Starting in Windows PowerShell 4.0, method invocation by using dynamic method names is supported.
  You can use a variable to store a method name, and then dynamically invoke the method by calling
  the variable.
- Asynchronous workflow jobs are no longer deleted when the time-out period that is specified by the
  **PSElapsedTimeoutSec** workflow common parameter has elapsed.
- A new parameter, **RepeatIndefinitely**, has been added to the **New-JobTrigger** and
  **Set-JobTrigger** cmdlets. This eliminates the necessity of specifying a **TimeSpan.MaxValue**
  value for the **RepetitionDuration** parameter to run a scheduled job repeatedly for an indefinite
  period.
- A **Passthru** parameter has been added to the **Enable-JobTrigger** and **Disable-JobTrigger**
  cmdlets. The Passthru parameter displays any objects that are created or modified by your command.
- The parameter names for specifying a workgroup in the **Add-Computer** and **Remove-Computer**
  cmdlets are now consistent. Both cmdlets now use the parameter **WorkgroupName**.
- A new common parameter, **PipelineVariable**, has been added. PipelineVariable lets you save the
  results of a piped command (or part of a piped command) as a variable that can be passed through
  the remainder of the pipeline.
- Collection filtering by using a method syntax is now supported. This means that you can now filter
  a collection of objects by using simplified syntax, similar to that for Where() or Where-Object,
  formatted as a method call. The following is an example: (Get-Process).where({$_.Name -match
  'powershell'})
- The **Get-Process** cmdlet has a new switch parameter, **IncludeUserName**.
- A new cmdlet, **Get-FileHash**, that returns a file hash in one of several formats for a specified
  file, has been added.
- In Windows PowerShell 4.0, if a module uses the **DefaultCommandPrefix** key in its manifest, or
  if the user imports a module with the **Prefix** parameter, the **ExportedCommands** property of
  the module shows the commands in the module with the prefix. When you run the commands by using
  the module-qualified syntax, ModuleName\\CommandName, the command names must include the prefix.
- The value of **$PSVersionTable.PSVersion** has been updated to 4.0.
- **Where()** operator behavior has changed. `Collection.Where('property -match name')` accepting a
  string expression in the format `"Property -CompareOperator Value"` is no longer supported.
  However, the **Where()** operator accepts string expressions in the format of a scriptblock; this
  is still supported.

### New features in Windows PowerShell Integrated Scripting Environment (ISE)

- Windows PowerShell ISE supports both Windows PowerShell Workflow debugging and remote script
  debugging.
- IntelliSense support has been added for Windows PowerShell Desired State Configuration providers
  and configurations.

### New features in Windows PowerShell Workflow

- Support has been added for a new **PipelineVariable** common parameter in the context of iterative
  pipelines, such as those used by System Center Orchestrator; that is, pipelines that run commands
  simply left-to-right, as opposed to interspersed running by using streaming.
- Parameter binding has been significantly enhanced to work outside of tab completion scenarios,
  such as with commands that do not exist in the current runspace.
- Support for custom container activities has been added to Windows PowerShell Workflow. If an
  activity parameter is of the types **Activity**, **Activity\[]** (or is a generic collection of
  activities) and the user has supplied a script block as an argument, then Windows PowerShell
  Workflow converts the script block to XAML, as with normal Windows PowerShell script-to-workflow
  compilation.
- After a crash, Windows PowerShell Workflow automatically reconnects to managed nodes.
- You can now throttle **Foreach -Parallel** activity statements by using the **ThrottleLimit**
  property.
- The **ErrorAction** common parameter has a new valid value, **Suspend**, that is exclusively for
  workflows.
- A workflow endpoint now automatically closes if there are no active sessions, no in-progress jobs,
  and no pending jobs. This feature conserves resources on the computer that is acting as the
  workflow server, when the automatic closure conditions have been met.

### New features in Windows PowerShell Web Services

- When an error occurs in Windows PowerShell Web Services (PSWS, also called Management OData IIS
  Extension), while a cmdlet is running, more detailed error messages are returned to the caller. In
  addition, error codes follow
  [Windows Azure REST API error code guidelines](/rest/api/storageservices/Common-REST-API-Error-Codes).
- An endpoint can now define the API version, as well as enforce the usage of a specific API
  version. Whenever version mismatches occur between client and server, errors are displayed to both
  the client and the server.
- Management of the dispatch schema has been simplified by automatically generating values for any
  missing fields in the schema. Generation occurs, as a helpful starting point, even if the dispatch
  schema does not exist.
- Type handling in PSWS has been improved to support types that use a different constructor than the
  default constructor, by behaving similarly to the **PSTypeConverter** in Windows PowerShell. This
  lets you use complex types with PSWS.
- PSWS now allows expanding an associated instance while running a query. For larger binary contents
  (such as images, audio, or video), the transfer cost is significant, and it is better to transfer
  binary data without encoding. PSWS uses named resource streams for transferring without encoding.
  The named resource stream is a property of an entity of the **Edm.Stream** type. Each named
  resource stream has a separate URI for GET or UPDATE operations.
- OData actions now provide a mechanism for invoking non-CRUD (Create, Read, Update, and Delete)
  methods on a resource. You can invoke an action by sending an HTTP POST request to the URI that is
  defined for the action. The parameters for the action are defined in the body of the POST request.
- To be consistent with Windows Azure guidelines, all URLs should be simplified. A change included
  in **Key As Segment** allows single keys to be represented as segments. Note that references that
  use multiple key values require comma-separated values in parenthetical notation, as before.
- Before this release of PSWS, the only way to perform Create, Update, or Delete operations was to
  invoke Post, Put, or Delete on a top-level resource. New in this release of PSWS, Contained
  Resource operations let users achieve the same results while reaching the same resource less
  directly, approaching as if these resources were contained.

### New features in Windows PowerShell Web Access

- You can disconnect from and reconnect to existing sessions in the web-based Windows PowerShell Web
  Access console. A **Save** button in the web-based console lets you disconnect from a session
  without deleting it and reconnect to the session another time.
- Default parameters can be displayed on the sign-in page. To display default parameters, configure
  values for all of the settings displayed in the **Optional Connection Settings** area of the
  sign-in page in a file named **web.config**. You can use the **web.config** file to configure all
  optional connection settings except for a second or alternate set of credentials.
- In Windows Server 2012 R2, you can remotely manage authorization rules for Windows PowerShell Web
  Access. The **Add-PswaAuthorizationRule** and **Test-PswaAuthorizationRule** cmdlets now include a
  Credential parameter that enables administrators to manage authorization rules from a remote
  computer or in a Windows PowerShell Web Access session.
- You can now have multiple Windows PowerShell Web Access sessions in a single browser session by
  using a new browser tab for each session. You no longer need to open a new browser session to
  connect to a new session in the web-based Windows PowerShell console.

### Notable bug fixes in Windows PowerShell 4.0

- **Get-Counter** can now return counters that contain an apostrophe character in French editions of
  Windows.
- You can now view the **GetType** method on deserialized objects.
- **#Requires** statements now let users require Administrator access rights, if needed.
- The **Import-Csv** cmdlet now ignores blank lines.
- A problem where Windows PowerShell ISE uses too much memory when you are running an
  **Invoke-WebRequest** command has been fixed.
- **Get-Module** now displays module versions in a **Version** column.
- Remove-Item -Recurse now removes items from subfolders as expected.
- A **UserName** property has been added to **Get-Process** output objects.
- The **Invoke-RestMethod** cmdlet now returns all available results.
- **Add-Member** now takes effect on hashtables, even if the hashtables have not yet been accessed.
- **Select-Object -Expand** no longer fails or generates an exception if the value of the property
  is null or empty.
- **Get-Process** can now be used in a pipeline with other commands that get the **ComputerName**
  property from objects.
- **ConvertTo-Json** and **ConvertFrom-Json** can now accept terms within double quotes, and its
  error messages are now localizable.
- **Get-Job** now returns any completed scheduled jobs, even in new sessions.
- Issues with mounting and unmounting VHDs by using the **FileSystem** provider in Windows
  PowerShell 4.0 have been fixed. Windows PowerShell is now able to detect new drives when they are
  mounted in the same session.
- You no longer need to explicitly load **ScheduledJob** or **Workflow** modules to work with their
  job types.
- Performance improvements have been made to the process of importing workflows that define nested
  workflows; this process is now faster.

## New features in Windows PowerShell 3.0

Windows PowerShell 3.0 includes the following new features.

- [Windows PowerShell Workflow](#windows-powershell-workflow)
- [Windows PowerShell Web Access](#windows-powershell-web-access)
- [New Windows PowerShell ISE Features](#new-windows-powershell-ise-features)
- [Support for Microsoft .NET Framework 4.0](#support-for-microsoft-net-framework-4)
- [Support for Windows Preinstallation Environment](#support-for-windows-preinstallation-environment)
- [Disconnected Sessions](#disconnected-sessions)
- [Robust Session Connectivity](#robust-session-connectivity)
- [Updatable Help System](#updatable-help-system)
- [Enhanced Online Help](#enhanced-online-help)
- [CIM integration](#cim-integration)
- [Session Configuration Files](#session-configuration-files)
- [Scheduled Jobs and Task Scheduler Integration](#scheduled-jobs-and-task-scheduler-integration)
- [Windows PowerShell Language Enhancements](#windows-powershell-language-enhancements)
- [New Core Cmdlets](#new-core-cmdlets)
- [Improvements to Existing Core Cmdlets and Providers](#improvements-to-existing-core-cmdlets-and-providers)
- [Remote module import and discovery](#remote-module-import-and-discovery)
- [Enhanced Tab Completion](#enhanced-tab-completion)
- [Module Auto-Loading](#module-auto-loading)
- [Module Experience Improvements](#module-experience-improvements)
- [Simplified Command Discovery](#simplified-command-discovery)
- [Improved Logging, Diagnostics, and Group Policy Support](#improved-logging-diagnostics-and-group-policy-support)
- [Formatting and Output Improvements](#formatting-and-output-improvements)
- [Enhanced Console Host Experience](#enhanced-console-host-experience)
- [New Cmdlet and Hosting APIs](#new-cmdlet-and-hosting-apis)
- [Performance Improvements](#performance-improvements)
- [RunAs and Shared Host Support](#runas-and-shared-host-support)
- [Special Character Handling Improvements](#special-character-handling-improvements)

### Windows PowerShell Workflow

Windows PowerShell Workflow brings the power of Windows Workflow Foundation to Windows PowerShell.
You can write workflows in XAML or in the Windows PowerShell language and run them just as you would
run a cmdlet. The `Get-Command` cmdlet gets workflow commands and the `Get-Help` cmdlet gets help
for workflows.

Workflows are sequences of multicomputer management activities that are long-running, repeatable,
frequent, parallelizable, interruptible, suspendable, and restartable. Workflows can be resumed from
an intentional or accidental interruption, such as a network outage, a Windows restart, or a power
failure.

Workflows are also portable; they can be exported as or imported from XAML files. You can write
custom session configurations that allow workflow or activities in a workflow to be run by delegated
or subordinate users.

The following are the benefits of Windows PowerShell Workflow

- Automation of sequenced, long-running tasks.
- **Remote monitoring of long-running tasks**. Status and progress of activities are visible at any
  time.
- **Multicomputer management.** Simultaneously run tasks as workflows on hundreds of managed nodes.
  Windows PowerShell Workflow includes a built-in library of common management parameters, such as
  **PSComputerName**, which enable multi-computer management scenarios.
- **Single task execution of complex processes.** You can combine related scripts that implement an
  entire end-to-end scenario into a single workflow.
- **Persistence.**: a workflow is saved (or check-pointed) at specific points defined by its author
  so you can resume the workflow from the last persisted task (or checkpoint), instead of restarting
  the workflow from the beginning.
- **Robustness.** Automated failure recovery. Workflows survive planned and unplanned restarts. You
  can suspend workflow execution and then resume the workflow from the last persistence point.
  Workflow authors can designate specific activities to be re-run in case of failure on one or more
  managed nodes.
- **Ability to disconnect, reconnect, and run in disconnected sessions.** Users can connect and
  disconnect from the workflow server, but the workflow runs continuously. You can log off of the
  client computer or restart the client computer and monitor the workflow execution from another
  computer without interrupting the workflow.
- **Scheduling.** Workflow tasks can be scheduled like any Windows PowerShell cmdlet or script.
- **Workflow and Connection Throttling.** Workflow execution and connections to nodes can be
  throttled, thus enabling scalability and high-availability scenarios.

### Windows PowerShell Web Access

Windows PowerShell Web Access is a Windows Server 2012 feature that lets users run Windows
PowerShell commands and scripts in a web-based console. Devices that use the web-based console do
not require Windows PowerShell, remote management software, or browser plug-in installations. All
that is required is a properly-configured Windows PowerShell Web Access gateway and a client device
browser that supports JavaScript and accepts cookies.

For more information, see [Deploy Windows PowerShell Web Access](/previous-versions/powershell/scripting/components/web-access/install-and-use-windows-powershell-web-access).

### New Windows PowerShell ISE Features

For Windows PowerShell 3.0, Windows PowerShell Integrated Scripting Environment (ISE) has many new
features, including IntelliSense, Show-Command window, a unified Console Pane, snippets,
brace-matching, expand-collapse sections, auto-save, recent items list, rich copy, block copy, and
full support for writing Windows PowerShell script workflows. For more information, see
[about_Windows_PowerShell_ISE](/powershell/module/microsoft.powershell.core/about/about_windows_powershell_ise).

### Support for Microsoft .NET Framework 4

Windows PowerShell is built against the Common Language Runtime 4.0. Cmdlet, script, and workflow
authors can use the new Microsoft .NET Framework 4 classes in Windows PowerShell, with features that
include Application Compatibility and Deployment, Managed Extensibility Framework, Parallel
Computing, Networking, Windows Communication Foundation and Windows Workflow Foundation.

### Support for Windows Preinstallation Environment

Windows PowerShell 3.0 is an optional component of Windows Preinstallation Environment (Windows PE)
4.0 for Windows 8. Windows PE is a minimal operating system that starts a computer that has no
operating system and prepares it for Windows installation. Windows PE can be used to partition and
format hard drives, copy disk images to a computer, and initiate Windows Setup from a network share.
Windows PowerShell 3.0 can be used on Windows PE to manage deployment, diagnostics, and recovery
scenarios.

### Disconnected Sessions

Beginning in Windows PowerShell 3.0, persistent user-managed sessions ("PSSessions") that you create
by using the New-PSSession cmdlet are saved on the remote computer. They are no longer dependent on
the session in which they were created.

You can now disconnect from a session without disrupting the commands that are running in the
session. You can close the session and shut down your computer. Later, you can reconnect to the
session from a different session on the same or on a different computer.

The **ComputerName** parameter of the `Get-PSSession` cmdlet now gets all of the user's sessions
that connect to the computer, even if they were started in a different session on a different
computer. You can connect to the sessions, get the results of commands, start new commands, and then
disconnect from the session.

New cmdlets have been added to support the Disconnected Sessions feature, including
`Disconnect-PSSession`, `Connect-PSSession`, and `Receive-PSSession`, and new parameters have been
added to cmdlets that manage PSSessions, such as the **InDisconnectedSession** parameter of the
`Invoke-Command` cmdlet.

The Disconnected Sessions feature is supported only when the computers at both the originating
("client") and terminating ("server") ends of the connection are running Windows PowerShell 3.0.

### Robust Session Connectivity

Windows PowerShell 3.0 detects unexpected losses of connectivity between the client and server and
attempts to reestablish connectivity and resume execution automatically. If the client-server
connection cannot be reestablished in the allotted time, the user is notified and the session is
disconnected. During the attempt to reconnect, Windows PowerShell provides continuous feedback to
the user.

If the disconnected session was started by using the InvokeCommand, Windows PowerShell creates a job
for the disconnected session to make it easier to reconnect and resume execution.

These features provide a more reliable and recoverable remoting experience and allow users to
perform long-running tasks that require robust sessions, such as workflows.

### Updatable Help System

You can now download updated help files for the cmdlets in your modules. The `Update-Help` cmdlet
identifies the newest help files, downloads them from the Internet, unpacks them, validates them,
and installs them in the correct language-specific directory for the module.

To use the updated help files, just type `Get-Help`. You do not need to restart Windows or Windows
PowerShell. To update help for modules in the $pshome directory, start Windows PowerShell with the
"Run as administrator" option.

To support users who don't have Internet access and users behind firewalls, the new `Save-Help`
cmdlet downloads help files to a file system directory, such as a file share. Users can then use the
`Update-Help` cmdlet to get updated help files from the file share.

You can use the `Update-Help` cmdlet to update help files for all or particular modules in all
supported UI cultures. You can even put an `Update-Help` command in your Windows PowerShell profile.
By default, Windows PowerShell downloads the help files for a module no more than once each day.

Windows 8 and Windows Server 2012 modules do not include help files. To download the latest help
files, type `Update-Help`. For more information, type `Get-Help` (without parameters) or see
[about_Updatable_Help](/powershell/module/microsoft.powershell.core/about/about_Updatable_Help).

When the help files for a cmdlet are not installed on the computer, the `Get-Help` cmdlet now
displays auto-generated help. The auto-generated help includes the command syntax and instructions
for using the `Update-Help` cmdlet to download help files.

Any module author can support Updatable Help for their module. You can include help files in the
module and use Updatable Help to update them or omit the help files and use Updatable Help to
install them. For more information about supporting Updatable Help, see
[Supporting Updatable Help](/powershell/scripting/developer/module/supporting-updatable-help).

### Enhanced Online Help

Windows PowerShell online help is a valuable resource for all users, but it is especially important
to users who do not or cannot install updated help files.

To get online help for any Windows PowerShell cmdlet, type:

```
Get-Help <cmdlet-name> -Online
```

Windows PowerShell opens the online version of the help topic in your default Internet browser.

The **Get-Help -Online** feature in Windows PowerShell 3.0 is now even more powerful because it
works even when help files for the cmdlet are not installed on the computer. The **Get-Help
-Online** feature gets the URI for online help topic from the HelpUri property of cmdlets and
advanced functions.

```
PS C:\>(Get-Command Get-ScheduledJob).HelpUri
https://go.microsoft.com/fwlink/?LinkID=223923
```

Beginning in Windows PowerShell 3.0, authors of C# cmdlets can populate the **HelpUri** property by
creating a **HelpUri** attribute on the cmdlet class. Authors of advanced functions can define a
**HelpUri** property on the **CmdletBinding** attribute. The value of the **HelpUri** property must
begin with "http" or "https".

You can also include a **HelpUri** value in the first related link of an XML-based cmdlet help file
or the .Link directive of comment-based help in a function.

For more information about supporting online help, see
[Supporting Online Help](/powershell/scripting/developer/module/supporting-online-help) in the
Microsoft Docs.

### CIM integration

Windows PowerShell 3.0 includes support for the Common Information Model (CIM), which provides
common definitions of management information for systems, networks, applications, and services,
allowing them the exchange of management information between heterogeneous systems. Support for CIM
in Windows PowerShell 3.0, including the ability to author Windows PowerShell cmdlets based on new
or existing CIM classes, commands based on cmdlet definition XML files, support for CIM .NET
Framework. API, CIM management cmdlets and WMI 2.0 providers.

### Session Configuration Files

Beginning in Windows PowerShell 3.0, you can design a custom session configuration by using a file.
The new session configuration file lets you determine the environment of sessions that use the
session configuration, including which modules, scripts, and format files are loaded into sessions,
which cmdlets and language elements users can use, which modules and scripts they can run, and which
variables they can see.

You can design a session in which users can only run the cmdlets from one particular module, or a
session in which users have full language, access to all modules, and access to scripts that perform
advanced tasks.

In previous versions of Windows PowerShell, control at this level was available only to those who
could write a C# program or a complex start-up script. Now, any member of the Administrators group
on the computer can customize a session configuration by using a configuration file.

To create a session configuration file, use the `New-PSSessionConfigurationFile` cmdlet. To apply
the session configuration file to a session configuration, use the `Register-PSSessionConfiguration`
or `Set-PSSessionConfiguration cmdlets.

For more information, see
[about_Session_Configuration_Files](/powershell/module/microsoft.powershell.core/about/about_session_configuration_files)
and `New-PSSessionConfigurationFile`.

### Scheduled Jobs and Task Scheduler Integration

You can now schedule Windows PowerShell background jobs and manage them in Windows PowerShell and in
Task Scheduler.

Windows PowerShell scheduled jobs are a useful hybrid of Windows PowerShell background jobs and Task
Scheduler tasks.

Like Windows PowerShell background jobs, scheduled jobs run asynchronously in the background.
Instances of scheduled jobs that have completed can be managed by using the job cmdlets, such as
`Start-Job` and `Get-Job`.

Like Task Scheduler tasks, you can run scheduled jobs on a one-time or recurrent schedule, or in
response to an action or event. You can view and manage scheduled jobs in Task Scheduler, enable and
disable them as needed, run them or use them as templates, and set conditions under which the jobs
start.

In addition, scheduled jobs come with a customized set of cmdlets for managing them. The cmdlets let
you create, edit, manage, disable, and re-enable scheduled jobs, create scheduled job triggers and
set scheduled job options.

For more information about scheduled jobs, see [about_Scheduled_Jobs](/powershell/module/psscheduledjob/about/about_scheduled_jobs).

### Windows PowerShell Language Enhancements

Windows PowerShell 3.0 includes many features that are designed to make its language simpler, easier
to use, and to avoid common errors. The improvements include property enumeration, count and length
properties on scalar objects, new redirection operators, the $Using scope modifier, PSItem automatic
variable, flexible script formatting, attributes of variables, simplified attribute arguments,
numeric command names, the Stop-Parsing operator, improved array splatting, new bit operators,
ordered dictionaries, PSCustomObject casting, and improved comment-based help.

### New Core Cmdlets

New cmdlets were added to the Windows PowerShell Core installation, including cmdlets to manage
scheduled jobs, disconnected sessions, CIM integration and the Updatable Help System.

- CimCmdlets
  - Get-CimAssociatedInstance
  - Get-CimClass
  - Get-CimInstance
  - Get-CimSession
  - Invoke-CimMethod
  - New-CimInstance
  - New-CimSession
  - New-CimSessionOption
  - Register-CimIndicationEvent
  - Remove-CimInstance
  - Remove-CimSession
  - Set-CimInstance
- Microsoft.PowerShell.Core
  - Connect-PSSession
  - Disconnect-PSSession
  - New-PSSessionConfigurationFile
  - New-PSTransportOption
  - Receive-PSSession
  - Resume-Job
  - Save-Help
  - Suspend-Job
  - Test-PSSessionConfigurationFile
  - Update-Help
- Microsoft.PowerShell.Diagnostics
  - New-WinEvent
- Microsoft.PowerShell.Management
  - Get-ControlPanelItem
  - Rename-Computer
  - Show-ControlPanelItem
- Microsoft.PowerShell.Utility
  - ConvertFrom-Json
  - ConvertTo-Json
  - Get-TypeData
  - Invoke-RestMethod
  - Invoke-WebRequest
  - Remove-TypeData
  - Show-Command
  - Unblock-File
- PSScheduledJob
  - Add-JobTrigger
  - Disable-JobTrigger
  - Disable-ScheduledJob
  - Enable-JobTrigger
  - Enable-ScheduledJob
  - Get-JobTrigger
  - Get-ScheduledJob
  - Get-ScheduledJobOption
  - New-JobTrigger
  - New-ScheduledJobOption
  - Register-ScheduledJob
  - Set-JobTrigger
  - Set-ScheduledJob
  - Set-ScheduledJobOption
  - Unregister-ScheduledJob
- PSWorkflow
  - New-PSWorkflowExecutionOption
  - New-PSWorkflowSession
- PSWorkflowUtility
  - Invoke-AsWorkflow
- ISE
  - Get-IseSnippet
  - Import-IseSnippet
  - New-IseSnippet

### Improvements to Existing Core Cmdlets and Providers

Windows PowerShell 3.0 includes new features for existing cmdlets including the simplified syntax,
and new parameters for the following cmdlets: Computer cmdlets, CSV cmdlets, Get-ChildItem,
Get-Command, Get-Content, Get-History, Measure-Object, Security cmdlets, Select-Object,
Select-String, Split-Path, Start-Process, Tee-Object, Test-Connection, Add-Member, and WMI cmdlets.

The Windows PowerShell providers were also improved significantly, including Certificate provider
support for managing Secure Socket Layer (SSL) certificates for web hosting, support for credential,
persistent network drives, and alternate data streams in file system drives.

### Remote module import and discovery

Windows PowerShell 3.0 extends module discovery, importing, and implicit remoting capabilities on
remote computers. The Module cmdlets get modules on remote computers and import the modules to the
remote or local computer by using Windows PowerShell remoting. New CIM session support allows you to
use CIM and WMI to manage non-Windows computers by importing commands to the local computer that run
implicitly on the remote computer.

For more information, see the help topics for the `Get-Module` and `Import-Module` cmdlets.

### Enhanced Tab Completion

Tab completion in the Windows PowerShell console now completes the names of cmdlets, parameters,
parameter values, enumerations, .NET Frameworks types, COM objects, hidden directories, and more.
The tab completion feature is completely rewritten based on a new parser and abstract syntax tree to
support more scenarios, including in-memory parsing trees and midline tab completion.

### Module Auto-Loading

The `Get-Command` cmdlet now gets all cmdlets and functions from all modules that are installed on
the computer, even if the module is not imported into the current session.

When you get the cmdlet that you need, you can use it immediately without importing any modules.
Windows PowerShell modules are now imported automatically when you use any cmdlet in the module. You
no longer need to search for the module and import it to use its cmdlets.

Automatic importing of modules is triggered by using the cmdlet in a command, running `Get-Command`
for a cmdlet without wildcards, or running `Get-Help` for a cmdlet without wildcards.

You can enable, disable, and configure automatic importing of modules by using the
**$PSModuleAutoLoadingPreference** preference variable.

For more information, see
[about_Modules](/powershell/module/microsoft.powershell.core/about/about_modules),
[about_Preference_Variables](/powershell/module/microsoft.powershell.core/about/about_Preference_Variables),
and the help topics for the `Get-Command` and `Import-Module` cmdlets.

### Module Experience Improvements

Windows PowerShell 3.0 brings advanced feature support to modules, including the following new
features.

1. Module logging for individual modules (LogPipelineExecutionDetails) and the new "Turn on Module
   Logging" Group Policy setting
2. Extended module objects that expose the values from the module manifest
3. New **ExportedCommands** property of modules, including nested modules, that combines commands of
   all types
4. Improved discovery of available (un-imported) modules, including allowing the **Path** and
   **ListAvailable** parameters in the same command
5. New **DefaultCommandPrefix** key in module manifests that avoids name conflicts without changing
   module code.
6. Improved module requirements, including fully-qualified required modules with version and GUID
   and automatic importing of required modules
7. Quieter, streamlined operation of the `New-ModuleManifest` cmdlet.
8. New **Module** parameter for #Requires
9. Improved `Import-Module` cmdlet with both **MinimumVersion** and **RequiredVersion** parameters.

### Simplified Command Discovery

You no longer need to import all modules to discover the commands available to your session. In
Windows PowerShell 3.0, the `Get-Command` cmdlet gets all commands from all installed modules. And,
if you use a command, the module that exports the command is automatically imported into your
session.

The new `Show-Command` cmdlet is designed especially for beginners. You can search for commands in a
window. You can view all commands or filter by module, import a module by clicking a button, use
text boxes and drop-down lists to construct a valid command, and then copy or run the command
without ever leaving the window.

### Improved Logging, Diagnostics, and Group Policy Support

Windows PowerShell 3.0 improves the logging and tracing support for commands and modules with
support for Event Tracing in Windows (ETW) logs, an editable **LogPipelineExecutionDetails**
property of modules, and the "Turn on Module Logging" Group Policy setting. You can now get
parameter values from log details by displaying the log properties.

### Formatting and Output Improvements

New formatting and output improvements improve the efficiency of all Windows PowerShell users. The
improvements include output redirection for all streams, an enhanced Update-Type cmdlet that adds
types dynamically without Format.ps1xml files, word wrap in output, default formatting properties of
custom objects, the **PSCustomObject** type, improved formatting for WMI objects and heterogeneous
objects, and support for discovering method overloads.

### Enhanced Console Host Experience

The Windows PowerShell console host program has new features in Windows PowerShell 3.0 including
single threaded apartment by default. The new "Run with PowerShell" option in File Explorer lets you
run scripts in a unrestricted session just by right-clicking. New console host launch logic starts
Windows PowerShell faster and new fonts allow you to personalize the familiar console window
experience.

### New Cmdlet and Hosting APIs

The new Cmdlet API and Hosting API include public advanced syntax tree (AST) APIs, and APIs for
pipeline paging, nested pipelines, runspace pools tab completion, Windows RT, the Obsolete cmdlet
attribute, and Verb and Noun properties of the FunctionInfo object.

### Performance Improvements

Significant performance improvements in Windows PowerShell come from the new language parser, which
is built on Dynamic Runtime Language (DLR) in .NET Framework 4., along with runtime script
compilation, engine reliability improvements, and changes to the algorithm of the `Get-ChildItem`
that improve its performance, especially when searching network shares.

### RunAs and Shared Host Support

Windows PowerShell 3.0 includes support for RunAs and Shared Host features.

The *RunAs* feature, designed for Windows PowerShell Workflow, lets users of a session configuration
create sessions that run with the permission of a shared user account. This enables less privileged
users to run particular commands and scripts with administrator permissions, and reduces the need
for adding less senior users to the Administrators group.

The **SharedHost** feature allows multiple users on multiple computers to connect to a workflow
session concurrently and monitor the progress of a workflow. Users can start a workflow on one
computer and then connect to the workflow session on another computer without disconnecting the
session from the original computer. Users must have the same permissions and be using the same
session configuration. For more information, see "Running a Windows PowerShell Workflow" in Getting
Started with Windows PowerShell Workflow.

### Special Character Handling Improvements

To improve the ability of Windows PowerShell 3.0 to interpret and correctly handle special
characters, the **LiteralPath** parameter, which handles special characters in paths, is valid on
almost all cmdlets that have a **Path** parameter, including the new `Update-Help` and `Save-Help`
cmdlets. The parser also includes special logic to improve handling of the backtick character (\`)
and square brackets in file names and paths.

## See Also

- [about_Windows_PowerShell_5.0](/previous-versions/powershell/module/microsoft.powershell.core/about/about_windows_powershell_5.0)
- [Windows PowerShell](/powershell/)

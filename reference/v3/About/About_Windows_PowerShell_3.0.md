---
title: About_Windows_PowerShell_3.0
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6d56fa88-371e-40c9-b2de-64a2a0cd49da
---
# About_Windows_PowerShell_3.0
```  
TOPIC  
    about_Windows_PowerShell_3.0  
  
SHORT DESCRIPTION  
    Describes some of the new features that are included in   
    Windows PowerShell 3.0.  
  
LONG DESCRIPTION  
    Windows PowerShell 3.0 includes several significant features that  
    extend its use, improve its usability, and allow you to control and  
    manage Windows-based environments more easily and comprehensively.  
  
    Windows PowerShell 3.0 is backward-compatible. Cmdlets, providers, modules,  
    snap-ins, scripts, functions, and profiles that were designed for Windows  
    PowerShell 2.0 work in Windows PowerShell 3.0 without changes.  
  
    This topic highlights some of the most prominent features. For a   
    complete list of changes, see the Release Notes.  
  
NEW FEATURES  
    Windows PowerShell 3.0 includes the following new features.  
    -- Disconnected Sessions   
    -- Windows PowerShell Workflow  
    -- Windows PowerShell Web Access  
    -- Scheduled Jobs  
    -- Module Auto-Loading and Cmdlet Discovery Improvements  
    -- Get-ChildItem Attributes and Recursive Searches  
    -- Map Network Drives  
    -- Extend Types Without Types.ps1xml Files  
    -- Simplified Syntax for Where-Object and ForEach-Object  
    -- Updatable Help  
    -- Enhanced Online Help  
    -- Session Configuration Files  
    -- Windows PowerShell Remoting on Public Networks  
    -- Certificate Provider Support for Web Hosting  
    -- Show-Command  
    -- Web Cmdlets  
    -- More features  
  
 Disconnected Sessions  
  
    Beginning in Windows PowerShell 3.0, persistent user-managed sessions  
    ("PSSessions") that you create by using the New-PSSession cmdlet are  
    saved on the remote computer. They are no long dependent on the   
    session in which they were created.  
  
    You can now disconnect from a session without disrupting the commands  
    that are running in the session. You can close the session and shut down  
    your computer. Later, you can reconnect to the session from a different  
    session on the same or on a different computer.  
  
    The ComputerName parameter of the Get-PSSession cmdlet now gets all of the  
    user's sessions that connect to the computer, even if they were started  
    in a different session on a different computer. You can connect to the  
    sessions, get the results of commands, start new commands, and then  
    disconnect from the session.  
  
    New cmdlets have been added to support the Disconnected Sessions feature,  
    including Disconnect-PSSession, Connect-PSSession, and Receive-PSSession,  
    and new parameters have been added to cmdlets that manage PSSessions, such  
    as the InDisconnectedSession parameter of the Invoke-Command cmdlet.  
  
    The Disconnected Sessions feature is supported only when the computers at   
    both the originating ("client") and terminating ("server") ends of the  
    connection are running Windows PowerShell 3.0.  
  
 Windows PowerShell Workflow  
  
    Windows PowerShell Workflow brings the power of Windows Workflow  
    Foundation to Windows PowerShell. You can write workflows in XAML  
    or in the Windows PowerShell language and run them just as you   
    would run a cmdlet. The Get-Command cmdlet gets workflow commands  
    and the Get-Help cmdlet gets help for workflows.  
  
    Workflows are sequences of multicomputer management activities that  
    are long-running, repeatable, frequent, parallelizable, interruptible,  
    suspendable, and restartable. Workflows can be resumed from an intentional  
    or accidental interruption, such as a network outage, a Windows restart,  
    or a power failure.   
  
    Workflows are also portable; they can be exported as or imported from  
    XAML files.   
  
    You can write custom session configurations that allow workflow or   
    activities in a workflow to be run by delegated or subordinate users.  
  
    Benefits of Windows PowerShell Workflow  
  
    -- Automation of sequenced, long-running tasks.   
    -- Remote monitoring of long-running tasks. Status and progress of  
       activities are visible at any time.  
    -- Multicomputer management. Simultaneously run tasks as workflows  
       on hundreds of managed nodes.  Windows PowerShell Workflow includes  
       a built-in library of common management parameters, such as PSComputerName,  
       which enable multi-computer management scenarios.  
    -- Single task execution of complex processes. You can combine  
       related scripts that implement an entire end-to-end scenario  
       into a single workflow.   
    -- Persistence. a workflow is saved (or check-pointed) at specific points  
       defined by its author so you can resume the workflow from the last  
       persisted task (or checkpoint), instead of restarting the workflow  
       from the beginning.  
    -- Robustness. Automated failure recovery. Workflows survive planned  
       and unplanned restarts. You can suspend workflow execution and then  
       resume the workflow from the last persistence point. Workflow authors  
       can designate specific activities to be re-run in case of failure on  
       one or more managed nodes.  
    -- Ability to disconnect, reconnect, and run in disconnected sessions.   
       Users can connect and disconnect from the workflow server, but the  
       workflow runs continuously. You can log off of the client computer  
       or restart the client computer and monitor the workflow execution  
       from another computer without interrupting the workflow.   
    -- Scheduling. Workflow tasks can be scheduled like any Windows PowerShell  
       cmdlet or script.  
    -- Workflow and Connection Throttling. Workflow execution and connections  
       to nodes can be throttled, thus enabling scalability and high-availability  
       scenarios.  
  
 Windows PowerShell Web Access  
  
    Windows PowerShell Web Access is a Windows Server "8" feature that lets users  
    run Windows PowerShell commands and scripts in a web-based console. Devices that  
    use the web-based console do not require Windows PowerShell, remote management  
    software, or browser plug-in installations. All that is required is a properly-configured  
    Windows PowerShell Web Access gateway and a client device browser that supports  
    JavaScript® and accepts cookies.  
  
    For more information, see "Deploy Windows PowerShell Web Access" in the   
    Microsoft TechNet Library at http://go.microsoft.com/fwlink/p/?LinkID=221050.  
  
 Scheduled Jobs  
  
    You can now schedule Windows PowerShell background jobs and manage them  
    in Windows PowerShell and in Task Scheduler.   
  
    Windows PowerShell scheduled jobs are a useful hybrid of Windows PowerShell  
    background jobs and Task Scheduler tasks.  
  
    Like Windows PowerShell background jobs, scheduled jobs run asynchronously  
    in the background. Instances of scheduled jobs that have completed can be managed  
    by using the job cmdlets, such as Start-Job, Get-Job, Stop-Job, Receive-Job,  
    and Remove-Jobs.  
  
    Like Task Scheduler tasks, you can run scheduled jobs on a one-time or recurrent  
    schedule or in response to an action or event. You can view and manage scheduled  
    jobs in Task Scheduler, enable and disable them as needed, run them or use them  
    as templates, and set conditions under which the jobs start.  
  
    In addition, scheduled jobs come with a customized set of cmdlets for managing  
    them. The cmdlets let you create, edit, manage, disable, and re-enable scheduled  
    jobs, create scheduled job triggers and set scheduled job options.  
  
    For more information about scheduled jobs, see about_Scheduled_Jobs  
    (http://go.microsoft.com/fwlink/?LinkID=244816).  
  
 Module Auto-Loading and Cmdlet Discovery Improvements  
  
    The Get-Command cmdlet now gets all cmdlets and functions from all modules  
    that are installed on the computer, even if the module is not imported into  
    the current session.   
  
    When you get the cmdlet that you need, you can use it immediately without  
    importing any modules. Windows PowerShell modules are now imported  
    automatically when you use any cmdlet in the module. You no longer need to  
    search for the module and import it to use its cmdlets.   
  
    Automatic importing of modules is triggered by using the cmdlet in       
    a command, running Get-Command for a cmdlet without wildcards, or  
    running Get-Help for a cmdlet without wildcards.  
  
    You can enable, disable and configure automatic importing of modules     
    by using the $PSModuleAutoLoadingPreference preference variable.  
  
    For more information, see about_Modules   
   (http://go.microsoft.com/fwlink/?LinkID=144311),   
    about_Preference_Variables (http://go.microsoft.com/fwlink/?LinkID=113248),  
    and the help topic for the Get-Command cmdlet.  
  
 Get-ChildItem Attributes and Recursive Searches  
  
    The Get-ChildItem cmdlet ("dir") has new parameters, including File,   
    Directory, Hidden, ReadOnly, and System, that make it easier to   
    search for files with particular attributes. It also has an Attributes  
    parameter that lets you search for complex combinations of attributes.   
  
    The Recurse parameter of Get-ChildItem now searches recursively, even  
    when the item is not a container.   
  
    For example, the following command gets all Windows PowerShell script  
    files on the D: drive of the computer.  
  
        Get-ChildItem D:\*.ps1 -Recurse  
  
    For more information, see the help topic for the Get-ChildItem cmdlet.  
  
 Map Network Drives  
  
    The New-PSDrive cmdlet has a new Persist parameter that creates   
    Windows mapped network drives. Commands that use the Persist parameter  
    are saved on the local computer and are equivalent to using Net Use or  
    File Explorer to create mapped network drives.  
  
    Mapped network drives must have drive-letter names and map to locations  
    on a remote computer.   
  
    For more information, see the help topic for the New-PSDrive cmdlet.  
  
 Extend Types Without Types.ps1xml Files  
    You can now add properties and methods to the object types in Windows  
    PowerShell without using Types.ps1xml files. The Update-TypeData cmdlet  
    has new parameters that add extended types, including note properties,  
    alias properties, script properties, and script methods to types in  
    the current session.  
  
    For example, the following command adds a UTC property to all DateTime  
    objects in the current session.  
  
        Update-TypeData -TypeName System.DateTime -MemberName UTC `  
          -MemberType ScriptProperty -Value {$this.ToUniversalTime()}  
  
    Update-TypeData adds extended types only to the current session, but you  
    can add an Update-TypeData command to your Windows PowerShell profile.  
  
    The extended types experience is also enhanced by the addition of the   
    Get-TypeData and Remove-TypeData cmdlets, which help you manage extended  
    types in your session.  
  
    For more information, see the help topics for the Update-TypeData,   
    Get-TypeData, and Remove-TypeData cmdlets, and about_Types.ps1xml.  
  
 Simplified Syntax for Where-Object and ForEach-Object  
  
    The Where-Object and Foreach-Object cmdlets have been simplified to make them  
    easier to use. Instead of requiring script blocks and symbols, you can now  
    filter objects and run the commands on multiple objects by using commands that  
    are more similar to natural language.  
  
    For example, the following command gets processes that have more than 500  
    handles.  
  
        Get-Process | Where Handles -gt 500  
  
    The following command calls the PadRight method of strings on all input,  
    and uses dashes to pad them to a total length of 10 characters.  
  
        “Hello”, “World” | ForEach-Object PadRight  10 "-"           
  
    For more information, see the help topics for the Where-Object and   
    Foreach-Object cmdlets.  
  
 Updatable Help  
     You can now download updated help files for the cmdlets in your modules.      
     The new Update-Help cmdlet identifies the newest help files, downloads them   
     from the Internet, unpacks them, validates them, and installs them in the correct  
     language-specific directory for the module.   
  
     To use the updated help files, just type "Get-Help". You do not need to   
     restart Windows or Windows PowerShell.   
  
     To update help for modules in the $pshome directory, start Windows PowerShell  
     with the "Run as administrator" option.  
  
     To support users who don't have Internet access and users behind firewalls,  
     the new Save-Help cmdlet downloads help files to a file system directory,   
     such as a file share. Users can then use the Update-Help cmdlet to get  
     updated help files from the file share.   
  
     You can use the Update-Help cmdlet to update help files for all or particular  
     modules in all supported UI cultures. You can even put an Update-Help command  
     in your Windows PowerShell profile. By default, Windows PowerShell downloads  
     the help files for a module no more than once each day.  
  
     Windows 8 and Windows Server "8" modules do not include help files. To  
     download the latest help files, type "Update-Help". For more information, type   
     "Get-Help" (without parameters) or see about_Updatable_Help at   
     (http://go.microsoft.com/fwlink/?LinkID=235801).  
  
     When the help files for a cmdlet are not installed on the computer, the   
     Get-Help cmdlet now displays auto-generated help. The auto-generated help  
     includes the command syntax and instructions for using Update-Help to download  
     help files.  
  
     Any module author can support Updatable Help for their module. You can include  
     help files in the module and use Updatable Help to update them or omit the help  
     files and use Updatable Help to install them. For more information about   
     supporting Updatable Help, see "Supporting Updatable Help" in MSDN at  
     http://go.microsoft.com/FWLink/?LinkID=242129.  
  
 Enhanced Online Help  
     Windows PowerShell online help is a valuable resource for all users, but it is   
     especially important to users who do not or cannot install updated help files.  
  
     To get online help for any Windows PowerShell cmdlet, type:  
  
         Get-Help <cmdlet-name> -Online  
  
     Windows PowerShell opens the online version of the help topic in your default  
     Internet browser.  
  
     The Get-Help -Online feature in Windows PowerShell 3.0 is now even more powerful  
     because it works even when help files for the cmdlet are not installed on the computer.  
  
     The Get-Help -Online feature gets the URI for online help topic from the HelpUri  
     property of cmdlets and advanced functions.   
  
        (Get-Command Get-ScheduledJob).HelpUri  
         http://go.microsoft.com/fwlink/?LinkID=223923  
  
     Beginning in Windows PowerShell 3.0, authors of C# cmdlets can populate the HelpUri  
     property by creating a HelpUri attribute on the cmdlet class. Authors of advanced  
     functions can define a HelpUri property on the CmdletBinding attribute. The value of  
     the HelpUri property must begin with "http" or "https".  
  
     You can also include a HelpUri value in the first related link of an XML-based  
     cmdlet help file or the .Link directive of comment-based help in a function.  
  
     For more information about supporting online help, see "Supporting Online Help" in  
     MSDN at http://go.microsoft.com/fwlink/?LinkId=242132.  
  
 Define Custom Session Configurations with a File  
     Beginning in Windows PowerShell 3.0, you can design a custom session configuration   
     by using a file. The new session configuration file lets you determine the environment  
     of sessions that use the session configuration, including which modules, scripts, and  
     format files are loaded into sessions, which cmdlets and language elements users can  
     use, which modules and scripts they can run, and which variables they can see.  
  
     You can design a session in which users can only run the cmdlets from one particular  
     module, or a session in which users have full language, access to all modules, and access  
     to scripts that perform advanced tasks.  
  
     In previous versions of Windows PowerShell, control at this level was available only  
     to those who could write a C# program or a start-up script. Beginning in Windows  
     PowerShell 3.0, any member of the Administrators group on the computer can customize  
     a session configuration by using a configuration file.  
  
     To create a session configuration file, use the New-PSSessionConfigurationFile cmdlet.  
     To apply the session configuration file to a session configuration, use the   
     Register-PSSessionConfiguration or Set-PSSessionConfiguration cmdlets.  
  
     For more information, see about_Session_Configuration_Files and the help topic for the  
     New-PSSessionConfigurationFile cmdlet.  
  
 Windows PowerShell Remoting on Public Networks  
     The new SkipNetworkProfileCheck parameter of the Enable-PSRemoting and Set-WSManQuickConfig  
     cmdlets lets you enable Windows PowerShell remoting on client versions of Windows on public  
     networks. This configuration was not available in previous versions of Windows PowerShell.  
  
     The SkipNetworkProfileCheck parameter enables creates a firewall rule that allows traffic  
     from computers within the local subnet. This rule is created by default on server versions  
     of Windows. To eliminate the local subnet restriction, use the Set-NetFirewallRule cmdlet  
     in the NetSecurity module.  
  
     For more information, see about_Remote_Requirements and the help topics for the  
     Enable-PSRemoting and Set-WSManQuickConfig cmdlets.  
  
 Certificate Provider Support for Web Hosting  
  
     Beginning in Windows PowerShell 3.0, the Certificate provider enhances its support  
     for managing Secure Socket Layer (SSL) certificates for web hosting. The Certificate  
     provider adds support for cmdlets and new dynamic parameters that create and delete  
     certificate stores in the LocalMachine certificate store location, and find, move,  
     and delete certificates.   
  
     New dynamic parameters, DnsName, EKU, SSLServerAuthentication, and ExpiringInDays have  
     been added to the Get-ChildItem cmdlet in the Cert: drive. Also, a DeleteKey dynamic  
     parameter has been added to Remove-Item in the Cert: drive.  
  
     New script properties, DnsNameList, EnhancedKeyUsageList, and SendAsTrustedIssuer,  
     have been added to the x509Certificate2 object that represents the certificates to make  
     it easy to search and manage the certificates.   
  
     These new features let you search for certificates based on their DNS names and  
     expiration dates, and distinguish client and server authentication certificates by the  
     value of their Enhanced Key Usage (EKU) properties.  
  
     These enhancements are designed to support the new WebHosting certificate store created  
     by IIS. This certificate store is optimized to scale for efficient, automated management  
     of the thousands of certificates that are required for dynamic shared hosting.    
  
     For more information about the Certificate provider, see the help topic for the  
     Certificate provider ("Get-Help Certificate").  
  
 Show-Command  
     The new Show-Command cmdlet lets you compose and run Windows PowerShell commands  
     in a graphic user interface.   
  
     The Show-Command cmdlet displays a window designed for composing commands. It  
     displays all modules and cmdlets in the session. When you select a cmdlet, Show-Command  
     displays tabs for each parameter set and helps you to select values for the parameters.  
  
     You can click Copy at any time to save the current command to the clipboard, and when   
     the command is complete, you can click Run to run it.  
  
     The Show-Command cmdlet runs only on systems that support a graphic user interface.  
     You cannot run Show-Command commands on a remote computer.  
  
     For more information, see the help topic for the Show-Command cmdlet.  
  
 Web Cmdlets  
    Windows PowerShell 3.0 include new cmdlets for searching the web and managing web  
    services.   
  
        Invoke-WebRequest: Sends an HTTP or HTTPS request to a web service and parses the response.  
        Invoke-RestMethod: Sends HTTP and HTTPS requests to RESTful web services. It returns HTML  
                           documents and JSON objects.  
        ConvertFrom-Json:  Converts a JSON-formatted string to a JSON object.  
        ConvertTo-Json:    Converts any object to a JSON-formatted string.  
  
    For more information, see the help topics for these cmdlets.  
  
 New Windows PowerShell ISE Features  
    For Windows PowerShell 3.0, Windows PowerShell Integrated Scripting Environment  
    has many new features, including Intellisense, expand-collapse, a unified Console pane,  
    and saved-text "snippets." For more information, see about_Windows_PowerShell_ISE.  
  
    For more information about Windows PowerShell 3.0, visit the following web  
    sites:  
  
    -- Windows PowerShell Web Site   
       http://go.microsoft.com/fwlink/?LinkID=106031  
  
    -- Windows PowerShell Team Blog:  
       http://go.microsoft.com/fwlink/?LinkId=143696  
  
SEE ALSO  
  about_Modules  
  about_Preference_Variables  
  about_Remote_Disconnect_Reconnect  
  about_Scheduled_Jobs  
  about_Session_Configuration_Files  
  about_Types.ps1xml  
  about_Updatable_Help  
  about_Windows_PowerShell_ISE  
  Certificate Provider  
  Connect-PSSession  
  Disconnect-PSSession  
  Enable-PSRemoting     
  ForEach-Object  
  Get-ChildItem  
  New-PSDrive  
  New-PSSessionConfiguration  
  Save-Help  
  Show-Command  
  Update-Help  
  Update-TypeData  
  Where-Object  
  
KEYWORDS  
    What's New in Windows PowerShell 3.0  
  
```
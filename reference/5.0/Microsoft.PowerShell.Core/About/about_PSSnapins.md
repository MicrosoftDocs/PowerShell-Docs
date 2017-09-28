---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_PSSnapins
---

# About PSSnapins
## about_PSSnapins


## SHORT DESCRIPTION
Describes  Windows PowerShell?snap-ins and shows how to use and manage them.


## LONG DESCRIPTION
A  Windows PowerShell snap-in is a Microsoft .NET Framework assembly that contains  Windows PowerShell providers and\/or cmdlets.  Windows PowerShell includes a set of basic snap-ins, but you can extend the power and value of  Windows PowerShell by adding snap-ins that contain providers and cmdlets that you create or get from others.

When you add a snap-in, the cmdlets and providers that it contains are immediately available for use in the current session, but the change affects only the current session.

To add the snap-in to all future sessions, save it in your  Windows PowerShell profile. You can also use the Export-Console cmdlet to save the snap-in names to a console file and then use it in future sessions. You can even save multiple console files, each with a different set of snap-ins.

NOTE:  Windows PowerShell snap-ins (PSSnapins) are available for use in  Windows PowerShell 3.0 and  Windows PowerShell 2.0. They might be altered or unavailable in subsequent versions. To package  Windows PowerShell cmdlets and providers, use modules. For information about creating modules and converting snap-ins to modules, see "Writing a  Windows PowerShell Module" in MSDN at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=141556.


### FINDING SNAP-INS
To get a list of the  Windows PowerShell snap-ins on your computer, type:


```
get-pssnapin
```


To get the snap-in for each  Windows PowerShell provider, type:


```
get-psprovider | format-list name, pssnapin
```


To get a list of the cmdlets in a  Windows PowerShell snap-in, type:


```
get-command -module <snap-in_name>
```



### INSTALLING A SNAP-IN
The built-in snap-ins are registered in the system and added to the default session when you start  Windows PowerShell. However, you have to register snap-ins that you create or obtain from others and then add the snap-ins to your session.


### REGISTERING A SNAP-IN
A  Windows PowerShell snap-in is a program written in a .NET Framework language that is compiled into a .dll file. To use the providers and cmdlets in a snap-in, you must first register the snap-in (add it to the registry).

Most snap-ins include an installation program (an .exe or .msi file) that registers the .dll file for you. However, if you receive a snap-in as a .dll file, you can register it on your system. For more information, see [How to Register Cmdlets, Providers, and Host Applications](https://go.microsoft.com/fwlink/?LinkID=143619) in the MSDN library.

To get all the registered snap-ins on your system or to verify that a snap-in is registered, type:


```
get-pssnapin -registered
```



### ADDING THE SNAP-IN TO THE CURRENT SESSION
To add a registered snap-in to the current session, use the Add-PsSnapin cmdlet. For example, to add the Microsoft SQL Server snap-in to the session, type:


```
add-pssnapin sql
```


After the command is completed, the providers and cmdlets in the snap-in are available in the session. However, they are available only in the current session unless you save them.


### SAVING THE SNAP-INS
To use a snap-in in future  Windows PowerShell sessions, add the Add-PsSnapin command to your  Windows PowerShell profile. Or, export the snap-in names to a console file.

If you add the Add-PSSnapin command to your profile, it is available in all future  Windows PowerShell sessions. If you export the names of the snap-ins in your session, you can use the export file only when you need the snap-ins.

To add the Add-PsSnapin command to your  Windows PowerShell profile, open your profile, paste or type the command, and then save the profile. For more information, see about_Profiles.

To save the snap-ins from a session in console file (.psc1), use the Export-Console cmdlet. For example, to save the snap-ins in the current session configuration to the NewConsole.psc1 file in the current directory, type:


```
export-console NewConsole
```


For more information, see Export-Console.


### OPENING WINDOWS POWERSHELL WITH A CONSOLE FILE
To use a console file that includes the snap-in, start  Windows PowerShell (PowerShell.exe) from the command prompt in Cmd.exe or in another  Windows PowerShell session. Use the PsConsoleFile parameter to specify the console file that includes the snap-in. For example, the following command starts  Windows PowerShell with the NewConsole.psc1 console file:


```
PowerShell.exe -psconsolefile NewConsole.psc1
```


The providers and cmdlets in the snapin are now available for use in the session.


### REMOVING A SNAP-IN
To remove a  Windows PowerShell snap-in from the current session, use the Remove-PsSnapin cmdlet. For example, to remove the SQL Server snap-in from the current session, type:


```
remove-pssnapin sql
```


This cmdlet removes the snap-in from the session. The snap-in is still loaded, but the providers and cmdlets that it supports are no longer available.


### BUILT-IN COMMANDS
In  Windows PowerShell 2.0 and in older-style host programs in  Windows PowerShell 3.0 and later, the built-in commands that are installed with  Windows PowerShell are packaged in snap-ins that are added automatically to every  Windows PowerShell session.

Beginning in  Windows PowerShell 3.0, in newer-style host programs -- those that start sessions by using the InitialSessionState.CreateDefault2 method -- the built-in commands are packaged in modules. The exception is Microsoft.PowerShell.Core, which always appears as a snap-in. The Core snap-in is included in every session by default. The built-in modules are loaded automatically on first-use.

NOTE: Remote sessions, including sessions that are started by using the New-PSSession cmdlet, are older-style sessions in which the built-in commands are packaged in snap-ins.

The following snap-ins (or modules) are installed with Windows PowerShell.

Microsoft.PowerShell.Core

Contains providers and cmdlets used to manage the basic features of Windows PowerShell. It includes the FileSystem, Registry, Alias, Environment, Function, and Variable providers and basic cmdlets like Get-Help, Get-Command, and Get-History.

Microsoft.PowerShell.Host

Contains cmdlets used by the Windows PowerShell host, such as Start-Transcript and Stop-Transcript.

Microsoft.PowerShell.Management

Contains cmdlets such as Get-Service and Get-ChildItem that are used to manage Windows-based features.

Microsoft.PowerShell.Security

Contains the Certificate provider and cmdlets used to manage Windows PowerShell security, such as Get-Acl, Get-AuthenticodeSignature, and ConvertTo-SecureString.

Microsoft.PowerShell.Utility

Contains cmdlets used to manipulate objects and data, such as Get-Member, Write-Host, and Format-List.

Microsoft.WSMan.Management

Contains the WSMan provider and cmdlets that manage the Windows Remote Management service, such as Connect-WSMan and Enable-WSManCredSSP.


## LOGGING SNAP-IN EVENTS
Beginning in  Windows PowerShell 3.0, you can record execution events for the cmdlets in  Windows PowerShell modules and snap-ins by setting the LogPipelineExecutionDetails property of modules and snap-ins to TRUE. For more information, see about_EventLogs (http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113224).


## SEE ALSO

Add-PsSnapin

Get-PsSnapin

Remove-PsSnapin

Export-Console

Get-Command

[about_Profiles](about_Profiles.md)

[about_Modules](about_Modules.md)


## KEYWORDS:

about_Snapins, about_Snap_ins, about_Snap-ins


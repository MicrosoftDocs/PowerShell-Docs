---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  about_PSSnapins
ms.technology:  powershell
ms.assetid:  de6e3eff-bc35-42f9-b945-e6599bba9fa9
---

# about_PSSnapins
## TOPIC  
 about\_PSSnapins  
  
## SHORT DESCRIPTION  
 Describes [!INCLUDE[wps_1]()] snap\-ins and shows how to use and manage them.  
  
## LONG DESCRIPTION  
 A [!INCLUDE[wps_2]()] snap\-in is a Microsoft .NET Framework assembly that contains [!INCLUDE[wps_2]()] providers and\/or cmdlets. [!INCLUDE[wps_2]()] includes a set of basic snap\-ins, but you can extend the power and value of [!INCLUDE[wps_2]()] by adding snap\-ins that contain providers and cmdlets that you create or get from others.  
  
 When you add a snap\-in, the cmdlets and providers that it contains are immediately available for use in the current session, but the change affects only the current session.  
  
 To add the snap\-in to all future sessions, save it in your [!INCLUDE[wps_2]()] profile. You can also use the Export\-Console cmdlet to save the snap\-in names to a console file and then use it in future sessions. You can even save multiple console files, each with a different set of snap\-ins.  
  
> [!NOTE]  
>  [!INCLUDE[wps_2]()] snap\-ins \(PSSnapins\) are available for use in [!INCLUDE[wps_2]()] 3.0 and [!INCLUDE[wps_2]()] 2.0. They might be altered or unavailable in subsequent versions. To package [!INCLUDE[wps_2]()] cmdlets and providers, use modules. For information about creating modules and converting snap\-ins to modules, see "Writing a [!INCLUDE[wps_2]()] Module" in MSDN at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=141556.  
  
## FINDING SNAP\-INS  
 To get a list of the [!INCLUDE[wps_2]()] snap\-ins on your computer, type:  
  
```  
get-pssnapin  
```  
  
 To get the snap\-in for each [!INCLUDE[wps_2]()] provider, type:  
  
```  
get-psprovider | format-list name, pssnapin  
```  
  
 To get a list of the cmdlets in a [!INCLUDE[wps_2]()] snap\-in, type:  
  
```  
get-command -module <snap-in_name>  
```  
  
## INSTALLING A SNAP\-IN  
 The built\-in snap\-ins are registered in the system and added to the default session when you start Windows PowerShell. However, you have to register snap\-ins that you create or obtain from others and then add the snap\-ins to your session.  
  
## REGISTERING A SNAP\-IN  
 A [!INCLUDE[wps_2]()] snap\-in is a program written in a .NET Framework language that is compiled into a .dll file. To use the providers and cmdlets in a snap\-in, you must first register the snap\-in \(add it to the registry\).  
  
 Most snap\-ins include an installation program \(an .exe or .msi file\) that registers the .dll file for you. However, if you receive a snap\-in as a .dll file, you can register it on your system. For more information, see "How to Register Cmdlets, Providers, and Host Applications" in the MSDN \(Microsoft Developer Network\) library at http:\/\/go.microsoft.com\/fwlink\/?LinkID\=143619.  
  
 To get all the registered snap\-ins on your system or to verify that a snap\-in is registered, type:  
  
```  
get-pssnapin -registered  
```  
  
## ADDING THE SNAP\-IN TO THE CURRENT SESSION  
 To add a registered snap\-in to the current session, use the Add\-PsSnapin cmdlet. For example, to add the Microsoft SQL Server snap\-in to the session, type:  
  
```  
add-pssnapin sql  
```  
  
 After the command is completed, the providers and cmdlets in the snap\-in are available in the session. However, they are available only in the current session unless you save them.  
  
## SAVING THE SNAP\-INS  
 To use a snap\-in in future [!INCLUDE[wps_2]()] sessions, add the Add\-PsSnapin command to your [!INCLUDE[wps_2]()] profile. Or, export the snap\-in names to a console file.  
  
 If you add the Add\-PSSnapin command to your profile, it is available in all future [!INCLUDE[wps_2]()] sessions. If you export the names of the snap\-ins in your session, you can use the export file only when you need the snap\-ins.  
  
 To add the Add\-PsSnapin command to your [!INCLUDE[wps_2]()] profile, open your profile, paste or type the command, and then save the profile. For more information, see about\_Profiles.  
  
 To save the snap\-ins from a session in console file \(.psc1\), use the Export\-Console cmdlet. For example, to save the snap\-ins in the current session configuration to the NewConsole.psc1 file in the current directory, type:  
  
 Insert section body here.  
  
```  
export-console NewConsole  
```  
  
 For more information, see Export\-Console.  
  
## OPENING WINDOWS POWERSHELL WITH A CONSOLE FILE  
 To use a console file that includes the snap\-in, start [!INCLUDE[wps_2]()] \(PowerShell.exe\) from the command prompt in Cmd.exe or in another [!INCLUDE[wps_2]()] session. Use the PsConsoleFile parameter to specify the console file that includes the snap\-in. For example, the following command starts [!INCLUDE[wps_2]()] with the NewConsole.psc1 console file:  
  
```  
PowerShell.exe -psconsolefile NewConsole.psc1  
```  
  
 The providers and cmdlets in the snapin are now available for use in the session.  
  
## REMOVING A SNAP\-IN  
 To remove a [!INCLUDE[wps_2]()] snap\-in from the current session, use the Remove\-PsSnapin cmdlet. For example, to remove the SQL Server snap\-in from the current session, type:Insert section body here.  
  
```  
remove-pssnapin sql  
```  
  
 This cmdlet removes the snap\-in from the session. The snap\-in is still loaded, but the providers and cmdlets that it supports are no longer available.  
  
## BUILT\-IN COMMANDS  
 In [!INCLUDE[wps_2]()] 2.0 and in older\-style host programs in [!INCLUDE[wps_2]()] 3.0 and later, the built\-in commands that are installed with [!INCLUDE[wps_2]()] are packaged in snap\-ins that are added automatically to every [!INCLUDE[wps_2]()] session.  
  
 Beginning in [!INCLUDE[wps_2]()] 3.0, in newer\-style host programs \-\- those that start sessions by using the InitialSessionState.CreateDefault2 method \-\- the built\-in commands are packaged in modules. The exception is Microsoft.PowerShell.Core, which always appears as a snap\-in. The Core snap\-in is included in every session by default. The built\-in modules are loaded automatically on first\-use.  
  
> [!NOTE]  
>  Remote sessions, including sessions that are started by using the New\-PSSession cmdlet, are older\-style sessions in which the built\-in commands are packaged in snap\-ins.  
  
 `Microsoft.PowerShell.Core`  
 Contains providers and cmdlets used to manage the basic features of Windows PowerShell. It includes the FileSystem, Registry, Alias, Environment, Function, and Variable providers and basic cmdlets like Get\-Help, Get\-Command, and Get\-History.  
  
 `Microsoft.PowerShell.Host`  
 Contains cmdlets used by the [!INCLUDE[wps_2]()] host, such as Start\-Transcript and Stop\-Transcript.  
  
 `Microsoft.PowerShell.Management`  
 Contains cmdlets such as Get\-Service and Get\-ChildItem that are used to manage Windows\-based features.  
  
 `Microsoft.PowerShell.Security`  
 Contains the Certificate provider and cmdlets used to manage [!INCLUDE[wps_2]()] security, such as Get\-Acl, Get\-AuthenticodeSignature, and ConvertTo\-SecureString.  
  
 `Microsoft.PowerShell.Utility`  
 Contains cmdlets used to manipulate objects and data, such as Get\-Member, Write\-Host, and Format\-List.  
  
 `Microsoft.WSMan.Management`  
 Contains the WSMan provider and cmdlets that manage the Windows Remote Management service, such as Connect\-WSMan and Enable\-WSManCredSSP.  
  
## LOGGING SNAP\-IN EVENTS  
 Beginning in [!INCLUDE[wps_2]()] 3.0, you can record execution events for the cmdlets in [!INCLUDE[wps_2]()] modules and snap\-ins by setting the LogPipelineExecutionDetails property of modules and snap\-ins to TRUE. For more information, see about\_EventLogs \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=113224\).  
  
## SEE ALSO  
 Add\-PsSnapin  
  
 Get\-PsSnapin  
  
 Remove\-PsSnapin  
  
 Export\-Console  
  
 Get\-Command  
  
 about\_Profiles  
  
 about\_Modules  
  
 KEYWORDS: about\_Snapins, about\_Snap\_ins, about\_Snap\-ins


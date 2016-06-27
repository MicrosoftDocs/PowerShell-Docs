---
title: about_Session_Configuration_Files
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: df4cb045-5bc1-4504-8145-6a26ee8e4a66
---
# about_Session_Configuration_Files
## TOPIC  
 about\_Session\_Configuration\_Files  
  
## SHORT DESCRIPTION  
 Describes session configuration files, which can be used in a session configuration \("endpoint"\) to define the environment of sessions that use the session configuration.  
  
## LONG DESCRIPTION  
 A "session configuration file" is a text file with a .pssc file name extension that contains a hash table of session configuration properties and values. You can use a session configuration file to set the properties of a session configuration and, thereby, to define the environment of [!INCLUDE[wps_1]()] sessions that use the session configuration.  
  
 Session configuration files make it easy to design custom session configurations without complex C\# assemblies or scripts.  
  
 A "session configuration" or "endpoint" is a collection of settings on the local computer that determine which users can create sessions on the computer and which commands they can run in the sessions. For more information about session configurations, see about\_Session\_Configurations \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=145152\).  
  
 Session configurations were introduced in [!INCLUDE[wps_2]()] 2.0. Session configuration files were introduced in [!INCLUDE[wps_2]()] 3.0. You must use [!INCLUDE[wps_2]()] 3.0 to include a session configuration file in a session configuration, but users of [!INCLUDE[wps_2]()] 2.0 and later are affected by all settings in the session configuration.  
  
### CREATING CUSTOM SESSIONS  
 You can customize many features of a [!INCLUDE[wps_2]()] session by specifying session properties in a session configuration. You can customize a session by writing a C\# program that defines a custom runspace, or you can use a session configuration file to define the properties of sessions that are created by using the session configuration.  
  
 You can use a session configuration file to create fully functioning sessions for highly trusted users, locked\-down sessions for minimal access, and sessions designed for particular tasks that contain only the modules required for the task.  
  
 For example, you can determine whether users of the session can use [!INCLUDE[wps_2]()] language elements, such as script blocks, or whether they can only run commands. You can determine which version of [!INCLUDE[wps_2]()] can run in the session, which modules are imported into the session and which cmdlets, functions, and aliases session users can run.  
  
### CREATING A SESSION CONFIGURATION FILE  
 The easiest way to create a session configuration file is by using the New\-PSSessionConfiguration cmdlet. This cmdlet generates a file with the correct syntax and format, and it verifies many of the property values.  
  
 For detailed descriptions of the properties that you can set in a session configuration file, see the help topic for the New\-PSSessionConfigurationFile cmdlet.  
  
 To create a session configuration file with the default values, use the following command:Insert section body here.  
  
```  
PS C:\> New-PSSessionConfigurationFile -Path .\Defaults.pssc  
```  
  
 To open and view the file in your default text editor, use the following command:  
  
```  
PS C:\> Invoke-Item -Path .\Defaults.pssc  
```  
  
 To create a session configuration for sessions in which user can run commands, but not use other elements of the [!INCLUDE[wps_2]()] language, type:  
  
```  
PS C:\> New-PSSessionConfigurationFile -LanguageMode NoLanguage -Path .\NoLanguage.pssc  
```  
  
 To create a session configuration for sessions in which users can use only Get cmdlets, type:  
  
```  
PS C:\> New-PSSessionConfigurationFile -VisibleCmdlets Get-* -Path .\GetSessions.pssc  
```  
  
### USING A SESSION CONFIGURATION FILE  
 You can include a session configuration file when you create a session configuration or add it to the session configuration at later time.  
  
 To include a session configuration file when creating a session configuration, use the Path parameter of the Register\-PSSessionConfiguration cmdlet.  
  
 The following command includes the NoLanguage.pssc file when it creates the NoLanguage session configuration.  
  
```  
PS C:\> Register-PSSessionConfiguration -Name NoLanguage -Path .\NoLanguage.pssc  
```  
  
 To add a session configuration file to an existing session configuration, use the Path parameter of the Set\-PSSessionConfiguration cmdlet. The change affects all new sessions created with the session configuration after the command completes.  
  
 The following command adds the NoLanguage.pssc file to LockedDown session configuration.  
  
```  
PS C:\> Set-PSSessionConfiguration -Name LockedDown -Path .\NoLanguage.pssc  
```  
  
 When users use the LockedDown session configuration to create a session, they can run cmdlets, but they cannot create or use variables, assign values, or use other [!INCLUDE[wps_2]()] language elements.  
  
 For example, the following command uses the New\-PSSession cmdlet to create a session on the local computer that uses the LockedDown session configuration. The command saves the session in the $s variable. The ACL of the session configuration determines who can use it to create a session.  
  
```  
PS C:\> $s = New-PSSession -ComputerName Srv01 -ConfigurationName LockedDown  
```  
  
 The following command uses the Invoke\-Command cmdlet to run commands in the session in the $s variable. The first command, which runs the Get\-UICulture cmdlet, succeeds. However, the second command, which gets the value of the $PSUICulture variable, fails.  
  
```  
PS C:\> Invoke-Command -Session $s {Get-UICulture}  
en-US  
  
PS C:\> Invoke-Command -Session $s {$PSUICulture}  
The syntax is not supported by this runspace. This might be because it is in no-language mode.  
  + CategoryInfo          : ParserError: ($PSUICulture:String) [], ParseException  
  + FullyQualifiedErrorId : ScriptsNotAllowed  
```  
  
### EDITING A SESSION CONFIGURATION FILE  
 To edit the session configuration file that is being used by a session configuration, begin by locating the active copy of the session configuration file.  
  
 When you use a session configuration file in a session configuration, [!INCLUDE[wps_2]()] creates an active copy of the session configuration file and stores it in the $pshome\\SessionConfig directory on the local computer.  
  
 The location of the active copy of a session configuration file is stored in the ConfigFilePath property of the session configuration object.  
  
 The following command gets the location of the session configuration file for the NoLanguage session configuration.  
  
```  
PS C:\> (Get-PSSessionConfiguration -Name NoLanguage).ConfigFilePath  
C:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\NoLanguage_0c115179-ff2a-4f66-a5eb-e56e5692ba22.pssc  
```  
  
 You can edit the file in any text editor. The file is changed as soon as you save it and is effective in new sessions that use the session configuration.  
  
### TESTING A SESSION CONFIGURATION FILE  
 Be sure to test all manually edited session configuration files. If the file syntax and values are not valid, users will not be able to use the session configuration to create a session.  
  
 For example, the following command tests the active session configuration file of the NoLanguage session configuration.  
  
```  
PS C:\> Test-PSSessionConfigurationFile -Path C:\WINDOWS\System32\WindowsPowerShell\v1.0\SessionConfig\NoLanguage_0c115179-ff2a-4f66-a5eb-e56e5692ba22.pssc  
```  
  
 You can use Test\-PSSessionConfigurationFile to test any session configuration file, including the files the New\-PSSessionConfiguration creates. For more information, see the help topic for the Test\-PSSessionConfigurationFile cmdlet.  
  
### REMOVING A SESSION CONFIGURATION FILE  
 You cannot safely remove a session configuration file from a session configuration, but you can replace the file with one that has no effect.Insert section body here.  
  
 To remove a session configuration file, create a session configuration file with the default settings and then use the Set\-PSSessionConfiguration cmdlet to replace the custom session configuration file with a default version.  
  
 For example, the following command creates a Default session configuration file and then replaces the active session configuration file in the NoLanguage session configuration.  
  
```  
PS C:\> New-PSSessionConfigurationFile -Path .\Default.pssc  
PS C:\> Set-PSSessionConfiguration -Name NoLanguage -Path .\Default.pssc  
```  
  
 As a result of this command the NoLanguage session configuration now provides full language support \(the default\) in all sessions created with the session configuration.  
  
### VIEWING THE PROPERTIES OF A SESSION CONFIGURATION  
 The session configuration objects that represent session configurations that use session configuration files have additional properties that make it easy to discover and analyze the session configuration. \(Note that the type name includes a formatted view definition.\)  
  
```  
PS C:\> Get-PSSessionConfiguration NoLanguage | Get-Member  
  
  TypeName: Microsoft.PowerShell.Commands.PSSessionConfigurationCommands#PSSessionConfiguration  
  
Name                          MemberType     Definition  
----                          ----------     ----------  
Equals                        Method         bool Equals(System.Object obj)  
GetHashCode                   Method         int GetHashCode()  
GetType                       Method         type GetType()  
ToString                      Method         string ToString()  
Architecture                  NoteProperty   System.String Architecture=64  
Author                        NoteProperty   System.String Author=juneb  
AutoRestart                   NoteProperty   System.String AutoRestart=fals  
Capability                    NoteProperty   System.Object[] Capability=Sys  
CompanyName                   NoteProperty   System.String CompanyName=Unkn  
configfilepath                NoteProperty   System.String configfilepath=C  
Copyright                     NoteProperty   System.String Copyright=(c) 20  
Enabled                       NoteProperty   System.String Enabled=True  
ExactMatch                    NoteProperty   System.String ExactMatch=true  
ExecutionPolicy               NoteProperty   System.String ExecutionPolicy=  
Filename                      NoteProperty   System.String Filename=%windir  
GUID                          NoteProperty   System.String GUID=0c115179-ff  
ProcessIdleTimeoutSec         NoteProperty   System.String ProcessIdleTimeo  
IdleTimeoutms                 NoteProperty   System.String IdleTimeoutms=72  
lang                          NoteProperty   System.String lang=en-US  
LanguageMode                  NoteProperty   System.String LanguageMode=NoL  
MaxConcurrentCommandsPerShell NoteProperty   System.String MaxConcurrentCom  
MaxConcurrentUsers            NoteProperty   System.String MaxConcurrentUse  
MaxIdleTimeoutms              NoteProperty   System.String MaxIdleTimeoutms  
MaxMemoryPerShellMB           NoteProperty   System.String MaxMemoryPerShel  
MaxProcessesPerShell          NoteProperty   System.String MaxProcessesPerS  
MaxShells                     NoteProperty   System.String MaxShells=300  
MaxShellsPerUser              NoteProperty   System.String MaxShellsPerUser  
Name                          NoteProperty   System.String Name=NoLanguage  
PSVersion                     NoteProperty   System.String PSVersion=3.0  
ResourceUri                   NoteProperty   System.String ResourceUri=http  
RunAsPassword                 NoteProperty   System.String RunAsPassword=  
RunAsUser                     NoteProperty   System.String RunAsUser=  
SchemaVersion                 NoteProperty   System.String SchemaVersion=1.  
SDKVersion                    NoteProperty   System.String SDKVersion=1  
OutputBufferingMode           NoteProperty   System.String OutputBufferingM  
SessionType                   NoteProperty   System.String SessionType=Defa  
UseSharedProcess              NoteProperty   System.String UseSharedProcess  
SupportsOptions               NoteProperty   System.String SupportsOptions=  
xmlns                         NoteProperty   System.String xmlns=http://sch  
XmlRenderingType              NoteProperty   System.String XmlRenderingType  
Permission                    ScriptProperty System.Object Permission {get=  
```  
  
 The new properties make it easier to search session configurations. For example, you can use the ExecutionPolicy property to find an session configuration that supports sessions with the RemoteSigned execution policy. Because the ExecutionPolicy property exists only on sessions that use session configuration files, the command might not get all qualifying session configurations.  
  
```  
PS C:\> Get-PSSessionConfiguration | where {$_.ExecutionPolicy -eq "RemoteSigned"}  
```  
  
 The following command gets session configurations in which the RunAsUser is the Exchange administrator.  
  
```  
PS C:\>  Get-PSSessionConfiguration | where {$_.RunAsUser -eq "Exchange01\Admin01"}  
```  
  
## NOTES  
 An Empty session type is designed for you to create custom sessions with selected commands. If you do not add modules, functions, or scripts to an empty session, the session is limited to expressions and might not be usable.  
  
## SEE ALSO  
 about\_Session\_Configurations  
  
 New\-PSSession  
  
 Disable\-PSSessionConfiguration  
  
 Enable\-PSSessionConfiguration  
  
 Get\-PSSessionConfiguration  
  
 New\-PSSessionConfigurationFile  
  
 Register\-PSSessionConfiguration  
  
 Set\-PSSessionConfiguration  
  
 Test\-PSSessionConfigurationFile  
  
 Unregister\-PSSessionConfiguration
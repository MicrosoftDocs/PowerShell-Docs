---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/p/?linkid=289570
external help file:  System.Management.Automation.dll-Help.xml
title:  Add-PSSnapin
---

# Add-PSSnapin

## SYNOPSIS
Adds one or more Windows PowerShell snap-ins to the current session.

## SYNTAX

```
Add-PSSnapin [-Name] <String[]> [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
The Add-PSSnapin cmdlet adds registered Windows PowerShell snap-ins to the current session. After the snap-ins are added, you can use the cmdlets and providers that the snap-ins support in the current session.

To add the snap-in to all future Windows PowerShell sessions, add an Add-PSSnapin command to your Windows PowerShell profile.
For more information, see about_Profiles.

Beginning in Windows PowerShell 3.0, the core commands that are included in Windows PowerShell are packaged in modules.
The exception is **Microsoft.PowerShell.Core**, which is a snap-in (PSSnapin).
By default, only the **Microsoft.PowerShell.Core** snap-in is added to the session.
Modules are imported automatically on first use and you can use the Import-Module cmdlet to import them.

## EXAMPLES

### Example 1
```
PS C:\> add-PSSnapIn Microsoft.Exchange, Microsoft.Windows.AD
```

This command adds the Microsoft Exchange and Active Directory snap-ins to the current session.

### Example 2
```
PS C:\> get-pssnapin -registered | add-pssnapin -passthru
```

This command adds all of the registered Windows PowerShell snap-ins to the session.
It uses the Get-PSSnapin cmdlet with the Registered parameter to get objects representing each of the registered snap-ins.
The pipeline operator (|) passes the result to Add-PSSnapin, which adds them to the session.
The PassThru parameter returns objects that represent each of the added snap-ins.

### Example 3
```
The first command gets snap-ins that have been added to the current session, including the snap-ins that are installed with Windows PowerShell. In this example, ManagementFeatures is not returned. This indicates that it has not been added to the session.
PS C:\> get-pssnapin

The second command gets snap-ins that have been registered on your system (including those that have already been added to the session). It does not include the snap-ins that are installed with Windows PowerShell.In this case, the command does not return any snap-ins. This indicates that the ManagementFeatures snapin has not been registered on the system.
PS C:\> get-pssnapin -registered

The third command creates an alias, "installutil", for the path to the InstallUtil tool in .NET Framework.
PS C:\> set-alias installutil $env:windir\Microsoft.NET\Framework\v2.0.50727\installutil.exe

The fourth command uses the InstallUtil tool to register the snap-in. The command specifies the path to ManagementCmdlets.dll, the file name or "module name" of the snap-in.
PS C:\> installutil C:\Dev\Management\ManagementCmdlets.dll

The fifth command is the same as the second command. This time, you use it to verify that the ManagementCmdlets snap-in is registered.
PS C:\> get-pssnapin -registered

The sixth command uses the Add-PSSnapin cmdlet to add the ManagementFeatures snap-in to the session. It specifies the name of the snap-in, ManagementFeatures, not the file name.
PS C:\> add-pssnapin ManagementFeatures

To verify that the snap-in is added to the session, the seventh command uses the Module parameter of the Get-Command cmdlet. It displays the items that were added to the session by a snap-in or module.
PS C:\> get-command -module ManagementFeatures

You can also use the PSSnapin property of the object that the Get-Command cmdlet returns to find the snap-in or module in which a cmdlet originated. The eighth command uses dot notation to find the value of the PSSnapin property of the Set-Alias cmdlet.
PS C:\> (get-command set-alias).pssnapin
```

This example demonstrates the process of registering a snap-in on your system and then adding it to your session.
It uses ManagementFeatures, a fictitious snap-in implemented in a file called ManagementCmdlets.dll.

## PARAMETERS

### -Name
Specifies the name of the snap-in.
(This is the Name, not the AssemblyName or ModuleName.) Wildcards are permitted.

To find the names of the registered snap-ins on your system, type: "get-pssnapin -registered".

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru
Returns an object representing each added snap-in.
By default, this cmdlet does not generate any output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
You cannot pipe objects to Add-PSSnapin.

## OUTPUTS

### None or System.Management.Automation.PSSnapInInfo
When you use the PassThru parameter, Add-PSSnapin returns a PSSnapInInfo object that represents the snap-in.
Otherwise, this cmdlet does not generate any output.

## NOTES
* Beginning in Windows PowerShell 3.0, the core commands that are installed with Windows PowerShell are packaged in modules. In Windows PowerShell 2.0, and in host programs that create older-style sessions in later versions of Windows PowerShell, the core commands are packaged in snap-ins ("PSSnapins"). The exception is **Microsoft.PowerShell.Core**, which is always a snap-in. Also, remote sessions, such as those started by the New-PSSession cmdlet, are older-style sessions that include core snap-ins.

  For information about the **CreateDefault2** method that creates newer-style sessions with core modules, see [CreateDefault2 Method](https://msdn.microsoft.com/library/system.management.automation.runspaces.initialsessionstate.createdefault2) in the MSDN library.

* For more information about snap-ins, see [about_PSSnapins](About/about_PSSnapins.md) and [How to Create a Windows PowerShell Snap-in](https://go.microsoft.com/fwlink/?LinkId=144762) in the MSDN library.
* Add-PSSnapin adds the snap-in only to the current session. To add the snap-in to all Windows PowerShell sessions, add it to your Windows PowerShell profile. For more information, see about_Profiles.
* You can add any snap-in that has been registered by using the Microsoft .NET Framework install utility. For more information, see [How to Register Cmdlets, Providers, and Host Applications](https://go.microsoft.com/fwlink/?LinkID=143619) in the MSDN library.
* To get a list of snap-ins that are registered on your computer, type get-pssnapin -registered.
* Before adding a snap-in, Add-PSSnapin checks the version of the snap-in to verify that it is compatible with the current version of Windows PowerShell. If the snap-in fails the version check, Windows PowerShell reports an error.

## RELATED LINKS

[Get-PSSnapin](Get-PSSnapin.md)

[Remove-PSSnapin](Remove-PSSnapin.md)

[about_Profiles](About/about_profiles.md)

[about_PSSnapins](About/about_PSSnapins.md)


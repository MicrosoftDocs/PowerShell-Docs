---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Get PSSnapin
ms.technology:  powershell
external help file:  PSITPro3_Core.xml
online version:  http://go.microsoft.com/fwlink/?LinkID=113330
schema:  2.0.0
---


# Get-PSSnapin
## SYNOPSIS
Gets the Windows PowerShell snap-ins on the computer.
## SYNTAX

```
Get-PSSnapin [[-Name] <String[]>] [-Registered] [<CommonParameters>]
```

## DESCRIPTION
The Get-PSSnapin cmdlet gets the Windows PowerShell snap-ins that have been added to the current session or that have been registered on the system.
The snap-ins are listed in the order in which they are detected.

Get-PSSnapin gets only registered snap-ins.
To register a Windows PowerShell snap-in, use the InstallUtil tool included with the Microsoft .NET Framework 2.0.
For more information, see "How to Register Cmdlets, Providers, and Host Applications" in the MSDN (Microsoft Developer Network) library at http://go.microsoft.com/fwlink/?LinkId=143619.

Beginning in Windows PowerShell 3.0, the core commands that are included in Windows PowerShell are packaged in modules.
The exception is Microsoft.PowerShell.Core, which is a snap-in (PSSnapin).
Only the Microsoft.PowerShell.Core snap-in is added to the session by default.
Modules are imported automatically on first use and you can use the Import-Module cmdlet to import them.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>get-PSSnapIn
```

This command gets the Windows PowerShell snap-ins that are currently loaded in the session.
This includes the snap-ins that are installed with Windows PowerShell and those that have been added to the session.
### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>get-PSSnapIn -registered
```

This command gets the Windows PowerShell snap-ins that have been registered on the computer, including those that have already been added to the session.
The output does not include snap-ins that are installed with Windows PowerShell or Windows PowerShell snap-in dynamic-link libraries (DLLs) that have not yet been registered on the system.
### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>get-PSSnapIn smp*
```

This command gets the Windows PowerShell snap-ins in the current session that have names that begin with "smp".
## PARAMETERS

### -Name
Gets only the specified Windows PowerShell snap-ins.
Enter the names of one or more Windows PowerShell snap-ins.
Wildcards are permitted.

The parameter name ("Name") is optional.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: 
Accept pipeline input: False
Accept wildcard characters: True
```

### -Registered
Gets the Windows PowerShell snap-ins that have been registered on the system (even if they have not yet been added to the session).

The snap-ins that are installed with Windows PowerShell do not appear in this list.

Without this parameter, Get-PSSnapin gets the Windows PowerShell snap-ins that have been added to the session.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### None
You cannot pipe input to Get-PSSnapin.
## OUTPUTS

### System.Management.Automation.PSSnapInInfo
Get-PSSnapin returns an object for each snap-in that it gets.
## NOTES
* Beginning in Windows PowerShell 3.0, the core commands that are installed with Windows PowerShell are packaged in modules. In Windows PowerShell 2.0, and in host programs that create older-style sessions in later versions of Windows PowerShell, the core commands are packaged in snap-ins ("PSSnapins"). The exception is Microsoft.PowerShell.Core, which is always a snap-in. Also, remote sessions, such as those started by the New-PSSession cmdlet, are older-style sessions that include core snap-ins.

  For information about the CreateDefault2 method that creates newer-style sessions with core modules, see "CreateDefault2 Method" in MSDN at http://msdn.microsoft.com/library/windows/desktop/system.management.automation.runspaces.initialsessionstate.createdefault2(v=VS.85).aspxhttp://msdn.microsoft.com/library/windows/desktop/system.management.automation.runspaces.initialsessionstate.createdefault2(v=VS.85).aspx.
## RELATED LINKS

[Add-PSSnapin](Add-PSSnapin.md)

[Remove-PSSnapin](Remove-PSSnapin.md)


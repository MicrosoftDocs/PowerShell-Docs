---
external help file: PSITPro5_Core.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=289590
schema: 2.0.0
---

# Get-PSSnapin
## SYNOPSIS
Gets the Windows PowerShell snap-ins on the computer.

## SYNTAX

```
Get-PSSnapin [[-Name] <String[]>] [-Registered]
```

## DESCRIPTION
The Get-PSSnapin cmdlet gets the Windows PowerShell snap-ins that have been added to the current session or that have been registered on the system.
This cmdlet lists the snap-ins in the order in which they are detected.

Get-PSSnapin gets only registered snap-ins.
To register a Windows PowerShell snap-in, use the InstallUtil tool included with the Microsoft .NET Framework 2.0.
For more information, see How to Register Cmdlets, Providers, and Host Applicationshttp://go.microsoft.com/fwlink/?LinkId=143619 (http://go.microsoft.com/fwlink/?LinkId=143619) in the Microsoft Developer Network (MSDN) library.

Starting in Windows PowerShell 3.0, the core commands that are included in Windows PowerShell are packaged in modules.
The exception is Microsoft.PowerShell.Core, which is a snap-in (PSSnapin).
By default, only the Microsoft.PowerShell.Core snap-in is added to the session.
Modules are imported automatically on first use and you can use the Import-Module cmdlet to import them.

## EXAMPLES

### Example 1: Get snap-ins that are currently loaded
```
PS C:\>Get-PSSnapIn
```

This command gets the Windows PowerShell snap-ins that are currently loaded in the session.
This includes the snap-ins that are installed with Windows PowerShell and those that have been added to the session.

### Example 2: Get snap-ins that have been registered
```
PS C:\>get-PSSnapIn -Registered
```

This command gets the Windows PowerShell snap-ins that have been registered on the computer, including those that have already been added to the session.
The output does not include snap-ins that are installed with Windows PowerShell or Windows PowerShell snap-in dynamic-link libraries (DLLs) that have not yet been registered on the system.

### Example 3: Get current snap-ins that match a string
```
PS C:\>Get-PSSnapIn -Name smp*
```

This command gets the Windows PowerShell snap-ins in the current session that have names that begin with smp.

## PARAMETERS

### -Name
Specifies an array of snap-in names.
This cmdlet gets only the specified Windows PowerShell snap-ins.
Wildcard characters are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Registered
Indicates that this cmdlet gets the Windows PowerShell snap-ins that have been registered on the system even if they have not yet been added to the session.

The snap-ins that are installed with Windows PowerShell do not appear in this list.

Without this parameter, Get-PSSnapin gets the Windows PowerShell snap-ins that have been added to the session.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
You cannot pipe input to this cmdlet.

## OUTPUTS

### System.Management.Automation.PSSnapInInfo
Get-PSSnapin returns an object for each snap-in that it gets.

## NOTES
Starting in Windows PowerShell 3.0, the core commands that are installed with Windows PowerShell are packaged in modules.
In Windows PowerShell 2.0, and in host programs that create older-style sessions in later versions of Windows PowerShell, the core commands are packaged in snap-ins (PSSnapin).
The exception is Microsoft.PowerShell.Core, which is always a snap-in.
Also, remote sessions, such as those started by the New-PSSession cmdlet, are older-style sessions that include core snap-ins.

For information about the CreateDefault2 method that creates newer-style sessions with core modules, see CreateDefault2 Methodhttp://msdn.microsoft.com/en-us/library/windows/desktop/system.management.automation.runspaces.initialsessionstate.createdefault2(v=VS.85).aspx (http://msdn.microsoft.com/en-us/library/windows/desktop/system.management.automation.runspaces.initialsessionstate.createdefault2(v=VS.85).aspx) in the MSDN library.

## RELATED LINKS

[Add-PSSnapin](4125e0dc-d3c1-494f-87e1-4918df7d0f84)

[Remove-PSSnapin](4f10ad2d-8da1-49b7-ad20-7bbc254042f2)


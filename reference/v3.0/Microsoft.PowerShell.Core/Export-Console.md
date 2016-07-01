---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Export Console
ms.technology:  powershell
external help file:  PSITPro3_Core.xml
online version:  http://go.microsoft.com/fwlink/?LinkID=113298
schema:  2.0.0
---


# Export-Console
## SYNOPSIS
Exports the names of snap-ins in the current session to a console file.
## SYNTAX

```
Export-Console [[-Path] <String>] [-Force] [-NoClobber] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Export-Console cmdlet exports the names of the Windows PowerShell snap-ins in the current session to a Windows PowerShell console file (.psc1).
You can use this cmdlet to save the snap-ins for use in future sessions.

To add the snap-ins in the .psc1 console file to a session, start Windows PowerShell (Powershell.exe) at the command line by using Cmd.exe or another Windows PowerShell session, and then use the PSConsoleFile parameter of Powershell.exe to specify the console file.

For more information about Windows PowerShell snap-ins, see about_PSSnapins.
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>export-console -path $pshome\Consoles\ConsoleS1.psc1
```

This command exports the names of Windows PowerShell snap-ins in the current session to the ConsoleS1.psc1 file in the Consoles subdirectory of the Windows PowerShell installation directory, $pshome.
### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>export-console
```

This command exports the names of Windows PowerShell snap-ins from current session to the Windows PowerShell console file that was most recently used in the current session.
It overwrites the previous file contents.

If you have not exported a console file during the current session, you are prompted for permission to continue and then prompted for a file name.
### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>add-pssnapin NewPSSnapin
PS C:\>export-console -path NewPSSnapinConsole.psc1
PS C:\>powershell.exe -PsConsoleFile NewPsSnapinConsole.psc1
```

These commands add the NewPSSnapin Windows PowerShell snap-in to the current session, export the names of Windows PowerShell snap-ins in the current session to a console file, and then start a Windows PowerShell session with the console file.

The first command uses the Add-PSSnapin cmdlet to add the NewPSSnapin snap-in to the current session.
You can only add Windows PowerShell snap-ins that are registered on your system.

The second command exports the Windows PowerShell snap-in names to the NewPSSnapinConsole.psc1 file.

The third command starts Windows PowerShell with the NewPSSnapinConsole.psc1 file.
Because the console file includes the Windows PowerShell snap-in name, the cmdlets and providers in the snap-in are available in the current session.
### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\>export-console -path Console01
PS C:\>notepad console01.psc1
<?xml version="1.0" encoding="utf-8"?>
<PSConsoleFile ConsoleSchemaVersion="1.0">
  <PSVersion>2.0</PSVersion>
  <PSSnapIns>
     <PSSnapIn Name="NewPSSnapin" />
  </PSSnapIns>
</PSConsoleFile>
```

This command exports the names of the Windows PowerShell snap-ins in the current session to the Console01.psc1 file in the current directory.

The second command displays the contents of the Console01.psc1 file in Notepad.
### -------------------------- EXAMPLE 5 --------------------------
```
PS C:\>powershell.exe -PSConsoleFile Console01.psc1
PS C:\>add-pssnapin MySnapin
PS C:\>export-console NewConsole.psc1
PS C:\>$consolefilename
PS C:\>add-pssnapin SnapIn03
PS C:\>export-console
```

This example shows how to use the $ConsoleFileName automatic variable to determine the console file that will be updated if you use Export-Console without a Path parameter value.

The first command uses the PSConsoleFile parameter of PowerShell.exe to open Windows PowerShell with the Console01.psc1 file.

The second command uses the Add-PSSnapin cmdlet to add the MySnapin Windows PowerShell snap-in to the current session.

The third command uses the Export-Console cmdlet to export the names of all the Windows PowerShell snap-ins in the session to the NewConsole.psc1 file.

The fourth command uses the $ConsoleFileName parameter to display the most recently used console file.
The sample output shows that NewConsole.ps1 is the most recently used file.

The fifth command adds SnapIn03 to the current console.

The sixth command uses the ExportConsole cmdlet without a Path parameter.
This command exports the names of all the Windows PowerShell snap-ins in the current session to the most recently used file, NewConsole.psc1.
## PARAMETERS

### -Force
Overwrites the data in a console file without warning, even if the file has the read-only attribute.
The read-only attribute is changed and is not reset when the command completes.

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

### -NoClobber
Will not overwrite (replace the contents of) an existing console file.
By default, if a file exists in the specified path, Export-Console overwrites the file without warning.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: NoOverwrite

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies a path and file name for the console file (*.psc1).
Enter a path (optional) and name.
Wildcards are not permitted.

If you type only a file name, Export-Console creates a file with that name and the ".psc1" file name extension in the current directory.

This parameter is required unless you have opened Windows PowerShell with the PSConsoleFile parameter or exported a console file during the current session.
It is also required when you use the NoClobber parameter to prevent the current console file from being overwritten.

If you omit this parameter, Export-Console overwrites (replaces the content of) the console file that was used most recently in this session.
The path to the most recently used console file is stored in the value of the $ConsoleFileName automatic variable.
For more information, see about_Automatic_Variables.

```yaml
Type: String
Parameter Sets: (All)
Aliases: PSPath

Required: False
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).
## INPUTS

### System.String
You can pipe a path string to Export-Console.
## OUTPUTS

### System.IO.FileInfo
Export-Console creates a file that contains the exported aliases.
## NOTES
* When a console file (.psc1) is used to start the session, the name of the console file is automatically stored in the $ConsoleFileName automatic variable.  The value of $ConsoleFileName is updated when you use the Path parameter of Export-Console to specify a new console file. When no console file is used, $ConsoleFileName has no value ($null).

  To use a Windows PowerShell console file in a new session, use the following syntax to start Windows PowerShell:

  "powershell.exe -PsConsoleFile \<ConsoleFile\>.psc1".

  You can also save Windows PowerShell snap-ins for future sessions by adding an Add-PSSnapin command to your Windows PowerShell profile.
For more information, see about_Profiles.

*
## RELATED LINKS

[Add-PSSnapin](Add-PSSnapin.md)

[Get-PSSnapin](Get-PSSnapin.md)

[Remove-PSSnapin](Remove-PSSnapin.md)


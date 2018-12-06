---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=141556
external help file:  System.Management.Automation.dll-Help.xml
title:  Remove-Module
---
# Remove-Module

## SYNOPSIS

Removes modules from the current session.

## SYNTAX

### name

```
Remove-Module [-Name] <String[]> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ModuleInfo

```
Remove-Module [-ModuleInfo] <PSModuleInfo[]> [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

The **Remove-Module** cmdlet removes the members of a module, such as cmdlets and functions, from the current session.

If the module includes an assembly (.dll), all members that are implemented by the assembly are removed, but the assembly is not unloaded.

This cmdlet does not uninstall the module or delete it from the computer.
It affects only the current Windows PowerShell session.

## EXAMPLES

### Example 1

```
PS> Remove-Module -Name BitsTransfer
```

This command removes the BitsTransfer module from the current session.

### Example 2

```
PS> Get-Module | Remove-Module
```

This command removes all modules from the current session.

### Example 3

```
PS> "FileTransfer", "PSDiagnostics" | Remove-Module -Verbose
VERBOSE: Performing operation "Remove-Module" on Target "filetransfer (Path: 'C:\Windows\system32\WindowsPowerShell\v1.0\Modules\filetransfer\filetransfer.psd1')".
VERBOSE: Performing operation "Remove-Module" on Target "Microsoft.BackgroundIntelligentTransfer.Management (Path: 'C:\Windows\assembly\GAC_MSIL\Microsoft.BackgroundIntelligentTransfer.Management\1.0.0.0__31bf3856ad364e35\Microsoft.BackgroundIntelligentTransfe
r.Management.dll')".
VERBOSE: Performing operation "Remove-Module" on Target "psdiagnostics (Path: 'C:\Windows\system32\WindowsPowerShell\v1.0\Modules\psdiagnostics\psdiagnostics.psd1')".
VERBOSE: Removing imported function 'Start-Trace'.
VERBOSE: Removing imported function 'Stop-Trace'.
VERBOSE: Removing imported function 'Enable-WSManTrace'.
VERBOSE: Removing imported function 'Disable-WSManTrace'.
VERBOSE: Removing imported function 'Enable-PSWSManCombinedTrace'.
VERBOSE: Removing imported function 'Disable-PSWSManCombinedTrace'.
VERBOSE: Removing imported function 'Set-LogProperties'.
VERBOSE: Removing imported function 'Get-LogProperties'.
VERBOSE: Removing imported function 'Enable-PSTrace'.
VERBOSE: Removing imported function 'Disable-PSTrace'.
VERBOSE: Performing operation "Remove-Module" on Target "PSDiagnostics (Path: 'C:\Windows\system32\WindowsPowerShell\v1.0\Modules\psdiagnostics\PSDiagnostics.psm1')".
```

This command removes the BitsTransfer and PSDiagnostics modules from the current session.

The command uses a pipeline operator (|) to send the module names to **Remove-Module**.
It uses the **Verbose** common parameter to get detailed information about the members that are removed.

The Verbose messages show the items that are removed.
The messages differ because the BitsTransfer module includes an assembly that implements its cmdlets and a nested module with its own assembly.
The PSDiagnostics module includes a module script file (.psm1) that exports functions.

### Example 4

```
PS> $a = Get-Module BitsTransfer
PS> Remove-Module -ModuleInfo $a
```

This command uses the ModuleInfo parameter to remove the BitsTransfer module.

## PARAMETERS

### -Force

Removes read-only modules.
By default, **Remove-Module** removes only read-write modules.

The **ReadOnly** and **ReadWrite** values are stored in **AccessMode** property of a module.

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

### -ModuleInfo

Specifies the module objects to remove.
Enter a variable that contains a module object (PSModuleInfo) or a command that gets a module object, such as a Get-Module command.
You can also pipe module objects to **Remove-Module**.

```yaml
Type: PSModuleInfo[]
Parameter Sets: ModuleInfo
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Name

Specifies the names of modules to remove.
Wildcards are permitted.
You can also pipe name strings to **Remove-Module**.

```yaml
Type: String[]
Parameter Sets: name
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: True
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).

## INPUTS

### System.String, System.Management.Automation.PSModuleInfo

You can pipe module names (strings) and module objects to **Remove-Module**.

## OUTPUTS

### None

Remove-Module does not generate any output.

## NOTES

## RELATED LINKS

[Get-Module](Get-Module.md)

[Import-Module](Import-Module.md)

[about_Modules](About/about_Modules.md)

[about_modules](About/about_Modules.md)
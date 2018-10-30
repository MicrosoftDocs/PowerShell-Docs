---
ms.date:  06/09/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=141557
external help file:  System.Management.Automation.dll-Help.xml
title:  Test-ModuleManifest
---

# Test-ModuleManifest
## SYNOPSIS
Verifies that a module manifest file accurately describes the contents of a module.
## SYNTAX

```
Test-ModuleManifest [-Path] <String> [<CommonParameters>]
```

## DESCRIPTION
The Test-ModuleManifest cmdlet verifies that the files that are listed in the module manifest (.psd1) file actually exist in the specified paths.

This cmdlet is designed to help module authors test their manifest files.
Module users can also use this cmdlet in scripts and commands to detect errors before running scripts that depend on the module.

The Test-ModuleManifest cmdlet returns an object that represents the module (the same type of object that Get-Module returns).
If any files are not in the locations specified in the manifest, the cmdlet also generates an error for each missing file.
## EXAMPLES

### Example 1
```
PS C:\> test-ModuleManifest -path $pshome\Modules\TestModule.psd1
```

This command tests the TestModule.psd1 module manifest.
### Example 2
```
PS C:\> "$pshome\Modules\TestModule.psd1" | test-modulemanifest

Test-ModuleManifest : The specified type data file 'C:\Windows\System32\Wi
ndowsPowerShell\v1.0\Modules\TestModule\TestTypes.ps1xml' could not be processed because the file was not found. Please correct the path and try again.
At line:1 char:34
+ "$pshome\Modules\TestModule.psd1" | test-modulemanifest <<<<
+ CategoryInfo          : ResourceUnavailable: (C:\Windows\System32\WindowsPowerShell\v1.0\Modules\TestModule\TestTypes.ps1xml:String) [Test-ModuleManifest], FileNotFoundException
+ FullyQualifiedErrorId : Modules_TypeDataFileNotFound,Microsoft.PowerShell.Commands.TestModuleManifestCommandName

Name              : TestModule
Path              : C:\Windows\system32\WindowsPowerShell\v1.0\Modules\TestModule\TestModule.psd1
Description       :
Guid              : 6f0f1387-cd25-4902-b7b4-22cff6aefa7b
Version           : 1.0
ModuleBase        : C:\Windows\system32\WindowsPowerShell\v1.0\Modules\TestModule
ModuleType        : Manifest
PrivateData       :
AccessMode        : ReadWrite
ExportedAliases   : {}
ExportedCmdlets   : {}
ExportedFunctions : {}
ExportedVariables : {}
NestedModules     : {}
```

This command uses a pipeline operator (|) to send a path string to Test-ModuleManifest.

The command output shows that the test failed, because the TestTypes.ps1xml file, which was listed in the manifest, was not found.
### Example 3
```
PS C:\> function Test-ManifestBool ($path)
{$a = dir $path | test-modulemanifest -erroraction SilentlyContinue; $?}
```

This function is like Test-ModuleManifest, but it returns a Boolean value;  it returns "True" if the manifest passed the test and "False" otherwise.

The function uses the Get-ChildItem cmdlet (alias = dir) to get the module manifest specified by the $path variable.
It uses a pipeline operator (|) to pass the file object to the Test-ModuleManifest cmdlet.

The Test-ModuleManifest command uses the ErrorAction common parameter with a value of SilentlyContinue to suppress the display of any errors that the command generates.
It also saves the PSModuleInfo object that Test-ModuleManifest returns in the $a variable, so the object is not displayed.

Then, in a separate command (the semi-colon \[;\] is the command separator), it displays the value of the $?
automatic variable, which returns "True" if the previous command generated no error and "False" otherwise.

You can use this function in conditional statements, such as those that might precede an Import-Module command or a command that uses the module.
## PARAMETERS

### -Path
Specifies the path to the module manifest file.
Enter a path (optional) and the name of the module manifest file with the .psd1 file name extension.
The default location is the current directory.
Wildcards are supported, but must resolve to a single module manifest file.
This parameter is required.
The parameter name ("Path") is optional.
You can also pipe a path to Test-ModuleManifest.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: True
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](./About/about_CommonParameters.md).
## INPUTS

### System.String
You can pipe the path to a module manifest to Test-ModuleManifest.
## OUTPUTS

### System.Management.Automation.PSModuleInfo
Test-ModuleManifest returns a PSModuleInfo object that represents the module.
It returns this object even if the manifest has errors.
## NOTES

## RELATED LINKS

[Export-ModuleMember](Export-ModuleMember.md)

[Get-Module](Get-Module.md)

[Import-Module](Import-Module.md)

[New-Module](New-Module.md)

[New-ModuleManifest](New-ModuleManifest.md)

[Remove-Module](Remove-Module.md)

[about_Modules](About/about_Modules.md)
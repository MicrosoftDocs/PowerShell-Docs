---
external help file: PSITPro3_Core.xml
schema: 2.0.0
---

# Test-ModuleManifest
## SYNOPSIS
Verifies that a module manifest file accurately describes the contents of a module.

## SYNTAX

```
Test-ModuleManifest [-Path] <String>
```

## DESCRIPTION
The Test-ModuleManifest cmdlet verifies that the files that are listed in the module manifest \(.psd1\) file actually exist in the specified paths.

This cmdlet is designed to help module authors test their manifest files.
Module users can also use this cmdlet in scripts and commands to detect errors before running scripts that depend on the module.

The Test-ModuleManifest cmdlet returns an object that represents the module \(the same type of object that Get-Module returns\).
If any files are not in the locations specified in the manifest, the cmdlet also generates an error for each missing file.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>test-ModuleManifest -path $pshome\Modules\TestModule.psd1
```

This command tests the TestModule.psd1 module manifest.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>"$pshome\Modules\TestModule.psd1" | test-modulemanifest

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

This command uses a pipeline operator \(|\) to send a path string to Test-ModuleManifest.

The command output shows that the test failed, because the TestTypes.ps1xml file, which was listed in the manifest, was not found.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>function Test-ManifestBool ($path)
{$a = dir $path | test-modulemanifest -erroraction SilentlyContinue; $?}
```

This function is like Test-ModuleManifest, but it returns a Boolean value;  it returns "True" if the manifest passed the test and "False" otherwise.

The function uses the Get-ChildItem cmdlet \(alias = dir\) to get the module manifest specified by the $path variable.
It uses a pipeline operator \(|\) to pass the file object to the Test-ModuleManifest cmdlet.

The Test-ModuleManifest command uses the ErrorAction common parameter with a value of SilentlyContinue to suppress the display of any errors that the command generates.
It also saves the PSModuleInfo object that Test-ModuleManifest returns in the $a variable, so the object is not displayed.

Then, in a separate command \(the semi-colon \[;\] is the command separator\), it displays the value of the $?
automatic variable, which returns "True" if the previous command generated no error and "False" otherwise.

You can use this function in conditional statements, such as those that might precede an Import-Module command or a command that uses the module.

## PARAMETERS

### -Path
Specifies the path to the module manifest file. 
Enter a path \(optional\) and the name of the module manifest file with the .psd1 file name extension.
The default location is the current directory.
Wildcards are supported, but must resolve to a single module manifest file.
This parameter is required.
The parameter name \("Path"\) is optional.
You can also pipe a path to Test-ModuleManifest.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: true (ByValue, ByPropertyName)
Accept wildcard characters: True
```

## INPUTS

### System.String
You can pipe the path to a module manifest to Test-ModuleManifest.

## OUTPUTS

### System.Management.Automation.PSModuleInfo
Test-ModuleManifest returns a PSModuleInfo object that represents the module.
It returns this object even if the manifest has errors.

## NOTES

## RELATED LINKS

[Online Version:](http://go.microsoft.com/fwlink/?LinkID=141557)

[Export-ModuleMember](cbad7943-ded7-4311-9956-da867ad7233c)

[Get-Module](2cccd4c4-9a21-4c77-b691-984ee57242e1)

[Import-Module](af616c24-e122-4098-930e-1e3ea2080ade)

[New-Module](e4d0486e-3235-441b-8d9b-4485985efd04)

[New-ModuleManifest](512adced-f42f-4e88-ba7c-834fc9e5d047)

[Remove-Module](c0968566-4d7e-49e9-82b9-e4df1f489267)

[about_Modules](3be86334-7efa-4ccd-952e-54afe47977a2)



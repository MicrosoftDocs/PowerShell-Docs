---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
online version:  http://go.microsoft.com/fwlink/?LinkID=113320
external help file:  Microsoft.PowerShell.Commands.Management.dll-Help.xml
title:  Get-ItemProperty
---

# Get-ItemProperty
## SYNOPSIS
Gets the properties of a specified item.
## SYNTAX

### Path (Default)
```
Get-ItemProperty [-Path] <String[]> [[-Name] <String[]>] [-Filter <String>] [-Include <String[]>]
 [-Exclude <String[]>] [-Credential <PSCredential>] [-UseTransaction] [<CommonParameters>]
```

### LiteralPath
```
Get-ItemProperty -LiteralPath <String[]> [[-Name] <String[]>] [-Filter <String>] [-Include <String[]>]
 [-Exclude <String[]>] [-Credential <PSCredential>] [-UseTransaction] [<CommonParameters>]
```

## DESCRIPTION
The Get-ItemProperty cmdlet gets the properties of the specified items.
For example, you can use Get-ItemProperty to get the value of the LastAccessTime property of a file object.
You can also use Get-ItemProperty to view registry entries and their values.
## EXAMPLES

### Example 1
```
PS C:\> Get-ItemProperty C:\Windows
```

This command gets information about the C:\Windows directory.
### Example 2
```
PS C:\> Get-ItemProperty C:\Test\Weather.xls | Format-List
```

This command gets the properties of the C:\Test\Weather.xls file.
The result is piped to the Format-List cmdlet to display the output as a list.
### Example 3
```
PS C:\> Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion
```

This command displays the value name and data of each of the registry entries contained in the CurrentVersion registry subkey.
Note that the command requires that there is a Windows PowerShell drive named HKLM: that is mapped to the HKEY_LOCAL_MACHINE hive of the registry.
A drive with that name and mapping is available in Windows PowerShell by default.
Alternatively, the path to this registry subkey can be specified by using the following alternative path that begins with the provider name followed by two colons:

Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion.
### Example 4
```
PS C:\> Get-ItemProperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion -name "ProgramFilesDir"
```

This command gets the value name and data of the ProgramFilesDir registry entry in the CurrentVersion registry subkey.
The command uses the Path parameter to specify the subkey and the Name parameter to specify the value name of the entry.

The command uses a back tick or "grave accent" (\`), the Windows PowerShell continuation character, to continue the command on the second line.
### Example 5
```
PS C:\> Get-ItemProperty -path HKLM:\SOFTWARE\Microsoft\PowerShell\1\PowerShellEngine

ApplicationBase         : C:\Windows\system32\WindowsPowerShell\v1.0\
ConsoleHostAssemblyName : Microsoft.PowerShell.ConsoleHost, Version=1.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35, ProcessorArchitecture=msil
PowerShellVersion       : 2.0
RuntimeVersion          : v2.0.50727
CTPVersion              : 5
PSCompatibleVersion     : 1.0,2.0
```

This command gets the value names and data of the registry entries in the PowerShellEngine registry key.
The results are shown in the following sample output.
### Example 6
```
PS C:\> Get-ItemProperty -path HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell

Path                                                        ExecutionPolicy
----                                                        ---------------
C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe   RemoteSigned

PS C:\> Get-ItemProperty -path HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell | Format-List -property *

PSPath          : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\PowerShell\1\ShellIds\Micro
soft.PowerShell
PSParentPath    : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\PowerShell\1\ShellIds
PSChildName     : Microsoft.PowerShell
PSDrive         : HKLM
PSProvider      : Microsoft.PowerShell.Core\Registry
Path            : C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe
ExecutionPolicy : RemoteSigned
```

This example shows how to format the output of a Get-ItemProperty command in a list to make it easy to see the registry values and data and to make it easy to interpret the results.

The first command uses the Get-ItemProperty cmdlet to get the registry entries in the Microsoft.PowerShell subkey.
This subkey stores options for the default shell for Windows PowerShell.
The results are shown in the following sample output.

The output shows that there are two registry entries, Path and ExecutionPolicy.
When a registry key contains fewer than five entries, by default it is displayed in a table, but it is often easier to view in a list.

The second command uses the same Get-ItemProperty command.
However, this time, the command uses a pipeline operator (|) to send the results of the command to the Format-List cmdlet.
The Format-List command uses the Property parameter with a value of * (all) to display all of the properties of the objects in a list. 
The results are shown in the following sample output.

The resulting display shows the Path and ExecutionPolicy registry entries, along with several less familiar properties of the registry key object.
The other properties, prefixed with "PS", are properties of Windows PowerShell custom objects, such as the objects that represent the registry keys.
## PARAMETERS

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as "User01" or "Domain01\User01", or enter a PSCredential object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.

This parameter is not supported by any providers installed with Windows PowerShell.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Current user
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Exclude
Omits the specified items.
Wildcards are permitted.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Filter
Specifies a filter in the provider's format or language.
The value of this parameter qualifies the Path parameter.
The syntax of the filter, including the use of wildcards, depends on the provider.
Filters are more efficient than other parameters, because the provider applies them when retrieving the objects rather than having Windows PowerShell filter the objects after they are retrieved.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: True
```

### -Include
Includes the specified items.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiteralPath
Specifies a path to the item property.
The value of LiteralPath is used exactly as it is typed.
No characters are interpreted as wildcards.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: LiteralPath
Aliases: PSPath

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies the name of the property or properties to retrieve.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: PSProperty

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the path to the item or items.

```yaml
Type: String[]
Parameter Sets: Path
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -UseTransaction
Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see about_Transactions.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: usetx

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
You can pipe a string that contains a path to Get-ItemProperty.
## OUTPUTS

### System.Boolean, System.String, System.DateTime
Get-ItemProperty returns an object for each item property that it gets.
The object type depends on the object that is retrieved.
For example, in a file system drive, it might return a file or folder.
## NOTES
* The Get-ItemProperty cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, type "Get-PSProvider". For more information, see about_Providers.

*
## RELATED LINKS

[Clear-ItemProperty](Clear-ItemProperty.md)

[Copy-ItemProperty](Copy-ItemProperty.md)

[Move-ItemProperty](Move-ItemProperty.md)

[New-ItemProperty](New-ItemProperty.md)

[Remove-ItemProperty](Remove-ItemProperty.md)

[Rename-ItemProperty](Rename-ItemProperty.md)

[Set-ItemProperty](Set-ItemProperty.md)

[about_Providers](../Microsoft.PowerShell.Core/About/about_Providers.md)



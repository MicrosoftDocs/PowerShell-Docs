---
description:  
manager:  dongill
ms.topic:  article
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-07-01
title:  Set ItemProperty
ms.technology:  powershell
external help file:  PSITPro4_Management.xml
online version:  http://go.microsoft.com/fwlink/p/?linkid=293911
schema:  2.0.0
---


# Set-ItemProperty
## SYNOPSIS
Creates or changes the value of a property of an item.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Set-ItemProperty [-Path] <String[]> [-Name] <String> [-Type] <Microsoft.Win32.RegistryValueKind>
 [-Value] <Object> [-Credential <PSCredential>] [-Exclude <String[]>] [-Filter <String>] [-Force]
 [-Include <String[]>] [-PassThru] [-Confirm] [-WhatIf] [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_2
```
Set-ItemProperty [-Path] <String[]> [-Credential <PSCredential>] [-Exclude <String[]>] [-Filter <String>]
 [-Force] [-Include <String[]>] [-PassThru] [[-Type] <Microsoft.Win32.RegistryValueKind>]
 -InputObject <PSObject> [-Confirm] [-WhatIf] [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_3
```
Set-ItemProperty [-Credential <PSCredential>] [-Exclude <String[]>] [-Filter <String>] [-Force]
 [-Include <String[]>] [-PassThru] [[-Type] <Microsoft.Win32.RegistryValueKind>] -InputObject <PSObject>
 -LiteralPath <String[]> [-Confirm] [-WhatIf] [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_4
```
Set-ItemProperty [-Name] <String> [-Type] <Microsoft.Win32.RegistryValueKind> [-Value] <Object>
 [-Credential <PSCredential>] [-Exclude <String[]>] [-Filter <String>] [-Force] [-Include <String[]>]
 [-PassThru] -LiteralPath <String[]> [-Confirm] [-WhatIf] [-UseTransaction]
```

## DESCRIPTION
The Set-ItemProperty cmdlet changes the value of the property of the specified item.
You can use the cmdlet to establish or change the properties of items.
For example, you can use Set-ItemProperty to set the value of the IsReadOnly property of a file object to true.

You also use Set-ItemProperty to create and change registry values and data.
For example, you can add a new registry entry to a key and establish or change its value.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\>set-itemproperty -path c:\GroupFiles\final.doc -name IsReadOnly -value $true
```

This command sets the value of the IsReadOnly property of the final.doc file to true.

The command uses the Set-ItemProperty cmdlet to change the value of the property of the final.doc file.
It uses the Path parameter to specify the file.
It uses the Name parameter to specify the name of the property and the Value parameter to specify the new value.

The $true automatic variable represents a value of TRUE.
For more information, see about_Automatic_Variables.

The file is a System.IO.FileInfo object and IsReadOnly is just one of its properties.
To see all of the properties and methods of a FileInfo object, pipe the file to the Get-Member cmdlet.
For example, "final.doc | get-member".

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\>set-itemproperty -path HKLM:\Software\MyCompany -name NoOfEmployees -value 823
PS C:\>get-itemproperty -path HKLM:\Software\MyCompany

PSPath        : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\software\mycompany
PSParentPath  : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\software
PSChildName   : mycompany
PSDrive       : HKLM
PSProvider    : Microsoft.PowerShell.Core\Registry
NoOfLocations : 2
NoOfEmployees : 823
PS C:\>set-itemproperty -path HKLM:\Software\MyCompany -name NoOfEmployees -value 824
PS C:\>get-itemproperty -path HKLM:\Software\MyCompany
PSPath        : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\software\mycompany
PSParentPath  : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\software
PSChildName   : mycompany
PSDrive       : HKLM
PSProvider    : Microsoft.PowerShell.Core\Registry
NoOfLocations : 2
NoOfEmployees : 824
```

This example shows how to use Set-ItemProperty to create a new registry entry and to assign a value to the entry.
It creates the NoOfEmployees entry in the MyCompany key in HKLM\Software key and sets its value to 823.

Because registry entries are considered to be properties of the registry keys (which are items), you use Set-ItemProperty to create registry entries, and to establish and change their values.

The first command uses the Set-ItemProperty cmdlet to create the registry entry.
It uses the Path parameter to specify the path to the HKLM: drive and the Software\MyCompany key.
It uses the Name parameter to specify the entry name and the Value parameter to specify a value.

The second command uses the Get-ItemProperty cmdlet to see the new registry entry.
If you use the Get-Item or Get-ChildItem cmdlets, the entries do not appear because they are properties of a key, not items or child items.

The third command changes the value of the NoOfEmployees entry to 824.

You can also use the New-ItemProperty cmdlet to create the registry entry and its value and then use Set-ItemProperty to change the value.

For more information about the HKLM: drive, type "get-help get-psdrive".
For more information about using Windows PowerShell to manage the registry, type "get-help registry".

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\>get-childitem weekly.txt | set-itemproperty -name IsReadOnly -value $true
```

These commands show how to use a pipeline operator (|) to send an item to Set-ItemProperty.

The first part of the command uses the Get-ChildItem cmdlet to get an object that represents the Weekly.txt file.
The command uses a pipeline operator to send the file object to Set-ItemProperty.
The Set-ItemProperty command uses the Name and Value parameters to specify the property and its new value.

This command is equivalent to using the InputObject parameter to specify the object that Get-ChildItem gets.

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
Specifies those items upon which the cmdlet is not to act, and includes all others.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
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
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Allows the cmdlet to set a property on items that cannot otherwise be accessed by the user.
Implementation varies from provider to provider.
For more information, see about_Providers.

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

### -Include
Specifies only those items upon which the cmdlet will act, excluding all others.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Specifies the object that has the properties that you want to change.
Enter a variable that contains the object or a command that gets the object.

```yaml
Type: PSObject
Parameter Sets: UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByPropertyName, ByValue)
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
Parameter Sets: UNNAMED_PARAMETER_SET_3, UNNAMED_PARAMETER_SET_4
Aliases: PSPath

Required: True
Position: Named
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies the name of the property.

```yaml
Type: String
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_4
Aliases: PSProperty

Required: True
Position: 2
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru
Returns an object representing the item property.
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

### -Path
Specifies the path to the items with the property to be set.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_2
Aliases: 

Required: True
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Type
Establishes or changes the data type of a registry value.
The default is String (REG_SZ).
Valid values for this parameter include the following:

- String. Specifies a null-terminated string. Equivalent to REG_SZ.
- ExpandString. Specifies a null-terminated string that contains unexpanded references to environment variables that are expanded when the value is retrieved. Equivalent to REG_EXPAND_SZ.
- Binary. Specifies binary data in any form. Equivalent to REG_BINARY.
- DWord. Specifies a 32-bit binary number. Equivalent to REG_DWORD.
- MultiString. Specifies an array of null-terminated strings terminated by two null characters. Equivalent to REG_MULTI_SZ.
- Qword. Specifies a 64-bit binary number. Equivalent to REG_QWORD.
- Unknown. Indicates an unsupported registry data type, such as REG_RESOURCE_LIST.

This parameter works as designed on the Set-ItemProperty cmdlet.
It is also available on the Set-Item cmdlet in the registry drives, but it has no effect.

```yaml
Type: Microsoft.Win32.RegistryValueKind
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_4
Aliases: 

Required: True
Position: 3
Default value: String
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

```yaml
Type: Microsoft.Win32.RegistryValueKind
Parameter Sets: UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
Aliases: 

Required: False
Position: 3
Default value: String
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Value
Specifies the value of the property.

```yaml
Type: Object
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_4
Aliases: 

Required: True
Position: 3
Default value: 
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.Prompts you for confirmation before running the cmdlet.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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

### -UseTransaction
Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see Includes the command in the active transaction.
This parameter is valid only when a transaction is in progress.
For more information, see

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

## INPUTS

### System.Management.Automation.PSObject
You can pipe objects to Set-ItemProperty.

## OUTPUTS

### None or System.Management.Automation.PSCustomObject
When you use the PassThru parameter, Set-ItemProperty generates a PSCustomObject object that represents the item that was changed and its new property value.
Otherwise, this cmdlet does not generate any output.

## NOTES
* The Set-ItemProperty cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, type "Get-PSProvider". For more information, see about_Providers.

*

## RELATED LINKS

[Clear-ItemProperty](Clear-ItemProperty.md)

[Copy-ItemProperty](Copy-ItemProperty.md)

[Get-ItemProperty](Get-ItemProperty.md)

[Move-ItemProperty](Move-ItemProperty.md)

[New-ItemProperty](New-ItemProperty.md)

[Remove-ItemProperty](Remove-ItemProperty.md)

[Rename-ItemProperty](Rename-ItemProperty.md)

[about_Providers](../About/about_Providers.md)


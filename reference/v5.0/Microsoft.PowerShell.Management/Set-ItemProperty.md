---
external help file: PSITPro5_Management.xml
online version: http://go.microsoft.com/fwlink/p/?linkid=293911
schema: 2.0.0
---

# Set-ItemProperty
## SYNOPSIS
Creates or changes the value of a property of an item.

## SYNTAX

### UNNAMED_PARAMETER_SET_1
```
Set-ItemProperty [-Path] <String[]> [-Name] <String> [-Value] <Object> [-Credential <PSCredential>]
 [-Exclude <String[]>] [-Filter <String>] [-Force] [-Include <String[]>] [-PassThru] [-Confirm] [-WhatIf]
 [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_2
```
Set-ItemProperty [-Credential <PSCredential>] [-Exclude <String[]>] [-Filter <String>] [-Force]
 [-Include <String[]>] [-PassThru] -InputObject <PSObject> -LiteralPath <String[]> [-Confirm] [-WhatIf]
 [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_3
```
Set-ItemProperty [-Path] <String[]> [-Credential <PSCredential>] [-Exclude <String[]>] [-Filter <String>]
 [-Force] [-Include <String[]>] [-PassThru] -InputObject <PSObject> [-Confirm] [-WhatIf] [-UseTransaction]
```

### UNNAMED_PARAMETER_SET_4
```
Set-ItemProperty [-Name] <String> [-Value] <Object> [-Credential <PSCredential>] [-Exclude <String[]>]
 [-Filter <String>] [-Force] [-Include <String[]>] [-PassThru] -LiteralPath <String[]> [-Confirm] [-WhatIf]
 [-UseTransaction]
```

## DESCRIPTION
The Set-ItemProperty cmdlet changes the value of the property of the specified item.
You can use the cmdlet to establish or change the properties of items.
For example, you can use Set-ItemProperty to set the value of the IsReadOnly property of a file object to $True.

You also use Set-ItemProperty to create and change registry values and data.
For example, you can add a new registry entry to a key and establish or change its value.

## EXAMPLES

### Example 1: Set a property of a file
```
PS C:\>Set-ItemProperty -Path "c:\GroupFiles\final.doc" -Name IsReadOnly -Value $True
```

This command sets the value of the IsReadOnly property of the final.doc file to true.

The command uses Set-ItemProperty to change the value of the property of the final.doc file.
It uses Path to specify the file.
It uses Name to specify the name of the property and the Value parameter to specify the new value.

The $True automatic variable represents a value of TRUE.
For more information, see about_Automatic_Variables.

The file is a System.IO.FileInfo object and IsReadOnly is just one of its properties.
To see all of the properties and methods of a FileInfo object, pipe the file to the Get-Member cmdlet.
For example, type final.doc | Get-Member.

### Example 2: Create a registry entry and value
```
PS C:\>Set-ItemProperty -Path "HKLM:\Software\ContosoCompany" -Name "NoOfEmployees" -Value 823
PS C:\> Get-ItemProperty -Path "HKLM:\Software\MyCompany"

PSPath        : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\software\contosocompany
PSParentPath  : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\software
PSChildName   : contosocompany
PSDrive       : HKLM
PSProvider    : Microsoft.PowerShell.Core\Registry
NoOfLocations : 2
NoOfEmployees : 823

PS C:\> Set-ItemProperty -Path "HKLM:\Software\ContosoCompany" -Name "NoOfEmployees" -value 824
PS C:\> Get-ItemProperty -Path "HKLM:\Software\ContosoCompany"

PSPath        : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\software\contosocompany
PSParentPath  : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\software
PSChildName   : contosocompany
PSDrive       : HKLM
PSProvider    : Microsoft.PowerShell.Core\Registry
NoOfLocations : 2
NoOfEmployees : 824
```

This example shows how to use Set-ItemProperty to create a new registry entry and to assign a value to the entry.
It creates the NoOfEmployees entry in the ContosoCompany key in HKLM\Software key and sets its value to 823.

Because registry entries are considered to be properties of the registry keys, which are items, you use Set-ItemProperty to create registry entries, and to establish and change their values.

The first command creates the registry entry.
It uses Path to specify the path of the HKLM: drive and the Software\MyCompany key.
The command uses Name to specify the entry name and Value to specify a value.

The second command uses the Get-ItemProperty cmdlet to see the new registry entry.
If you use the Get-Item or Get-ChildItem cmdlets, the entries do not appear because they are properties of a key, not items or child items.

The third command changes the value of the NoOfEmployees entry to 824.

You can also use the New-ItemProperty cmdlet to create the registry entry and its value and then use Set-ItemProperty to change the value.

For more information about the HKLM: drive, type Get-Help Get-PSDrive.
For more information about how to use Windows PowerShell to manage the registry, type Get-Help Registry.

### Example 3: Modify an item by using the pipeline
```
PS C:\>Get-ChildItem weekly.txt | Set-ItemProperty -Name IsReadOnly -Value $True
```

These commands show how to use a pipeline operator (|) to send an item to Set-ItemProperty.

The first part of the command uses Get-ChildItem to get an object that represents the Weekly.txt file.
The command uses a pipeline operator to send the file object to Set-ItemProperty.
The Set-ItemProperty command uses the Name and Value parameters to specify the property and its new value.

This command is equivalent to using the InputObject parameter to specify the object that Get-ChildItem gets.

## PARAMETERS

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.

Type a user name, such as User01 or Domain01\User01, or enter a PSCredential object, such as one generated by the Get-Credential cmdlet.
If you type a user name, this cmdlet prompts you for a password.

This parameter is not supported by any providers installed with parameter is not supported by any providers installed with Windows PowerShell.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Exclude
Specifies those items upon which the cmdlet does not act, and includes all others.

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

### -Filter
Specifies a filter in the format or language of the provider.
The value of this parameter qualifies the Path parameter.
The syntax of the filter, including the use of wildcard characters, depends on the provider.
Filters are more efficient than other parameters, because the provider applies them when it retrieves the objects instead of having Windows PowerShell filter the objects after they are retrieved.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Forces the cmdlet to set a property on items that cannot otherwise be accessed by the user.
Implementation varies from provider to provider.
For more information, see about_Providers.

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

### -Include
Specifies only those items upon which the cmdlet acts, which excludes all others.

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

### -InputObject
Specifies the object that has the properties that this cmdlet changes.
Enter a variable that contains the object or a command that gets the object.

```yaml
Type: PSObject
Parameter Sets: UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: True(ByValue,ByPropertyName)
Accept wildcard characters: False
```

### -LiteralPath
Specifies a path of the item property.
The value of LiteralPath is used exactly as it is typed.
No characters are interpreted as wildcard characters.
If the path includes escape characters, enclose it in single quotation marks.
Single quotation marks tell Windows PowerShell not to interpret any characters as escape sequences.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_2, UNNAMED_PARAMETER_SET_4
Aliases: PSPath

Required: True
Position: Named
Default value: None
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
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PassThru
Returns an object that represents the item property.
By default, this cmdlet does not generate any output.

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

### -Path
Specifies the path of the items with the property to modify.

```yaml
Type: String[]
Parameter Sets: UNNAMED_PARAMETER_SET_1, UNNAMED_PARAMETER_SET_3
Aliases: 

Required: True
Position: 1
Default value: None
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
Default value: None
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
You can pipe objects to this cmdlet.

## OUTPUTS

### None, System.Management.Automation.PSCustomObject
This cmdlet generates a PSCustomObject object that represents the item that was changed and its new property value, if you specify the PassThru parameter.
Otherwise, this cmdlet does not generate any output.

## NOTES
* Set-ItemProperty is designed to work with the data exposed by any provider. To list the providers available in your session, type Get-PSProvider. For more information, see about_Providers.

*

## RELATED LINKS

[Clear-ItemProperty](f49c0340-d5cd-4099-8494-24b961ab4f7e)

[Copy-ItemProperty](c5baceb8-7348-412c-9593-e7f36a5380ad)

[Get-ItemProperty](d9774a6a-780f-4b5f-946b-02a54f9def80)

[Move-ItemProperty](0f2182c7-a28b-4b81-91fb-82022b3c14a8)

[New-ItemProperty](774ad4a6-deea-4c34-afb6-7274e18552e5)

[Remove-ItemProperty](28c7ecd8-5030-41f9-8478-5d7a06201a5f)

[Rename-ItemProperty](07be82e9-597b-4a41-b9b8-1b192c5f0322)

[about_Providers](55e2974f-3314-48d2-8b1b-abdea6b303cb)


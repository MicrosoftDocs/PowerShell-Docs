---
external help file: System.Management.Automation.dll-Help.xml
keywords: powershell,cmdlet
locale: en-us
Module Name: Microsoft.PowerShell.Core
ms.date: 06/09/2017
online version: http://go.microsoft.com/fwlink/?LinkId=821495
schema: 2.0.0
title: New-Module
---

# New-Module

## SYNOPSIS
Creates a new dynamic module that exists only in memory.

## SYNTAX

### ScriptBlock (Default)
```
New-Module [-ScriptBlock] <ScriptBlock> [-Function <String[]>] [-Cmdlet <String[]>] [-ReturnResult]
 [-AsCustomObject] [-ArgumentList <Object[]>] [<CommonParameters>]
```

### Name
```
New-Module [-Name] <String> [-ScriptBlock] <ScriptBlock> [-Function <String[]>] [-Cmdlet <String[]>]
 [-ReturnResult] [-AsCustomObject] [-ArgumentList <Object[]>] [<CommonParameters>]
```

## DESCRIPTION
The **New-Module** cmdlet creates a dynamic module from a script block.
The members of the dynamic module, such as functions and variables, are immediately available in the session and remain available until you close the session.

Like static modules, by default, the cmdlets and functions in a dynamic module are exported and the variables and aliases are not.
However, you can use the Export-ModuleMember cmdlet and the parameters of **New-Module** to override the defaults.

You can also use the *AsCustomObject* parameter of **New-Module** to return the dynamic module as a custom object.
The members of the modules, such as functions, are implemented as script methods of the custom object instead of being imported into the session.

Dynamic modules exist only in memory, not on disk.
Like all modules, the members of dynamic modules run in a private module scope that is a child of the global scope.
Get-Module cannot get a dynamic module, but Get-Command can get the exported members.

To make a dynamic module available to **Get-Module**, pipe a **New-Module** command to Import-Module, or pipe the module object that **New-Module** returns to **Import-Module**.
This action adds the dynamic module to the **Get-Module** list, but it does not save the module to disk or make it persistent.

## EXAMPLES

### Example 1: Create a dynamic module
```
PS C:\> New-Module -ScriptBlock {function Hello {"Hello!"}}

Name              : __DynamicModule_2ceb1d0a-990f-45e4-9fe4-89f0f6ead0e5
Path              : 2ceb1d0a-990f-45e4-9fe4-89f0f6ead0e5
Description       :
Guid              : 00000000-0000-0000-0000-000000000000
Version           : 0.0
ModuleBase        :
ModuleType        : Script
PrivateData       :
AccessMode        : ReadWrite
ExportedAliases   : {}
ExportedCmdlets   : {}
ExportedFunctions : {[Hello, Hello]}
ExportedVariables : {}
NestedModules     : {}
```

This command creates a new dynamic module with a function called Hello.
The command returns a module object that represents the new dynamic module.

### Example 2: Working with dynamic modules and Get-Module and Get-Command
```
PS C:\> new-module -scriptblock {function Hello {"Hello!"}}

Name              : __DynamicModule_2ceb1d0a-990f-45e4-9fe4-89f0f6ead0e5
Path              : 2ceb1d0a-990f-45e4-9fe4-89f0f6ead0e5
Description       :
Guid              : 00000000-0000-0000-0000-000000000000
Version           : 0.0
ModuleBase        :
ModuleType        : Script
PrivateData       :
AccessMode        : ReadWrite
ExportedAliases   : {}
ExportedCmdlets   : {}
ExportedFunctions : {[Hello, Hello]}
ExportedVariables : {}
NestedModules     : {}
PS C:\> Get-Module
PS C:\>
PS C:\> Get-Command Hello

CommandType     Name   Definition
-----------     ----   ----------
Function        Hello  "Hello!"
```

This example demonstrates that dynamic modules are not returned by the **Get-Module** cmdlet.
The members that they export are returned by the **Get-Command** cmdlet.

### Example 3: Export a variable into the current session
```
PS C:\> New-Module -ScriptBlock {$SayHelloHelp="Type 'SayHello', a space, and a name."; function SayHello ($name) { "Hello, $name" }; Export-ModuleMember -function SayHello -Variable SayHelloHelp}

PS C:\> $SayHelloHelp

Type 'SayHello', a space, and a name.

PS C:\> SayHello Jeffrey
Hello, Jeffrey
```

This command uses the **Export-ModuleMember** cmdlet to export a variable into the current session.
Without the **Export-ModuleMember** command, only the function is exported.

The output shows that both the variable and the function were exported into the session.

### Example 4: Make a dynamic module available to Get-Module
```
PS C:\> New-Module -ScriptBlock {function Hello {"Hello!"}} -name GreetingModule | Import-Module
PS C:\> Get-Module

Name              : GreetingModule
Path              : d54dfdac-4531-4db2-9dec-0b4b9c57a1e5
Description       :
Guid              : 00000000-0000-0000-0000-000000000000
Version           : 0.0
ModuleBase        :
ModuleType        : Script
PrivateData       :
AccessMode        : ReadWrite
ExportedAliases   : {}
ExportedCmdlets   : {}
ExportedFunctions : {[Hello, Hello]}
ExportedVariables : {}
NestedModules     : {}

PS C:\> Get-Command hello

CommandType     Name                                                               Definition
-----------     ----                                                               ----------
Function        Hello                                                              "Hello!"
```

This command demonstrates that you can make a dynamic module available to **Get-Module** by piping the dynamic module to **Import-Module**.

The first command uses a pipeline operator (|) to send the module object that **New-Module** generates to the **Import-Module** cmdlet.
The command uses the *Name* parameter of **New-Module** to assign a friendly name to the module.
Because **Import-Module** does not return any objects by default, there is no output from this command.

The second command uses **Get-Module** to get the modules in the session.
The result shows that **Get-Module** can get the new dynamic module.

The third command uses the **Get-Command** cmdlet to get the Hello function that the dynamic module exports.

### Example 5: Generate a custom object that has exported functions
```
PS C:\> $m = New-Module -ScriptBlock {function Hello ($name) {"Hello, $name"}; functionn Goodbye ($name) {"Goodbye, $name"}} -AsCustomObject
PS C:\> $m
PS C:\> $m | Get-Member
TypeName: System.Management.Automation.PSCustomObject

Name        MemberType   Definition
----        ----------   ----------
Equals      Method       bool Equals(System.Object obj)
GetHashCode Method       int GetHashCode()
GetType     Method       type GetType()
ToString    Method       string ToString()
Goodbye     ScriptMethod System.Object Goodbye();
Hello       ScriptMethod System.Object Hello();

PS C:\ps-test> $m.goodbye("Jane")
Goodbye, Jane

PS C:\ps-test> $m.hello("Manoj")
Hello, Manoj
```

This example shows how to use the *AsCustomObject* parameter of **New-Module** to generate a custom object that has script methods that represent the exported functions.

The first command uses the **New-Module** cmdlet to generate a dynamic module with two functions, Hello and Goodbye.
The command uses the *AsCustomObject* parameter to generate a custom object instead of the PSModuleInfo object that **New-Module** generates by default.
The command saves the custom object in the $m variable.

The second command attempts to display the value of the $m variable.
No content appears.

The third command uses a pipeline operator to send the custom object to the **Get-Member** cmdlet, which displays the properties and methods of the custom object.
The output shows that the object has script methods that represent the Hello and Goodbye functions.

The fourth and fifth commands use the script method format to call the Hello and Goodbye functions.

### Example 6: Get the results of the script block
```
PS C:\> New-Module -ScriptBlock {function SayHello {"Hello, World!"}; SayHello} -ReturnResult
Hello, World!
```

This command uses the *ReturnResult* parameter to request the results of running the script block instead of requesting a module object.

The script block in the new module defines the SayHello function and then calls the function.

## PARAMETERS

### -ArgumentList
Specifies an array of arguments which are parameter values that are passed to the script block.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: Args

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsCustomObject
Indicates that this cmdlet returns a custom object that represents the dynamic module.
The module members are implemented as script methods of the custom object, but they are not imported into the session.
You can save the custom object in a variable and use dot notation to invoke the members.

If the module has multiple members with the same name, such as a function and a variable that are both named A, only one member with each name can be accessed from the custom object.

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

### -Cmdlet
Specifies an array of cmdlets that this cmdlet exports from the module into the current session.
Enter a comma-separated list of cmdlets.
Wildcard characters are permitted.
By default, all cmdlets in the module are exported.

You cannot define cmdlets in a script block, but a dynamic module can include cmdlets if it imports the cmdlets from a binary module.

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

### -Function
Specifies an array of functions that this cmdlet exports from the module into the current session.
Enter a comma-separated list of functions.
Wildcard characters are permitted.
By default, all functions defined in a module are exported.

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

### -Name
Specifies a name for the new module.
You can also pipe a module name to New-Module.

The default value is an autogenerated name that starts with `__DynamicModule_` and is followed by a GUID that specifies the path of the dynamic module.

```yaml
Type: String
Parameter Sets: Name
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ReturnResult
Indicates that this cmdlet runs the script block and returns the script block results instead of returning a module object.

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

### -ScriptBlock
Specifies the contents of the dynamic module.
Enclose the contents in braces ( { } ) to create a script block.
This parameter is required.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
You can pipe a module name to this cmdlet.

## OUTPUTS

### System.Management.Automation.PSModuleInfo, System.Management.Automation.PSCustomObject, or None
This cmdlet generates a **PSModuleInfo** object, by default.
If you use the *AsCustomObject* parameter, it generates a **PSCustomObject** object.
If you use the *ReturnResult* parameter, it returns the result of evaluating the script block in the dynamic module.

## NOTES
* You can also refer to `New-Module` by its alias, `nmo`.
  For more information, see [about_Aliases](About/about_Aliases.md).

## RELATED LINKS

[Export-ModuleMember](Export-ModuleMember.md)

[Get-Module](Get-Module.md)

[Import-Module](Import-Module.md)

[Remove-Module](Remove-Module.md)
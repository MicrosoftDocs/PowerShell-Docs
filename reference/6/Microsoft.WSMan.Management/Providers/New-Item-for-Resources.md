---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  New-Item for Resources
online version:  http://go.microsoft.com/fwlink/?LinkId=834978
---

# New-Item for Resources
Creates a new item.  

## Syntax  

```  
New-Item [-ResourceURI <Uri>] [-SupportsOptions] [-ExactMatch] [-Capability <string>] [-Confirm] [-WhatIf] [<CommonParameters>]  

```  

## Description  
 The [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet creates a new item and sets its value. The types of items that can be created depend upon the location of the item. For example, in the file system, [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) is used to create files and folders. In the registry, [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) creates registry keys and entries.  

 In the Resources directory, you can use the [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet to create and configure a Plugin resources.  

## Parameters  

### -ResourceURI <Uri\>  
 Specifies the Uniform Resource Identifier (URI) that identifies a specific type of resource, such as a disk or a process, on a computer.  

 A URI consists of a prefix and a path to a resource. For example:  

 http://schemas.microsoft.com/wbem/wsman/1/wmi/root/cimv2/Win32_LogicalDisk  

 http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/CIM_NumericSensor  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -SupportsOptions  
 Specifies whether the plug-in supports the use of options, which are passed within the wsman:OptionSet header in a request message.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -ExactMatch  
 Specifies how to use the security settings that are specified in the Sddl parameter. If the ExactMatch parameter is set to True, the security settings in Sddl are used only to authorize access attempts to the URI exactly as specified by the URI. If ExactMatch is set to false, the security settings in Sddl are used to authorize access attempts to the URIs that begin with the string specified in the URI.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -Capability <string\>  
 Specifies an operation that is supported on this Uniform Resource Identifier (URI). You have to create one entry for each type of operation that the URI supports.  

 The following are valid values:  

 -- Create: Create operations are supported on the URI. The SupportFragment attribute is used if the Create operation supports the concept. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  

 -- Delete: Delete operations are supported on the URI. The SupportFragment attribute is used if the Delete operation supports the concept. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  

 -- Enumerate: Enumerate operations are supported on the URI. The SupportFragment attribute is not supported for Enumerate operations and should be set to False. The SupportFiltering attribute is valid, and if the plug-in supports filtering, this attribute should be set to True. This operation is not valid for a URI if Shell operations are also supported.  

 -- Get: Get operations are supported on the URI. The SupportFragment attribute is used if the Get operation supports the concept. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  

 -- Invoke: Invoke operations are supported on the URI. The SupportFragment attribute is not supported for Invoke operations and should be set to False. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  

 -- Put: Put operations are supported on the URI. The SupportFragment attribute is used if the Put operation supports the concept. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  

 -- Subscribe: Subscribe operations are supported on the URI. The SupportFragment attribute is not supported for Subscribe operations and should be set to False. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  

 -- Shell: Shell operations are supported on the URI. The SupportFragment attribute is not supported for Shell operations and should be set to False. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if any other operation is also supported. If a Shell operation is configured for a URI, Get, Put, Create, Delete, Invoke, and Enumerate operations are processed internally within the WS-Management (WinRM) service to manage shells. As a result, the plug-in cannot handle the operations.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -Confirm  
 Prompts you for confirmation before executing the command.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### -WhatIf  
 Describes what would happen if you executed the command without actually executing the command.  

|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  

### <CommonParameters\>  
 This cmdlet supports the common parameters: -Verbose, -Debug, -ErrorAction, -ErrorVariable, -OutBuffer, and -OutVariable. For more information, see [about_CommonParameters](../../Microsoft.PowerShell.Core/About/about_CommonParameters.md).  

## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  

|||  
|-|-|  
|Inputs|System.Object<br /><br /> You can pipe a value for the new item to the New-Item cmdlet.|  
|Outputs|Any|  

## Notes  
 The [New-Item](../../Microsoft.PowerShell.Management/New-Item.md) cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, type "Get-PsProvider". For more information, see About_Providers.  

## Example 1  

```  
C:\PS>New-Item -Path WSMan:\localhost\Plugin\TestPlugin\Resources -ResourceUri http://schemas.dmtf.org/wbem/wscim/3/cim-schema -Capability "Enumerate"  

This command creates a resource entry in the Resources directory of TestPlugin.  

```  

## See Also  
 [about_Providers](../../Microsoft.PowerShell.Core/About/about_Providers.md)   
 [Get-Item](../../Microsoft.PowerShell.Management/Get-Item.md)   
 [Set-Item](../../Microsoft.PowerShell.Management/Set-Item.md)   
 [Remove-Item](../../Microsoft.PowerShell.Management/Remove-Item.md)   
 [Clear-Item](../../Microsoft.PowerShell.Management/Clear-Item.md)   
 [Invoke-Item](../../Microsoft.PowerShell.Management/Invoke-Item.md)   
 [Rename-Item](../../Microsoft.PowerShell.Management/Rename-Item.md)   
 [Move-Item](../../Microsoft.PowerShell.Management/Move-Item.md)   
 [Copy-Item](../../Microsoft.PowerShell.Management/Copy-Item.md)


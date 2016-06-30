---
title: New-Item for Plugin
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b5b0d0c2-2784-4c01-90cf-b63407c5888b
---
# New-Item for Plugin
Creates a new item.  
  
## Syntax  
  
```  
New-Item -Plugin <string> -Filename <string> -ResourceURI <Uri> -Capability <string> [-lang <string>] -SDKVersion <string> [-xmlns <string>] -XMLRenderingType <string> [-Confirm] [-WhatIf] [<CommonParameters>]  
  
```  
  
## Description  
 The [New-Item](New-Item.md) cmdlet creates a new item and sets its value. The types of items that can be created depend upon the location of the item. For example, in the file system, [New-Item](New-Item.md) is used to create files and folders. In the registry, [New-Item](New-Item.md) creates registry keys and entries.  
  
 New\-Item can also set the value of the items that it creates. For example, when creating a new file, [New-Item](New-Item.md) can add initial content to the file.  
  
## Parameters  
  
### \-Plugin \<string\>  
 Specifies the display name to use for the plug\-in. If an error is returned by the plug\-in, the display name will be put in the error XML that is returned to the client application. The name is not locale specific.  
  
|||  
|-|-|  
|Required?|true|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-FileName \<string\>  
 Specifies the file name of the operations plug\-in. Any environment variables that are put in this entry will be expanded in the users' context when a request is received. Because each user could have a different version of the same environment variable, each user could have a different plug\-in. This entry cannot be blank and must point to a valid plug\-in.  
  
|||  
|-|-|  
|Required?|true|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-ResourceURI \<Uri\>  
 Specifies the Uniform Resource Identifier \(URI\) that identifies a specific type of resource, such as a disk or a process, on a computer.  
  
 A URI consists of a prefix and a path to a resource. For example:  
  
 http:\/\/schemas.microsoft.com\/wbem\/wsman\/1\/wmi\/root\/cimv2\/Win32\_LogicalDisk  
  
 http:\/\/schemas.dmtf.org\/wbem\/wscim\/1\/cim\-schema\/2\/CIM\_NumericSensor  
  
|||  
|-|-|  
|Required?|true|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-Capability \<string\>  
 Specifies an operation that is supported on this Uniform Resource Identifier \(URI\). You have to create one entry for each type of operation that the URI supports. The following are valid values:  
  
 \-\- Create: Create operations are supported on the URI. The SupportFragment attribute is used if the Create operation supports the concept. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  
  
 \-\- Delete: Delete operations are supported on the URI. The SupportFragment attribute is used if the Delete operation supports the concept. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  
  
 \-\- Enumerate: Enumerate operations are supported on the URI. The SupportFragment attribute is not supported for Enumerate operations and should be set to False. The SupportFiltering attribute is valid, and if the plug\-in supports filtering, this attribute should be set to True. This operation is not valid for a URI if Shell operations are also supported.  
  
 \-\- Get: Get operations are supported on the URI. The SupportFragment attribute is used if the Get operation supports the concept. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  
  
 \-\- Invoke: Invoke operations are supported on the URI. The SupportFragment attribute is not supported for Invoke operations and should be set to False. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  
  
 \-\- Put: Put operations are supported on the URI. The SupportFragment attribute is used if the Put operation supports the concept. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  
  
 \-\- Subscribe: Subscribe operations are supported on the URI. The SupportFragment attribute is not supported for Subscribe operations and should be set to False. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if Shell operations are also supported.  
  
 \-\- Shell: Shell operations are supported on the URI. The SupportFragment attribute is not supported for Shell operations and should be set to False. The SupportFiltering attribute is not valid and should be set to False. This operation is not valid for a URI if any other operation is also supported. If a Shell operation is configured for a URI, Get, Put, Create, Delete, Invoke, and Enumerate operations are processed internally within the WS\-Management \(WinRM\) service to manage shells. As a result, the plug\-in cannot handle the operations.  
  
|||  
|-|-|  
|Required?|true|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-lang \<string\>  
 A string that specifies a language, or a language\-region with language and region separated by a hyphen.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-SDKVersion \<string\>  
 Specifies the version of the WS\-Management plug\-in SDK. The only valid value is 1.  
  
|||  
|-|-|  
|Required?|true|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-xmlns \<string\>  
 A string that specifies specifies a Uniform Resource Name \(URN\) that uniquely identifies the namespace.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-XMLRenderingType \<string\>  
 Specifies the format in which XML is passed to plug\-ins through the WSMAN\_DATA object. The following are valid values:  
  
 Text: Incoming XML data is contained in a WSMAN\_DATA\_TYPE\_TEXT structure, which represents the XML as a PCWSTR memory buffer.  
  
 XMLReader:  Incoming XML data is contained in a WSMAN\_DATA\_TYPE\_WS\_XML\_READER structure, which represents the XML as an XmlReader object, which is defined in the WebServices.h header file.  
  
|||  
|-|-|  
|Required?|true|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-Confirm  
 Prompts you for confirmation before executing the command.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-WhatIf  
 Describes what would happen if you executed the command without actually executing the command.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \<CommonParameters\>  
 This cmdlet supports the common parameters: \-Verbose, \-Debug, \-ErrorAction, \-ErrorVariable, \-OutBuffer, and \-OutVariable. For more information, see [about\_CommonParameters](assetId:///cd121ee6-f6a8-4aa6-8f89-94edcedb6780).  
  
## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  
  
|||  
|-|-|  
|Inputs|System.Object<br /><br /> You can pipe a value for the new item to the New\-Item cmdlet.|  
|Outputs|Any|  
  
## Notes  
 The [New-Item](New-Item.md) cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, type "Get\-PsProvider". For more information, see About\_Providers.  
  
## Example 1  
  
```  
C:\PS>New-Item -Path WSMan:\localhost\Plugin -Force -Name "Test Plugin" -File C:\Testplugin.xml  
  
              Where Testplugin.xml contains:  
  
This command creates (registers) a plug-in for the WS-Management service. This example uses an XML file to load all of the necessary setting to create a plug-in.  
  
This command creates (registers) a plug-in for the WS-Management service. This example uses an XML file to load all of the necessary setting to create a plug-in.  
  
```  
  
## Example 2  
  
```  
C:\PS>New-Item -Path WSMan:\localhost\Plugin -Plugin TestPlugin -FileName %systemroot%\system32\WsmWmiPl.dll -Resource http://schemas.dmtf.org/wbem/wscim/2/cim-schema -SDKVersion 1 -Capability "Get","Put","Invoke","Enumerate" -XMLRenderingType text  
  
This command creates (registers) a plug-in for the WS-Management service.  
  
```  
  
## See Also  
 [about\_Providers](assetId:///55e2974f-3314-48d2-8b1b-abdea6b303cb)   
 [Get-Item](Get-Item.md)   
 [Set-Item](Set-Item.md)   
 [Remove-Item](Remove-Item.md)   
 [Clear-Item](Clear-Item.md)   
 [Invoke-Item](Invoke-Item.md)   
 [Rename-Item](Rename-Item.md)   
 [Move-Item](Move-Item.md)   
 [Copy-Item](Copy-Item.md)
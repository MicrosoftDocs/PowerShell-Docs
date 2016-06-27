---
title: New-Item for InitializationParameters
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 92f03160-ae7d-420f-ae66-bfa33215af48
---
# New-Item for InitializationParameters
Creates a new item.  
  
## Syntax  
  
```  
New-Item [-ParamName <string>] [-ParamValue <string>] [-Confirm] [-WhatIf] [<CommonParameters>]  
  
```  
  
## Description  
 The [New\-Item &#91;m2&#93;](assetId:///005a0eae-0d1b-4fd0-a8f8-135487794106) cmdlet creates a new item and sets its value. The types of items that can be created depend upon the location of the item. For example, in the file system, [New\-Item &#91;m2&#93;](assetId:///005a0eae-0d1b-4fd0-a8f8-135487794106) is used to create files and folders. In the registry, [New\-Item &#91;m2&#93;](assetId:///005a0eae-0d1b-4fd0-a8f8-135487794106) creates registry keys and entries.  
  
 In the InitializationParameters directory, you can use the [New\-Item &#91;m2&#93;](assetId:///005a0eae-0d1b-4fd0-a8f8-135487794106) cmdlet to create and configure Plugin initialization parameters.  
  
## Parameters  
  
### \-ParamName \<string\>  
 Specifies the display name to use for the initialization parameter.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-ParamValue \<string\>  
 Specifies the value of an initialization parameter, which is a plug\-in\-specific value that is used to specify configuration options.  
  
|||  
|-|-|  
|Required?|false|  
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
 This cmdlet supports the common parameters: \-Verbose, \-Debug, \-ErrorAction, \-ErrorVariable, \-OutBuffer, and \-OutVariable. For more information, see [about\_CommonParameters &#91;m2&#93;](assetId:///cd121ee6-f6a8-4aa6-8f89-94edcedb6780).  
  
## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  
  
|||  
|-|-|  
|Inputs|System.Object<br /><br /> You can pipe a value for the new item to the New\-Item cmdlet.|  
|Outputs|Any|  
  
## Notes  
 The [New\-Item &#91;m2&#93;](assetId:///005a0eae-0d1b-4fd0-a8f8-135487794106) cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, type "Get\-PsProvider". For more information, see About\_Providers.  
  
## Example 1  
  
```  
C:\PS>New-Item -Path WSMan:\localhost\Plugin\TestPlugin\InitializationParameters -ParamName testparametername -ParamValue testparametervalue  
  
This command creates an Initialization parameter named testparametername in the InitializationParameters directory.  
  
```  
  
## See Also  
 [about\_Providers](assetId:///55e2974f-3314-48d2-8b1b-abdea6b303cb)   
 [Get\-Item &#91;m2&#93;](assetId:///0650f666-6d85-4b5f-ab57-34fd9b3d6f19)   
 [Set\-Item &#91;m2&#93;](assetId:///2ae0f9bc-105b-4363-8410-7f94a3c12fa3)   
 [Remove\-Item &#91;m2&#93;](assetId:///f98b4219-60df-408b-bdc8-994f920fc7bd)   
 [Clear\-Item &#91;m2&#93;](assetId:///b5937fc5-533c-4ac2-9885-61db6df3067d)   
 [Invoke\-Item &#91;m2&#93;](assetId:///38a9887b-ce1a-4bde-be4e-98012efae204)   
 [Rename\-Item &#91;m2&#93;](assetId:///cf036d63-7739-4f1c-ba54-d1049fbcf21d)   
 [Move\-Item &#91;m2&#93;](assetId:///c52264a4-b567-453b-89d5-1ead1289f21b)   
 [Copy\-Item &#91;m2&#93;](assetId:///2c819aec-96c0-49e9-ae3e-9a57559ec99a)
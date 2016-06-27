---
title: New-Item for Listener
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1e38dfa6-6707-4698-aad8-963d60c268c4
---
# New-Item for Listener
Creates a new item.  
  
## Syntax  
  
```  
New-Item -Address <string> -Transport <string> [-Hostname <string>] [-Enabled] [-URLPrefix <string>] [-CertificateThumbprint <string>] [-Confirm] [-WhatIf] [<CommonParameters>]  
  
```  
  
## Description  
 The [New\-Item](assetId:///005a0eae-0d1b-4fd0-a8f8-135487794106) cmdlet creates a new item and sets its value. The types of items that can be created depend upon the location of the item. For example, in the file system, [New\-Item](assetId:///005a0eae-0d1b-4fd0-a8f8-135487794106) is used to create files and folders. In the registry, [New\-Item](assetId:///005a0eae-0d1b-4fd0-a8f8-135487794106) creates registry keys and entries.  
  
 New\-Item can also set the value of the items that it creates. For example, when creating a new file, [New\-Item](assetId:///005a0eae-0d1b-4fd0-a8f8-135487794106) can add initial content to the file.  
  
## Parameters  
  
### \-Address \<string\>  
 Specifies the address for which this listener was created. The value can be one of the following:  
  
 \-\-The literal string "\*". \(The wildcard character \(\*\) makes the command bind all the IP addresses on all the network interface cards \[NIC\].\)  
  
 \-\-The literal string "IP:" followed by a valid IP address in either IPv4 dotted\-decimal format or in IPv6 cloned\-hexadecimal format.  
  
 \-\-The literal string "MAC:" followed by the MAC address of a NIC. For example: MAC:32\-a3\-58\-90\-be\-cc.  
  
|||  
|-|-|  
|Required?|true|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-Transport \<string\>  
 Specifies the transport to use to send and receive WS\-Management protocol requests and responses. The value must be either HTTP or HTTPS.  
  
|||  
|-|-|  
|Required?|true|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-Hostname \<string\>  
 Specifies the host name of the computer on which the WS\-Management \(WinRM\) service is running. The value must be a fully qualified domain name, an IPv4 or IPv6 literal string, or a wildcard character.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-Enabled  
 Specifies whether the listener is enabled or disabled. The default is True.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-URLPrefix \<string\>  
 A URL prefix on which to accept HTTP or HTTPS requests. This is a string containing only the characters a\-z, A\-Z, 9\-0, underscore \(\_\) and backslash \(\/\). The string must not start with or end with a backslash \(\/\). For example, if the computer name is SampleMachine, the WS\-Management client would specify http:\/\/SampleMachine\/URLPrefix in the destination address.  
  
|||  
|-|-|  
|Required?|false|  
|Position?|named|  
|Default Value||  
|Accept Pipeline Input?|false|  
|Accept Wildcard Characters?|false|  
  
### \-CertificateThumbprint \<string\>  
 Specifies the thumbprint of the service certificate.  
  
 This value represents the string of two\-digit hexadecimal values in the Thumbprint field of the certificate. It specifies the digital public key certificate \(X509\) of a user account that has permission to perform this action. Certificates are used in client certificate\-based authentication. They can be mapped only to local user accounts, and they do not work with domain accounts. To get a certificate thumbprint, use the [Get\-Item](assetId:///0650f666-6d85-4b5f-ab57-34fd9b3d6f19) or [Get\-ChildItem](assetId:///4b270d63-c995-45b8-b5b4-3f8887efbfcc) cmdlets in the Windows PowerShell Cert: drive.  
  
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
 This cmdlet supports the common parameters: \-Verbose, \-Debug, \-ErrorAction, \-ErrorVariable, \-OutBuffer, and \-OutVariable. For more information, see [about\_CommonParameters](assetId:///cd121ee6-f6a8-4aa6-8f89-94edcedb6780).  
  
## Inputs and Outputs  
 The input type is the type of the objects that you can pipe to the cmdlet. The return type is the type of the objects that the cmdlet returns.  
  
|||  
|-|-|  
|Inputs|System.Object<br /><br /> You can pipe a value for the new item to the New\-Item cmdlet.|  
|Outputs|Any|  
  
## Notes  
 The [New\-Item](assetId:///005a0eae-0d1b-4fd0-a8f8-135487794106) cmdlet is designed to work with the data exposed by any provider. To list the providers available in your session, type "Get\-PsProvider". For more information, see About\_Providers.  
  
## Example 1  
  
```  
C:\PS>New-Item -Path WSMan:\localhost\Listener -Address * -Transport HTTP -force  
  
This command creates an HTTP listener on any IP address on the computer.  
  
```  
  
## See Also  
 [about\_Providers](assetId:///55e2974f-3314-48d2-8b1b-abdea6b303cb)   
 [Get\-Item](assetId:///0650f666-6d85-4b5f-ab57-34fd9b3d6f19)   
 [Set\-Item](assetId:///2ae0f9bc-105b-4363-8410-7f94a3c12fa3)   
 [Remove\-Item](assetId:///f98b4219-60df-408b-bdc8-994f920fc7bd)   
 [Clear\-Item](assetId:///b5937fc5-533c-4ac2-9885-61db6df3067d)   
 [Invoke\-Item](assetId:///38a9887b-ce1a-4bde-be4e-98012efae204)   
 [Rename\-Item](assetId:///cf036d63-7739-4f1c-ba54-d1049fbcf21d)   
 [Move\-Item](assetId:///c52264a4-b567-453b-89d5-1ead1289f21b)   
 [Copy\-Item](assetId:///2c819aec-96c0-49e9-ae3e-9a57559ec99a)
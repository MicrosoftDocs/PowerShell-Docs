---
description:  
manager:  carmonm
ms.topic:  reference
author:  jpjofre
ms.prod:  powershell
keywords:  powershell,cmdlet
ms.date:  2016-12-12
title:  New WebServiceProxy
ms.technology:  powershell
schema:   2.0.0
online version:   http://go.microsoft.com/fwlink/p/?linkid=293890
external help file:   Microsoft.PowerShell.Commands.Management.dll-Help.xml
---


# New-WebServiceProxy

## SYNOPSIS
Creates a Web service proxy object that lets you use and manage the Web service in Windows PowerShell.

## SYNTAX

### NoCredentials (Default)
```
New-WebServiceProxy [-Uri] <Uri> [[-Class] <String>] [[-Namespace] <String>] [<CommonParameters>]
```

### Credential
```
New-WebServiceProxy [-Uri] <Uri> [[-Class] <String>] [[-Namespace] <String>] [-Credential <PSCredential>]
 [<CommonParameters>]
```

### UseDefaultCredential
```
New-WebServiceProxy [-Uri] <Uri> [[-Class] <String>] [[-Namespace] <String>] [-UseDefaultCredential]
 [<CommonParameters>]
```

## DESCRIPTION
The **New-WebServiceProxy** cmdlet lets you use a Web service in Windows PowerShell.
The cmdlet connects to a Web service and creates a Web service proxy object in Windows PowerShell.
You can use the proxy object to manage the Web service.

A Web service is an XML-based program that exchanges data over a network, particularly over the Internet.
The Microsoft .NET Framework provides Web service proxy objects that represent the Web service as a .NET Framework object.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> $zip = New-WebServiceProxy -Uri http://www.webservicex.net/uszip.asmx?WSDL
```

This command uses the **New-WebServiceProxy** command to create a .NET Framework proxy of the US Zip Web service in Windows PowerShell.

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> $URI = "http://www.webservicex.net/uszip.asmx?WSDL"
PS C:\> $zip = New-WebServiceProxy -Uri $URI -Namespace WebServiceProxy -Class USZip
```

This command uses the **New-WebServiceProxy** cmdlet to create a .NET Framework proxy of the US Zip Web service.

The first command stores the URI of the Web service in the $URI variable.

The second command creates the Web service proxy.
The command uses the **URI** parameter to specify the URI and the **Namespace** and **Class** parameters to specify the namespace and class of the object.

### -------------------------- EXAMPLE 3 --------------------------
```
PS C:\> $zip | get-member -type method

TypeName: WebServiceProxy.USZip
Name                      MemberType Definition
----                      ---------- ----------
Abort                     Method     System.Void Abort(
BeginGetInfoByAreaCode    Method     System.IAsyncResul
BeginGetInfoByCity        Method     System.IAsyncResul
BeginGetInfoByState       Method     System.IAsyncResul
BeginGetInfoByZIP         Method     System.IAsyncResul
CreateObjRef              Method     System.Runtime.Rem
Discover                  Method     System.Void Discov
Dispose                   Method     System.Void Dispos
EndGetInfoByAreaCode      Method     System.Xml.XmlNode
EndGetInfoByCity          Method     System.Xml.XmlNode
EndGetInfoByState         Method     System.Xml.XmlNode
EndGetInfoByZIP           Method     System.Xml.XmlNode
Equals                    Method     System.Boolean Equ
GetHashCode               Method     System.Int32 GetHa
GetInfoByAreaCode         Method     System.Xml.XmlNode
GetInfoByCity             Method     System.Xml.XmlNode
GetInfoByState            Method     System.Xml.XmlNode
GetInfoByZIP              Method     System.Xml.XmlNode
GetLifetimeService        Method     System.Object GetL
GetType                   Method     System.Type GetTyp
InitializeLifetimeService Method     System.Object Init
ToString                  Method     System.String ToSt
```

This command uses the Get-Member cmdlet to display the methods of the Web service proxy object in the $zip variable.
We will use these methods in the following example.

Notice that the TypeName of the proxy object, WebServiceProxy, reflects the namespace and class names that were specified in the previous example.

### -------------------------- EXAMPLE 4 --------------------------
```
PS C:\> $zip.getinfobyzip(20500).table
CITY      : Washington
STATE     : DC
ZIP       : 20500
AREA_CODE : 202
TIME_ZONE : E
```

This command uses the Web service proxy stored in the Zip variable.
The command uses the GetInfoByZip method of the proxy and its Table property.

## PARAMETERS

### -Class
Specifies a name for the proxy class that the cmdlet creates for the Web service.
The value of this parameter is used with the **Namespace** parameter to provide a fully qualified name for the class.
The default value is generated from the URI.

```yaml
Type: String
Parameter Sets: (All)
Aliases: FileName, FN

Required: False
Position: 2
Default value: Generated from the URI
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Specifies a user account that has permission to perform this action.
The default is the current user.
This is an alternative to using the **UseDefaultCredential** parameter.

Type a user name, such as "User01" or "Domain01\User01".
Or, enter a PSCredential object, such as one generated by the Get-Credential cmdlet.
If you type a user name, you will be prompted for a password.

```yaml
Type: PSCredential
Parameter Sets: Credential
Aliases: Cred

Required: False
Position: Named
Default value: Current user
Accept pipeline input: False
Accept wildcard characters: False
```

### -Namespace
Specifies a namespace for the new class.

The value of this parameter is used with the value of the **Class** parameter to generate a fully qualified name for the class.
The default value is  Microsoft.PowerShell.Commands.NewWebserviceProxy.AutogeneratedTypes plus a type that is generated from the URI.

You can set the value of the **Namespace** parameter so that you can access multiple Web services with the same name.

```yaml
Type: String
Parameter Sets: (All)
Aliases: NS

Required: False
Position: 3
Default value: Microsoft.PowerShell.Commands.NewWebserviceProxy.AutogeneratedTypes
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri
Specifies the URI of the Web service.
Enter a URI or the path and file name of a file that contains a service description.

The URI must refer to an .asmx page or to a page that returns a service description.
To return a service description of a Web service that was created by using ASP.NET, append "?WSDL" to the URL of the Web service (for example,  http://www.contoso.com/MyWebService.asmx?WSDL).

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: WL, WSDL, Path

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UseDefaultCredential
Sets the **UseDefaultCredential** property in the resulting proxy object to True.
This is an alternative to using the **Credential** parameter.

```yaml
Type: SwitchParameter
Parameter Sets: UseDefaultCredential
Aliases: UDC

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
This cmdlet does not take input from the pipeline.

## OUTPUTS

### A Web service proxy object
The namespace and class of the object are determined by the parameters of the command.
The default is generated from the input Uniform Resource Identifier (URI).

## NOTES
* **New-WebServiceProxy** uses the System.Net.WebClient class to load the specified Web service.

*

## RELATED LINKS

[New-Service](New-Service.md)


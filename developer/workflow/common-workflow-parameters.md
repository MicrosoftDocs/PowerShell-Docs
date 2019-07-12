---
title: "Common Workflow Parameters | Microsoft Docs"
ms.custom: ""
ms.date: "09/12/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: d5891467-8e13-484d-b7af-32e6bffab35d
caps.latest.revision: 4
---
# Common Workflow Parameters

A workflow activity generated from a Windows PowerShell cmdlet  defines a number of parameters that common to all activities. A subset of these parameters can be specified at authoring time so that workflow authors can customize activities. Another subset of these parameters can be specified by the user when calling the activity.

The common workflow parameters are grouped into several categories as follows.

## Connectivity Parameters

|Name|Type|Description|Can be specified by end user at execution time?|Can be specified by workflow author at authoring time?|Can be specified by workflow author at instantiation?|
|----------|----------|-----------------|-----------------------------------------------------|------------------------------------------------------------|-----------------------------------------------------------|
|PSComputerName|String[]|A list of computer names for which to launch jobs.|Yes|Yes|Yes|
|PSCredential|[System.Management.Automation.PSCredential](/dotnet/api/System.Management.Automation.PSCredential)|The authentication credential to use to login to the computers specified by the PSComputerName parameter. This parameter is valid only if PSComputerName is specified.|Yes|Yes|Yes|
|PSPort|UInt32|The port to be used to run the workflow.|Yes|Yes|Yes|
|PSUseSSL|Boolean|Use Secure Sockets Layer (SSL) protocol to establish a secure connection to the remote computer to run the workflow.|Yes|Yes|Yes|
|PSConfigurationName|String|The session configuration used to run the workflow.|Yes|Yes|Yes|
|PSApplicationName|String|The application name portion of the connection URI for the workflow execution. Use this parameter only when you are not using the ConnectionURI parameter.|Yes|Yes|Yes|
|PSThrottleLimit|UInt32|The maximum number of concurrent connections that can be established to run the workflow.|Yes|TBD|Yes|
|PSConnectionURI|String[]|An array of fully-qualified URIs that specify the endpoints for the interactive sessions used to run the workflow.|Yes|Yes|Yes|
|PSAllowRedirection|Boolean|Specifies whether to allow redirection of this connection to an alternate URI to run the workflow.|Yes|Yes|Yes|
|PSSessionOption|[System.Management.Automation.Remoting.Pssessionoption](/dotnet/api/System.Management.Automation.Remoting.PSSessionOption)|Advanced options for the session used to run the workflow.|Yes|Yes|Yes|
|PSAuthentication|[System.Management.Automation.Runspaces.Authenticationmechanism](/dotnet/api/System.Management.Automation.Runspaces.AuthenticationMechanism)|A value of the [System.Management.Automation.Runspaces.Authenticationmechanism](/dotnet/api/System.Management.Automation.Runspaces.AuthenticationMechanism) enumeration that specifies the authentication mechanism used to authenticate the user's credentials.|Yes|Yes|Yes|
|PSCertificateThumbprint|String|The digital public key certificate (X509) of a user account that has permission to run the workflow.|Yes|Yes|Yes|

### Behavior Parameters
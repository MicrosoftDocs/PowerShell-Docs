---
title: "Windows PowerShell Sample Code | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 1106829a-8ddc-454e-bbdd-ade15d4bffb4
caps.latest.revision: 7
---
# Windows PowerShell Sample Code

Windows PowerShell® samples are available through the Windows SDK. This section contains the sample code that is contained in the Windows SDK samples.

> [!NOTE]
> When the Windows SDK is installed, a **Samples** directory is created in which all the Windows PowerShell samples are made available. A typical installation directory is **C:\Program Files\Microsoft SDKs\Windows\v6.0**. Start Windows PowerShell and type **"cd Samples\SysMgmt\PowerShell"**  to locate the Windows PowerShell Samples directory. In this document, the Windows PowerShell Samples directory is referred to as **\<PowerShell Samples>**.

## Sample Code Listing

|Sample Code|Description|
|-----------------|-----------------|
|[AccessDbProviderSample01 Code Sample](./accessdbprovidersample01-code-sample.md)|This is the provider described in [Creating a Basic Windows PowerShell Provider](./creating-a-basic-windows-powershell-provider.md).|
|[AccessDbProviderSample02 Code Sample](./accessdbprovidersample02-code-sample.md)|This is the provider described in [Creating a Windows PowerShell Drive Provider](./creating-a-windows-powershell-drive-provider.md).|
|[AccessDbProviderSample03 Code Sample](./accessdbprovidersample03-code-sample.md)|This is the provider described in [Creating a Windows PowerShell Item Provider](./creating-a-windows-powershell-item-provider.md).|
|[AccessDbProviderSample04 Code Sample](./accessdbprovidersample04-code-sample.md)|This is the provider described in [Creating a Windows PowerShell Container Provider](./creating-a-windows-powershell-container-provider.md).|
|[AccessDbProviderSample05 Code Sample](./accessdbprovidersample05-code-sample.md)|This is the provider described in [Creating a Windows PowerShell Navigation Provider](./creating-a-windows-powershell-navigation-provider.md).|
|[AccessDbProviderSample06 Code Sample](./accessdbprovidersample06-code-sample.md)|This is the provider described in [Creating a Windows PowerShell Content Provider](./creating-a-windows-powershell-content-provider.md).|
|[GetProc01 Code Samples](./getproc01-code-samples.md)|This is the basic `Get-Process` cmdlet sample described in [Creating Your First Cmdlet](../cmdlet/creating-a-cmdlet-without-parameters.md).|
|[GetProc02 Code Samples](./getproc02-code-samples.md)|This is the `Get-Process` cmdlet sample described in [Adding Parameters that Process Command-Line Input](../cmdlet/adding-parameters-that-process-command-line-input.md).|
|[GetProc03 Code Samples](./getproc03-code-samples.md)|This is the `Get-Process` cmdlet sample described in [Adding Parameters that Process Pipeline Input](../cmdlet/adding-parameters-that-process-pipeline-input.md).|
|[GetProc04 Code Samples](./getproc04-code-samples.md)|This is the `Get-Process` cmdlet sample described in [Adding Nonterminating Error Reporting to Your Cmdlet](../cmdlet/adding-non-terminating-error-reporting-to-your-cmdlet.md).|
|[GetProc05 Code Samples](./getproc05-code-samples.md)|This `Get-Process` cmdlet is similar to the cmdlet described in [Adding Nonterminating Error Reporting to Your Cmdlet](../cmdlet/adding-non-terminating-error-reporting-to-your-cmdlet.md).|
|[StopProc01 Code Samples](./stopproc01-code-samples.md)|This is the `Stop-Process` cmdlet sample described in [Creating a Cmdlet That Modifies the System](../cmdlet/creating-a-cmdlet-that-modifies-the-system.md).|
|[StopProcessSample04 Code Samples](./stopprocesssample04-code-samples.md)|This is the `Stop-Process` cmdlet sample described in [Adding Parameter Sets to a Cmdlet](../cmdlet/adding-parameter-sets-to-a-cmdlet.md).|
|[Runspace01 Code Samples](./runspace01-code-samples.md)|These are the code samples for the runspace described in [Creating a Console Application That Runs a Specified Command](/dotnet/csharp/programming-guide/inside-a-program/hello-world-your-first-program).|
|[Runspace02 Code Samples](./runspace02-code-samples.md)|This sample uses the [System.Management.Automation.Runspaceinvoke](/dotnet/api/System.Management.Automation.RunspaceInvoke) class to execute the `Get-Process` cmdlet synchronously.|
|[RunSpace03 Code Samples](./runspace03-code-samples.md)|These are the code samples for the runspace described in [Creating a Console Application That Runs a Specified Script](fd).|
|[RunSpace04 Code Samples](./runspace04-code-samples.md)|This is a code sample for a runspace that uses the [System.Management.Automation.Runspaceinvoke](/dotnet/api/System.Management.Automation.RunspaceInvoke) class to execute a script that generates a terminating error.|
|[RunSpace05 Code Sample](./runspace05-code-sample.md)|This is the source code for the Runspace05 sample described in [Configuring a Runspace Using RunspaceConfiguration](https://msdn.microsoft.com/en-us/42681d19-2d05-4975-befd-afb1990e79b2).|
|[RunSpace06 Code Sample](./runspace06-code-sample.md)|This is the source code for the Runspace06 sample described in [Configuring a Runspace Using a Windows PowerShell Snap-in](https://msdn.microsoft.com/en-us/a7289ee8-9732-49ee-91c7-d533e9538b83).|
|[RunSpace07 Code Sample](./runspace07-code-sample.md)|This is the source code for the Runspace07 sample described in [Creating a Console Application That Adds Commands to a Pipeline](https://msdn.microsoft.com/en-us/01eb7808-e97b-4905-80be-9e2fa38c262e).|
|[RunSpace08 Code Sample](./runspace08-code-sample.md)|This is the source code for the Runspace08 sample described in [Creating a Console Application That Adds Parameters to a Command](https://msdn.microsoft.com/en-us/848b2b46-60f1-4a86-b448-cfc7c0cccfba).|
|[RunSpace09 Code Sample](./runspace09-code-sample.md)|This is the source code for the Runspace09 sample described in [Creating a Console Application That Invokes a Pipeline Asynchronously](https://msdn.microsoft.com/en-us/198c1c94-2a06-457e-93ce-c0d910618e47).|
|[RunSpace10 Code Sample](./runspace10-code-sample.md)|This is the source code for the Runspace10 sample, which adds a cmdlet to [System.Management.Automation.Runspaces.Runspaceconfiguration](/dotnet/api/System.Management.Automation.Runspaces.RunspaceConfiguration) and then uses the modified configuration information to create the runspace.|

## See Also

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)
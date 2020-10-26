---
ms.date: 09/13/2016
ms.topic: reference
title: AccessDbProviderSample01 Code Sample
description: AccessDbProviderSample01 Code Sample
---
# AccessDbProviderSample01 Code Sample

The following code shows the implementation of the Windows PowerShell provider described in
[Creating a Basic Windows PowerShell Provider](./creating-a-basic-windows-powershell-provider.md).
This implementation provides methods for starting and stopping the provider, and although it does
not provide a means to access a data store or to get or set the data in the data store, it does
provide the basic functionality that is required by all providers.

> [!NOTE]
> You can download the C# source file (AccessDBSampleProvider01.cs) for this provider by using the
> Windows Software Development Kit for Windows Vista and Microsoft .NET Framework 3.0 Runtime
> Components. For download instructions, see
> [How to Install Windows PowerShell and Download the Windows PowerShell SDK](/powershell/scripting/developer/installing-the-windows-powershell-sdk).
> The downloaded source files are available in the **\<PowerShell Samples>** directory. For more
> information about other Windows PowerShell provider implementations, see
> [Designing Your Windows PowerShell Provider](./designing-your-windows-powershell-provider.md).

## Code Sample

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample01/AccessDBProviderSample01.cs" range="11-30":::

## See Also

[Windows PowerShell Programmer's Guide](./windows-powershell-programmer-s-guide.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)

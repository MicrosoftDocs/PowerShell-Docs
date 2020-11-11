---
ms.date: 09/13/2016
ms.topic: reference
title: AccessDbProviderSample04 Code Sample
description: AccessDbProviderSample04 Code Sample
---
# AccessDbProviderSample04 Code Sample

The following code shows the implementation of the Windows PowerShell provider described in
[Creating a Windows PowerShell Container Provider](./creating-a-windows-powershell-container-provider.md).
This provider works on multi-layer data stores. For this type of data store, the top level of the
store contains the root items and each subsequent level is referred to as a node of child items. By
allowing the user to work on these child nodes, a user can interact hierarchically through the data
store.

## Code Sample

:::code language="csharp" source="~/../powershell-sdk-samples/SDK-2.0/csharp/AccessDBProviderSample04/AccessDBProviderSample04.cs" range="11-1635":::

## See Also

[Windows PowerShell SDK](../windows-powershell-reference.md)

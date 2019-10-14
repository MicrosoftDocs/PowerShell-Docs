---
title: "Attributes in Cmdlet Code | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: aea8d293-c45b-41eb-8385-548f7c9b280b
caps.latest.revision: 10
---
# Attributes in Cmdlet Code

To use the common functionality provided by Windows PowerShell, the classes and public properties defined in the cmdlet code are decorated with attributes. For example, the following class definition uses the Cmdlet attribute to identify the Microsoft .NET Framework class in which the **Get-Proc** cmdlet is implemented. (This cmdlet is used as an example in this document, and is similar to the `Get-Process` cmdlet provided by Windows PowerShell.)

```csharp
[Cmdlet(VerbsCommon.Get, "Proc")]
public class GetProcCommand : Cmdlet
```

These attributes are considered metadata because their implementation is separate from the implementation of the cmdlet code. When the Windows PowerShell runtime runs the cmdlet, it recognizes the attributes and then performs the appropriate action for each attribute.

Although you might want to implement your own version of the functionality provided by these attributes, a good cmdlet design uses these common functionalities.

For more information about the different attributes that can be declared in your cmdlets, see [Attribute Types](./attribute-types.md).

## See Also

[Attribute Types](./attribute-types.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

---
title: "Defining Default Methods for Objects | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 53fe744a-485f-4c21-9623-1cb546372211
caps.latest.revision: 9
---
# Defining Default Methods for Objects

When you extend .NET Framework objects, you can add code methods and script methods to the objects. The XML that is used to define these methods is described in the following sections.

> [!NOTE]
> The examples in the following sections are from the Types.ps1xml types file in the Windows PowerShell installation directory (`$pshome`).

## Code Methods

A code method references a static method of a .NET Framework object.

In the following example, the **ConvertLargeIntegerToInt64** method is added to the [System.Xml.Xmlnode?Displayproperty=Fullname](/dotnet/api/System.Xml.XmlNode) type. The [CodeMethod](https://msdn.microsoft.com/1ea9b031-bbcf-4e35-b497-bf30fa0b1b05) element defines the extended method as a code method. The [Name](https://msdn.microsoft.com/b58e9d21-c8c9-49a5-909e-9c1cfc64f873) element specifies the name of the extended method. And, the [CodeReference](https://msdn.microsoft.com/70017b85-18d2-4f55-8357-92f309d5618b) element specifies the static method. (You can also add the [CodeMethod](https://msdn.microsoft.com/1ea9b031-bbcf-4e35-b497-bf30fa0b1b05) element to the members of the [MemberSets](https://msdn.microsoft.com/46a50fb5-e150-4c03-8584-e1b53e4d49e3) element.)

```xml
<Type>
  <Name>System.Xml.XmlNode</Name>
  <Members>
    <CodeMethod>
      <Name>ToString</Name>
      <CodeReference>
        <TypeName>Microsoft.PowerShell.ToStringCodemethods</TypeName>
        <MethodName>XmlNode</MethodName>
      </CodeReference>
    </CodeMethod>
  </Members>
</Type>
```

## Script Methods

A script method defines a method whose value is the output of a script. In the following example, the **ConvertToDateTime** method is added to the [System.Management.Managementobject?Displayproperty=Fullname](/dotnet/api/System.Management.ManagementObject) type. The [ScriptMethod](https://msdn.microsoft.com/59f8160f-bc95-42f0-92e2-b16a616bc65c) element defines the extended method as a script method. The [Name](https://msdn.microsoft.com/b58e9d21-c8c9-49a5-909e-9c1cfc64f873) element specifies the name of the extended method. And, the [Script](https://msdn.microsoft.com/1937ad1b-bb2b-4512-9864-01fc0767d46f) element specifies the script that generates the method value. (You can also add the [ScriptMethod](https://msdn.microsoft.com/59f8160f-bc95-42f0-92e2-b16a616bc65c) element to the members of the [MemberSets](https://msdn.microsoft.com/46a50fb5-e150-4c03-8584-e1b53e4d49e3) element.)

```xml
<Type>
  <Name>System.Management.ManagementObject</Name>
  <Members>
    <ScriptMethod>
      <Name>ConvertToDateTime</Name>
      <Script>
        [System.Management.ManagementDateTimeConverter]::ToDateTime($args[0])
      </Script>
    </ScriptMethod>
  </Members>
</Type>
```

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)
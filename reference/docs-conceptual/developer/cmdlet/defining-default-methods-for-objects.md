---
ms.date: 09/13/2016
ms.topic: reference
title: Defining Default Methods for Objects
description: Defining Default Methods for Objects
---

# Defining Default Methods for Objects

When you extend .NET Framework objects, you can add code methods and script methods to the objects.
The XML that is used to define these methods is described in the following sections.

> [!NOTE]
> The examples in the following sections are from the `Types.ps1xml` types file in the Windows
> PowerShell installation directory (`$PSHOME`). For more information, see
> [About Types.ps1xml](/powershell/module/microsoft.powershell.core/about/about_types.ps1xml).

## Code methods

A code method references a static method of a .NET Framework object.

In the following example, the **ToString** method is added to the
[System.Xml.XmlNode](/dotnet/api/System.Xml.XmlNode) type. The
[PSCodeMethod](/dotnet/api/system.management.automation.pscodemethod) element defines the extended
method as a code method. The
[Name](/dotnet/api/system.management.automation.psmemberinfo.name#System_Management_Automation_PSMemberInfo_Name)
element specifies the name of the extended method. And, the
[CodeReference](/dotnet/api/system.management.automation.pscodemethod.codereference#System_Management_Automation_PSCodeMethod_CodeReference)
element specifies the static method. You can also add the
[PSCodeMethod](/dotnet/api/system.management.automation.pscodemethod) element to the members of the
[PSMemberSets](/dotnet/api/system.management.automation.psmemberset) element.

```xml
<Type>
  <Name>System.Xml.XmlNode</Name>
  <Members>
    <CodeMethod>
      <Name>ToString</Name>
      <CodeReference>
        <TypeName>Microsoft.PowerShell.ToStringCodeMethods</TypeName>
        <MethodName>XmlNode</MethodName>
      </CodeReference>
    </CodeMethod>
  </Members>
</Type>
```

## Script methods

A script method defines a method whose value is the output of a script. In the following example,
the **ConvertToDateTime** method is added to the
[System.Management.ManagementObject](/dotnet/api/System.Management.ManagementObject) type. The
[PSScriptMethod](/dotnet/api/system.management.automation.psscriptmethod) element defines the
extended method as a script method. The
[Name](/dotnet/api/system.management.automation.psmemberinfo.name#System_Management_Automation_PSMemberInfo_Name)
element specifies the name of the extended method. And, the
[Script](/dotnet/api/system.management.automation.psscriptmethod.script#System_Management_Automation_PSScriptMethod_Script)
element specifies the script that generates the method value. You can also add the
[PSScriptMethod](/dotnet/api/system.management.automation.psscriptmethod) element to the members of
the [PSMemberSets](/dotnet/api/system.management.automation.psmemberset) element.

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

## See also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

---
ms.date: 08/21/2019
ms.topic: reference
title: Extending Properties for Objects
description: Extending Properties for Objects
---

# Extending Properties for Objects

When you extend .NET Framework objects, you can add alias properties, code properties, note
properties, script properties, and property sets to the objects. The XML that defines these
properties is described in the following sections.

> [!NOTE]
> The examples in the following sections are from the default `Types.ps1xml` types file in the
> PowerShell installation directory (`$PSHOME`). For more information, see [About Types.ps1xml](/powershell/module/microsoft.powershell.core/about/about_types.ps1xml).

## Alias properties

An alias property defines a new name for an existing property.

In the following example, the **Count** property is added to the [System.Array](/dotnet/api/System.Array)
type. The [AliasProperty](/dotnet/api/system.management.automation.psaliasproperty) element defines
the extended property as an alias property. The [Name](/dotnet/api/system.management.automation.psmemberinfo.name)
element specifies the new name. And, the
[ReferencedMemberName](/dotnet/api/system.management.automation.psaliasproperty.referencedmembername)
element specifies the existing property that is referenced by the alias. You can also add the
`AliasProperty` element to the members of the [MemberSets](/dotnet/api/system.management.automation.psmemberset)
element.

```xml
<Type>
  <Name>System.Array</Name>
  <Members>
    <AliasProperty>
      <Name>Count</Name>
      <ReferencedMemberName>Length</ReferencedMemberName>
    </AliasProperty>
  </Members>
</Type>
```

## Code properties

A code property references a static property of a .NET Framework object.

In the following example, the **Mode** property is added to the [System.IO.DirectoryInfo](/dotnet/api/System.IO.DirectoryInfo)
type. The [CodeProperty](/dotnet/api/system.management.automation.pscodeproperty) element defines
the extended property as a code property. The [Name](/dotnet/api/system.management.automation.psmemberinfo.name)
element specifies the name of the extended property. And, the [GetCodeReference](/dotnet/api/system.management.automation.pscodeproperty.gettercodereference)
element defines the static method that is referenced by the extended property. You can also add the
`CodeProperty` element to the members of the [MemberSets](/dotnet/api/system.management.automation.psmemberset)
element.

```xml
<Type>
  <Name>System.IO.DirectoryInfo</Name>
  <Members>
    <CodeProperty>
      <Name>Mode</Name>
      <GetCodeReference>
        <TypeName>Microsoft.PowerShell.Commands.FileSystemProvider</TypeName>
        <MethodName>Mode</MethodName>
      </GetCodeReference>
    </CodeProperty>
  </Members>
</Type>
```

## Note properties

A note property defines a property that has a static value.

In the following example, the **Status** property, whose value is always **Success**, is added to
the [System.IO.DirectoryInfo](/dotnet/api/System.IO.DirectoryInfo) type. The [NoteProperty](/dotnet/api/system.management.automation.psnoteproperty)
element defines the extended property as a note property. The [Name](/dotnet/api/system.management.automation.psmemberinfo.name)
element specifies the name of the extended property. The [Value](/dotnet/api/system.management.automation.psnoteproperty.value)
element specifies the static value of the extended property. The `NoteProperty` element can also be
added to the members of the [MemberSets](/dotnet/api/system.management.automation.psmemberset)
element.

```xml
<Type>
  <Name>System.IO.DirectoryInfo</Name>
  <Members>
    <NoteProperty>
      <Name>Status</Name>
      <Value>Success</Value>
    </NoteProperty>
  </Members>
</Type>
```

## Script properties

A script property defines a property whose value is the output of a script.

In the following example, the **VersionInfo** property is added to the [System.IO.FileInfo](/dotnet/api/System.IO.FileInfo)
type. The [ScriptProperty](/dotnet/api/system.management.automation.psscriptproperty) element
defines the extended property as a script property. The [Name](/dotnet/api/system.management.automation.psmemberinfo.name)
element specifies the name of the extended property. And, the [GetScriptBlock](/dotnet/api/system.management.automation.psscriptproperty.getterscript)
element specifies the script that generates the property value. You can also add the
`ScriptProperty` element to the members of the [MemberSets](/dotnet/api/system.management.automation.psmemberset)
element.

```xml
<Type>
  <Name>System.IO.FileInfo</Name>
  <Members>
    <ScriptProperty>
      <Name>VersionInfo</Name>
      <GetScriptBlock>
        [System.Diagnostics.FileVersionInfo]::GetVersionInfo($this.FullName)
      </GetScriptBlock>
    </ScriptProperty>
  </Members>
</Type>
```

## Property sets

A property set defines a group of extended properties that can be referenced by the name of the set.
For example, the [Format-Table](/powershell/module/Microsoft.PowerShell.Utility/Format-Table)
**Property** parameter can specify a specific property set to be displayed. When a property set is
specified, only those properties that belong to the set are displayed.

There's no restriction on the number of property sets that can be defined for an object. However,
the property sets used to define the default display properties of an object must be specified
within the **PSStandardMembers** member set. In the `Types.ps1xml` types file, the default property
set names include **DefaultDisplayProperty**, **DefaultDisplayPropertySet**, and
**DefaultKeyPropertySet**. Any additional property sets that you add to the **PSStandardMembers**
member set are ignored.

In the following example, the **DefaultDisplayPropertySet** property set is added to the
**PSStandardMembers** member set of the [System.Serviceprocess.Servicecontroller](/dotnet/api/System.ServiceProcess.ServiceController)
type. The [PropertySet](/dotnet/api/system.management.automation.pspropertyset) element defines the
group of properties. The [Name](/dotnet/api/system.management.automation.psmemberinfo.name) element
specifies the name of the property set. And, the
[ReferencedProperties](/dotnet/api/system.management.automation.pspropertyset.referencedpropertynames)
element specifies the properties of the set. You can also add the `PropertySet` element to the
members of the [Type](/dotnet/api/system.management.automation.pstypename) element.

```xml
<Type>
  <Name>System.ServiceProcess.ServiceController</Name>
  <Members>
    <MemberSet>
      <Name>PSStandardMembers</Name>
      <Members>
        <PropertySet>
           <Name>DefaultDisplayPropertySet</Name>
           <ReferencedProperties>
            <Name>Status</Name
            <Name>Name</Name>
            <Name>DisplayName</Name>
          </ReferencedProperties>
        </PropertySet>
      </Members>
    </MemberSet>
  </Members>
</Type>
```

## See also

[About Types.ps1xml](/powershell/module/microsoft.powershell.core/about/about_types.ps1xml)

[System.Management.Automation](/dotnet/api/System.Management.Automation)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

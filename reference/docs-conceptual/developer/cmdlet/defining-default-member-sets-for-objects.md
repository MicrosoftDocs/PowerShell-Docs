---
ms.date: 09/13/2016
ms.topic: reference
title: Defining Default Member Sets for Objects
description: Defining Default Member Sets for Objects
---
# Defining Default Member Sets for Objects

The PSStandardMembers member set is used by Windows PowerShell to define the default property sets for an object. The default property sets can be used by commands such as the formatting cmdlets to display only those properties that are defined by the property set. The default property sets include DefaultDisplayProperty, DefaultDisplayPropertySet, and DefaultKeyPropertySet. Windows PowerShell ignores all other member sets and any other property sets added to the PSStandardMembers member set.

## Member Set for System.Diagnostics.Process

In the following example, the PSStandardMembers member set defines the DefaultDisplayPropertySet property set for [System.Diagnostics.Process](/dotnet/api/System.Diagnostics.Process) objects. This property set is used by the [Format-List](/powershell/module/Microsoft.PowerShell.Utility/Format-List) cmdlet.

```xml
<Type>
  <Name>System.Diagnostics.Process</Name>
  <Members>
    <MemberSet>
     <Name>PSStandardMembers</Name>
     <Members>
       <PropertySet>
         <Name>DefaultDisplayPropertySet</Name>
         <ReferencedProperties>
           <Name>Id</Name>
           <Name>Handles</Name>
           <Name>CPU</Name>
           <Name>Name</Name>
         </ReferencedProperties>
      </PropertySet>
    </Members>
  </MemberSet>
```

The following output shows the default properties returned by the [Format-List](/powershell/module/Microsoft.PowerShell.Utility/Format-List) cmdlet. Only the `Id`, `Handles`, `CPU`, and `Name` properties are returned for each process object.

```powershell
Get-Process | format-list
```

```output
Id      : 2036
Handles : 27
CPU     :
Name    : AEADISRV

Id      : 272
Handles : 38
CPU     :
Name    : agrsmsvc
...
```

## See Also

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

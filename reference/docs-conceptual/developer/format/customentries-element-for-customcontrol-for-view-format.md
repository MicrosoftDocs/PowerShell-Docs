---
title: "CustomEntries Element for CustomControl for View (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: cb412831-94f7-4054-b19e-32c1b14c66dd
caps.latest.revision: 11
---
# CustomEntries Element for CustomControl for View (Format)

Provides the definitions of the custom control view. The custom control view must specify one or more definitions.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
CustomControl Element (Format)
CustomEntries Element for CustomControl for View (Format)

## Syntax

```xml
<CustomEntries>
  <CustomEntry>...</CustomEntry>
</CustomEntries>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `CustomControlEntries` element. You must specify one or more child elements.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[CustomEntry Element for CustomEntries for View (Format)](./customentry-element-for-customentries-for-customcontrol-for-view-format.md)|Required element.<br /><br /> Provides a definition of the custom control view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomControl Element for View (Format)](./customcontrol-element-for-view-format.md)|Required element.<br /><br /> Defines a custom control format for the view.|

## Remarks

In most cases, a control has only one definition, which is defined in a single `CustomEntry` element. However it is possible to have multiple definitions if you want to use the same control to display different .NET objects. In those cases, you can define a `CustomEntry` element for each object or set of objects.

## See Also

[CustomControl Element for View (Format)](./customcontrol-element-for-view-format.md)

[CustomEntry Element for CustomEntries for View (Format)](./customentry-element-for-customentries-for-customcontrol-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

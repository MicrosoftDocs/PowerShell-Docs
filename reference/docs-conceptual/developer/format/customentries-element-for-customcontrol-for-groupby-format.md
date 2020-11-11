---
ms.date: 09/13/2016
ms.topic: reference
title: CustomEntries Element for CustomControl for GroupBy (Format)
description: CustomEntries Element for CustomControl for GroupBy (Format)
---
# CustomEntries Element for CustomControl for GroupBy (Format)

Provides the definitions for the control. This element is used when defining how a new group of objects is displayed.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
GroupBy Element for View (Format)
CustomControl Element for GroupBy (Format)
CustomEntries Element for CustomControl for GroupBy (Format)

## Syntax

```xml
<CustomEntries>
  <CustomEntry>...</CustomEntry>
</CustomEntries>
```

## Attributes and Elements

The following sections describe attributes, child elements, and parent elements of the `CustomEntries` element. There is no maximum limit to the number of child elements that can be specified.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[CustomEntry Element for CustomControl for GroupBy (Format)](./customentry-element-for-customcontrol-for-groupby-format.md)|Required element.<br /><br /> Provides a definition of the control.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomControl Element for GroupBy (Format)](./customcontrol-element-for-groupby-format.md)|Defines the custom control that displays the new group.|

## Remarks

In most cases, a control has only one definition, which is specified in a single `CustomEntry` element. However, it is possible to provide multiple definitions if you want to use the same control to display different groups. In those cases, you can define a `CustomEntry` element for a group.

## See Also

[CustomEntry Element for CustomEntries for Controls for View (Format)](./customentry-element-for-customentries-for-controls-for-view-format.md)

[CustomControl Element for GroupBy (Format)](./customcontrol-element-for-groupby-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

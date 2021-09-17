---
description: CustomEntries Element for CustomControl for Controls for View
ms.date: 08/20/2021
ms.topic: reference
title: CustomEntries Element for CustomControl for Controls for View
---
# CustomEntries Element for CustomControl for Controls for View

Provides the definitions for the control. This element is used when defining controls that can be
used by a view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- Controls Element
- Control Element
- CustomControl Element
- CustomEntries Element

## Syntax

```xml
<CustomEntries>
  <CustomEntry>...</CustomEntry>
</CustomEntries>
```

## Attributes and Elements

The following sections describe attributes, child elements, and parent elements of the
`CustomEntries` element. There is no maximum limit to the number of child elements that can be
specified.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[CustomEntry Element for CustomEntries for Controls for View](./customentry-element-for-customentries-for-controls-for-view-format.md)|Required element.<br /><br /> Provides a definition of the control.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomControl Element for Control for Controls for View](./customcontrol-element-for-control-for-controls-for-view-format.md)|Defines the control used by the view.|

## Remarks

In most cases, a control has only one definition, which is specified in a single `CustomEntry`
element. However, it is possible to provide multiple definitions if you want to use the same control
to display different .NET objects. In those cases, you can define a `CustomEntry` element for each
object or set of objects.

## See Also

[CustomEntry Element for CustomEntries for Controls for View](./customentry-element-for-customentries-for-controls-for-view-format.md)

[CustomControl Element for Control for Controls for View](./customcontrol-element-for-control-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

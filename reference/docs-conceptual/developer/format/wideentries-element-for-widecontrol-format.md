---
ms.date: 09/13/2016
ms.topic: reference
title: WideEntries Element for WideControl (Format)
description: WideEntries Element for WideControl (Format)
---
# WideEntries Element for WideControl (Format)

Provides the definitions of the wide view. The wide view must specify one or more definitions.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
WideControl Element (Format)
WideEntries Element (Format)

## Syntax

```xml
<WideEntries>
  <WideEntry>...</WideEntry>
</WideEntries>

```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent element of the `WideEntries` element. At least one child element must be specified.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[WideEntry Element (Format)](./wideentry-element-for-widecontrol-format.md)|Provides a definition of the wide view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[WideControl Element (Format)](./widecontrol-element-format.md)|Defines a wide (single value) list format for the view.|

## Remarks

A wide view is a list format that displays a single property value or script value for each object. For more information about the components of a wide view, see [Wide View Components](./creating-a-wide-view.md).

## Example

The following example shows a `WideEntries` element that defines a single `WideEntry` element. The `WideEntry` element contains a single `WideItem` element that defines what property or script value is displayed in the view.

```xml
<WideControl>
  <WideEntries>
    <WideEntry>
      <WideItem>...</WideItem>
    <WideEntry>
  </WideEntries>
</WideControl>
```

For a complete example of a wide view, see [Wide View (Basic)](./wide-view-basic.md).

## See Also

[Creating a Wide View](./creating-a-wide-view.md)

[WideControl Element (Format)](./widecontrol-element-format.md)

[WideEntry Element (Format)](./wideentry-element-for-widecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

---
ms.date: 09/13/2016
ms.topic: reference
title: AutoSize Element for WideControl (Format)
description: AutoSize Element for WideControl (Format)
---
# AutoSize Element for WideControl (Format)

Specifies whether the column size and the number of columns are adjusted based on the size of the data.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
WideControl Element (Format)
Autosize Element for WideControl (Format)

## Syntax

```xml
<AutoSize/>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `AutoSize` element.

### Attributes

None.

### Child Elements

None

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[WideControl Element (Format)](./widecontrol-element-format.md)|Defines a wide (single value) list format for the view.|

## Remarks

When defining a wide view, you can add the `AutoSize` element or the [ColumnNumber](./columnnumber-element-for-widecontrol-format.md) element, but you cannot add both.

For more information about the components of a wide view, see [Creating a Wide View](./creating-a-wide-view.md).

For an example of a wide view, see [Wide View (Basic)](./wide-view-basic.md).

## See Also

[ColumnNumber Element for WideControl (Format)](./columnnumber-element-for-widecontrol-format.md)

[Creating a Wide View](./creating-a-wide-view.md)

[WideControl Element (Format)](./widecontrol-element-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

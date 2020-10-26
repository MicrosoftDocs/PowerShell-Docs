---
ms.date: 09/13/2016
ms.topic: reference
title: WideControl Element (Format)
description: WideControl Element (Format)
---
# WideControl Element (Format)

Defines a wide (single value) list format for the view. This view displays a single property value or script value for each object.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
WideControl Element (Format)

## Syntax

```xml
<WideControl>
  <AutoSize/>
  <ColumnNumber>PositiveInteger</ColumnNumber>
  <WideEntries>...</WideEntries>
</WideControl>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent element of the `WideControl` element. You cannot specify the `AutoSize` and `ColumnNumber` elements at the same time.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[AutoSize Element for WideControl (Format)](./autosize-element-for-widecontrol-format.md)|Optional element.<br /><br /> Specifies whether the column size and the number of columns are adjusted based on the size of the data.|
|[ColumnNumber Element for WideControl (Format)](./columnnumber-element-for-widecontrol-format.md)|Optional element.<br /><br /> Specifies the number of columns displayed in the wide view.|
|[WideEntries Element (Format)](./wideentries-element-for-widecontrol-format.md)|Required element.<br /><br /> Provides the definitions of the wide view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[View Element (Format)](./view-element-format.md)|Defines a view that is used to display one or more .NET objects.|

## Remarks

When defining a wide view, you can add the `AutoSize` element or the `ColumnNumber` but you cannot add both.

In most cases, only one definition is required for each wide view, but it is possible to have multiple definitions if you want to use the same view to display different .NET objects. In those cases, you can provide a separate definition for each object or set of objects.

For more information about the components of a wide view, see [Wide View Components](./creating-a-wide-view.md).

## Example

The following example shows a `WideControl` element that is used to display a property of the [System.Diagnostics.Process](/dotnet/api/System.Diagnostics.Process) object.

```xml
<View>
  <Name>process</Name>
  <ViewSelectedBy>
    <TypeName>System.Diagnostics.Process</TypeName>
  </ViewSelectedBy>
  <WideControl>
    <WideEntries>...</WideEntries>
  </WideControl>
</View>
```

For a complete example of a wide view, see [Wide View (Basic)](./wide-view-basic.md).

## See Also

[Autosize Element for WideControl (Format)](./autosize-element-for-widecontrol-format.md)

[ColumnNumber Element for WideControl (Format)](./columnnumber-element-for-widecontrol-format.md)

[View Element (Format)](./view-element-format.md)

[WideEntries Element (Format)](./wideentries-element-for-widecontrol-format.md)

[Wide View (Basic)](./wide-view-basic.md)

[Creating a Wide View](./creating-a-wide-view.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

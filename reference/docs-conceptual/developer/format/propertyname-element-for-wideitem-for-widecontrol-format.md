---
ms.date: 09/13/2016
ms.topic: reference
title: PropertyName Element for WideItem for WideControl (Format)
description: PropertyName Element for WideItem for WideControl (Format)
---
# PropertyName Element for WideItem for WideControl (Format)

Specifies the property of the object whose value is displayed in the wide view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
WideControl Element (Format)
WideEntries Element (Format)
WideEntry Element (Format)
WideItem Element (Format)
PropertyName Element for WideItem (Format)

## Syntax

```xml
<PropertyName>.NetTypeProperty</PropertyName>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent element of the `PropertyName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[WideItem Element (Format)](./wideitem-element-for-widecontrol-format.md)|Defines the property or script whose value is displayed in the wide view.|

## Text Value

Specify the name of the property whose value is displayed.

## Remarks

For more information about the components of a wide view, see [Creating a Wide View](./creating-a-wide-view.md).

## Example

This example shows a wide view that displays the value of the ProcessName property of the [System.Diagnostics.Process](/dotnet/api/System.Diagnostics.Process) object.

```xml
View>
  <Name>process</Name>
  <ViewSelectedBy>
    <TypeName>System.Diagnostics.Process</TypeName>
  </ViewSelectedBy>
  <WideControl>
    <WideEntries>
      <WideEntry>
        <WideItem>
          <PropertyName>ProcessName</PropertyName>
        </WideItem>
      </WideEntry>
    </WideEntries>
  </WideControl>
</View>

```

## See Also

[WideItem Element (Format)](./wideitem-element-for-widecontrol-format.md)

[Creating a Wide View](./creating-a-wide-view.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

---
ms.date: 09/13/2016
ms.topic: reference
title: PropertyName Element for GroupBy (Format)
description: PropertyName Element for GroupBy (Format)
---
# PropertyName Element for GroupBy (Format)

Specifies the .NET property that starts a new group whenever its value changes.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
GroupBy Element for View (Format)
PropertyName Element for GroupBy (Format)

## Syntax

```xml
<PropertyName>.NetTypeProperty</PropertyName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `PropertyName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[GroupBy Element for View (Format)](./groupby-element-for-view-format.md)|Defines how a group of .NET objects is displayed.|

## Text Value

Specify the .NET property name.

## Remarks

Windows PowerShell starts a new group whenever the value of this property changes.

When this element is specified, you cannot specify the [ScriptBlock](./scriptblock-element-for-groupby-format.md) element to start a new group.

## Example

The following example shows how to start a new group when the value of a property changes.

```xml
<GroupBy>
  <Label>Service Type</Label>
  <PropertyName>ServiceType</PropertyName>
</GroupBy>

```

For an example of a complete formatting file that includes this element, see [Wide View (GroupBy)](./wide-view-groupby.md).

## See Also

[GroupBy Element for View (Format)](./groupby-element-for-view-format.md)

[ScriptBlock Element for GroupBy (Format)](./scriptblock-element-for-groupby-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

---
ms.date: 09/13/2016
ms.topic: reference
title: PropertyName Element for ListItem for ListControl (Format)
description: PropertyName Element for ListItem for ListControl (Format)
---
# PropertyName Element for ListItem for ListControl (Format)

Specifies the .NET property whose value is displayed in the list.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
ListControl Element (Format)
ListEntries Element (Format)
ListEntry Element (Format)
ListItems Element (Format)
ListItem Element (Format)
PropertyName Element for ListItem (Format)

## Syntax

```xml
<PropertyName>.NetTypeProperty</PropertyName>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the `PropertyName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ListItem Element (Format)](./listitem-element-for-listitems-for-listcontrol-format.md)|Defines the property or script whose value is displayed in the row of the list view.|

## Text Value

Specify the name of the property whose value is displayed.

## Remarks

When this element is specified, you cannot specify the [ScriptBlock](./scriptblock-element-for-listitem-for-listcontrol-format.md) element.

In addition to displaying the property value, you can also specify a label for the value or a format string that can be used to change the display of the value. For more information about specifying data in a list view, see [Creating a List View](./creating-a-list-view.md).

## Example

The following example shows how to specify the label and property whose value is displayed.

```xml
ListItem>
  <Label>NameOfProperty</Label>
  <PropertyName>.NetTypeProperty</PropertyName>
</ListItem>

```

## See Also

[ScriptBlock Element for ListItem for ListControl (Format)](./scriptblock-element-for-listitem-for-listcontrol-format.md)

[Creating a List View](./creating-a-list-view.md)

[ListItem Element for ListControl(Format)](./listitem-element-for-listitems-for-listcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

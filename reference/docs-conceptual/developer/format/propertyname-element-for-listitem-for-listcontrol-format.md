---
description: PropertyName Element for ListItem for ListControl
ms.date: 08/24/2021
ms.topic: reference
title: PropertyName Element for ListItem for ListControl
---
# PropertyName Element for ListItem for ListControl

Specifies the .NET property whose value is displayed in the list.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- ListControl Element
- ListEntries Element
- ListEntry Element
- ListItems Element
- ListItem Element
- PropertyName Element

## Syntax

```xml
<PropertyName>.NetTypeProperty</PropertyName>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the
`PropertyName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ListItem Element](./listitem-element-for-listitems-for-listcontrol-format.md)|Defines the property or script whose value is displayed in the row of the list view.|

## Text Value

Specify the name of the property whose value is displayed.

## Remarks

When this element is specified, you cannot specify the [ScriptBlock](./scriptblock-element-for-listitem-for-listcontrol-format.md) element.

In addition to displaying the property value, you can also specify a label for the value or a format
string that can be used to change the display of the value. For more information about specifying
data in a list view, see [Creating a List View](./creating-a-list-view.md).

## Example

The following example shows how to specify the label and property whose value is displayed.

```xml
ListItem>
  <Label>NameOfProperty</Label>
  <PropertyName>.NetTypeProperty</PropertyName>
</ListItem>

```

## See Also

[ScriptBlock Element for ListItem for ListControl](./scriptblock-element-for-listitem-for-listcontrol-format.md)

[Creating a List View](./creating-a-list-view.md)

[ListItem Element for ListControl(Format)](./listitem-element-for-listitems-for-listcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

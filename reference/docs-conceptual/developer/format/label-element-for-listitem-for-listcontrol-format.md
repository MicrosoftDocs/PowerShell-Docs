---
ms.date: 09/13/2016
ms.topic: reference
title: Label Element for ListItem for ListControl (Format)
description: Label Element for ListItem for ListControl (Format)
---
# Label Element for ListItem for ListControl (Format)

Specifies the label that is displayed to the left of the property or script value in the row.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
ListControl Element (Format)
ListEntries Element for ListControl (Format)
ListEntry Element for ListControl (Format)
ListItems for ListEntry for ListControl Element (Format)
ListItem Element for ListItems for ListControl (Format)
Label Element for ListItem for ListControl (Format)

## Syntax

```xml
<Label>Label for displayed value</Label>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the `Label` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ListItem Element for ListItems for ListControl (Format)](./listitem-element-for-listitems-for-listcontrol-format.md)|Defines the property or script whose value is displayed in a row of the list view.|

## Text Value

Specify the label to be display to the left of the property or script value.

## Remarks

If a label is not specified, the name of the property or the script is displayed. For more information about using labels in a list view, see [Creating a List View](./creating-a-list-view.md).

## Example

The following example shows how to add a label to a row.

```xml
<ListItem>
  <Label>Property1: </Label>
  <PropertyName>DotNetProperty1</PropertyName>
</ListItem>

```

## See Also

[Creating a List View](./creating-a-list-view.md)

[ListItem Element (Format)](./listitem-element-for-listitems-for-listcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

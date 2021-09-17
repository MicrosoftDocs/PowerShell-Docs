---
description: ListItems Element
ms.date: 08/23/2021
ms.topic: reference
title: ListItems Element
---
# ListItems Element

Defines the properties and scripts whose values are displayed in the rows of the list view.

- Configuration Element
- ViewDefinitions Element
- View Element
- ListControl Element
- ListEntries Element
- ListEntry Element
- ListItems Element

## Syntax

```xml
<ListItems>
  <ListItem>...</ListItem>
</ListItems>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent element of the
`ListItems` element. There is no limit to the number of child elements that can be specified. The
order of the child elements defines the order that values are displayed in the list view.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[ListItem Element for ListControl](./listitem-element-for-listitems-for-listcontrol-format.md)|Required element.<br /><br /> Defines the property or script whose value is displayed by the list view.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ListEntry Element for ListControl](./listentry-element-for-listcontrol-format.md)|Provides a definition of the list view.|

## Remarks

For more information about this type of view, see [Creating a List View](./creating-a-list-view.md).

## Example

This example shows the XML elements that define three rows of the list view.

```xml
<ListEntry>
    <ListItems>
      <ListItem>
        <Label>Property1: </Label>
        <PropertyName>.NetTypeProperty1</PropertyName>
      </ListItem>
      <ListItem>
        <PropertyName>.NetTypeProperty2</PropertyName>
      </ListItem>
      <ListItem>
        <ScriptBlock>$_.ProcessName + ":" $_.Id</ScriptBlock>
      </ListItem>
  </ListEntry>
```

## See Also

[ListEntry Element for ListControl](./listentry-element-for-listcontrol-format.md)

[ListItem Element for ListControl](./listitem-element-for-listitems-for-listcontrol-format.md)

[Creating a List View](./creating-a-list-view.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

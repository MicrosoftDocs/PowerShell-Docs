---
ms.date: 09/13/2016
ms.topic: reference
title: ScriptBlock Element for ListItem for ListControl (Format)
description: ScriptBlock Element for ListItem for ListControl (Format)
---
# ScriptBlock Element for ListItem for ListControl (Format)

Specifies the script whose value is displayed in the row.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
ListControl Element (Format)
ListEntries Element for ListControl (Format)
ListEntry Element for ListEntries for ListControl (Format)
ListItems Element for ListEntry for ListControl (Format)
ListItem Element for ListItems for ListControl (Format)
ScriptBlock Element for ListItem for ListControl (Format)

## Syntax

```xml
<ScriptBlock>ScriptToEvaluate</ScriptBlock>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the `ScriptBlock` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ListItem Element (Format)](./listitem-element-for-listitems-for-listcontrol-format.md)|Defines the property or script whose value is displayed in a row of the list view.|

## Text Value

Specify the script whose value is displayed in the row.

## Remarks

When this element is specified, you cannot specify the [PropertyName](./propertyname-element-for-listitem-for-listcontrol-format.md) element.

For more information about specifying scripts in a list view, see [List View](./creating-a-list-view.md).

## Example

The following example shows how to specify the property whose value is displayed.

```xml
<ListItem>
  <ScriptBlock>$_.ProcessName + ":" $_.Id</ScriptBlock>
</ListItem>

```

## See Also

[PropertyName Element for ListItem for ListControl (Format)](./propertyname-element-for-listitem-for-listcontrol-format.md)

[Creating a List View](./creating-a-list-view.md)

[ListItem Element for ListItems for ListControl (Format)](./listitem-element-for-listitems-for-listcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

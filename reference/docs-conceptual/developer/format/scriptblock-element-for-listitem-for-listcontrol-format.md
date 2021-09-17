---
description: ScriptBlock Element for ListItem for ListControl
ms.date: 08/24/2021
ms.topic: reference
title: ScriptBlock Element for ListItem for ListControl
---
# ScriptBlock Element for ListItem for ListControl

Specifies the script whose value is displayed in the row.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- ListControl Element
- ListEntries Element
- ListEntry Element
- ListItems Element
- ListItem Element
- ScriptBlock Element

## Syntax

```xml
<ScriptBlock>ScriptToEvaluate</ScriptBlock>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the
`ScriptBlock` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ListItem Element](./listitem-element-for-listitems-for-listcontrol-format.md)|Defines the property or script whose value is displayed in a row of the list view.|

## Text Value

Specify the script whose value is displayed in the row.

## Remarks

When this element is specified, you cannot specify the [PropertyName](./propertyname-element-for-listitem-for-listcontrol-format.md)
element.

For more information about specifying scripts in a list view, see [List View](./creating-a-list-view.md).

## Example

The following example shows how to specify the property whose value is displayed.

```xml
<ListItem>
  <ScriptBlock>$_.ProcessName + ":" $_.Id</ScriptBlock>
</ListItem>

```

## See Also

[PropertyName Element for ListItem for ListControl](./propertyname-element-for-listitem-for-listcontrol-format.md)

[Creating a List View](./creating-a-list-view.md)

[ListItem Element for ListItems for ListControl](./listitem-element-for-listitems-for-listcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

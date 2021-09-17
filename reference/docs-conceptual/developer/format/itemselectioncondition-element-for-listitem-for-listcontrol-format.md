---
description: ItemSelectionCondition Element for ListItem for ListControl
ms.date: 08/23/2021
ms.topic: reference
title: ItemSelectionCondition Element for ListItem for ListControl
---
# ItemSelectionCondition Element for ListItem for ListControl

Defines the condition that must exist for this list item to be used.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- ListControl Element
- ListEntries Element
- ListEntry Element
- ListItems Element
- ListItem Element
- ItemSelectionCondition Element

## Syntax

```xml
<ItemSelectionCondition>
  <PropertyName>.NetTypeProperty</PropertyName>
  <ScriptBlock>ScriptToEvaluate</ScriptBlock>
</ItemSelectionCondition>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`ItemSelectionCondition` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[PropertyName Element for ItemSelectionCondition for ListControl](./propertyname-element-for-itemselectioncondition-for-listcontrol-format.md)|Optional element.<br /><br /> Specifies the .NET property that triggers the condition.|
|[ScriptBlock Element for ItemSelectionCondition for ListControl](./scriptblock-element-for-itemselectioncondition-for-listcontrol-format.md)|Optional element.<br /><br /> Specifies the script that triggers the condition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ListItem Element for ListItems for ListControl](./listitem-element-for-listitems-for-listcontrol-format.md)|Defines the property or script whose value is displayed in a row of the list view.|

## Remarks

You can specify one property name or a script for this condition but cannot specify both.

## See Also

[ListItem Element for ListItems for ListControl](./listitem-element-for-listitems-for-listcontrol-format.md)

[PropertyName Element for ItemSelectionCondition for ListControl](./propertyname-element-for-itemselectioncondition-for-listcontrol-format.md)

[ScriptBlock Element for ItemSelectionCondition for ListControl](./scriptblock-element-for-itemselectioncondition-for-listcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

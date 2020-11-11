---
ms.date: 09/13/2016
ms.topic: reference
title: ItemSelectionCondition Element for ListItem for ListControl (Format)
description: ItemSelectionCondition Element for ListItem for ListControl (Format)
---
# ItemSelectionCondition Element for ListItem for ListControl (Format)

Defines the condition that must exist for this list item to be used.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
ListControl Element (Format)
ListEntries Element for ListControl (Format)
ListEntry Element for ListEntries for ListControl (Format)
ListItems Element for ListEntry for ListControl (Format)
ListItem Element for ListItems for ListControl (Format)
ItemSelectionCondition Element for ListItem for ListControl (Format)

## Syntax

```xml
<ItemSelectionCondition>
  <PropertyName>.NetTypeProperty</PropertyName>
  <ScriptBlock>ScriptToEvaluate</ScriptBlock>
</ItemSelectionCondition>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `ItemSelectionCondition` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[PropertyName Element for ItemSelectionCondition for ListControl (Format)](./propertyname-element-for-itemselectioncondition-for-listcontrol-format.md)|Optional element.<br /><br /> Specifies the .NET property that triggers the condition.|
|[ScriptBlock Element for ItemSelectionCondition for ListControl (Format)](./scriptblock-element-for-itemselectioncondition-for-listcontrol-format.md)|Optional element.<br /><br /> Specifies the script that triggers the condition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[ListItem Element for ListItems for ListControl (Format)](./listitem-element-for-listitems-for-listcontrol-format.md)|Defines the property or script whose value is displayed in a row of the list view.|

## Remarks

You can specify one property name or a script for this condition but cannot specify both.

## See Also

[ListItem Element for ListItems for ListControl (Format)](./listitem-element-for-listitems-for-listcontrol-format.md)

[PropertyName Element for ItemSelectionCondition for ListControl (Format)](./propertyname-element-for-itemselectioncondition-for-listcontrol-format.md)

[ScriptBlock Element for ItemSelectionCondition for ListControl (Format)](./scriptblock-element-for-itemselectioncondition-for-listcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

---
title: "SelectionCondition Element for EntrySelectedBy for GroupBy (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 6dc2093a-dc54-42c4-ada3-c8d089ba1e8e
caps.latest.revision: 6
---
# SelectionCondition Element for EntrySelectedBy for GroupBy (Format)

Defines a condition that must exist for a control definition to be used. This element is used when defining how a new group of objects is displayed.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
GroupBy Element for View (Format)
CustomControl Element for GroupBy (Format)
CustomEntries Element for CustomControl for GroupBy (Format)
CustomEntry Element for CustomControl for GroupBy (Format)
EntrySelectedBy Element for CustomEntry for GroupBy (Format)
SelectionCondition Element for EntrySelectedBy for GroupBy (Format)

## Syntax

```xml
<SelectionCondition>
  <TypeName>Nameof.NetType</TypeName>
  <SelectionSetName>NameofSelectionSet</SelectionSetName>
  <PropertyName>.NetTypeProperty</PropertyName>
  <ScriptBlock>ScriptToEvaluate</ScriptBlock>
</SelectionCondition>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `SelectionCondition` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[PropertyName Element for SelectionCondition for GroupBy (Format)](./propertyname-element-for-selectioncondition-for-groupby-format.md)|Optional element.<br /><br /> Specifies a .NET property that triggers the condition.|
|[ScriptBlock Element for SelectionCondition for GroupBy (Format)](./scriptblock-element-for-selectioncondition-for-entryselectedby-for-groupby-format.md)|Optional element.<br /><br /> Specifies the script that triggers the condition.|
|[SelectionSetName Element for SelectionCondition for GroupBy (Format)](./selectionsetname-element-for-selectioncondition-for-groupby-format.md)|Optional element.<br /><br /> Specifies the set of .NET types that triggers the condition.|
|[TypeName Element for SelectionCondition for GroupBy  (Format)](./typename-element-for-selectioncondition-for-groupby-format.md)|Optional element.<br /><br /> Specifies a .NET type that triggers the condition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for CustomEntry for GroupBy (Format)](./entryselectedby-element-for-customentry-for-groupby-format.md)|Defines the .NET types that use this control definition or the condition that must exist for this definition to be used.|

## Remarks

When you are defining a selection condition, the following requirements apply:

- The selection condition must specify a least one property name or a script block, but cannot specify both.

- The selection condition can specify any number of .NET types or selection sets, but cannot specify both.

For more information about how to use selection conditions, see [Defining Conditions for when Data is Displayed](./defining-conditions-for-displaying-data.md).

## See Also

[PropertyName Element for SelectionCondition for CustomControl for View (Format)](./propertyname-element-for-selectioncondition-for-customcontrol-for-view-format.md)

[ScriptBlock Element for SelectionCondition for CustomControl for View (Format)](./scriptblock-element-for-selectioncondition-for-customcontrol-for-view-format.md)

[SelectionSetName Element for SelectionCondition for Custom Control for View (Format)](./selectionsetname-element-for-selectioncondition-for-customcontrol-for-view-format.md)

[TypeName Element for SelectionCondition for GroupBy  (Format)](./typename-element-for-selectioncondition-for-groupby-format.md)

[EntrySelectedBy Element for CustomEntry for GroupBy (Format)](./entryselectedby-element-for-customentry-for-groupby-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

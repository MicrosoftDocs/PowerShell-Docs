---
description: SelectionCondition Element for EntrySelectedBy for CustomControl
ms.date: 08/25/2021
ms.topic: reference
title: SelectionCondition Element for EntrySelectedBy for CustomControl
---
# SelectionCondition Element for EntrySelectedBy for CustomControl

Defines a condition that must exist for a control definition to be used. This element is used when
defining a custom control view.

- Configuration Element
- ViewDefinitions Element
- View Element
- CustomControl Element
- CustomEntries Element
- CustomEntry Element
- CustomItem Element
- EntrySelectedBy Element
- SelectionCondition Element

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

The following sections describe attributes, child elements, and the parent element of the
`SelectionCondition` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[PropertyName Element for SelectionCondition for CustomControl for View](./propertyname-element-for-selectioncondition-for-customcontrol-for-view-format.md)|Optional element.<br /><br /> Specifies a .NET property that triggers the condition.|
|[ScriptBlock Element for SelectionCondition for CustomControl for View](./scriptblock-element-for-selectioncondition-for-customcontrol-for-view-format.md)|Optional element.<br /><br /> Specifies the script that triggers the condition.|
|[SelectionSetName Element for SelectionCondition for Custom Control for View](./selectionsetname-element-for-selectioncondition-for-customcontrol-for-view-format.md)|Optional element.<br /><br /> Specifies the set of .NET types that triggers the condition.|
|[TypeName Element for SelectionCondition for CustomControl for View ](./typename-element-for-selectioncondition-for-customcontrol-for-view-format.md)|Optional element.<br /><br /> Specifies a .NET type that triggers the condition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for CustomEntry for CustomControl for View](./entryselectedby-element-for-customentry-for-customcontrol-for-view-format.md)|Defines the .NET types that use this control definition or the condition that must exist for this definition to be used.|

## Remarks

When you are defining a selection condition, the following requirements apply:

- The selection condition must specify a least one property name or a script block, but cannot
  specify both.
- The selection condition can specify any number of .NET types or selection sets, but cannot specify
  both.

For more information about how to use selection conditions, see [Defining Conditions for when Data is Displayed](./defining-conditions-for-displaying-data.md).

## See Also

[PropertyName Element for SelectionCondition for CustomControl for View](./propertyname-element-for-selectioncondition-for-customcontrol-for-view-format.md)

[ScriptBlock Element for SelectionCondition for CustomControl for View](./scriptblock-element-for-selectioncondition-for-customcontrol-for-view-format.md)

[SelectionSetName Element for SelectionCondition for Custom Control for View](./selectionsetname-element-for-selectioncondition-for-customcontrol-for-view-format.md)

[TypeName Element for SelectionCondition for CustomControl for View ](./typename-element-for-selectioncondition-for-customcontrol-for-view-format.md)

[EntrySelectedBy Element for CustomEntry for CustomControl for View](./entryselectedby-element-for-customentry-for-customcontrol-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

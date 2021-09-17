---
description: SelectionCondition Element for EntrySelectedBy for Controls for Configuration
ms.date: 08/25/2021
ms.topic: reference
title: SelectionCondition Element for EntrySelectedBy for Controls for Configuration
---
# SelectionCondition Element for EntrySelectedBy for Controls for Configuration

Defines a condition that must exist for a common control definition to be used. This element is used
when defining a common control that can be used by all the views in the formatting file.

## Schema

- Configuration Element
- Controls Element
- Control Element
- CustomControl Element
- CustomEntries Element
- CustomEntry Element
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
|[PropertyName Element for SelectionCondition for Controls for Configuration](./propertyname-element-for-selectioncondition-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies a .NET property that triggers the condition.|
|[ScriptBlock Element for SelectionCondition for Controls for Configuration](./scriptblock-element-for-selectioncondition-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies the script that triggers the condition.|
|[SelectionSetName Element for SelectionCondition for Controls for Configuration](./selectionsetname-element-for-selectioncondition-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies the set of .NET types that triggers the condition.|
|[TypeName Element for SelectionCondition for Controls for Configuration](./typename-element-for-selectioncondition-for-controls-for-configuration-format.md)|Optional element.<br /><br /> Specifies a .NET type that triggers the condition.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for CustomEntry for Controls for Configuration](./entryselectedby-element-for-customentry-for-controls-for-configuration-format.md)|Defines the .NET types that use this entry of the common control definition.|

## Remarks

The following guidelines must be followed when defining a selection condition:

- The selection condition must specify a least one property name or a script block, but cannot
  specify both.
- The selection condition can specify any number of .NET types or selection sets, but cannot specify
  both.

For more information about how selection conditions can be used, see [Defining Conditions for when Data is Displayed](./defining-conditions-for-displaying-data.md).

## See Also

[PropertyName Element for SelectionCondition for Controls for Configuration](./propertyname-element-for-selectioncondition-for-controls-for-configuration-format.md)

[ScriptBlock Element for SelectionCondition for Controls for Configuration](./scriptblock-element-for-selectioncondition-for-controls-for-configuration-format.md)

[SelectionSetName Element for SelectionCondition for Controls for Configuration](./selectionsetname-element-for-selectioncondition-for-controls-for-configuration-format.md)

[TypeName Element for SelectionCondition for Controls for Configuration](./typename-element-for-selectioncondition-for-controls-for-configuration-format.md)

[EntrySelectedBy Element for CustomEntry for Controls for Configuration](./entryselectedby-element-for-customentry-for-controls-for-configuration-format.md)

[Writing a Windows PowerShell Formatting and Types File](./writing-a-powershell-formatting-file.md)

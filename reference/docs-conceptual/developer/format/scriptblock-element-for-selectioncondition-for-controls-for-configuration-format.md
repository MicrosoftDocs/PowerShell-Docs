---
ms.date: 09/13/2016
ms.topic: reference
title: ScriptBlock Element for SelectionCondition for Controls for Configuration (Format)
description: ScriptBlock Element for SelectionCondition for Controls for Configuration (Format)
---
# ScriptBlock Element for SelectionCondition for Controls for Configuration (Format)

Specifies the script that triggers the condition. When this script is evaluated to `true`, the condition is met, and the definition is used. This element is used when defining a common control that can be used by all the views in the formatting file.

Configuration Element (Format)
Controls Element of Configuration (Format)
Control Element for Controls for Configuration (Format)
CustomControl Element for Control for Configuration (Format)
CustomEntries Element for CustomControl for Configuration (Format)
CustomEntry Element for CustomControl for Controls for Configuration (Format)
EntrySelectedBy Element for CustomEntry for Controls for Configuration (Format)
SelectionCondition Element for EntrySelectedBy for Controls for Configuration (Format)
ScriptBlock Element for SelectionCondition for Controls for Configuration (Format)

## Syntax

```xml
<ScriptBlock>ScriptToEvaluate</ScriptBlock>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `ScriptBlock` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for Controls for Configuration (Format)](./selectioncondition-element-for-entryselectedby-for-controls-for-configuration-format.md)|Defines a condition that must exist for the common control definition to be used.|

## Text Value

Specify the script that is evaluated.

## Remarks

The selection condition must specify a least one script or property name to evaluate, but cannot specify both. For more information about how selection conditions can be used, see [Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md).

## See Also

[SelectionCondition Element for EntrySelectedBy for Controls for Configuration (Format)](./selectioncondition-element-for-entryselectedby-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

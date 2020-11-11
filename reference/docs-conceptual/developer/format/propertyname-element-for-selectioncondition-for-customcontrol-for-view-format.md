---
ms.date: 09/13/2016
ms.topic: reference
title: PropertyName Element for SelectionCondition for CustomControl for View (Format)
description: PropertyName Element for SelectionCondition for CustomControl for View (Format)
---
# PropertyName Element for SelectionCondition for CustomControl for View (Format)

Specifies the .NET property that triggers the condition. When this property is present or when it evaluates to `true`, the condition is met, and the definition is used. This element is used when defining a custom control view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
CustomControl Element for View (Format)
CustomEntries Element for CustomControl for View (Format)
CustomEntry Element for CustomEntries for CustomControl for View (Format)
CustomItem Element for CustomEntry for CustomControl for View (Format)
EntrySelectedBy Element for CustomEntry for CustomControl for View (Format)
SelectionCondition Element for EntrySelectedBy for CustomControl for View (Format)
PropertyName Element for SelectionCondition for CustomControl for View (Format)

## Syntax

```xml
<PropertyName>.NetTypeProperty</PropertyName>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `PropertyName` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[SelectionCondition Element for EntrySelectedBy for CustomControl for View (Format)](./selectioncondition-element-for-entryselectedby-for-customcontrol-format.md)|Defines a condition that must exist for the control definition to be used.|

## Text Value

Specify the .NET property name.

## Remarks

The selection condition must specify a least one property name or a script, but cannot specify both. For more information about how selection conditions can be used, see [Defining Conditions for Displaying Data](./defining-conditions-for-displaying-data.md).

## See Also

[SelectionCondition Element for EntrySelectedBy for CustomControl for View (Format)](./selectioncondition-element-for-entryselectedby-for-customcontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

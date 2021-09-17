---
description: ScriptBlock Element for GroupBy
ms.date: 08/24/2021
ms.topic: reference
title: ScriptBlock Element for GroupBy
---
# ScriptBlock Element for GroupBy

Specifies the script that starts a new group whenever its value changes.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- GroupBy Element
- ScriptBlock Element

## Syntax

```xml
<ScriptBlock>ScriptToEvaluate</ScriptBlock>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`ScriptBlock` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[GroupBy Element for View](./groupby-element-for-view-format.md)|Defines how a group of .NET objects is displayed.|

## Text Value

Specify the script that is evaluated.

## Remarks

PowerShell starts a new group whenever the value of this script changes.

When this element is specified, you cannot specify the [PropertyName](propertyname-element-for-groupby-format.md)
element to start a new group.

## See Also

[PropertyName Element for GroupBy](propertyname-element-for-groupby-format.md)

[GroupBy Element for View](groupby-element-for-view-format.md)

[Writing a PowerShell Formatting File](writing-a-powershell-formatting-file.md)

---
ms.date: 09/13/2016
ms.topic: reference
title: ScriptBlock Element for GroupBy (Format)
description: ScriptBlock Element for GroupBy (Format)
---
# ScriptBlock Element for GroupBy (Format)

Specifies the script that starts a new group whenever its value changes.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
GroupBy Element for View (Format)
ScriptBlock Element for GroupBy (Format)

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
|[GroupBy Element for View (Format)](./groupby-element-for-view-format.md)|Defines how a group of .NET objects is displayed.|

## Text Value

Specify the script that is evaluated.

## Remarks

PowerShell starts a new group whenever the value of this script changes.

When this element is specified, you cannot specify the [PropertyName](propertyname-element-for-groupby-format.md) element to start a new group.

## See Also

[PropertyName Element for GroupBy (Format)](propertyname-element-for-groupby-format.md)

[GroupBy Element for View (Format)](groupby-element-for-view-format.md)

[Writing a PowerShell Formatting File](writing-a-powershell-formatting-file.md)

---
ms.date: 09/13/2016
ms.topic: reference
title: Controls Element for Configuration (Format)
description: Controls Element for Configuration (Format)
---
# Controls Element for Configuration (Format)

Defines the common controls that can be used by all views of the formatting file.

Configuration Element (Format)
Controls Element of Configuration (Format)

## Syntax

```xml
<Controls>
  <Control>...</Control>
</Controls>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the `Controls` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[Control Element for Controls for Configuration (Format)](./control-element-for-controls-for-configuration-format.md)|Required element.<br /><br /> Defines a common control that can be used by all views of the formatting file.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[Configuration Element (Format)](./configuration-element-format.md)|Represents the top-level element of a formatting file.|

## Remarks

You can create any number of common controls. For each control, you must specify the name that is used to reference the control and the components of the control.

## See Also

[Configuration Element (Format)](./configuration-element-format.md)

[Control Element for Controls for Configuration (Format)](./control-element-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

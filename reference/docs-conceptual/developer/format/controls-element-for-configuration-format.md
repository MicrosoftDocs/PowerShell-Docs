---
description: Controls Element for Configuration
ms.date: 08/20/2021
ms.topic: reference
title: Controls Element for Configuration
---
# Controls Element for Configuration

Defines the common controls that can be used by all views of the formatting file.

## Schema

- Configuration Element
- Controls Element

## Syntax

```xml
<Controls>
  <Control>...</Control>
</Controls>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the
`Controls` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[Control Element for Controls for Configuration](./control-element-for-controls-for-configuration-format.md)|Required element.<br /><br /> Defines a common control that can be used by all views of the formatting file.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[Configuration Element](./configuration-element-format.md)|Represents the top-level element of a formatting file.|

## Remarks

You can create any number of common controls. For each control, you must specify the name that is
used to reference the control and the components of the control.

## See Also

[Configuration Element](./configuration-element-format.md)

[Control Element for Controls for Configuration](./control-element-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

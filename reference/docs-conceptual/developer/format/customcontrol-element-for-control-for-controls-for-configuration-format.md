---
description: CustomControl Element for Control for Controls for Configuration
ms.date: 09/13/2016
ms.topic: reference
title: CustomControl Element for Control for Controls for Configuration
---
# CustomControl Element for Control for Controls for Configuration

Defines a control. This element is used when defining a common control that can be used by all the
views in the formatting file.

## Schema

- Configuration Element
- Controls Element
- Control Element
- CustomControl Element

## Syntax

```xml
<CustomControl>
  <CustomEntries>...</CustomEntries>
</CustomControl>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the
`CustomControl` element. This element must have at least one child element. There is no maximum
limit to the number of child elements that can be specified.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[CustomEntries Element for CustomControl for Configuration](./customentries-element-for-customcontrol-for-controls-for-configuration-format.md)|Required element.<br /><br /> Provides the definitions of a control.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[Control Element for Controls for Configuration](./control-element-for-controls-for-configuration-format.md)|Defines a common control that can be used by all the views of the formatting file and the name that is used to reference the control.|

## Remarks

## See Also

[Control Element for Controls for Configuration](./control-element-for-controls-for-configuration-format.md)

[CustomEntries Element for CustomControl for Configuration](./customentries-element-for-customcontrol-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

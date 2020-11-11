---
ms.date: 09/13/2016
ms.topic: reference
title: CustomEntries Element for CustomControl for Controls for Configuration (Format)
description: CustomEntries Element for CustomControl for Controls for Configuration (Format)
---
# CustomEntries Element for CustomControl for Controls for Configuration (Format)

Provides the definitions of a common control. This element is used when defining a common control that can be used by all the views in the formatting file.

Configuration Element (Format)
Controls Element of Configuration (Format)
Control Element for Controls for Configuration (Format)
CustomControl Element for Control for Configuration (Format)
CustomEntries Element for CustomControl for Configuration (Format)

## Syntax

```xml
<CustomEntries>
  <CustomEntry>...</CustomEntry>
</CustomEntries>

```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `CustomEntries` element. You must specify one or more child elements.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[CustomEntry Element for CustomControl for Controls for Configuration (Format)](./customentry-element-for-customcontrol-for-controls-for-configuration-format.md)|Provides a definition of the common control.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomControl Element for Control for Configuration (Format)](./customcontrol-element-for-control-for-controls-for-configuration-format.md)|Defines a common control.|

## Remarks

In most cases, a control has only one definition, which is defined in a single `CustomEntry` element. However it is possible to have multiple definitions if you want to use the same control to display different .NET objects. In those cases, you can define a `CustomEntry` element for each object or set of objects.

## See Also

[CustomControl Element for Control for Configuration (Format)](./customcontrol-element-for-control-for-controls-for-configuration-format.md)

[CustomEntry Element for CustomControl for Controls for Configuration (Format)](./customentry-element-for-customcontrol-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

---
description: CustomEntries Element for CustomControl for Controls for Configuration
ms.date: 08/20/2021
ms.topic: reference
title: CustomEntries Element for CustomControl for Controls for Configuration
---
# CustomEntries Element for CustomControl for Controls for Configuration

Provides the definitions of a common control. This element is used when defining a common control
that can be used by all the views in the formatting file.

## Schema

- Configuration Element
- Controls Element
- Control Element
- CustomControl Element
- CustomEntries Element

## Syntax

```xml
<CustomEntries>
  <CustomEntry>...</CustomEntry>
</CustomEntries>

```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`CustomEntries` element. You must specify one or more child elements.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[CustomEntry Element for CustomControl for Controls for Configuration](./customentry-element-for-customcontrol-for-controls-for-configuration-format.md)|Provides a definition of the common control.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomControl Element for Control for Configuration](./customcontrol-element-for-control-for-controls-for-configuration-format.md)|Defines a common control.|

## Remarks

In most cases, a control has only one definition, which is defined in a single `CustomEntry`
element. However it is possible to have multiple definitions if you want to use the same control to
display different .NET objects. In those cases, you can define a `CustomEntry` element for each
object or set of objects.

## See Also

[CustomControl Element for Control for Configuration](./customcontrol-element-for-control-for-controls-for-configuration-format.md)

[CustomEntry Element for CustomControl for Controls for Configuration](./customentry-element-for-customcontrol-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

---
description: FirstLineIndent Element for Frame for Controls for Configuration
ms.date: 08/23/2021
ms.topic: reference
title: FirstLineIndent Element for Frame for Controls for Configuration
---
# FirstLineIndent Element for Frame for Controls for Configuration

Specifies how many characters the first line of data is shifted to the right. This element is used
when defining a common control that can be used by all the views in the formatting file.

## Schema

- Configuration Element
- Controls Element
- Control Element
- CustomControl Element
- CustomEntries Element
- CustomEntry Element
- CustomItem Element
- Frame Element
- FirstLineIndent Element

## Syntax

```xml
<FirstLineIndent>NumberOfCharactersToShift</FirstLineIndent>
```

## Attributes and Elements

The following sections describe attributes, child elements, and parent element of the
`FirstLineIndent` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[Frame Element for CustomItem for Controls for Configuration](./frame-element-for-customitem-for-controls-for-configuration-format.md)|Defines how the data is displayed, such as shifting the data to the left or right.|

## Text Value

Specify the number of characters that you want to shift the first line of the data.

## Remarks

If this element is specified, you cannot specify the [FirstLineHanging](./firstlinehanging-element-for-frame-for-controls-for-configuration-format.md) element.

## See Also

[FirstLineHanging Element for Frame for Controls for Configuration](./firstlinehanging-element-for-frame-for-controls-for-configuration-format.md)

[Frame Element for CustomItem for Controls for Configuration](./frame-element-for-customitem-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

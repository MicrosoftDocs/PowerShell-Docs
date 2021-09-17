---
description: FirstLineHanging Element for Frame for Controls for Configuration
ms.date: 08/23/2021
ms.topic: reference
title: FirstLineHanging Element for Frame for Controls for Configuration
---
# FirstLineHanging Element for Frame for Controls for Configuration

Specifies how many characters the first line of data is shifted to the left. This element is used
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
- FirstLineHanging Element

## Syntax

```xml
<FirstLineHanging>NumberOfCharactersToShift</FirstLineHanging>
```

## Attributes and Elements

The following sections describe attributes, child elements, and parent element of the
`FirstLineHanging` element.

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

If this element is specified, you cannot specify the `FirstLineIndent` element.

## See Also

[Frame Element for CustomItem for Controls for Configuration](./frame-element-for-customitem-for-controls-for-configuration-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

---
ms.date: 09/13/2016
ms.topic: reference
title: FirstLineHanging Element for Frame for GroupBy (Format)
description: FirstLineHanging Element for Frame for GroupBy (Format)
---
# FirstLineHanging Element for Frame for GroupBy (Format)

Specifies how many characters the first line of data is shifted to the left. This element is used when defining how a new group of objects is displayed.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
GroupBy Element for View (Format)
CustomControl Element for GroupBy (Format)
CustomEntries Element for CustomControl for GroupBy (Format)
CustomEntry Element for CustomControl for GroupBy (Format)
CustomItem Element for CustomEntry for GroupBy (Format)
Frame Element for CustomItem for GroupBy (Format)
FirstLineHanging Element for Frame for GroupBy (Format)

## Syntax

```xml
<FirstLineHanging>NumberOfCharactersToShift</FirstLineHanging>
```

## Attributes and Elements

The following sections describe attributes, child elements, and parent element of the `FirstLineHanging` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[Frame Element for CustomItem for GroupBy (Format)](./frame-element-for-customitem-for-groupby-format.md)|Defines how the data is displayed, such as shifting the data to the left or right.|

## Text Value

Specify the number of characters that you want to shift the first line of the data.

## Remarks

If this element is specified, you cannot specify the [FirstLineIndent](./firstlineindent-element-for-frame-for-groupby-format.md) element.

## See Also

[FirstLineIndent Element for Frame for GroupBy (Format)](./firstlineindent-element-for-frame-for-groupby-format.md)

[Frame Element for CustomItem for GroupBy (Format)](./frame-element-for-customitem-for-groupby-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

---
ms.date: 09/13/2016
ms.topic: reference
title: FirstLineHanging Element for Frame for Controls for View (Format)
description: FirstLineHanging Element for Frame for Controls for View (Format)
---
# FirstLineHanging Element for Frame for Controls for View (Format)

Specifies how many characters the first line of data is shifted to the left. This element is used when defining controls that can be used by a view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
Controls Element (Format)
Control Element for Controls for View (Format)
CustomControl Element for Control for Controls for View (Format)
CustomEntries Element for CustomControl for View (Format)
CustomEntry Element for CustomEntries for Controls for View (Format)
CustomItem Element for CustomEntry for Controls for View (Format)
Frame Element for CustomItem for Controls for View (Format)
FirstLineHanging Element of Frame of Controls of View (Format)

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
|[Frame Element for CustomItem for Controls for View (Format)](./frame-element-for-customitem-for-controls-for-view-format.md)|Defines how the data is displayed, such as shifting the data to the left or right.|

## Text Value

Specify the number of characters that you want to shift the first line of the data.

## Remarks

If this element is specified, you cannot specify the [FirstLineIndent](./firstlineindent-element-for-frame-for-controls-for-view-format.md) element.

## See Also

[FirstLineIndent Element for Frame for Controls for View (Format)](./firstlineindent-element-for-frame-for-controls-for-view-format.md)

[Frame Element for CustomItem for Controls for View (Format)](./frame-element-for-customitem-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

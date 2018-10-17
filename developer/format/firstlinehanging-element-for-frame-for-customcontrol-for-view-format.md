---
title: "FirstLineHanging Element for Frame for CustomControl for View (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: c6ac3d86-0529-4b93-9bc7-ee94fcef9618
caps.latest.revision: 8
---
# FirstLineHanging Element for Frame for CustomControl for View (Format)

Specifies how many characters the first line of data is shifted to the left. This element is used when defining a custom control view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
CustomControl Element (Format)
CustomEntries Element for CustomControl for View (Format)
CustomEntry Element for CustomEntries for View (Format)
CustomItem Element for CustomEntry for CutomControlView (Format)
Frame Element for CustomItem for CustomControl for View (Format)
FirstLineHanging Element for Frame for CustomControl for View (Format)

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
|[Frame Element for CustomItem for CustomControl for View (Format)](./frame-element-for-customitem-for-customcontrol-for-view-format.md)|Defines how the data is displayed, such as shifting the data to the left or right.|

## Text Value

Specify the number of characters that you want to shift the first line of the data.

## Remarks

If this element is specified, you cannot specify the [FirstLineIndent](./firstlineindent-element-for-frame-for-customcontrol-for-view-format.md) element.

## See Also

[FirstLineIndent Element for Frame for CustomControl for View (Format)](./firstlineindent-element-for-frame-for-customcontrol-for-view-format.md)

[Frame Element for CustomItem for CustomControl for View (Format)](./frame-element-for-customitem-for-customcontrol-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

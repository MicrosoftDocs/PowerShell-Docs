---
title: "FirstLineIndent Element for Frame for CustomControl for View (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: bb4e1564-3fd3-4be3-b93e-ac90480e05c0
caps.latest.revision: 6
---
# FirstLineIndent Element for Frame for CustomControl for View (Format)

Specifies how many characters the first line of data is shifted to the right. This element is used when defining a custom control view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
CustomControl Element (Format)
CustomEntries Element for CustomControl for View (Format)
CustomEntry Element for CustomEntries for View (Format)
CustomItem Element for CustomEntry for CustomControlView (Format)
Frame Element for CustomItem for CustomControl for View (Format)
FirstLineIndent Element

## Syntax

```xml
<FirstLineIndent>NumberOfCharactersToShift</FirstLineIndent>
```

## Attributes and Elements

The following sections describe attributes, child elements, and parent element of the `FirstLineIndent` element.

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

If this element is specified, you cannot specify the [FirstLineHanging](./firstlinehanging-element-for-frame-for-customcontrol-for-view-format.md) element.

## See Also

[FirstLineHanging Element for Frame for CustomControl for View (Format)](./firstlinehanging-element-for-frame-for-customcontrol-for-view-format.md)

[Frame Element for CustomItem for CustomControl for View (Format)](./frame-element-for-customitem-for-customcontrol-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

---
ms.date: 09/13/2016
ms.topic: reference
title: Frame Element for CustomItem for Controls for View (Format)
description: Frame Element for CustomItem for Controls for View (Format)
---
# Frame Element for CustomItem for Controls for View (Format)

Defines how the data is displayed, such as shifting the data to the left or right. This element is used when defining controls that can be used by a view.

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

## Syntax

```xml
<Frame>
  <LeftIndent>NumberOfCharactersToShift</LeftIndent>
  <RightIndent>NumberOfCharactersToShift</RightIndent>
  <FirstLineHanging>NumberOfCharactersToShift</FirstLineHanging>
  <FirstLineIndent>NumberOfCharactersToShift</FirstLineIndent>
  <CustomItem>...</CustomItem>
</Frame>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `Frame` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|`CustomItem Element`|Required Element|
|[FirstLineHanging Element of Frame of Controls of View (Format)](./firstlinehanging-element-for-frame-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies how many characters the first line is shifted to the left.|
|[FirstLineIndent Element of Frame of Controls of View (Format)](./firstlineindent-element-for-frame-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies how many characters the first line is shifted to the right.|
|[LeftIndent Element of Frame of Controls of View (Format)](./leftindent-element-for-frame-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies how many characters the data is shifted away from the left margin.|
|[RightIndent Element of Frame of Controls of View (Format)](./rightindent-element-for-frame-for-controls-for-view-format.md)|Optional element.<br /><br /> Specifies how many characters the data is shifted away from the right margin.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomItem Element for CustomEntry for Controls for View (Format)](./customitem-element-for-customentry-for-controls-for-view-format.md)|Defines what data is displayed by the control and how it is displayed.|

## Remarks

You cannot specify the [FirstLineHanging](./firstlinehanging-element-for-frame-for-controls-for-view-format.md) and the [FirstLineIndent](./firstlineindent-element-for-frame-for-controls-for-view-format.md) elements in the same `Frame` element.

## See Also

[FirstLineHanging Element of Frame of Controls of View (Format)](./firstlinehanging-element-for-frame-for-controls-for-view-format.md)

[FirstLineIndent Element of Frame of Controls of View (Format)](./firstlineindent-element-for-frame-for-controls-for-view-format.md)

[LeftIndent Element of Frame of Controls of View (Format)](./leftindent-element-for-frame-for-controls-for-view-format.md)

[RightIndent Element of Frame of Controls of View (Format)](./rightindent-element-for-frame-for-controls-for-view-format.md)

[CustomItem Element for CustomEntry for Controls for View (Format)](./customitem-element-for-customentry-for-controls-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

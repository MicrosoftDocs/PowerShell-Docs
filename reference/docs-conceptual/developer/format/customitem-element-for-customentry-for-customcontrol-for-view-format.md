---
description: CustomItem Element for CustomEntry for CustomControl for View
ms.date: 08/20/2021
ms.topic: reference
title: CustomItem Element for CustomEntry for CustomControl for View
---
# CustomItem Element for CustomEntry for CustomControl for View

Defines what data is displayed by the custom control view and how it is displayed. This element is
used when defining a custom control view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- CustomControl Element
- CustomEntries Element
- CustomEntry Element
- CustomItem Element

## Syntax

```xml
<CustomItem>
  <ExpressionBinding>...</ExpressionBinding>
  <Frame>...</Frame>
  <NewLine/>
  <Text>TextToDisplay</Text>
</CustomItem>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`CustomItem` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[ExpressionBinding Element for CustomItem for CustomControl for View](./expressionbinding-element-for-customitem-for-customcontrol-for-view-format.md)|Optional element.<br /><br /> Defines the data that is displayed by the control.|
|[Frame Element for CustomItem for CustomControl for View](./frame-element-for-customitem-for-customcontrol-for-view-format.md)|Optional element.<br /><br /> Defines what data is displayed by the custom control view and how it is displayed.|
|[NewLine Element for CustomItem for Custom Control for View](./newline-element-for-customitem-for-customcontrol-for-view-format.md)|Optional element.<br /><br /> Adds a blank line to the display of the control.|
|[Text Element for CustomItem for CustomControl for View](./text-element-for-customitem-for-customview-for-view-format.md)|Optional element.<br /><br /> Specifies additional text to the data displayed by the control.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomEntry Element for CustomEntries for CustomControl for View](./customentry-element-for-customentries-for-customcontrol-for-view-format.md)|Provides a definition of the custom control view.|

## Remarks

## See Also

[CustomEntry Element for CustomEntries for View](./customentry-element-for-customentries-for-customcontrol-for-view-format.md)

[ExpressionBinding Element for CustomItem for CustomControl for View](./expressionbinding-element-for-customitem-for-customcontrol-for-view-format.md)

[Frame Element for CustomItem for CustomControl for View](./frame-element-for-customitem-for-customcontrol-for-view-format.md)

[NewLine Element for CustomItem for CustomControl for View](./newline-element-for-customitem-for-customcontrol-for-view-format.md)

[Text Element for CustomItem for CustomControl for View](./text-element-for-customitem-for-customview-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

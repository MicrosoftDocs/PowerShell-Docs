---
description: CustomItem Element for CustomEntry for GroupBy
ms.date: 08/20/2021
ms.topic: reference
title: CustomItem Element for CustomEntry for GroupBy
---
# CustomItem Element for CustomEntry for GroupBy

Defines what data is displayed by the custom control view and how it is displayed. This element is
used when defining how a new group of objects is displayed.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- GroupBy Element
- CustomControl Element
- CustomEntries Element
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
|[ExpressionBinding Element for CustomItem for GroupBy](./expressionbinding-element-for-customitem-for-groupby-format.md)|Optional element.<br /><br /> Defines the data that is displayed by the control.|
|[Frame Element for CustomItem for GroupBy](./frame-element-for-customitem-for-groupby-format.md)|Optional element.<br /><br /> Defines what data is displayed by the custom control view and how it is displayed.|
|[NewLine Element for CustomItem for GroupBy](./newline-element-for-customitem-for-groupby-format.md)|Optional element.<br /><br /> Adds a blank line to the display of the control.|
|[Text Element for CustomItem for GroupBy](./text-element-for-customitem-for-groupby-format.md)|Optional element.<br /><br /> Specifies additional text to the data displayed by the control.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[CustomEntry Element for CustomControl for GroupBy](./customentry-element-for-customcontrol-for-groupby-format.md)|Provides a definition of the custom control view.|

## Remarks

## See Also

[CustomEntry Element for CustomControl for GroupBy](./customentry-element-for-customcontrol-for-groupby-format.md)

[ExpressionBinding Element for CustomItem for GroupBy](./expressionbinding-element-for-customitem-for-groupby-format.md)

[Frame Element for CustomItem for GroupBy](./frame-element-for-customitem-for-groupby-format.md)

[NewLine Element for CustomItem for GroupBy](./newline-element-for-customitem-for-groupby-format.md)

[Text Element for CustomItem for GroupBy](./text-element-for-customitem-for-groupby-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

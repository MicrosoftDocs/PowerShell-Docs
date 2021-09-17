---
description: ScriptBlock Element for WideItem for WideControl
ms.date: 08/24/2021
ms.topic: reference
title: ScriptBlock Element for WideItem for WideControl
---
# ScriptBlock Element for WideItem for WideControl

Specifies the script whose value is displayed in the wide view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- WideControl Element
- WideEntries Element
- WideEntry Element
- WideItem Element
- ScriptBlock Element

## Syntax

```xml
<ScriptBlock>ScriptToExecute</ScriptBlock>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent element of the
`ScriptBlock` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[WideItem Element](./wideitem-element-for-widecontrol-format.md)|Defines the property or script block whose value is displayed in the wide view.|

## Text Value

Specify the script whose value is displayed.

## Remarks

For more information about the components of a wide view, see [Creating a Wide View](./creating-a-wide-view.md).

## Example

This example shows a `WideItem` element that defines a script whose value is displayed in the view.

```xml
<WideItem>
  <ScriptBlock>ScriptToExecute</ScriptBlock>
</WideItem>
```

## See Also

[WideItem Element](./wideitem-element-for-widecontrol-format.md)

[Creating a Wide View](./creating-a-wide-view.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

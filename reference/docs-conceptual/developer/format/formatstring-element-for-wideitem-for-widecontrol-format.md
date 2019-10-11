---
title: "FormatString Element for WideItem for WideControl (Format) | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 5bc6ea26-3ca6-4bab-8a13-29189821ba15
caps.latest.revision: 7
---
# FormatString Element for WideItem for WideControl (Format)

Specifies a format pattern that defines how the property or script value is displayed in the view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
WideControl Element (Format)
WideEntries Element (Format)
WideEntry Element for WideControl (Format)
WideItem Element for WideControl (Format)
FormatString Element for WideItem for WideControl (Format)

## Syntax

```xml
<FormatString>PropertyPattern</FormatString>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the `FormatString` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[WideItem Element for WideControl (Format)](./wideitem-element-for-widecontrol-format.md)|Defines the property or script whose value is displayed in a row of the list view.|

## Text Value

Specify the pattern that is used to format the data. For example, you can use this pattern to format the value of any property that is of type [System.Timespan](/dotnet/api/System.TimeSpan): {0:MMM}{0:dd}{0:HH}:{0:mm}.

## Remarks

Format strings can be used when creating table views, list views, wide views, or custom views. For more information about formatting a value displayed in a view, see [Formatting Displayed Data](./formatting-displayed-data.md).

For more information about using format strings in wide views, see [Creating a Wide View](./creating-a-wide-view.md).

## Example

The following example shows how to define a formatting string for the value of the `StartTime` property.

```xml
<WideItem>
  <PropertyName>StartTime</PropertyName>
  <FormatString>{0:MMM} (0:DD) (0:HH):(0:MM)</FormatString>
</WideItem>
```

## See Also

[Creating a Wide View](./creating-a-wide-view.md)

[WideItem Element for WideControl (Format)](./wideitem-element-for-widecontrol-format.md)

[Writing a Windows PowerShell Formatting and Types File](./writing-a-powershell-formatting-file.md)

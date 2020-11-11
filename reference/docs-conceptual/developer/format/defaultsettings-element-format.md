---
ms.date: 09/13/2016
ms.topic: reference
title: DefaultSettings Element (Format)
description: DefaultSettings Element (Format)
---
# DefaultSettings Element (Format)

Defines common settings that apply to all the views of the formatting file. Common settings include displaying errors, wrapping text in tables, defining how collections are expanded, and more.

Configuration Element (Format)
DefaultSettings Element (Format)

## Syntax

```xml
<DefaultSettings>
  <ShowError/>
  <DisplayError/>
 <PropertyCountForTable>NumberOfProperties</PropertyCountFortable>
  <WrapTables/>
  <EnumerableExpansions>...</EnumerableExpansions>
</DefaultSettings>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the `DefaultSettings` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[DisplayError Element (Format)](./displayerror-element-format.md)|Optional element.<br /><br /> Specifies that the string #ERR is displayed when an error occurs while displaying a piece of data.|
|[EnumerableExpansions Element (Format)](./enumerableexpansions-element-format.md)|Optional element.<br /><br /> Defines the different ways that .NET objects are expanded when they are displayed in a view.|
|[PropertyCountForTable (Format)](./propertycountfortable-element-format.md)|Optional element.<br /><br /> Specifies the minimum number of properties that an object must have to display the object in a table view.|
|[ShowError Element (Format)](./showerror-element-format.md)|Optional element.<br /><br /> Specifies that the full error record is displayed when an error occurs while displaying a piece of data.|
|[WrapTables Element (Format)](./wraptables-element-format.md)|Optional element.<br /><br /> Specifies that data in a table is moved to the next line if it does not fit into the width of the column.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[Configuration Element](./configuration-element-format.md)|Represents the top-level element of a formatting file.|

## Remarks

## See Also

[Configuration Element](./configuration-element-format.md)

[DisplayError Element (Format)](./displayerror-element-format.md)

[EnumerableExpansions Element (Format)](./enumerableexpansions-element-format.md)

[PropertyCountForTable (Format)](./propertycountfortable-element-format.md)

[ShowError Element (Format)](./showerror-element-format.md)

[WrapTables Element (Format)](./wraptables-element-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

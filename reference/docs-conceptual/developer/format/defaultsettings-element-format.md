---
description: DefaultSettings Element
ms.date: 08/23/2021
ms.topic: reference
title: DefaultSettings Element
---
# DefaultSettings Element

Defines common settings that apply to all the views of the formatting file. Common settings include
displaying errors, wrapping text in tables, defining how collections are expanded, and more.

## Schema

- Configuration Element
- DefaultSettings Element

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

The following sections describe attributes, child elements, and the parent element of the
`DefaultSettings` element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[DisplayError Element](./displayerror-element-format.md)|Optional element.<br /><br /> Specifies that the string #ERR is displayed when an error occurs while displaying a piece of data.|
|[EnumerableExpansions Element](./enumerableexpansions-element-format.md)|Optional element.<br /><br /> Defines the different ways that .NET objects are expanded when they are displayed in a view.|
|[PropertyCountForTable](./propertycountfortable-element-format.md)|Optional element.<br /><br /> Specifies the minimum number of properties that an object must have to display the object in a table view.|
|[ShowError Element](./showerror-element-format.md)|Optional element.<br /><br /> Specifies that the full error record is displayed when an error occurs while displaying a piece of data.|
|[WrapTables Element](./wraptables-element-format.md)|Optional element.<br /><br /> Specifies that data in a table is moved to the next line if it does not fit into the width of the column.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[Configuration Element](./configuration-element-format.md)|Represents the top-level element of a formatting file.|

## Remarks

## See Also

[Configuration Element](./configuration-element-format.md)

[DisplayError Element](./displayerror-element-format.md)

[EnumerableExpansions Element](./enumerableexpansions-element-format.md)

[PropertyCountForTable](./propertycountfortable-element-format.md)

[ShowError Element](./showerror-element-format.md)

[WrapTables Element](./wraptables-element-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

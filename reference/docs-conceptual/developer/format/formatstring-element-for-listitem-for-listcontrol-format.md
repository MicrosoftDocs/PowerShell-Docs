---
ms.date: 09/13/2016
ms.topic: reference
title: FormatString Element for ListItem for ListControl  (Format)
description: FormatString Element for ListItem for ListControl  (Format)
---
# FormatString Element for ListItem for ListControl  (Format)

Specifies a format pattern that defines how the property or script value is displayed.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
ListControl Element (Format)
ListEntries Element for ListControl (Format)
ListEntry Element for ListControl (Format)
ListItems Element for ListControl (Format)
ListItem Element for ListControl (Format)
FormatString Element for ListItem for ListControl (Format)

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
|[ListItem Element (Format)](./listitem-element-for-listitems-for-listcontrol-format.md)|Defines the property or script whose value is displayed in a row of the list view.|

## Text Value

Specify the pattern that is used to format the data. For example, you can use this pattern to format the value of any property that is of type [System.Timespan](/dotnet/api/System.TimeSpan): {0:MMM}{0:dd}{0:HH}:{0:mm}.

## Remarks

Format strings can be used when creating table views, list views, wide views, or custom views. For more information about formatting a value displayed in a view, see [Formatting Displayed Data](./formatting-displayed-data.md).

For more information about using format strings in list views, see [Creating List View](./creating-a-list-view.md).

## Example

The following example shows how to define a formatting string for the value of the `StartTime` property.

```xml
<ListItem>
  <PropertyName>StartTime</PropertyName>
  <FormatString>{0:MMM} (0:DD) (0:HH):(0:MM)</FormatString>
</ListItem>
```

## See Also

[Creating a List View](./creating-a-list-view.md)

[ListItem Element (Format)](./listitem-element-for-listitems-for-listcontrol-format.md)

[Writing a Windows PowerShell Formatting and Types File](./writing-a-powershell-formatting-file.md)

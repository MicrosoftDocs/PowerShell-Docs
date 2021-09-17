---
description: Label Element for GroupBy
ms.date: 08/23/2021
ms.topic: reference
title: Label Element for GroupBy
---
# Label Element for GroupBy

Specifies a label that is displayed when a new group is encountered.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- GroupBy Element
- Label Element

## Syntax

```xml
<Label>DisplayedLabel</Label>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and parent element of the `Label`
element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[GroupBy Element for View](./groupby-element-for-view-format.md)|Defines how a new group of objects is displayed.|

## Text Value

Specify the text that is displayed whenever Windows PowerShell encounters a new property or script
value.

## Remarks

In addition to the text specified by this element, Windows PowerShell displays the new value that
starts the group, and adds a blank line before and after the group.

## Example

The following example shows the label for a new group. The displayed label would look similar to
this: `Service Type: NewValueofProperty`

```xml
<GroupBy>
  <Label>Service Type</Label>
  <PropertyName>ServiceType</PropertyName>
</GroupBy>

```

For an example of a complete formatting file that includes this element, see [Wide View (GroupBy)](./wide-view-groupby.md).

## See Also

[GroupBy Element for View](./groupby-element-for-view-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

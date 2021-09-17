---
description: WideEntry Element
ms.date: 08/25/2021
ms.topic: reference
title: WideEntry Element
---
# WideEntry Element

Provides a definition of the wide view.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- WideControl Element
- WideEntries Element
- WideEntry Element

## Syntax

```xml
<WideEntry>
  <EntrySelectedBy>...</EntrySelectedBy>
  <WideItem>...</WideItem>
</WideEntry>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the
`WideEntry` element. You must specify a single `WideItem` child element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for WideEntry](./entryselectedby-element-for-wideentry-format.md)|Optional element.<br /><br /> Defines the .NET types that use this wide entry definition or the condition that must exist for this definition to be used.|
|[WideItem Element](./wideitem-element-for-widecontrol-format.md)|Required element.<br /><br /> Defines the property or script whose value is displayed.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[WideEntries Element](./wideentries-element-for-widecontrol-format.md)|Provides the definitions of the wide view.|

## Remarks

A wide view is a list format that displays a single property value or script value for each object.
Unlike other types of views, you can specify only one item element for each view definition. For
more information about the other components of a wide view, see [Creating a Wide View](./creating-a-wide-view.md).

## Example

The following example shows a `WideEntry` element that defines a single `WideItem` element. The
`WideItem` element defines the property whose value is displayed in the view.

```xml
<WideEntries>
  <WideEntry>
    <WideItem>
      <PropertyName>ProcessName</PropertyName>
    </WideItem>
  </WideEntry>
</WideEntries>

```

For a complete example of a wide view, see [Wide View (Basic)](./wide-view-basic.md).

## See Also

[Creating a Wide View](./creating-a-wide-view.md)

[SelectionCondition Element for WideEntry](./selectioncondition-element-for-entryselectedby-for-widecontrol-format.md)

[SelectionSetName Element for WideEntry](./selectionsetname-element-for-entryselectedby-for-widecontrol-format.md)

[TypeName Element for WideEntry](./typename-element-for-entryselectedby-for-wideentry-format.md)

[WideEntries Element](./wideentries-element-for-widecontrol-format.md)

[WideItem Element](./wideitem-element-for-widecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

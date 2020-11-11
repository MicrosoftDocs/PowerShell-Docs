---
ms.date: 09/13/2016
ms.topic: reference
title: WideEntry Element for WideControl (Format)
description: WideEntry Element for WideControl (Format)
---
# WideEntry Element for WideControl (Format)

Provides a definition of the wide view.

Configuration Element (Format)
ViewDefinitions Element (Format)
View Element (Format)
WideControl Element (Format)
WideEntries Element (Format)
WideEntry Element (Format)

## Syntax

```xml
<WideEntry>
  <EntrySelectedBy>...</EntrySelectedBy>
  <WideItem>...</WideItem>
</WideEntry>
```

## Attributes and Elements

The following sections describe the attributes, child elements, and the parent element of the `WideEntry` element. You must specify a single `WideItem` child element.

### Attributes

None.

### Child Elements

|Element|Description|
|-------------|-----------------|
|[EntrySelectedBy Element for WideEntry (Format)](./entryselectedby-element-for-wideentry-format.md)|Optional element.<br /><br /> Defines the .NET types that use this wide entry definition or the condition that must exist for this definition to be used.|
|[WideItem Element (Format)](./wideitem-element-for-widecontrol-format.md)|Required element.<br /><br /> Defines the property or script whose value is displayed.|

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[WideEntries Element (Format)](./wideentries-element-for-widecontrol-format.md)|Provides the definitions of the wide view.|

## Remarks

A wide view is a list format that displays a single property value or script value for each object. Unlike other types of views, you can specify only one item element for each view definition. For more information about the other components of a wide view, see [Creating a Wide View](./creating-a-wide-view.md).

## Example

The following example shows a `WideEntry` element that defines a single `WideItem` element. The `WideItem` element defines the property whose value is displayed in the view.

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

[SelectionCondition Element for WideEntry (Format)](./selectioncondition-element-for-entryselectedby-for-widecontrol-format.md)

[SelectionSetName Element for WideEntry (Format)](./selectionsetname-element-for-entryselectedby-for-widecontrol-format.md)

[TypeName Element for WideEntry (Format)](./typename-element-for-entryselectedby-for-wideentry-format.md)

[WideEntries Element (Format)](./wideentries-element-for-widecontrol-format.md)

[WideItem Element (Format)](./wideitem-element-for-widecontrol-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

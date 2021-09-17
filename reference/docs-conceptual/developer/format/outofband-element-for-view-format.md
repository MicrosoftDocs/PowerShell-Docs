---
description: OutOfBand Element
ms.date: 08/27/2021
ms.topic: reference
title: OutOfBand Element
---
# OutOfBand Element

In a pipeline, the first object emitted is chosen as the type to format the output of the pipeline.
PowerShell attempts for format subsequent objects using the same view. If the object does not fit
the view, it is not displayed. You can create OutOfBand views that can be used for format these
other types.

## Schema

- Configuration Element
- ViewDefinitions Element
- View Element
- OutOfBand Element

## Syntax

```xml
<OutOfBand/>
```

## Attributes and Elements

The following sections describe attributes, child elements, and the parent element of the
`OutOfBand` element.

### Attributes

None.

### Child Elements

None.

### Parent Elements

|Element|Description|
|-------------|-----------------|
|[View Element](./view-element-format.md)|Defines a view that displays one or more .NET objects.|

## Remarks

When the "shape" of formatting (view) has been determined by previous objects, you may want objects
of different types to continue using that shape (table, list, or whatever) even if they specify
their own views. Or sometimes you want your view to take over. When OutOfBand is true, the view
applies regardless of previous objects that may have selected a different view.

## See Also

[View Element](./view-element-format.md)

[Writing a PowerShell Formatting File](./writing-a-powershell-formatting-file.md)

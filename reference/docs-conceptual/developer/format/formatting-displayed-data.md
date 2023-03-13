---
description: Formatting Displayed Data
ms.date: 03/13/2023
ms.topic: reference
title: Formatting Displayed Data
---
# Formatting Displayed Data

You can specify how the individual data points in your List, Table, or Wide view are displayed. You
can use the `FormatString` element when defining the items of your view, or you can use the
`ScriptBlock` element to call the `FormatString` method on the data.

## Using the FormatString Element

In the following example the value of the **TotalProcessorTime** property of the
[System.Diagnostics.Process][01] object is formatted using the FormatString element. the
**TotalProcessorTime** property

```xml
<TableColumnItem>
  <PropertyName>TotalProcessorTime</PropertyName>
  <FormatString>{0:MMM}{0:dd}{0:HH}:{0:mm}</FormatString>
</TableColumnItem>
```

<!-- link references -->
[01]: xref:System.Diagnostics.Process

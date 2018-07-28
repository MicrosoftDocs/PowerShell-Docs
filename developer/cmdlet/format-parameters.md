---
title: "Format Parameters | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: 10e025c5-9aa6-45a5-b851-23d14db1f4cc
caps.latest.revision: 7
---
# Format Parameters

The following table lists recommended names and functionality for parameters that are used to format or to generate data.

As
Data type: Keyword

Implement this parameter to specify the cmdlet output format. For example, possible values could be Text or Script.

Binary
Data type: SwitchParameter

Implement this parameter to indicate that the cmdlet handles binary values.

Encoding
Data type: Keyword

Implement this parameter to specify the type of encoding that is supported. For example, possible values could be ASCII, UTF8, Unicode, UTF7, BigEndianUnicode, Byte, and String.

NewLine
Data type: SwitchParameter

Implement this parameter so that the newline characters are supported when the parameter is specified.

ShortName
Data type: SwitchParameter

Implement this parameter so that short names are supported when the parameter is specified.

Width
Data type: Int32

Implement this parameter so that the user can specify the width of the output device.

Wrap
Data type: SwitchParameter

Implement this parameter so that text wrapping is supported when the parameter is specified.

## See Also

[Cmdlet Parameters](./cmdlet-parameters.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)

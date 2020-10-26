---
ms.date: 09/13/2016
ms.topic: reference
title: Format Parameters
description: Format Parameters
---
# Format Parameters

The following table lists recommended names and functionality for parameters that are used to format or to generate data.

|Parameter|Functionality|
|---|---|
|**As**<br>Data type: Keyword|Implement this parameter to specify the cmdlet output format. For example, possible values could be Text or Script.|
|**Binary**<br>Data type: SwitchParameter|Implement this parameter to indicate that the cmdlet handles binary values.|
|**Encoding**<br>Data type: Keyword|Implement this parameter to specify the type of encoding that is supported. For example, possible values could be ASCII, UTF8, Unicode, UTF7, BigEndianUnicode, Byte, and String.|
|**NewLine**<br>Data type: SwitchParameter|Implement this parameter so that the newline characters are supported when the parameter is specified.|
|**ShortName**<br>Data type: SwitchParameter|Implement this parameter so that short names are supported when the parameter is specified.|
|**Width**<br>Data type: Int32|Implement this parameter so that the user can specify the width of the output device.|
|**Wrap**<br>Data type: SwitchParameter|Implement this parameter so that text wrapping is supported when the parameter is specified.|
## See Also

[Cmdlet Parameters](./cmdlet-parameters.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)

---
author: sdwheeler
ms.author: sewhee
ms.date: 11/18/2020
ms.topic: include
ms.prod: powershell
---
> [!IMPORTANT]
> As of April 2020, the PowerShell Gallery no longer supports Transport Layer Security (TLS)
> versions 1.0 and 1.1. If you are not using TLS 1.2 or higher, you will receive an error when
> trying to access the PowerShell Gallery. Use the following command to ensure you are using TLS
> 1.2:
>
> ```powershell
> [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
> ```
>
> For more information, see the
> [announcement](https://devblogs.microsoft.com/powershell/powershell-gallery-tls-support/) in the
> PowerShell blog.

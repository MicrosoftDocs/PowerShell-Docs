---
ms.date:  06/12/2017
author:  JKeithB
ms.topic:  reference
keywords:  wmf,powershell,setup
---

# New-TemporaryFile
Sometimes in your scripts, you must create a temporary file. You can easily do this with the **New-TemporaryFile** cmdlet:

PS C:\\&gt; $tempFile = New-TemporaryFile

PS C:\\&gt; $tempFile.FullName

C:\\Users\\slee\\AppData\\Local\\Temp\\tmp375.tmp
---
title:   PowerShell Engine Improvements in WMF 5.1 (Preview)
ms.date:  2016-07-13
keywords:  PowerShell, DSC, WMF
description:  
ms.topic:  article
author:  keithb
manager:  dongill
ms.prod:  powershell
ms.technology: WMF
---

#PowerShell engine improvements

The following improvements to the core PowerShell engine have been implemented in WMF 5.1:


## Performance ##

Performance has improved in some important areas:

- Startup
- Pipelining to cmdlets like ForEach-Object and Where-Object is approximately 50% faster 

Some example improvements (your results may vary depending your your hardware): 

| Scenario | 5.0 Time (ms) | 5.1 Time (ms) |
| -------- | :---------------: | :---------------: |
| `powershell -command "echo 1"` | 900 | 250 |
| First ever PowerShell run: `powershell -command "Unknown-Command"` | 30000 | 13000 |
| Command analysis cache built: `powershell -command "Unknown-Command"` | 7000 | 520 |
| `1..1000000 | % { }` | 1400 | 750 |
  
> Note 
> One change related to startup might impact some unsupported scenarios. PowerShell no longer
reads the files `$pshome\*.ps1xml` - these files have been converted to C# to avoid some file
and CPU overhead of processing the XML files. The files still exist to support V2 side-by-side,
so if you change the file contents, it will not have any effect to V5, only V2. Note that changing
the contents of these files was never a supported scenario.

Another visible change is how PowerShell caches the exported commands and other information for
modules that are installed on a system. Previous, this cache was stored in the directory
`$env:LOCALAPPDATA\Microsoft\Windows\PowerShell\CommandAnalysis`. In WMF 5.1, the cache is a single
file `$env:LOCALAPPDATA\Microsoft\Windows\PowerShell\ModuleAnalysisCache`.
See [analysis_cache.md]() for more details.
---
title: example template of a known issue or limitation writeup
author:  
---

>Note: provide a proposed descriptive title and a brief description

## Example: Erroneous ExecutionPolicy errors ##
On Windows 7, the use of PowerShell modules and DSC resources may result in errors reported about ExecutionPolicy.

### Resolution

To resolve, set the **ExecutionPolicy** to **RemoteSigned** by running the following command in an elevated PowerShell session (Run as Administrator):

```powershell
Set-ExecutionPolicy RemoteSigned
```

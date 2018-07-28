---
ms.date:  06/12/2017


keywords:  wmf,powershell,setup
---

# Declare Base Class
You can declare a Windows PowerShell class as a base type for another Windows PowerShell class.

```powershell
class bar
{
   [int]foo()
       {
           return 100500
       }
}

class baz : bar {}

[baz]::new().foo() # return 100500
```

You can also use existing .NET Framework types as base classes:

```powershell
class MyIntList : system.collections.generic.list[int]
{

}

$list = [MyIntList]::new()

$list.Add(100)

$list[0] # return 100
```

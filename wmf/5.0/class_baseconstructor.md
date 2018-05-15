---
ms.date:  06/12/2017


keywords:  wmf,powershell,setup
---

# Call Base Class Constructor

To call a base class constructor from a subclass, use the keyword **base**:

```powershell
class A
{
	[int]$a

	A([int]$a)
	{
		$this.a = $a
	}
}

class B : A
{
	B() : base(103) {}
}

[B]::new().a # return 103
```

If a base class has a default (no parameter) constructor, you can omit an explicit constructor call:

```powershell
class C : B
{
	C([int]$c) {}
}
```

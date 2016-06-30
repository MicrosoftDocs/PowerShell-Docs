# Call Base Class Method

You can override existing methods in subclasses. To do this, declare methods by using the same name and signature:

```PowerShell
class baseClass
{
	[int]foo() {return 100500}
}

class childClass1 : baseClass
{
	[int]foo() {return 200600}
}

[childClass1]::new().foo() # return 200600
```

To call base class methods from overridden implementations, cast to the base class ([baseClass]$this) on invocation:

```PowerShell
class childClass2 : baseClass
{
	[int]foo()
	{
		return 3 * ([baseClass]$this).foo()
	}
}

[childClass2]::new().foo() # return 301500
```

All PowerShell methods are virtual. You can hide non-virtual .NET methods in a subclass by using the same syntax as you do for an override: just declare methods with same name and signature.

```PowerShell
class MyIntList : system.collections.generic.list[int]
{
	# Add is final in system.collections.generic.list
	[void] Add([int]$arg)
	{
		([system.collections.generic.list[int]]$this).Add($arg * 2)
	}
}

$list = [MyIntList]::new()
$list.Add(100)
$list[0] # return 200
```
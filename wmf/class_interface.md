# Declare Implemented Interface

You can declare implemented interfaces after base types, or immediately after a colon (:), if there is no base type specified. Separate all type names by using commas. It’s very similar to C# syntax.

```PowerShell
class MyComparable : system.IComparable
{
	[int] CompareTo([object] $obj)
	{
		return 0;
	}
}

class MyComparableBar : bar, system.IComparable
{
	[int] CompareTo([object] $obj)
	{
		return 0;
	}
}
```
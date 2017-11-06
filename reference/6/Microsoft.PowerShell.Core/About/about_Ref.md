---
ms.date:  2017-06-09
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Ref
---

# About Ref

## SHORT DESCRIPTION

Describes how to create and use a reference variable type.

## LONG DESCRIPTION

You can use the reference variable type to permit a method to change the value
of a variable that is passed to it.

When the [ref] type is associated with an object, it returns a reference to
that object. If the reference is used with a method, the method can refer to
the object that was passed to it. If the object is changed within the method,
the change appears as a change in the value of the variable when control
returns to the calling method.

To use referencing, the parameter must be a reference variable. If it is not,
an InvalidArgument exception is thrown.

The parameters used in method invocations must match the type required by the
methods.

Examples:

```powershell
PS> function swap([ref]$a,[ref]$b)
>> {
>>     $a.value,$b.value = $b.value,$a.value
>> }

PS> $a = 1
PS> $b = 10
PS> $a,$b
1
10
PS> swap ([ref]$a) ([ref]$b)
PS> $a,$b
10
1

PS C:\ps-test> function double
>> {
>>     param ([ref]$x) $x.value = $x.value * 2
>> }

PS C:> $number = 8
PS C:> $number
8
PS C> double ([ref]$number)
PS C> $number
16
```

The variable must be a reference variable.

```powershell
PS C:\ps-test> double $number
double : Reference type is expected in argument.
At line:1 char:7
+ double  <<<< $number
```

## SEE ALSO

- [about_Variables](about_Variables.md)
- [about_Environment_Variables](about_Environment_Variables.md)
- [about_Functions](about_Functions.md)
- [about_Script_Blocks](about_Script_Blocks.md)

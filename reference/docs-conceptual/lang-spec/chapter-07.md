---
description: An expression is a sequence of operators and operands that designates a method, a function, a writable location, or a value; specifies the computation of a value; produces one or more side effects; or performs some combination thereof.
ms.date: 05/19/2021
title: Expressions
---
# 7. Expressions

Syntax:

```Syntax
expression:
    logical-expression
```

Description:

An *expression* is a sequence of operators and operands that designates a method, a function, a
writable location, or a value; specifies the computation of a value; produces one or more side
effects; or performs some combination thereof. For example,

- The literal 123 is an expression that designates the int value 123.
- The expression `1,2,3,4` designates the 4-element array object having the values shown.
- The expression `10.4 * $a` specifies a computation.
- The expression `$a++` produces a side effect.
- The expression `$a[$i--] = $b[++$j]` performs a combination of these things.

Except as specified for some operators, the order of evaluation of terms in an expression and the
order in which side effects take place are both unspecified. Examples of unspecified behavior
include the following: `$i++ + $i`, `$i + --$i`, and `$w[$j++] = $v[$j]`.

An implementation of PowerShell may provide support for user-defined types, and those types may have
operations defined on them. All details of such types and operations are implementation defined.

A *top-level expression* is one that is not part of some larger expression. If a top-level
expression contains a side-effect operator the value of that expression is not written to the
pipeline; otherwise, it is. See [§7.1.1][] for a detailed discussion of this.

Ordinarily, an expression that designates a collection (§4) is enumerated into its constituent
elements when the value of that expression is used. However, this is not the case when the
expression is a cmdlet invocation. For example,

```powershell
$x = 10,20,30
$a = $($x; 99)                     # $a.Length is 4

$x = New-Object 'int[]' 3
$a = $($x; 99)                     # equivalent, $a.Length is 4

$a = $(New-Object 'int[]' 3; 99)   # $a.Length is 2
```

In the first two uses of the `$(...)` operator, the expression designating the collection is the
variable `$x`, which is enumerated resulting in three `int` values, plus the `int` 99. However, in
the third case, the expression is a direct call to a cmdlet, so the result is not enumerated, and
`$a` is an array of two elements, `int[3]` and `int`.

If an operation is not defined by PowerShell, the type of the value designated by the left operand
is inspected to see if it has a corresponding `op_<operation>` method.

## 7.1 Primary expressions

Syntax:

```Syntax
primary-expression:
    value
    member-access
    element-access
    invocation-expression
    post-increment-expression
    post-decrement-expression

value:
    parenthesized-expression
    sub-expression
    array-expression
    script-block-expression
    hash-literal-expression
    literal
    type-literal
    variable
```

### 7.1.1 Grouping parentheses

Syntax:

> [!TIP]
> The `~opt~` notation in the syntax definitions indicates that the lexical entity is optional in
> the syntax.

```Syntax
parenthesized-expression:
    ( new-lines~opt~ pipeline new-lines~opt~ )
```

Description:

A parenthesized expression is a *primary-expression* whose type and value are the same as those of
the expression without the parentheses. If the expression designates a variable then the
parenthesized expression designates that same variable. For example, `$x.m` and `($x).m` are
equivalent.

Grouping parentheses may be used in an expression to document the default precedence and
associativity within that expression. They can also be used to override that default precedence and
associativity. For example,

```powershell
4 + 6 * 2    # 16
4 + (6 * 2)  # 16 document default precedence
(4 + 6) * 2  # 20 override default precedence
```

Ordinarily, grouping parentheses at the top-most level are redundant. However, that is not always
the case. Consider the following example:

```powershell
2,4,6       # Length 3; values 2,4,6
(2,4),6     # Length 2; values [object[]],int
```

In the second case, the parentheses change the semantics, resulting in an array whose two elements
are an array of 2 ints and the scalar int 6.

Here's another exception:

```powershell
23.5/2.4          # pipeline gets 9.79166666666667
$a = 1234 * 3.5   # value not written to pipeline
$a                # pipeline gets 4319
```

In the first and third cases, the value of the result is written to the pipeline. However, although
the expression in the second case is evaluated, the result is not written to the pipeline due to the
presence of the side-effect operator = at the top level. (Removal of the `$a = ` part allows the
value to be written, as `*` is not a side-effect operator.)

To stop a value of any expression not containing top-level side effects from being written to the
pipeline, discard it explicitly, as follows:

```powershell
# None of these value are written to pipeline
[void](23.5/2.4)
[void]$a
$null = $a
$a > $null
```

To write to the pipeline the value of any expression containing top-level side effects, enclose that
expression in parentheses, as follows:

```powershell
($a = 1234 * 3.5) # pipeline gets 4319
```

As such, the grouping parentheses in this case are not redundant.

In the following example, we have variable substitution ([§2.3.5.2][]) taking place in a string
literal:

```powershell
">$($a = -23)<"    # value not written to pipeline, get
><
">$(($a = -23))<"  # pipeline gets >-23<
```

In the first case, the parentheses represent a *sub-expression*'s delimiters *not* grouping
parentheses, and as the top-level expression contains a side-effect operator, the expression's value
is not written to the pipeline. Of course, the `>` and `<` characters are still written.) If
grouping parenthesis are added -- as shown in the second case -- writing is enabled.

The following examples each contain top-level side-effect operators:

```powershell
$a = $b = 0      # value not written to pipeline
$a = ($b = 0)    # value not written to pipeline
($a = ($b = 0))  # pipeline gets 0

++$a             # value not written to pipeline
(++$b)           # pipeline gets 1

$a--             # value not written to pipeline
($b--)           # pipeline gets 1
```

The use of grouping parentheses around an expression containing no top-level side effects makes
those parentheses redundant. For example;

```powershell
$a      # pipeline gets 0
($a)    # no side effect, so () redundant
```

Consider the following example that has two side effects, neither of which is at the top level:

```powershell
12.6 + ($a = 10 - ++$b) # pipeline gets 21.6.
```

The result is written to the pipeline, as the top-level expression has no side effects.

### 7.1.2 Member access

Syntax:

```Syntax
member-access: Note no whitespace is allowed after
    primary-expression . member-name
    primary-expression :: member-name
```

Description:

The operator `.` is used to select an instance member from an object, or a key from a `Hashtable`.
The left operand must designate an object, and the right operand must designate an accessible
instance member.

Either the right operand designates an accessible instance member within the type of the object
designated by the left operand or, if the left operand designates an array, the right operand
designates accessible instance members within each element of the array.

White space is not permitted before the `.` operator.

This operator is left associative.

The operator `::` is used to select a static member from a given type. The left operand must
designate a type, and the right-hand operand must designate an accessible static member within that
type.

White space is not permitted before the `::` operator.

This operator is left associative.

If the right-hand operand designates a writable location within the type of the object designated by
the left operand, then the whole expression designates a writable location.

Examples:

```powershell
$a = 10, 20, 30
$a.Length                    # get instance property

(10, 20, 30).Length

$property = "Length"
$a.$property                 # property name is a variable

$h1 = @{ FirstName = "James"; LastName = "Anderson"; IDNum = 123
}
$h1.FirstName                # designates the key FirstName
$h1.Keys                     # gets the collection of keys

[int]::MinValue              # get static property
[double]::PositiveInfinity   # get static property
$property = "MinValue"
[long]::$property            # property name is a variable

foreach ($t in [byte], [int], [long]) {
    $t::MaxValue             # get static property
}

$a = @{ID = 1 }, @{ID = 2 }, @{ID = 3 }
$a.ID                        # get ID from each element in the array
```

### 7.1.3 Invocation expressions

Syntax:

```Syntax
invocation-expression: Note no whitespace is allowed after
    primary-expression . member-name argument-list
    primary-expression :: member-name argument-list

argument-list:
    ( argument-expression-list~opt~ new-lines~opt~ )
```

Description:

An *invocation-expression* calls the method designated by *primary-expression*.*member-name* or
*primary-expression*::*member-name*. The parentheses in *argument-list* contain a possibly empty,
comma-separated list of expressions, which designate the *arguments* whose values are passed to the
method. Before the method is called, the arguments are evaluated and converted according to the
rules of §6, if necessary, to match the types expected by the method. The order of evaluation of
*primary-expression*.*member-name*, *primary-expression*::*member-name*, and the arguments is
unspecified.

This operator is left associative.

The type of the result of an *invocation-expression* is a *method designator* ([§4.5.24][]).

Examples:

```powershell
[math]::Sqrt(2.0)            # call method with argument 2.0
[char]::IsUpper("a")         # call method
$b = "abc#$%XYZabc"
$b.ToUpper()                 # call instance method

[math]::Sqrt(2)              # convert 2 to 2.0 and call method
[math]::Sqrt(2D)             # convert 2D to 2.0 and call method
[math]::Sqrt($true)          # convert $true to 1.0 and call method
[math]::Sqrt("20")           # convert "20" to 20 and call method

$a = [math]::Sqrt            # get method descriptor for Sqrt
$a.Invoke(2.0)               # call Sqrt via the descriptor
$a = [math]::("Sq"+"rt")     # get method descriptor for Sqrt
$a.Invoke(2.0)               # call Sqrt via the descriptor
$a = [char]::ToLower         # get method descriptor for ToLower
$a.Invoke("X")               # call ToLower via the descriptor
```

### 7.1.4 Element access

Syntax:

```Syntax
element-access: Note no whitespace is allowed between primary-expression and [.
    primary-expression [ new-lines~opt~ expression new-lines~opt~ ]
```

Description:

There must not be any white space between *primary-expression* and the left square bracket (`[`).

#### 7.1.4.1 Subscripting an array

Description:

Arrays are discussed in detail in [§9.][] If *expression* is a 1-dimensional array, see
[§7.1.4.5][].

When *primary-expression* designates a 1-dimensional array *A*, the operator `[]` returns the
element located at `A[0 + expression]` after the value of *expression* has been converted to `int`.
The result has the element type of the array being subscripted. If *expression* is negative,
`A[expression]` designates the element located at `A[A.Length + expression]`.

When *primary-expression* designates a 2-dimensional array *B*, the operator `[]` returns the
element located at `B[0 + row,0 + column]` after the value of the *row* and *column* components of
*expression* (which are specified as a comma-separated list) have been converted to `int`. The
result has the element type of the array being subscripted. Unlike for a 1-dimensional array,
negative positions have no special meaning.

When *primary-expression* designates an array of three or more dimensions, the rules for
2-dimensional arrays apply and the dimension positions are specified as a comma-separated list of
values.

If a read access on a non-existing element is attempted, the result is `$null`. It is an error to
write to a non-existing element.

For a multidimensional-array subscript expression, the order of evaluation of the dimension position
expressions is unspecified. For example, given a 3-dimensional array `$a`, the behavior of
`$a[$i++,$i,++$i]` is unspecified.

If *expression* is an array, see [§7.1.4.5][].

This operator is left associative.

Examples:

```powershell
$a = [int[]](10,20,30) # [int[]], Length 3
$a[1] # returns int 20
$a[20] # no such position, returns $null
$a[-1] # returns int 30, i.e., $a[$a.Length-1]
$a[2] = 5 # changes int 30 to int 5
$a[20] = 5 # implementation-defined behavior

$a = New-Object 'double[,]' 3,2
$a[0,0] = 10.5 # changes 0.0 to 10.5
$a[0,0]++ # changes 10.5 to 10.6

$list = ("red",$true,10),20,(1.2, "yes")
$list[2][1] # returns string "yes"

$a = @{ A = 10 },@{ B = $true },@{ C = 123.45 }
$a[1]["B"] # $a[1] is a Hashtable, where B is a key

$a = "red","green"
$a[1][4] # returns string "n" from string in $a[1]
```

If a write access to a non-existing element is attempted, an **IndexOutOfRange** exception is
raised.

#### 7.1.4.2 Subscripting a string

Description:

When *primary-expression* designates a string *S*, the operator `[]` returns the character located
in the zero-based position indicated by *expression*, as a char. If *expression* is greater than or
equal to that string's length, the result is `$null`. If *expression* is negative,
`S[expression]` designates the element located at `S[S.Length + expression]`.

Examples:

```powershell
$s = "Hello"   # string, Length 5, positions 0-4
$c = $s[1]     # returns "e" as a string
$c = $s[20]    # no such position, returns $null
$c = $s[-1]    # returns "o", i.e., $s[$s.Length-1]
```

#### 7.1.4.3 Subscripting a Hashtable

Description:

When *primary-expression* designates a Hashtable, the operator `[]` returns the value(s) associated
with the key(s) designated by *expression*. The type of *expression* is not restricted.

When *expression* is a single key name, the result is the associated value and has that type, unless
no such key exists, in which case, the result is `$null`. If `$null` is used as the key the behavior
is implementation defined. If *expression* is an array of key names, see [§7.1.4.5][].

If *expression* is an array, see [§7.1.4.5][].

Examples:

```powershell
$h1 = @{ FirstName = "James"; LastName = "Anderson"; IDNum = 123 }
$h1['FirstName']     # the value associated with key FirstName
$h1['BirthDate']     # no such key, returns $null

$h1 = @{ 10 = "James"; 20.5 = "Anderson"; $true = 123 }
$h1[10]              # returns value "James" using key 10
$h1[20.5]            # returns value "Anderson" using key 20.5
$h1[$true]           # returns value 123 using key $true
```

When *expression* is a single key name, if `$null` is used as the only value to subscript a
Hashtable, a **NullArrayIndex** exception is raised.

#### 7.1.4.4 Subscripting an XML document

Description:

When *primary-expression* designates an object of type xml, *expression* is converted to string, if
necessary, and the operator `[]` returns the first child element having the name specified by
*expression*. The type of *expression* must be string. The type of the result is implementation
defined. The result can be subscripted to return its first child element. If no child element exists
with the name specified by *expression*, the result is `$null`. The result does not designate a
writable location.

Examples:

```powershell
$x = [xml]@"
<Name>
<FirstName>Mary</FirstName>
<LastName>King</LastName>
</Name>
"@

$x['Name']                # refers to the element Name
$x['Name']['FirstName']   # refers to the element FirstName within Name
$x['FirstName']           # No such child element at the top level, result is `$null`
```

The type of the result is `System.Xml.XmlElement` or `System.String`.

#### 7.1.4.5 Generating array slices

When *primary-expression* designates an object of a type that is enumerable (§4) or a Hashtable, and
*expression* is a 1-dimensional array, the result is an array slice ([§9.9][]) containing the
elements of *primary-expression* designated by the elements of *expression*.

In the case of a Hashtable, the array slice contains the associated values to the keys provided,
unless no such key exists, in which case, the corresponding element is `$null`. If `$null` is used
as any key name the behavior is implementation defined.

Examples:

```powershell
$a = [int[]](30,40,50,60,70,80,90)
$a[1,3,5]                 # slice has Length 3, value 40,60,80
++$a[1,3,5][1]            # preincrement 60 in array 40,60,80
$a[,5]                    # slice with Length 1
$a[@()]                   # slice with Length 0
$a[-1..-3]                # slice with Length 0, value 90,80,70
$a = New-Object 'int[,]' 3,2
$a[0,0] = 10; $a[0,1] = 20; $a[1,0] = 30
$a[1,1] = 40; $a[2,0] = 50; $a[2,1] = 60
$a[(0,1),(1,0)]           # slice with Length 2, value 20,30, parens needed
$h1 = @{ FirstName = "James"; LastName = "Anderson"; IDNum = 123 }
$h1['FirstName']          # the value associated with key FirstName
$h1['BirthDate']          # no such key, returns $null
$h1['FirstName','IDNum']  # returns [object[]], Length 2 (James/123)
$h1['FirstName','xxx']    # returns [object[]], Length 2 (James/$null)
$h1[$null,'IDNum']        # returns [object[]], Length 1 (123)
```

Windows PowerShell: When *expression* is a collection of two or more key names, if `$null` is used
as any key name that key is ignored and has no corresponding element in the resulting array.

### 7.1.5 Postfix increment and decrement operators

Syntax:

```Syntax
post-increment-expression:
    primary-expression ++

post-decrement-expression:
    primary-expression dashdash

dashdash:
    --
```

Description:

The *primary-expression* must designate a writable location having a value of numeric type (§4) or
the value `$null`. If the value designated by the operand is `$null`, that value is converted to
type int and value zero before the operator is evaluated. The type of the value designated by
*primary-expression* may change when the result is stored. See [§7.11][] for a discussion of type
change via assignment.

The result produced by the postfix `++` operator is the value designated by the operand. After that
result is obtained, the value designated by the operand is incremented by 1 of the appropriate type.
The type of the result of expression `E++` is the same as for the result of the expression `E + 1`
([§7.7][]).

The result produced by the postfix `--` operator is the value designated by the operand. After that
result is obtained, the value designated by the operand is decremented by 1 of the appropriate type.
The type of the result of expression `E--` is the same as for the result of the expression `E - 1`
([§7.7][]).

These operators are left associative.

Examples:

```powershell
$i = 0                # $i = 0
$i++                  # $i is incremented by 1
$j = $i--             # $j takes on the value of $i before the decrement

$a = 1,2,3
$b = 9,8,7
$i = 0
$j = 1
$b[$j--] = $a[$i++]   # $b[1] takes on the value of $a[0], then $j is
                      # decremented, $i incremented

$i = 2147483647       # $i holds a value of type int
$i++                  # $i now holds a value of type double because
                      # 2147483648 is too big to fit in type int

[int]$k = 0           # $k is constrained to int
$k = [int]::MaxValue  # $k is set to 2147483647
$k++                  # 2147483648 is too big to fit, imp-def bahavior

$x = $null            # target is unconstrained, $null goes to [int]0
$x++                  # value treated as int, 0->1
```

### 7.1.6 $(...) operator

Syntax:

```Syntax
sub-expression:
    $( new-lines~opt~ statement-list~opt~ new-lines~opt~ )
```

Description:

If *statement-list* is omitted, the result is `$null`. Otherwise, *statement-list* is evaluated. Any
objects written to the pipeline as part of the evaluation are collected in an unconstrained
1-dimensional array, in order. If the array of collected objects is empty, the result is `$null`. If
the array of collected objects contains a single element, the result is that element; otherwise, the
result is the unconstrained 1-dimensional array of collected results.

Examples:

```powershell
$j = 20
$($i = 10) # pipeline gets nothing
$(($i = 10)) # pipeline gets int 10
$($i = 10; $j) # pipeline gets int 20
$(($i = 10); $j) # pipeline gets [object[]](10,20)
$(($i = 10); ++$j) # pipeline gets int 10
$(($i = 10); (++$j)) # pipeline gets [object[]](10,22)
$($i = 10; ++$j) # pipeline gets nothing
$(2,4,6) # pipeline gets [object[]](2,4,6)
```

### 7.1.7 @(...) operator

Syntax:

```Syntax
array-expression:
    @( new-lines~opt~ statement-list~opt~ new-lines~opt~ )
```

Description:

If *statement-list* is omitted, the result is an unconstrained 1-dimensional array of length zero.
Otherwise, *statement-list* is evaluated, and any objects written to the pipeline as part of the
evaluation are collected in an unconstrained 1-dimensional array, in order. The result is the
(possibly empty) unconstrained 1-dimensional array.

Examples:

```powershell
$j = 20
@($i = 10)             # 10 not written to pipeline, result is array of 0
@(($i = 10))           # pipeline gets 10, result is array of 1
@($i = 10; $j)         # 10 not written to pipeline, result is array of 1
@(($i = 10); $j)       # pipeline gets 10, result is array of 2
@(($i = 10); ++$j)     # pipeline gets 10, result is array of 1
@(($i = 10); (++$j))   # pipeline gets both values, result is array of 2
@($i = 10; ++$j)       # pipeline gets nothing, result is array of 0

$a = @(2,4,6)          # result is array of 3
@($a)                  # result is the same array of 3
@(@($a))               # result is the same array of 3
```

### 7.1.8 Script block expression

Syntax:

```Syntax
script-block-expression:
    { new-lines~opt~ script-block new-lines~opt~ }

script-block:
    param-block~opt~ statement-terminators~opt~ script-block-body~opt~

script-block-body:
    named-block-list
    statement-list
```

Description:

*param-block* is described in [§8.10.9][]. *named-block-list* is described in [§8.10.7][].

A script block is an unnamed block of statements that can be used as a single unit. Script blocks
can be used to invoke a block of code as if it was a single command, or they can be assigned to
variables that can be executed.

The *named-block-list* or *statement-list* is executed and the type and value(s) of the result are
the type and value(s) of the results of those statement sets.

A *script-block-expression* has type scriptblock ([§4.3.7][]).

If *param-block* is omitted, any arguments passed to the script block are available via `$args`
([§8.10.1][]).

During parameter binding, a script block can be passed either as a script block object or as the
result after the script block has been evaluated. See [§6.17][] for further information.

### 7.1.9 Hash literal expression

Syntax:

```Syntax
hash-literal-expression:
    @{ new-lines~opt~ hash-literal-body~opt~ new-lines~opt~ }

hash-literal-body:
    hash-entry
    hash-literal-body statement-terminators hash-entry

hash-entry:
    key-expression = new-lines~opt~ statement

key-expression:
    simple-name
    unary-expression

statement-terminators:
    statement-terminator
    statement-terminators statement-terminator

statement-terminator:
    ;
    new-line-character
```

Description:

A *hash-literal-expression* is used to create a Hashtable (§10) of zero or more elements each of
which is a key/value pair.

The key may have any type except the null type. The associated values may have any type, including
the null type, and each of those values may be any expression that designates the desired value,
including `$null`.

The ordering of the key/value pairs is not significant.

Examples:

```powershell
$h1 = @{ FirstName = "James"; LastName = "Anderson"; IDNum = 123 }
$last = "Anderson"; $IDNum = 120
$h2 = @{ FirstName = "James"; LastName = $last; IDNum = $IDNum + 3 }
$h3 = @{ }
$h4 = @{ 10 = "James"; 20.5 = "Anderson"; $true = 123 }
```

which creates two Hashtables, `$h1` and `$h2`, each containing three key/value pairs, and a third,
`$h3`, that is empty. Hashtable `$h4` has keys of various types.

### 7.1.10 Type literal expression

Syntax:

```Syntax
type-literal:
    [ type-spec ]

type-spec:
    array-type-name new-lines~opt~ dimension~opt~ ]
    generic-type-name new-lines~opt~ generic-type-arguments ]
    type-name

dimension:
    ,
    dimension ,

generic-type-arguments:
    type-spec new-lines~opt~
    generic-type-arguments , new-lines~opt~ type-spec

array-type-name:
    type-name [

generic-type-name:
    type-name [
```

Description:

A *type-literal* is represented in an implementation by some unspecified *underlying type*. As a
result, a type name is a synonym for its underlying type.

Type literals are used in a number of contexts:

- Specifying an explicit conversion (§6, [§7.2.9][])
- Creating a type-constrained array ([§9.4][])
- Accessing the static members of an object ([§7.1.2][])
- Specifying a type constraint on a variable ([§5.3][]) or a function parameter ([§8.10.2][])

Examples:

Examples of type literals are `[int]`, `[object[]`, and `[int[,,]]`. A generic stack type ([§4.4][])
that is specialized to hold strings might be written as `[Stack[string]]`, and a generic dictionary
type that is specialized to hold `int` keys with associated string values might be written as
`[Dictionary[int,string]]`.

The type of a *type-literal* is `System.Type`. The complete name for the type `Stack[string]`
suggested above is `System.Collections.Generic.Stack[int]`. The complete name for the type
`Dictionary[int,string]` suggested above is `System.Collections.Generic.Dictionary[int,string]`.

## 7.2 Unary operators

Syntax:

```Syntax
unary-expression:
    primary-expression
    expression-with-unary-operator

expression-with-unary-operator:
    , new-lines~opt~ unary-expression
    -not new-lines~opt~ unary-expression
    ! new-lines~opt~ unary-expression
    -bnot new-lines~opt~ unary-expression
    + new-lines~opt~ unary-expression
    dash new-lines~opt~ unary-expression
    pre-increment-expression
    pre-decrement-expression
    cast-expression
    -split new-lines~opt~ unary-expression
    -join new-lines~opt~ unary-expression

dash:*
    - (U+002D)
    EnDash character (U+2013)
    EmDash character (U+2014)
    Horizontal bar character (U+2015)

pre-increment-expression:
    ++ new-lines~opt~ unary-expression

pre-decrement-expression:
    dashdash new-lines~opt~ unary-expression

cast-expression:
    type-literal unary-expression

dashdash:
    dash dash
```

### 7.2.1 Unary comma operator

Description:

This operator creates an unconstrained 1-dimensional array having one element, whose type and value
are that of *unary-expression*.

This operator is right associative.

Examples:

```powershell
$a = ,10         # create an unconstrained array of 1 element, $a[0],
                 # which has type int

$a = ,(10,"red") # create an unconstrained array of 1 element,
$a[0],
                 # which is an unconstrained array of 2 elements,
                 # $a[0][0] an int, and $a[0][1] a string

$a = ,,10        # create an unconstrained array of 1 element, which is
                 # an unconstrained array of 1 element, which is an int
                 # $a[0][0] is the int. Contrast this with @(@(10))
```

### 7.2.2 Logical NOT

Description:

The operator -not converts the value designated by *unary-expression* to type bool ([§6.2][]), if
necessary, and produces a result of that type. If *unary-expression*'s value is True, the result is
False, and vice versa. The operator ! is an alternate spelling for -not.

This operator is right associative.

Examples:

```powershell
-not $true         # False
-not -not $false   # False
-not 0             # True
-not 1.23          # False
!"xyz"             # False
```

### 7.2.3 Bitwise NOT

Description:

The operator -bnot converts the value designated by *unary-expression* to an integer type
([§6.4][]), if necessary. If the converted value can be represented in type int then that is the
result type. Else, if the converted value can be represented in type long then that is the result
type. Otherwise, the expression is ill formed. The resulting value is the ones-complement of the
converted value.

This operator is right associative.

Examples:

```powershell
-bnot $true         # int with value 0xFFFFFFFE
-bnot 10            # int with value 0xFFFFFFF5
-bnot 2147483648.1  # long with value 0xFFFFFFFF7FFFFFFF
-bnot $null         # int with value 0xFFFFFFFF
-bnot "0xabc"       # int with value 0xFFFFF543
```

### 7.2.4 Unary plus

Description:

An expression of the form +*unary-expression* is treated as if it were written as
`0 + unary-expression` ([§7.7][]). The integer literal 0 has type `int`.

This operator is right associative.

Examples:

```powershell
+123L         # type long, value 123
+0.12340D     # type decimal, value 0.12340
+"0xabc"      # type int, value 2748
```

### 7.2.5 Unary minus

Description:

An expression of the form -*unary-expression* is treated as if it were written as
`0 - unary-expression` ([§7.7][]). The integer literal 0 has type `int`.

This operator is right associative.

Examples:

-$true # type int, value -1
-123L # type long, value -123
-0.12340D # type decimal, value -0.12340

### 7.2.6 Prefix increment and decrement operators

Description:

The *unary-expression* must designate a writable location having a value of numeric type (§4) or the
value `$null`. If the value designated by its *unary-expression* is `$null`, *unary-expression*'s
value is converted to type int and value zero before the operator is evaluated.

> [!NOTE]
> The type of the value designated by *unary-expression* may change when the result is stored. See
> [§7.11][] for a discussion of type change via assignment.

For the prefix `++` operator, the value of *unary-expression* is incremented by 1 of the appropriate
type. The result is the new value after incrementing has taken place. The expression `++E` is
equivalent to `E += 1` ([§7.11.2][]).

For the prefix `--` operator, the value of *unary-expression* is decremented by 1 of the appropriate
type. The result is the new value after decrementing has taken place. The expression `--E` is
equivalent to `E -= 1` ([§7.11.2][]).

These operators are right associative.

Examples:

```powershell
$i = 0                # $i = 0
$++i                  # $i is incremented by 1
$j = --$i             # $i is decremented then $j takes on the value of $i

$a = 1,2,3
$b = 9,8,7
$i = 0;
$j = 1
$b[--$j] = $a[++$i]   # $j is # decremented, $i incremented, then $b[0]
                      # takes on the value of $a[1]

$i = 2147483647       # $i holds a value of type int
++$i                  # $i now holds a value of type double because
                      # 2147483648 is too big to fit in type int

[int]$k = 0           # $k is constrained to int
$k = [int]::MinValue  # $k is set to -2147483648
$--k                  # -2147483649 is too small to fit, imp-def behavior

$x = $null            # target is unconstrained, $null goes to [int]0
$--x                  # value treated as int, 0->-1
```

### 7.2.7 The unary -join operator

Description:

The unary `-join` operator produces a string that is the concatenation of the value of one or more
objects designated by *unary-expression*. (A separator can be inserted by using the binary version
of this operator ([§7.8.4.4][]).)

*unary-expression* can be a scalar value or a collection.

Examples:

```powershell
-join (10, 20, 30)             # result is "102030"
-join (123, $false, 19.34e17)  # result is "123False1.934E+18"
-join 12345                    # result is "12345"
-join $null                    # result is ""
```

### 7.2.8 The unary -split operator

Description:

The unary `-split` operator splits one or more strings designated by *unary-expression*, returning
their subparts in a constrained 1-dimensional array of string. It treats any contiguous group of
white space characters as the delimiter between successive subparts. (An explicit delimiter string
can be specified by using the binary version of this operator ([§7.8.4.5][]).) This operator has two
variants ([§7.8][]).

The delimiter text is not included in the resulting strings. Leading and trailing white space in the
input string is ignored. An input string that is empty or contains white space only results in an
array of 1 string, which is empty.

*unary-expression* can designate a scalar value or an array of strings.

Examples:

```powershell
-split " red\`tblue\`ngreen " # 3 strings: "red", "blue", "green"
-split ("yes no", "up down") # 4 strings: "yes", "no", "up", "down"
-split " " # 1 (empty) string
```

### 7.2.9 Cast operator

Description:

This operator converts explicitly (§6) the value designated by *unary-expression* to the type
designated by *type-literal*. If *type-literal* is other than void, the type of the result is the
named type, and the value is the value after conversion. If *type-literal* is void, no object is
written to the pipeline and there is no result.

When an expression of any type is cast to that same type, the resulting type and value is the
*unary-expression*'s type and value.

This operator is right associative.

Examples:

```powershell
[bool]-10        # a bool with value True
[int]-10.70D     # a decimal with value -10
[int]10.7        # an int with value 11
[long]"+2.3e+3"  # a long with value 2300
[char[]]"Hello"  # an array of 5 char with values H, e, l, l, and o.
```

## 7.3 Binary comma operator

Syntax:

```Syntax
array-literal-expression:
    unary-expression
    unary-expression , new-lines~opt~ array-literal-expression
```

Description:

The binary comma operator creates a 1-dimensional array whose elements are the values designated by
its operands, in lexical order. The array has unconstrained type.

Examples:

```powershell
2,4,6                    # Length 3; values 2,4,6
(2,4),6                  # Length 2; values [object[]],int
(2,4,6),12,(2..4)        # Length 3; [object[]],int,[object[]]
2,4,6,"red",$null,$true  # Length 6
```

The addition of grouping parentheses to certain binary comma expressions does not document the
default precedence; instead, it changes the result.

## 7.4 Range operator

Syntax:

```Syntax
range-expression:
array-literal-expression
range-expression *..* new-lines~opt~
array-literal-expression
```

Description:

A *range-expression* creates an unconstrained 1-dimensional array whose elements are the values of
the int sequence specified by the range bounds. The values designated by the operands are converted
to int, if necessary ([§6.4][]). The operand designating the lower value after conversion is the
*lower bound*, while the operand designating the higher value after conversion is the *upper bound*.
Both bounds may be the same, in which case, the resulting array has length 1. If the left operand
designates the lower bound, the sequence is in ascending order. If the left operand designates the
upper bound, the sequence is in descending order.

Conceptually, this operator is a shortcut for the corresponding binary comma operator sequence. For
example, the range `5..8` can also be generated using `5,6,7,8`. However, if an ascending or
descending sequence is needed without having an array, an implementation may avoid generating an
actual array. For example, in `foreach ($i in 1..5) { ... }`, no array need be created.

A *range-expression* can be used to specify an array slice ([§9.9][]).

Examples:

```powershell
1..10        # ascending range 1..10
-500..-495   # descending range -500..-495
16..16       # sequence of 1

$x = 1.5
$x..5.40D    # ascending range 2..5

$true..3     # ascending range 1..3
-2..$null    # ascending range -2..0
"0xf".."0xa" # descending range 15..10
```

## 7.5 Format operator

Syntax:

```Syntax
format-expression:
    range-expression
    format-expression format-operator new-lines~opt~ range-expression

format-operator:
    dash f

dash:
    - (U+002D)
    EnDash character (U+2013)
    EmDash character (U+2014)
    Horizontal bar character (U+2015)
```

Description:

A format-expression formats one or more values designated by *range-expression* according to a
*format specification string* designated by *format-expression*. The positions of the values
designated by *range-expression* are numbered starting at zero and increasing in lexical order. The
result has type `string`.

A format specification string may contain zero or more format specifications each having the
following form:

`{N [ ,M ][ : FormatString ]}`

*N* represents a (required) *range-expression* value position, *M* represents the (optional) minimum
display width, and *FormatString* indicates the (optional) format. If the width of a formatted value
exceeds the specified width, the width is increased accordingly. Values whose positions are not
referenced in *FormatString* are ignored after being evaluated for any side effects. If *N* refers
to a non-existent position, the behavior is implementation defined. Value of type `$null` and void
are formatted as empty strings. Arrays are formatted as for *sub-expression* ([§7.1.6][]). To
include the characters "{" and "}" in a format specification without their being interpreted as
format delimiters, write them as "{{" and "}}", respectively.

For a complete definition of format specifications, see the type `System.IFormattable` in Ecma
Technical Report TR/84.

Examples:

```powershell
`$i` = 10; $j = 12
"{2} <= {0} + {1}\`n" -f $i,$j,($i+$j)  # 22 <= 10 + 12
">{0,3}<" -f 5                          # > 5<
">{0,-3}<" -f 5                         # >5 <
">{0,3:000}<" -f 5                      # >005<
">{0,5:0.00}<" -f 5.0                   # > 5.00<
">{0:C}<" -f 1234567.888                # >$1,234,567.89<
">{0:C}<" -f -1234.56                   # >($1,234.56)<
">{0,12:e2}<" -f 123.456e2              # > 1.23e+004<
">{0,-12:p}<" -f -0.252                 # >-25.20 % <
$format = ">{0:x8}<"
$format -f 123455                       # >0001e23f<
```

In a format specification if *N* refers to a non-existent position, a **FormatError** is raised.

## 7.6 Multiplicative operators

Syntax:

```Syntax
multiplicative-expression:
    format-expression
    multiplicative-expression * new-lines~opt~ format-expression
    multiplicative-expression / new-lines~opt~ format-expression
    multiplicative-expression % new-lines~opt~ format-expression
```

### 7.6.1 Multiplication

Description:

The result of the multiplication operator `*` is the product of the values designated by the two
operands after the usual arithmetic conversions ([§6.15][]) have been applied.

This operator is left associative.

Examples:

```powershell
12 * -10L      # long result -120
-10.300D * 12  # decimal result -123.600
10.6 * 12      # double result 127.2
12 * "0xabc"   # int result 32976
```

### 7.6.2 String replication

Description:

When the left operand designates a string the binary `*` operator creates a new string that contains
the one designated by the left operand replicated the number of times designated by the value of the
right operand as converted to integer type ([§6.4][]).

This operator is left associative.

Examples:

```powershell
"red" * "3"       # string replicated 3 times
"red" * 4         # string replicated 4 times
"red" * 0         # results in an empty string
"red" * 2.3450D   # string replicated twice
"red" * 2.7       # string replicated 3 times
```

### 7.6.3 Array replication

Description:

When the left operand designates an array the binary `*` operator creates a new unconstrained
1‑dimensional array that contains the value designated by the left operand replicated the number of
times designated by the value of the right operand as converted to integer type ([§6.4][]). A
replication count of zero results in an array of length 1. If the left operand designates a
multidimensional array, it is flattened ([§9.12][]) before being used.

This operator is left associative.

Examples:

```powershell
$a = [int[]](10,20)              # [int[]], Length 2*1
$a * "3"                         # [object[]], Length 2*3
$a * 4                           # [object[]], Length 2*4
$a * 0                           # [object[]], Length 2*0
$a * 2.3450D                     # [object[]], Length 2*2
$a * 2.7                         # [object[]], Length 2*3
(New-Object 'float[,]' 2,3) * 2  # [object[]], Length 2*2
```

### 7.6.4 Division

Description:

The result of the division operator `/` is the quotient when the value designated by the left
operand is divided by the value designated by the right operand after the usual arithmetic
conversions ([§6.15][]) have been applied.

If an attempt is made to perform integer or decimal division by zero, an implementation-defined
terminating error is raised.

This operator is left associative.

Examples:

```powershell
10/-10      # int result -1
12/-10      # double result -1.2
12/-10D     # decimal result 1.2
12/10.6     # double result 1.13207547169811
12/"0xabc"  # double result 0.00436681222707424
```

If an attempt is made to perform integer or decimal division by zero, a **RuntimeException**
exception is raised.

### 7.6.5 Remainder

Description:

The result of the remainder operator `%` is the remainder when the value designated by the left
operand is divided by the value designated by the right operand after the usual arithmetic
conversions ([§6.15][]) have been applied.

If an attempt is made to perform integer or decimal division by zero, an implementation-defined
terminating error is raised.

Examples:

```powershell
10 % 3          # int result 1
10.0 % 0.3      # double result 0.1
10.00D % "0x4"  # decimal result 2.00
```

If an attempt is made to perform integer or decimal division by zero, a **RuntimeException**
exception is raised.

## 7.7 Additive operators

Syntax:

```Syntax
additive-expression:
    multiplicative-expression
    additive-expression + new-lines~opt~ multiplicative-expression
    additive-expression dash new-lines~opt~ multiplicative-expression
```

### 7.7.1 Addition

Description:

The result of the addition operator `+` is the sum of the values designated by the two operands
after the usual arithmetic conversions ([§6.15][]) have been applied.

This operator is left associative.

Examples:

```powershell
12 + -10L       # long result 2
-10.300D + 12   # decimal result 1.700
10.6 + 12       # double result 22.6
12 + "0xabc"    # int result 2760
```

### 7.7.2 String concatentaion

Description:

When the left operand designates a string the binary `+` operator creates a new string that contains
the value designated by the left operand followed immediately by the value(s) designated by the
right operand as converted to type string ([§6.8][]).

This operator is left associative.

Examples:

```powershell
"red" + "blue"      # "redblue"
"red" + "123"       # "red123"
"red" + 123         # "red123"
"red" + 123.456e+5  # "red12345600"
"red" + (20,30,40)  # "red20 30 40"
```

### 7.7.3 Array concatenation

Description:

When the left operand designates an array the binary `+` operator creates a new unconstrained
1‑dimensional array that contains the elements designated by the left operand followed immediately
by the value(s) designated by the right operand. Multidimensional arrays present in either operand
are flattened ([§9.12][]) before being used.

This operator is left associative.

Examples:

```powershell
$a = [int[]](10,20)               # [int[]], Length 2
$a + "red"                        # [object[]], Length 3
$a + 12.5,$true                   # [object[]], Length 4
$a + (New-Object 'float[,]' 2,3)  # [object[]], Length 8
(New-Object 'float[,]' 2,3) + $a  # [object[]], Length 8
```

### 7.7.4 Hashtable concatenation

Description:

When both operands designate Hashtables the binary `+` operator creates a new Hashtable that
contains the elements designated by the left operand followed immediately by the elements designated
by the right operand.

If the Hashtables contain the same key, an implementation-defined terminating error is raised.

This operator is left associative.

Examples:

```powershell
$h1 = @{ FirstName = "James"; LastName = "Anderson" }
$h2 = @{ Dept = "Personnel" }
$h3 = $h1 + $h2      # new Hashtable, Count = 3
```

If the Hashtables contain the same key, an exception of type **BadOperatorArgument** is raised.

### 7.7.5 Subtraction

Description:

The result of the subtraction operator `-` is the difference when the value designated by the right
operand is subtracted from the value designated by the left operand after the usual arithmetic
conversions ([§6.15][]) have been applied.

This operator is left associative.

Examples:

```powershell
12 - -10L      # long result 2c
-10.300D - 12  # decimal result -22.300
10.6 - 12      # double result -1.4
12 - "0xabc"   # int result -2736
```

## 7.8 Comparison operators

Syntax:

```Syntax
comparison-operator: one of
    dash as           dash ccontains     dash ceq
    dash cge          dash cgt           dash cle
    dash clike        dash clt           dash cmatch
    dash cne          dash cnotcontains  dash cnotlike
    dash cnotmatch    dash contains      dash creplace
    dash csplit       dash eq            dash ge
    dash gt           dash icontains     dash ieq
    dash ige          dash igt           dash ile
    dash ilike        dash ilt           dash imatch
    dash in           dash ine           dash inotcontains
    dash inotlike     dash inotmatch     dash ireplace
    dash is           dash isnot         dash isplit
    dash join         dash le            dash like
    dash lt           dash match         dash ne
    dash notcontains  dash notin         dash notlike
    dash notmatch     dash replace       dash shl
    dash shr          dash split

dash:
    - (U+002D)
    EnDash character (U+2013)
    EmDash character (U+2014)
    Horizontal bar character (U+2015)
```

Description:

The type of the value designated by the left operand determines how the value designated by the
right operand is converted (§6), if necessary, before the comparison is done.

Some *comparison-operator*s (written here as -*op*) have two variants, one that is case sensitive
(-c*op*), and one that is not (-i*op*). The -*op* version is equivalent to -i*op*. Case sensitivity
is meaningful only with comparisons of values of type string. In non-string comparison contexts, the
two variants behave the same.

These operators are left associative.

### 7.8.1 Equality and relational operators

Description:

There are two *equality* *operators*: equality (`-eq`) and inequality (`-ne`); and four *relational
operators*: less-than (`-lt`), less-than-or-equal-to (`-le`), greater-than (`-gt`), and
greater-than-or-equal-to (`-ge`). Each of these has two variants ([§7.8][]).

For two strings to compare equal, they must have the same length and contents, and letter case, if
appropriate.

If the value designated by the left operand is not a collection, the result has type `bool`.
Otherwise, the result is a possibly empty unconstrained 1-dimensional array containing the elements
of the collection that test True when compared to the value designated by the right operand.

Examples:

```powershell
10 -eq "010"           # True, int comparison
"010" -eq 10           # False, string comparison
"RED" -eq "Red"        # True, case-insensitive comparison
"RED" -ceq "Red"       # False, case-sensitive comparison
"ab" -lt "abc"         # True

10,20,30,20,10 -ne 20  # 10,30,10, Length 3
10,20,30,20,10 -eq 40  # Length 0
10,20,30,20,10 -ne 40  # 10,20,30,20,10, Length 5
10,20,30,20,10 -gt 25  # 30, Length 1
0,1,30 -ne $true       # 0,30, Length 2
0,"00" -eq "0"         # 0 (int), Length 1
```

### 7.8.2 Containment operators

Description:

There are four *containment* *operators*: contains (`-contains`), does-not-contain (`‑notcontains`),
in (`-in`) and not-in (`-notin`). Each of these has two variants ([§7.8][]).

The containment operators return a result of type bool that indicates whether a value occurs (or
does not occur) at least once in the elements of an array. With `-contains` and `‑notcontains`, the
value is designated by the right operand and the array is designated by the left operand. With -in
and `-notin`, the operands are reversed. The value is designated by the left operand and the array
is designated by the right operand.

For the purposes of these operators, if the array operand has a scalar value, the scalar value is
treated as an array of one element.

Examples:

```powershell
10,20,30,20,10 -contains 20     # True
10,20,30,20,10 -contains 42.9   # False
10,20,30 -contains "10"         # True
"010",20,30 -contains 10        # False
10,20,30,20,10 -notcontains 15  # True
"Red",20,30 -ccontains "RED"    # False
```

### 7.8.3 Type testing and conversion operators

Description:

The type operator `-is` tests whether the value designated by the left operand has the type, or is
derived from a type that has the type, designated by the right operand. The right operand must
designate a type or a value that can be converted to a type (such as a string that names a type).
The type of the result is `bool`. The type operator `-isnot` returns the logical negation of the
corresponding `-is` form.

The type operator `-as` attempts to convert the value designated by the left operand to the type
designated by the right operand. The right operand must designate a type or a value that can be
converted to a type (such as a string that names a type). If the conversion fails, `$null` is
returned; otherwise, the converted value is returned and the return type of that result is the
runtime type of the converted value.

Examples:

```powershell
$a = 10            # value 10 has type int
$a -is [int]       # True

$t = [int]
$a -isnot $t       # False
$a -is "int"       # True
$a -isnot [double] # True

$x = [int[]](10,20)
$x -is [int[]]     # True

$a = "abcd"        # string is derived from object
$a -is [object]    # True

$x = [double]
foreach ($t in [int],$x,[decimal],"string") {
    $b = (10.60D -as $t) * 2  # results in int 22, double 21.2
}                             # decimal 21.20, and string "10.6010.60"
```

### 7.8.4 Pattern matching and text manipulation operators

#### 7.8.4.1 The -like and -notlike operators

Description:

If the left operand does not designate a collection, the result has type `bool`. Otherwise, the
result is a possibly empty unconstrained 1-dimensional array containing the elements of the
collection that test True when compared to the value designated by the right operand. The right
operand may designate a string that contains wildcard expressions ([§3.15][]). These operators have
two variants ([§7.8][]).

Examples:

```powershell
"Hello" -like "h*"                   # True, starts with h
"Hello" -clike "h*"                  # False, does not start with lowercase h
"Hello" -like "*l*"                  # True, has an l in it somewhere
"Hello" -like "??l"                  # False, no length match

"-abc" -like "[-xz]*"                # True, - is not a range separator
"#$%\^&" -notlike "*[A-Za-z]"        # True, does not end with alphabetic character
"He" -like "h[aeiou]?*"              # False, need at least 3 characters
"When" -like "*[?]"                  # False, ? is not a wildcard character
"When?" -like "*[?]"                 # True, ? is not a wildcard character

"abc","abbcde","abcgh" -like "abc*"  # object[2], values
"abc" and "abcgh"
```

#### 7.8.4.2 The -match and -notmatch operators

Description:

If the left operand does not designate a collection, the result has type `bool` and if that result
is `$true`, the elements of the Hashtable `$matches` are set to the strings that match (or
do-not-match) the value designated by the right operand. Otherwise, the result is a possibly empty
unconstrained 1-dimensional array containing the elements of the collection that test True when
compared to the value designated by the right operand, and `$matches` is not set. The right operand
may designate a string that contains regular expressions ([§3.16][]), in which case, it is referred
to as a *pattern*. These operators have two variants ([§7.8][]).

These operators support submatches ([§7.8.4.6][]).

Examples:

```powershell
"Hello" -match ".l"                    # True, $matches key/value is 0/"el"
"Hello" -match '\^h.*o$'               # True, $matches key/value is
0/"Hello"
"Hello" -cmatch '\^h.*o$'              # False, $matches not set
"abc\^ef" -match ".\\\^e"              # True, $matches key/value is 0/"c\^e"

"abc" -notmatch "[A-Za-z]"             # False
"abc" -match "[\^A-Za-z]"              # False
"He" -match "h[aeiou]."                # False, need at least 3 characters
"abc","abbcde","abcgh" -match "abc.*"  # Length is 2, values "abc", "abcgh"
```

#### 7.8.4.3 The -replace operator

Description:

The `-replace` operator allows text replacement in one or more strings designated by the left
operand using the values designated by the right operand. This operator has two variants
([§7.8][]). The right operand has one of the following forms:

- The string to be located, which may contain regular expressions ([§3.16][]). In this case, the
  replacement string is implicitly "".
- An array of 2 objects containing the string to be located, followed by the replacement string.

If the left operand designates a string, the result has type string. If the left operand designates
a 1‑dimensional array of string, the result is an unconstrained 1-dimensional array, whose length is
the same as for left operand's array, containing the input strings after replacement has completed.

This operator supports submatches ([§7.8.4.6][]).

Examples:

```powershell
"Analogous","an apple" -replace "a","*"      # "*n*logous","*n *pple"
"Analogous" -creplace "[aeiou]","?"          # "An?l?g??s"
"Analogous","an apple" -replace '\^a',"%%A"  # "%%Analogous","%%An apple"
"Analogous" -replace "[aeiou]",'$&$&'        # "AAnaaloogoouus"
```

#### 7.8.4.4 The binary -join operator

Description:

The binary `-join` operator produces a string that is the concatenation of the value of one or more
objects designated by the left operand after having been converted to string ([§6.7][]), if
necessary. The string designated by the right operand is used to separate the (possibly empty)
values in the resulting string.

The left operand can be a scalar value or a collection.

Examples:

```powershell
(10, 20, 30) -join "\|"    # result is "10\|20\|30"
12345 -join ","            # result is "12345", no separator needed
($null,$null) -join "<->"  # result is "<->", two zero-length values
```

#### 7.8.4.5 The binary -split operator

Description:

The binary `-split` operator splits one or more strings designated by the left operand, returning
their subparts in a constrained 1-dimensional array of string. This operator has two variants
([§7.8][]). The left operand can designate a scalar value or an array of strings. The right operand
has one of the following forms:

- A *delimiter string*
- An array of 2 objects containing a delimiter string followed by a numeric *split count*
- An array of 3 objects containing a delimiter string, a numeric split count, and an *options
  string*
- A script block
- An array of 2 objects containing a script block followed by a numeric split count

The delimiter string may contain regular expressions ([§3.16][]). It is used to locate subparts with
the input strings. The delimiter is not included in the resulting strings. If the left operand
designates an empty string, that results in an empty string element. If the delimiter string is an
empty string, it is found at every character position in the input strings.

By default, all subparts of the input strings are placed into the result as separate elements;
however, the split count can be used to modify this behavior. If that count is negative, zero, or
greater than or equal to the number of subparts in an input string, each subpart goes into a
separate element. If that count is less than the number of subparts in the input string, there are
count elements in the result, with the final element containing all of the subparts beyond the first
**count - 1** subparts.

An options string contains zero or more *option names* with each adjacent pair separated by a comma.
Leading, trailing, and embedded white space is ignored. Option names may be in any order and are
case-sensitive.

If an options string contains the option name **SimpleMatch**, it may also contain the option name
**IgnoreCase**. If an options string contains the option name **RegexMatch** or it does not contain
either **RegexMatch** or **SimpleMatch**, it may contain any option name except **SimpleMatch**.
However, it must not contain both **Multiline** and **Singleline**.

Here is the set of option names:

|       **Option**        |                                           **Description**                                            |
| ----------------------- | ---------------------------------------------------------------------------------------------------- |
| CultureInvariant        | Ignores cultural differences in language when evaluating the delimiter.                              |
| ExplicitCapture         | Ignores non-named match groups so that only explicit capture groups are returned in the result list. |
| IgnoreCase              | Force case-insensitive matching, even if `-csplit` is used.                                          |
| IgnorePatternWhitespace | Ignores unescaped white space and comments marked with the number sign (#).                          |
| Multiline               | This mode recognizes the start and end of lines and strings. The default mode is **Singleline**.     |
| RegexMatch              | Use regular expression matching to evaluate the delimiter. This is the default.                      |
| SimpleMatch             | Use simple string comparison when evaluating the delimiter.                                          |
| Singleline              | This mode recognizes only the start and end of strings. It is the default mode.                      |

The script block ([§7.1.8][]) specifies the rules for determining the delimiter, and must evaluate
to type bool.

Examples:

```powershell
"one,forty two,," -split ","              # 5 strings: "one" "forty two" "" ""

"abc","de" -split ""                      # 9 strings: "" "a" "b" "c" "" "" "d" "e" ""

"ab,cd","1,5,7,8" -split ",", 2           # 4 strings: "ab" "cd" "1" "5,7,8"

"10X20x30" -csplit "X", 0, "SimpleMatch"  # 2 strings: "10" "20x30"

"analogous" -split "[AEIOU]", 0, "RegexMatch, IgnoreCase"
                                          # 6 strings: "" "n" "l" "g" "" "s"

"analogous" -split { $_ -eq "a" -or $_ -eq "o" }, 4
                                          # 4 strings: "" "n" "l" "gous"
```

#### 7.8.4.6 Submatches

The pattern being matched by `-match`, `-notmatch`, and `-replace` may contain subparts (called
*submatches*) delimited by parentheses. Consider the following example:

`"red" -match "red"`

The result is `$true` and key 0 of `$matches` contains "red", that part of the string designated by
the left operand that exactly matched the pattern designated by the right operand.

In the following example, the whole pattern is a submatch:

`"red" -match "(red)"`

As before, key 0 contains "red"; however, key 1 also contains "red", which is that part of the
string designated by the left operand that exactly matched the submatch.

Consider the following, more complex, pattern:

`"red" -match "((r)e)(d)"`

This pattern allows submatches of "r", "re", "d", or "red".

Again, key 0 contains "red". Key 1 contains "re", key 2 contains "r", and key 3 contains "d". The
key/value pairs are in matching order from left-to-right in the pattern, with longer string matches
preceding shorter ones.

In the case of `-replace`, the replacement text can access the submatches via names of the form
`$n`, where the first match is `$1`, the second is `$3`, and so on. For example,

```powershell
"Monday morning" -replace '(Monday|Tuesday) (morning|afternoon|evening)','the $2 of $1'
```

The resulting string is "the morning of Monday".

Instead of having keys in `$matches` be zero-based indexes, submatches can be named using the form
`?<*name*>`. For example, `"((r)e)(d)"` can be written with three named submatches, m1, m2, and m3,
as follows: `"(?<m1>(?<m2>r)e)(?<m3>d)"`.

### 7.8.5 Shift operators

Description:

The shift left (`-shl`) operator and shift right (`-shr`) operator convert the value designed by the
left operand to an integer type and the value designated by the right operand to int, if necessary,
using the usual arithmetic conversions ([§6.15][]).

The shift left operator shifts the left operand left by a number of bits computed as described
below. The low-order empty bit positions are set to zero.

The shift right operator shifts the left operand right by a number of bits computed as described
below. The low-order bits of the left operand are discarded, the remaining bits shifted right. When
the left operand is a signed value, the high-order empty bit positions are set to zero if the left
operand is non-negative and set to one if the left operand is negative. When the left operand is an
unsigned value, the high-order empty bit positions are set to zero.

When the left operand has type int, the shift count is given by the low-order five bits of the right
operand. When the right operand has type long, the shift count is given by the low-order six bits of
the right operand.

Examples:

```powershell
0x0408 -shl 1             # int with value 0x0810
0x0408 -shr 3             # int with value 0x0081
0x100000000 -shr 0xfff81  # long with value 0x80000000
```

## 7.9 Bitwise operators

Syntax:

```Syntax
bitwise-expression:
    comparison-expression
    bitwise-expression -band new-lines~opt~ comparison-expression
    bitwise-expression -bor new-lines~opt~ comparison-expression
    bitwise-expression -bxor new-lines~opt~ comparison-expression
```

Description:

The bitwise AND operator `-band`, the bitwise OR operator `-bor`, and the bitwise XOR operator -bxor
convert the values designated by their operands to integer types, if necessary, using the usual
arithmetic conversions ([§6.15][]). After conversion, if both values have type int that is the type
of the result. Otherwise, if both values have type long, that is the type of the result. If one
value has type int and the other has type long, the type of the result is long. Otherwise, the
expression is ill formed. The result is the bitwise AND, bitwise OR, or bitwise XOR, respectively,
of the possibly converted operand values.

These operators are left associative. They are commutative if neither operand contains a side
effect.

Examples:

```powershell
0x0F0F -band 0xFE    # int with value 0xE
0x0F0F -band 0xFEL   # long with value 0xE
0x0F0F -band 14.6    # long with value 0xF

0x0F0F -bor 0xFE     # int with value 0xFFF
0x0F0F -bor 0xFEL    # long with value 0xFFF
0x0F0F -bor 14.40D   # long with value 0xF0F

0x0F0F -bxor 0xFE    # int with value 0xFF1
0x0F0F -bxor 0xFEL   # long with value 0xFF1
0x0F0F -bxor 14.40D  # long with value 0xF01
0x0F0F -bxor 14.6    # long with value 0xF00
```

## 7.10 Logical operators

Syntax:

```Syntax
logical-expression:
    bitwise-expression
    logical-expression -and new-lines~opt~ bitwise-expression
    logical-expression -or new-lines~opt~ bitwise-expression
    logical-expression -xor new-lines~opt~ bitwise-expression
```

Description:

The logical AND operator `-and` converts the values designated by its operands to `bool`, if
necessary ([§6.2][]). The result is the logical AND of the possibly converted operand values, and
has type `bool`. If the left operand evaluates to False the right operand is not evaluated.

The logical OR operator `-or` converts the values designated by its operands to `bool`, if necessary
([§6.2][]). The result is the logical OR of the possibly converted operand values, and has type
`bool`. If the left operand evaluates to True the right operand is not evaluated.

The logical XOR operator `-xor` converts the values designated by its operands to `bool`
([§6.2][]). The result is the logical XOR of the possibly converted operand values, and has type
`bool`.

These operators are left associative.

Examples:

```powershell
$j = 10
$k = 20
($j -gt 5) -and (++$k -lt 15)   # True -and False -> False
($j -gt 5) -and ($k -le 21)     # True -and True -> True
($j++ -gt 5) -and ($j -le 10)   # True -and False -> False
($j -eq 5) -and (++$k -gt 15)   # False -and True -> False

$j = 10
$k = 20
($j++ -gt 5) -or (++$k -lt 15)  # True -or False -> True
($j -eq 10) -or ($k -gt 15)     # False -or True -> True
($j -eq 10) -or (++$k -le 20)   # False -or False -> False

$j = 10
$k = 20
($j++ -gt 5) -xor (++$k -lt 15) # True -xor False -> True
($j -eq 10) -xor ($k -gt 15)    # False -xor True -> True
($j -gt 10) -xor (++$k -le 25)  # True -xor True -> False
```

## 7.11 Assignment operators

Syntax:

```Syntax
assignment-expression:
    expression assignment-operator statement

assignment-operator: *one of
    =   dash =   +=   *=   /=   %=
```

Description:

An assignment operator stores a value in the writable location designated by *expression*. For a
discussion of *assignment-operator* `=` see [§7.11.1][]. For a discussion of all other
*assignment-operator*s see [§7.11.2][].

An assignment expression has the value designated by *expression* after the assignment has taken
place; however, that assignment expression does not itself designate a writable location. If
*expression* is type-constrained ([§5.3][]), the type used in that constraint is the type of the
result; otherwise, the type of the result is the type after the usual arithmetic conversions
([§6.15][]) have been applied.

This operator is right associative.

### 7.11.1 Simple assignment

Description:

In *simple assignment* (`=`), the value designated by *statement* replaces the value stored in the
writable location designated by *expression*. However, if *expression* designates a non-existent key
in a Hashtable, that key is added to the Hashtable with an associated value of the value designated
by *statement*.

As shown by the grammar, *expression* may designate a comma-separated list of writable locations.
This is known as *multiple assignment*. *statement* designates a list of one or more comma-separated
values. The commas in either operand list are part of the multiple-assignment syntax and do *not*
represent the binary comma operator. Values are taken from the list designated by *statement*, in
lexical order, and stored in the corresponding writable location designated by *expression*. If the
list designated by *statement* has fewer values than there are *expression* writable locations, the
excess locations take on the value `$null`. If the list designated by *statement* has more values
than there are *expression* writable locations, all but the right-most *expression* location take on
the corresponding *statement* value and the right-most *expression* location becomes an
unconstrained 1-dimensional array with all the remaining *statement* values as elements.

For statements that have values ([§8.1.2][]), *statement* can be a statement.

Examples:

```powershell
$a = 20; $b = $a + 12L             # $b has type long, value 22
$hypot = [Math]::Sqrt(3*3 + 4*4)   # type double, value 5
$a = $b = $c = 10.20D              # all have type decimal, value 10.20
$a = (10,20,30),(1,2)              # type [object[]], Length 2
[int]$x = 10.6                     # type int, value 11
[long]$x = "0xabc"                 # type long, value 0xabc
$a = [float]                       # value type literal [float]
$i,$j,$k = 10,"red",$true          # $i is 10, $j is "red", $k is True
$i,$j = 10,"red",$true             # $i is 10, $j is [object[]], Length 2
$i,$j = (10,"red"),$true           # $i is [object[]], Length 2, $j is True
$i,$j,$k = 10                      # $i is 10, $j is $null, $k is $null

$h = @{}
[int] $h.Lower, [int] $h.Upper = -split "10 100"

$h1 = @{ FirstName = "James"; LastName = "Anderson"; IDNum = 123 }
$h1.Dept = "Finance"               # adds element Finance
$h1["City"] = "New York"           # adds element City

[int]$Variable:v = 123.456         # v takes on the value 123
${E:output.txt} = "a"              # write text to the given file
$Env:MyPath = "x:\data\file.txt"   # define the environment variable
$Function:F = { param ($a, $b) "Hello there, $a, $b" }
F 10 "red"                         # define and invoke a function
function Demo { "Hi there from inside Demo" }
$Alias:A = "Demo"                  # create alias for function Demo
A                                  # invoke function Demo via the alias
```

### 7.11.2 Compound assignment

Description:

A *compound assignment* has the form `E1 op= E2`, and is equivalent to the simple assignment
expression `E1 = E1 op (E2)` except that in the compound assignment case the expression *E1* is
evaluated only once. If *expression* is type-constrained ([§5.3][]), the type used in that
constraint is the type of the result; otherwise, the type of the result is determined by *op*. For
`*=`, see [§7.6.1][], [§7.6.2][], [§7.6.3][]; for `/=`, see [§7.6.4][]; for `%=`, see [§7.6.5][];
for `+=`, see [§7.7.1][], [§7.7.2][], [§7.7.3][]; for `-=`, see [§7.7.5][].

> [!NOTE]
> An operand designating an unconstrained value of numeric type may have its type changed by an
> assignment operator when the result is stored.

Examples:

```powershell
$a = 1234; $a *= (3 + 2)  # type is int, value is 1234 * (3 + 2)
$b = 10,20,30             # $b[1] has type int, value 20
$b[1] /= 6                # $b[1] has type double, value 3.33...

$i = 0
$b = 10,20,30
$b[++$i] += 2             # side effect evaluated only once

[int]$Variable:v = 10     # v takes on the value 10
$Variable:v -= 3          # 3 is subtracted from v

${E:output.txt} = "a"     # write text to the given file
${E:output.txt} += "b"    # append text to the file giving ab
${E:output.txt} *= 4      # replicate ab 4 times giving abababab
```

## 7.12 Redirection operators

Syntax:

```Syntax
pipeline:
    assignment-expression
    expression redirections~opt~ pipeline-tail~opt~
    command verbatim-command-argument~opt~ pipeline-tail~opt~

redirections:
    redirection
    redirections redirection

redirection:
    merging-redirection-operator
    file-redirection-operator redirected-file-name

redirected-file-name:
    command-argument
    primary-expression

file-redirection-operator: one of
    >   >>   2>   2>>   3>   3>>   4>   4>>
    5>  5>>  6>   6>>   >    >>    <

merging-redirection-operator: one of
    >&1   2>&1   3>&1   4>&1   5>&1   6>&1
    >&2   1>&2   3>&2   4>&2   5>&2   6>&2
```

Description:

The redirection operator `>` takes the standard output from the pipeline and redirects it to the
location designated by *redirected-file-name*, overwriting that location's current contents.

The redirection operator `>>` takes the standard output from the pipeline and redirects it to the
location designated by *redirected-file-name*, appending to that location's current contents, if
any. If that location does not exist, it is created.

The redirection operator with the form `n>` takes the output of stream *n* from the pipeline and
redirects it to the location designated by *redirected-file-name*, overwriting that location's
current contents.

The redirection operator with the form `n>>` takes the output of stream *n* from the pipeline and
redirects it to the location designated by *redirected-file-name*, appending to that location's
current contents, if any. If that location does not exist, it is created.

The redirection operator with the form `m>&n` writes output from stream *m* to the same location as
stream *n*.

The following are the valid streams:

| Stream |                                       Description                                       |
| ------ | --------------------------------------------------------------------------------------- |
| 1      | Standard output stream                                                                  |
| 2      | Error output stream                                                                     |
| 3      | Warning output stream                                                                   |
| 4      | Verbose output stream                                                                   |
| 5      | Debug output stream                                                                     |
| *      | Standard output, error output, warning output, verbose output, and debug output streams |

The redirection operators `1>&2`, `6>`, `6>>` and `<` are reserved for future use.

If on output the value of *redirected-file-name* is `$null`, the output is discarded.

Ordinarily, the value of an expression containing a top-level side effect is not written to the
pipeline unless that expression is enclosed in a pair of parentheses. However, if such an expression
is the left operand of an operator that redirects standard output, the value is written.

Examples:

```powershell
$i = 200                       # pipeline gets nothing
$i                             # pipeline gets result
$i > output1.txt               # result redirected to named file
++$i >> output1.txt            # result appended to named file
type file1.txt 2> error1.txt   # error output redirected to named file
type file2.txt 2>> error1.txt  # error output appended to named file
dir -Verbose 4> verbose1.txt   # verbose output redirected to named file

# Send all output to output2.txt
dir -Verbose -Debug -WarningAction Continue *> output2.txt

# error output redirected to named file, verbose output redirected
# to the same location as error output
dir -Verbose 4>&2 2> error2.txt
```

<!-- reference links -->
[§2.3.5.2]: chapter-02.md#2352-string-literals
[§3.15]: chapter-03.md#315-wildcard-expressions
[§3.16]: chapter-03.md#316-regular-expressions
[§4.3.7]: chapter-04.md#437-the-scriptblock-type
[§4.4]: chapter-04.md#44-generic-types
[§4.5.24]: chapter-04.md#4524-method-designator-type
[§5.3]: chapter-05.md#53-constrained-variables
[§6.15]: chapter-06.md#615-usual-arithmetic-conversions
[§6.17]: chapter-06.md#617-conversion-during-parameter-binding
[§6.2]: chapter-06.md#62-conversion-to-bool
[§6.4]: chapter-06.md#64-conversion-to-integer
[§6.7]: chapter-06.md#67-conversion-to-object
[§6.8]: chapter-06.md#68-conversion-to-string
[§7.1.1]: chapter-07.md#711-grouping-parentheses
[§7.1.2]: chapter-07.md#712-member-access
[§7.1.4.5]: chapter-07.md#7145-generating-array-slices
[§7.1.6]: chapter-07.md#716--operator
[§7.1.8]: chapter-07.md#718-script-block-expression
[§7.11.1]: chapter-07.md#7111-simple-assignment
[§7.11.2]: chapter-07.md#7112-compound-assignment
[§7.11]: chapter-07.md#711-assignment-operators
[§7.2.9]: chapter-07.md#729-cast-operator
[§7.6.1]: chapter-07.md#761-multiplication
[§7.6.2]: chapter-07.md#762-string-replication
[§7.6.3]: chapter-07.md#763-array-replication
[§7.6.4]: chapter-07.md#764-division
[§7.6.5]: chapter-07.md#765-remainder
[§7.7.1]: chapter-07.md#771-addition
[§7.7.2]: chapter-07.md#772-string-concatentaion
[§7.7.3]: chapter-07.md#773-array-concatenation
[§7.7.5]: chapter-07.md#775-subtraction
[§7.7]: chapter-07.md#77-additive-operators
[§7.8.4.4]: chapter-07.md#7844-the-binary--join-operator
[§7.8.4.5]: chapter-07.md#7845-the-binary--split-operator
[§7.8.4.6]: chapter-07.md#7846-submatches
[§7.8]: chapter-07.md#78-comparison-operators
[§8.1.2]: chapter-08.md#812-statement-values
[§8.10.1]: chapter-08.md#8101-filter-functions
[§8.10.2]: chapter-08.md#8102-workflow-functions
[§8.10.7]: chapter-08.md#8107-named-blocks
[§8.10.9]: chapter-08.md#8109-param-block
[§9.]: chapter-09.md#9-arrays
[§9.12]: chapter-09.md#912-multidimensional-array-flattening
[§9.4]: chapter-09.md#94-constraining-element-types
[§9.9]: chapter-09.md#99-array-slices

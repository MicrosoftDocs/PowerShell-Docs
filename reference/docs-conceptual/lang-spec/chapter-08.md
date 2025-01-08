---
description: A statement specifies some sort of action that is to be performed.
ms.date: 05/16/2022
title: Statements
---
# 8. Statements

[!INCLUDE [Disclaimer](../../includes/language-spec.md)]

## 8.1 Statement blocks and lists

Syntax:

> [!TIP]
> The `~opt~` notation in the syntax definitions indicates that the lexical entity is optional in
> the syntax.

```Syntax
statement-block:
    new-lines~opt~ { statement-list~opt~ new-lines~opt~ }

statement-list:
    statement
    statement-list statement

statement:
    if-statement
    label~opt~ labeled-statement
    function-statement
    flow-control-statement statement-terminator
    trap-statement
    try-statement
    data-statement
    inlinescript-statement
    parallel-statement
    sequence-statement
    pipeline statement-terminator

statement-terminator:
    ;
    new-line-character
```

Description:

A *statement* specifies some sort of action that is to be performed. Unless indicated otherwise
within this clause, statements are executed in lexical order.

A *statement-block* allows a set of statements to be grouped into a single syntactic unit.

### 8.1.1 Labeled statements

Syntax:

```Syntax
labeled-statement:
    switch-statement
    foreach-statement
    for-statement
    while-statement
    do-statement
```

Description:

An iteration statement ([§8.4][§8.4]) or a switch statement ([§8.6][§8.6]) may optionally be preceded
immediately by one statement label, *label*. A statement label is used as the optional target of a
break ([§8.5.1][§8.5.1]) or continue ([§8.5.2][§8.5.2]) statement. However, a label does not alter the flow of
control.

White space is not permitted between the colon (`:`) and the token that follows it.

Examples:

```powershell
:go_here while ($j -le 100) {
    # ...
}

:labelA
for ($i = 1; $i -le 5; ++$i) {
    :labelB
    for ($j = 1; $j -le 3; ++$j) {
        :labelC
        for ($k = 1; $k -le 2; ++$k) {
            # ...
        }
    }
}
```

### 8.1.2 Statement values

The value of a statement is the cumulative set of values that it writes to the pipeline. If the
statement writes a single scalar value, that is the value of the statement. If the statement writes
multiple values, the value of the statement is that set of values stored in elements of an
unconstrained 1-dimensional array, in the order in which they were written. Consider the following
example:

`$v = for ($i = 10; $i -le 5; ++$i) { }`

There are no iterations of the loop and nothing is written to the pipeline. The value of the
statement is `$null`.

`$v = for ($i = 1; $i -le 5; ++$i) { }`

Although the loop iterates five times nothing is written to the pipeline. The value of the statement
is $null.

`$v = for ($i = 1; $i -le 5; ++$i) { $i }`

The loop iterates five times each time writing to the pipeline the `int` value `$i`. The value of
the statement is `object[]` of Length 5.

`$v = for ($i = 1; $i -le 5; ) { ++$i }`

Although the loop iterates five times nothing is written to the pipeline. The value of the statement
is `$null`.

`$v = for ($i = 1; $i -le 5; ) { (++$i) }`

The loop iterates five times with each value being written to the pipeline. The value of the
statement is `object[]` of Length 5.

`$i = 1; $v = while ($i++ -lt 2) { $i }`

The loop iterates once. The value of the statement is the `int` with value 2.

Here are some other examples:

```powershell
# if $count is not currently defined then define it with int value 10
$count = if ($count -eq $null) { 10 } else { $count }

$i = 1
$v = while ($i -le 5) {
    $i                   # $i is written to the pipeline
    if ($i -band 1) {

        "odd"            # conditionally written to the pipeline

    }

    ++$i                 # not written to the pipeline

}
# $v is object[], Length 8, value 1,"odd",2,3,"odd",4,5,"odd"
```

## 8.2 Pipeline statements

Syntax:

```Syntax
pipeline:
    assignment-expression
    expression redirections~opt~ pipeline-tail~opt~
    command verbatim-command-argument~opt~ pipeline-tail~opt~

assignment-expression:
    expression assignment-operator statement

pipeline-tail:
    | new-lines~opt~ command
    | new-lines~opt~ command pipeline-tail

command:
    command-name command-elements~opt~
    command-invocation-operator command-module~opt~ command-name-expr command-elements~opt~

command-invocation-operator: one of
    &   .

command-module:
    primary-expression

command-name:
    generic-token
    generic-token-with-subexpr

generic-token-with-subexpr:
    No whitespace is allowed between ) and command-name.
    generic-token-with-subexpr-start statement-list~opt~ )

command-namecommand-name-expr:
    command-name

primary-expressioncommand-elements:
    command-element
    command-elements command-element

command-element:
    command-parameter
    command-argument
    redirection

command-argument:
    command-name-expr

verbatim-command-argument:
    --% verbatim-command-argument-chars
```

Description:

*redirections* is discussed in [§7.12][§7.12]; *assignment-expression* is discussed in [§7.11][§7.11]; and the
*command-invocation-operator* dot (`.`) is discussed in [§3.5.5][§3.5.5]. For a discussion of
argument-to-parameter mapping in command invocations, see [§8.14][§8.14].

The first command in a *pipeline* is an expression or a command invocation. Typically, a command
invocation begins with a *command-name*, which is usually a bare identifier. *command-elements*
represents the argument list to the command. A newline or n unescaped semicolon terminates a
pipeline.

A command invocation consists of the command's name followed by zero or more arguments. The rules
governing arguments are as follows:

- An argument that is not an expression, but which contains arbitrary text without unescaped white
  space, is treated as though it were double quoted. Letter case is preserved.

- Variable substitution and sub-expression expansion ([§2.3.5.2][§2.3.5.2]) takes place inside
  *expandable-string-literal*s and *expandable-here-string-literal*s.

- Text inside quotes allows leading, trailing, and embedded white space to be included in the
  argument's value. [*Note*: The presence of whitespace in a quoted argument does not turn a single
  argument into multiple arguments. *end note*]

- Putting parentheses around an argument causes that expression to be evaluated with the result
  being passed instead of the text of the original expression.

- To pass an argument that looks like a switch parameter ([§2.3.4][§2.3.4]) but is not intended as such,
  enclose that argument in quotes.

- When specifying an argument that matches a parameter having the `[switch]` type constraint
  ([§8.10.5][§8.10.5]), the presence of the argument name on its own causes that parameter to be set to
  `$true`. However, the parameter's value can be set explicitly by appending a suffix to the
  argument. For example, given a type constrained parameter *p*, an argument of `-p:$true` sets p to
  True, while `-p:$false` sets p to False.

- An argument of `--` indicates that all arguments following it are to be passed in their actual
  form as though double quotes were placed around them.

- An argument of `--%` indicates that all arguments following it are to be passed with minimal
  parsing and processing. This argument is called the verbatim parameter. Arguments after the
  verbatim parameter are not PowerShell expressions even if they are syntactically valid PowerShell
  expressions.

If the command type is Application, the parameter `--%` is not passed to the command. The arguments
after `--%` have any environment variables (strings surrounded by `%`) expanded. For example:

```powershell
echoargs.exe --% "%path%" # %path% is replaced with the value $env:path
```

The order of evaluation of arguments is unspecified.

For information about parameter binding see [§8.14][§8.14]. For information about name lookup see
[§3.8][§3.8].

Once argument processing has been completed, the command is invoked. If the invoked command
terminates normally ([§8.5.4][§8.5.4]), control reverts to the point in the script or function immediately
following the command invocation. For a description of the behavior on abnormal termination see
`break` ([§8.5.1][§8.5.1]), `continue` ([§8.5.2][§8.5.2]), `throw` ([§8.5.3][§8.5.3]), `exit` ([§8.5.5][§8.5.5]), `try`
([§8.7][§8.7]), and `trap` ([§8.8][§8.8]).

Ordinarily, a command is invoked by using its name followed by any arguments. However, the
command-invocation operator, &, can be used. If the command name contains unescaped white space, it
must be quoted and invoked with this operator. As a script block has no name, it too must be invoked
with this operator. For example, the following invocations of a command call `Get-Factorial` are
equivalent:

```powershell
Get-Factorial 5
& Get-Factorial 5
& "Get-Factorial" 5
```

Direct and indirect recursive function calls are permitted. For example,

```powershell
function Get-Power([int]$x, [int]$y) {
    if ($y -gt 0) { return $x * (Get-Power $x (--$y)) }
    else { return 1 }
}
```

Examples:

```powershell
New-Object 'int[,]' 3,2
New-Object -ArgumentList 3,2 -TypeName 'int[,]'

dir e:\PowerShell\Scripts\*statement*.ps1 | Foreach-Object {$_.Length}

dir e:\PowerShell\Scripts\*.ps1 | Select-String -List "catch" | Format-Table path,linenumber -AutoSize
```

## 8.3 The if statement

Syntax:

```Syntax
if-statement:
    if new-lines~opt~ ( new-lines~opt~ pipeline new-lines~opt~ ) statement-block
        elseif-clauses~opt~ else-clause~opt~

elseif-clauses:
    elseif-clause
    elseif-clauses elseif-clause

elseif-clause:
    new-lines~opt~ elseif new-lines~opt~ ( new-lines~opt~ pipeline new-lines~opt~ ) statement-block

else-clause:
    new-lines~opt~ else statement-block
```

Description:

The *pipeline* controlling expressions must have type bool or be implicitly convertible to that
type. The *else-clause* is optional. There may be zero or more *elseif-clause*s.

If the top-level *pipeline* tests True, then its *statement-block* is executed and execution of the
statement terminates. Otherwise, if an *elseif-clause* is present, if its *pipeline* tests True,
then its *statement-block* is executed and execution of the statement terminates. Otherwise, if an
*else-clause* is present, its *statement-block* is executed.

Examples:

```powershell
$grade = 92
if ($grade -ge 90) { "Grade A" }
elseif ($grade -ge 80) { "Grade B" }
elseif ($grade -ge 70) { "Grade C" }
elseif ($grade -ge 60) { "Grade D" }
else { "Grade F" }
```

## 8.4 Iteration statements

### 8.4.1 The while statement

Syntax:

```Syntax
while-statement:
    while new-lines~opt~ ( new-lines~opt~ while-condition new-lines~opt~ ) statement-block

while-condition:
    new-lines~opt~ pipeline
```

Description:

The controlling expression *while-condition* must have type bool or be implicitly convertible to
that type. The loop body, which consists of *statement-block*, is executed repeatedly until the
controlling expression tests False. The controlling expression is evaluated before each execution of
the loop body.

Examples:

```powershell
$i = 1
while ($i -le 5) {                     # loop 5 times
    "{0,1}`t{1,2}" -f $i, ($i*$i)
    ++$i
}
```

### 8.4.2 The do statement

Syntax:

```Syntax
do-statement:
    do statement-block new-lines~opt~ while new-lines~opt~ ( while-condition new-lines~opt~ )
    do statement-block new-lines~opt~ until new-lines~opt~ ( while-condition new-lines~opt~ )

while-condition:
    new-lines~opt~ pipeline
```

Description:

The controlling expression *while-condition* must have type bool or be implicitly convertible to
that type. In the while form, the loop body, which consists of *statement-block*, is executed
repeatedly while the controlling expression tests True. In the until form, the loop body is executed
repeatedly until the controlling expression tests True. The controlling expression is evaluated
after each execution of the loop body.

Examples:

```powershell
$i = 1
do {
    "{0,1}`t{1,2}" -f $i, ($i * $i)
}
while (++$i -le 5)                 # loop 5 times

$i = 1
do {
    "{0,1}`t{1,2}" -f $i, ($i * $i)
}
until (++$i -gt 5)                 # loop 5 times
```

### 8.4.3 The for statement

Syntax:

```Syntax
for-statement:
    for new-lines~opt~ (
        new-lines~opt~ for-initializer~opt~ statement-terminator
        new-lines~opt~ for-condition~opt~ statement-terminator
        new-lines~opt~ for-iterator~opt~
        new-lines~opt~ ) statement-block

    for new-lines~opt~ (
        new-lines~opt~ for-initializer~opt~ statement-terminator
        new-lines~opt~ for-condition~opt~
        new-lines~opt~ ) statement-block

    for new-lines~opt~ (
        new-lines~opt~ for-initializer~opt~
        new-lines~opt~ ) statement-block

for-initializer:
    pipeline

for-condition:
    pipeline

for-iterator:
    pipeline
```

Description:

The controlling expression *for-condition* must have type bool or be implicitly convertible to that
type. The loop body, which consists of *statement-block*, is executed repeatedly while the
controlling expression tests True. The controlling expression is evaluated before each execution of
the loop body.

Expression *for-initializer* is evaluated before the first evaluation of the controlling expression.
Expression *for-initializer* is evaluated for its side effects only; any value it produces is
discarded and is not written to the pipeline.

Expression *for-iterator* is evaluated after each execution of the loop body. Expression
*for-iterator* is evaluated for its side effects only; any value it produces is discarded and is not
written to the pipeline.

If expression *for-condition* is omitted, the controlling expression tests True.

Examples:

```powershell
for ($i = 5; $i -ge 1; --$i) { # loop 5 times
    "{0,1}`t{1,2}" -f $i, ($i * $i)
}

$i = 5
for (; $i -ge 1; ) { # equivalent behavior
    "{0,1}`t{1,2}" -f $i, ($i * $i)
    --$i
}
```

### 8.4.4 The foreach statement

Syntax:

```Syntax
foreach-statement:
    foreach new-lines~opt~ foreach-parameter~opt~ new-lines~opt~
        ( new-lines~opt~ variable new-lines~opt~ *in* new-lines~opt~ pipeline
        new-lines~opt~ ) statement-block

foreach-parameter:
    -parallel
```

Description:

The loop body, which consists of *statement-block*, is executed for each element designated by the
variable *variable* in the collection designated by *pipeline*. The scope of *variable* is not
limited to the foreach statement. As such, it retains its final value after the loop body has
finished executing. If *pipeline* designates a scalar (excluding the value $null) instead of a
collection, that scalar is treated as a collection of one element. If *pipeline* designates the
value `$null`, *pipeline* is treated as a collection of zero elements.

If the *foreach-parameter* `-parallel` is specified, the behavior is implementation defined.

The *foreach-parameter* `‑parallel` is only allowed in a workflow ([§8.10.2][§8.10.2]).

Every foreach statement has its own enumerator, `$foreach` ([§2.3.2.2][§2.3.2.2], [§4.5.16][§4.5.16]), which exists
only while that loop is executing.

The objects produced by *pipeline* are collected before *statement-block* begins to execute.
However, with the [ForEach-Object](xref:Microsoft.PowerShell.Core.ForEach-Object) cmdlet,
*statement-block* is executed on each object as it is produced.

Examples:

```powershell
$a = 10, 53, 16, -43
foreach ($e in $a) {
    ...
}
$e # the int value -43

foreach ($e in -5..5) {
    ...
}

foreach ($t in [byte], [int], [long]) {
    $t::MaxValue # get static property
}

foreach ($f in Get-ChildItem *.txt) {
    ...
}

$h1 = @{ FirstName = "James"; LastName = "Anderson"; IDNum = 123 }
foreach ($e in $h1.Keys) {
    "Key is " + $e + ", Value is " + $h1[$e]
}
```

## 8.5 Flow control statements

Syntax:

```Syntax
flow-control-statement:
    break label-expression~opt~
    continue label-expression~opt~
    throw pipeline~opt~
    return pipeline~opt~
    exit pipeline~opt~

label-expression:
    simple-name
    unary-expression
```

Description:

A flow-control statement causes an unconditional transfer of control to some other location.

### 8.5.1 The break statement

Description:

A break statement with a *label-expression* is referred to as a *labeled break statement*. A break
statement without a *label-expression* is referred to as an *unlabeled break statement*.

Outside a trap statement, an unlabeled break statement directly within an iteration statement
([§8.4][§8.4]) terminates execution of that smallest enclosing iteration statement. An unlabeled break
statement directly within a switch statement ([§8.6][§8.6]) terminates pattern matching for the current
switch's *switch-condition*. See ([§8.8][§8.8]) for details of using break from within a trap statement.

An iteration statement or a switch statement may optionally be preceded immediately by one statement
label ([§8.1.1][§8.1.1]).Such a statement label may be used as the target of a labeled break statement, in
which case, that statement terminates execution of the targeted enclosing iteration statement.

A labeled break need not be resolved in any local scope; the search for a matching label may
continue up the calling stack even across script and function-call boundaries. If no matching label
is found, the current command invocation is terminated.

The name of the label designated by *label-expression* need not have a constant value.

If *label-expression* is a *unary-expression*, it is converted to a string.

Examples:

```powershell
$i = 1
while ($true) { # infinite loop
    if ($i * $i -gt 100) {
        break # break out of current while loop
    }
    ++$i
}

$lab = "go_here"
:go_here
for ($i = 1; ; ++$i) {
    if ($i * $i -gt 50) {
        break $lab # use a string value as target
    }
}

:labelA
for ($i = 1; $i -le 2; $i++) {

    :labelB
    for ($j = 1; $j -le 2; $j++) {

        :labelC
        for ($k = 1; $k -le 3; $k++) {
            if (...) { break labelA }
        }
    }
}
```

### 8.5.2 The continue statement

Description:

A `continue` statement with a *label-expression* is referred to as a *labeled continue statement*. A
continue statement without a *label-expression* is referred to as an *unlabeled continue statement*.

The use of `continue` from within a trap statement is discussed in [§8.8][§8.8].

An unlabeled `continue` statement within a loop terminates execution of the current loop and
transfers control to the closing brace of the smallest enclosing iteration statement ([§8.4][§8.4]). An
unlabeled `continue` statement within a switch terminates execution of the current `switch`
iteration and transfers control to the smallest enclosing `switch`'s *switch-condition* ([§8.6][§8.6]).

An iteration statement or a `switch` statement ([§8.6][§8.6]) may optionally be preceded immediately by
one statement label ([§8.1.1][§8.1.1]). Such a statement label may be used as the target of an enclosed
labeled `continue` statement, in which case, that statement terminates execution of the current loop
or `switch` iteration, and transfers control to the targeted enclosing iteration or `switch`
statement label.

A labeled `continue` need not be resolved in any local scope; the search for a matching label may
`continue` up the calling stack even across script and function-call boundaries. If no matching
label is found, the current command invocation is terminated.

The name of the label designated by *label-expression* need not have a constant value.

If *label-expression* is a *unary-expression*, it is converted to a string.

Examples:

```powershell
$i = 1
while (...) {
    ...
    if (...) {
        continue # start next iteration of current loop
    }
    ...
}

$lab = "go_here"
:go_here
for (...; ...; ...) {
    if (...) {
        continue $lab # start next iteration of labeled loop
    }
}

:labelA
for ($i = 1; $i -le 2; $i++) {

    :labelB
    for ($j = 1; $j -le 2; $j++) {

        :labelC
        for ($k = 1; $k -le 3; $k++) {
            if (...) { continue labelB }
        }
    }
}
```

### 8.5.3 The throw statement

Description:

An exception is a way of handling a system- or application-level error condition. The throw
statement raises an exception. (See [§8.7][§8.7] for a discussion of exception handling.)

If *pipeline* is omitted and the throw statement is not in a *catch-clause*, the behavior is
implementation defined. If *pipeline* is present and the throw statement is in a *catch-clause*, the
exception that was caught by that *catch-clause* is re-thrown after any *finally-clause* associated
with the *catch-clause* is executed.

If *pipeline* is present, the type of the exception thrown is implementation defined.

When an exception is thrown, control is transferred to the first catch clause in an enclosing try
statement that can handle the exception. The location at which the exception is thrown initially is
called the *throw point*. Once an exception is thrown the steps described in [§8.7][§8.7] are followed
repeatedly until a catch clause that matches the exception is found or none can be found.

Examples:

```powershell
throw
throw 100
throw "No such record in file"
```

If *pipeline* is omitted and the throw statement is not from within a *catch-clause*, the text
"ScriptHalted" is written to the pipeline, and the type of the exception raised is
`System.Management.Automation.RuntimeException`.

If *pipeline* is present, the exception raised is wrapped in an object of type
`System.Management.Automation.RuntimeException`, which includes information about the exception as a
`System.Management.Automation.ErrorRecord` object (accessible via `$_`).

Example 1: `throw 123` results in an exception of type **RuntimeException**. From within the catch
block, `$_.TargetObject` contains the object wrapped inside, in this case, a `System.Int32` with
value 123.

Example 2: `throw "xxx"` results in an exception of type **RuntimeException**. From within the catch
block, `$_.TargetObject` contains the object wrapped inside, in this case, a `System.String` with
value "xxx".

Example 3: `throw 10,20` results in an exception of type **RuntimeException**. From within the catch
block, `$_.TargetObject` contains the object wrapped inside, in this case, a `System.Object[]`, an
unconstrained array of two elements with the `System`.Int32` values 10 and 20.

### 8.5.4 The return statement

Description:

The `return` statement writes to the pipeline the value(s) designated by *pipeline*, if any, and
returns control to the function or script's caller. A function or script may have zero or more
`return` statements.

If execution reaches the closing brace of a function an implied `return` without *pipeline* is
assumed.

The `return` statement is a bit of "syntactic sugar" to allow programmers to express themselves as
they can in other languages; however, the value returned from a function or script is actually all
of the values written to the pipeline by that function or script plus any value(s) specified by
*pipeline*. If only a scalar value is written to the pipeline, its type is the type of the value
returned; otherwise, the return type is an unconstrained 1-dimensional array containing all the
values written to the pipeline.

Examples:

```powershell
function Get-Factorial ($v) {
    if ($v -eq 1) {
        return 1 # return is not optional
    }

    return $v * (Get-Factorial ($v - 1)) # return is optional
}
```

The caller to `Get-Factorial` gets back an `int`.

```powershell
function Test {
    "text1" # "text1" is written to the pipeline
    # ...
    "text2" # "text2" is written to the pipeline
    # ...
    return 123 # 123 is written to the pipeline
}
```

The caller to `Test` gets back an unconstrained 1-dimensional array of three elements.

### 8.5.5 The exit statement

Description:

The exit statement terminates the current script and returns control and an *exit code* to the host
environment or the calling script. If *pipeline* is provided, the value it designates is converted
to int, if necessary. If no such conversion exists, or if *pipeline* is omitted, the int value zero
is returned.

Examples:

```powershell
exit $count # terminate the script with some accumulated count
```

## 8.6 The switch statement

Syntax:

```Syntax
switch-statement:
    switch new-lines~opt~ switch-parameters~opt~ switch-condition switch-body

switch-parameters:
    switch-parameter
    switch-parameters switch-parameter

switch-parameter:
    -regex
    -wildcard
    -exact
    -casesensitive
    -parallel

switch-condition:
    ( new-lines~opt~ pipeline new-lines~opt~ )
    -file new-lines~opt~ switch-filename

switch-filename:
    command-argument
    primary-expression

switch-body:
    new-lines~opt~ { new-lines~opt~ switch-clauses }

switch-clauses:
    switch-clause
    switch-clauses switch-clause

switch-clause:
    switch-clause-condition statement-block statement-terimators~opt~

switch-clause-condition:
    command-argument
    primary-expression
```

Description:

If *switch-condition* designates a single value, control is passed to one or more matching pattern
statement blocks. If no patterns match, some default action can be taken.

A switch must contain one or more *switch-clause*s, each starting with a pattern (a *non-default
switch clause*), or the keyword `default` (a *default switch clause*). A switch must contain zero or
one `default` switch clauses, and zero or more non-default switch clauses. Switch clauses may be
written in any order.

Multiple patterns may have the same value. A pattern need not be a literal, and a switch may have
patterns with different types.

If the value of *switch-condition* matches a pattern value, that pattern's *statement-block* is
executed. If multiple pattern values match the value of *switch-condition*, each matching pattern's
*statement-block* is executed, in lexical order, unless any of those *statement-block*s contains a
`break` statement ([§8.5.1][§8.5.1]).

If the value of *switch-condition* does not match any pattern value, if a `default` switch clause
exists, its *statement-block* is executed; otherwise, pattern matching for that *switch-condition*
is terminated.

Switches may be nested, with each switch having its own set of switch clauses. In such instances, a
switch clause belongs to the innermost switch currently in scope.

On entry to each *statement-block*, `$_` is automatically assigned the value of the
*switch-condition* that caused control to go to that *statement-block*. `$_` is also available in
that *statement-block*'s *switch-clause-condition*.

Matching of non-strings is done by testing for equality ([§7.8.1][§7.8.1]).

If the matching involves strings, by default, the comparison is case-insensitive. The presence of
the *switch-parameter* `-casesensitive` makes the comparison case-sensitive.

A pattern may contain wildcard characters ([§3.15][§3.15]), in which case, wildcard string comparisons
are performed, but only if the *switch-parameter* -wildcard is present. By default, the comparison
is case-insensitive.

A pattern may contain a regular expression ([§3.16][§3.16]), in which case, regular expression string
comparisons are performed, but only if the *switch-parameter* `-regex` is present. By default, the
comparison is case-insensitive. If `-regex` is present and a pattern is matched, `$matches` is
defined in the *switch-clause* *statement-block* for that pattern.

A *switch-parameter* may be abbreviated; any distinct leading part of a parameter may be used. For
example, `‑regex`, `‑rege`, `‑reg`, `‑re`, and `‑r` are equivalent.

If conflicting *switch-parameter*s are specified, the lexically final one prevails. The presence of
`‑exact` disables `-regex` and `-wildcard`; it has no affect on `‑case`, however.

If the *switch-parameter* `‑parallel` is specified, the behavior is implementation defined.

The *switch-parameter* `‑parallel` is only allowed in a workflow ([§8.10.2][§8.10.2]).

If a pattern is a *script-block-expression*, that block is evaluated and the result is converted to
bool, if necessary. If the result has the value `$true`, the corresponding *statement-block* is
executed; otherwise, it is not.

If *switch-condition* designates multiple values, the switch is applied to each value in lexical
order using the rules described above for a *switch-condition* that designates a single value. Every
switch statement has its own enumerator, `$switch` ([§2.3.2.2][§2.3.2.2], [§4.5.16][§4.5.16]), which exists only
while that switch is executing.

A switch statement may have a label, and it may contain labeled and unlabeled break ([§8.5.1][§8.5.1]) and
continue ([§8.5.2][§8.5.2]) statements.

If *switch-condition* is `-file` *switch-filename*, instead of iterating over the values in an
expression, the switch iterates over the values in the file designated by *switch-filename*.The file
is read a line at a time with each line comprising a value. Line terminator characters are not
included in the values.

Examples:

```powershell
$s = "ABC def`nghi`tjkl`fmno @#$"
$charCount = 0; $pageCount = 0; $lineCount = 0; $otherCount = 0
for ($i = 0; $i -lt $s.Length; ++$i) {
    ++$charCount
    switch ($s[$i]) {
        "`n" { ++$lineCount }
        "`f" { ++$pageCount }
        "`t" { }
        " " { }
        default { ++$otherCount }
    }
}

switch -wildcard ("abc") {
    a* { "a*, $_" }
    ?B? { "?B? , $_" }
    default { "default, $_" }
}

switch -regex -casesensitive ("abc") {
    ^a* { "a*" }
    ^A* { "A*" }
}

switch (0, 1, 19, 20, 21) {
    { $_ -lt 20 } { "-lt 20" }
    { $_ -band 1 } { "Odd" }
    { $_ -eq 19 } { "-eq 19" }
    default { "default" }
}
```

## 8.7 The try/finally statement

Syntax:

```Syntax
try-statement:
    try statement-block catch-clauses
    try statement-block finally-clause
    try statement-block catch-clauses finally-clause

catch-clauses:
    catch-clause
    catch-clauses catch-clause

catch-clause:
    new-lines~opt~ catch catch-type-list~opt~
    statement-block

catch-type-list:
    new-lines~opt~ type-literal
    catch-type-list new-lines~opt~ , new-lines~opt~

type-literalfinally-clause:
    new-lines~opt~ finally statement-block
```

Description:

The try statement provides a mechanism for catching exceptions that occur during execution of a
block. The try statement also provides the ability to specify a block of code that is always
executed when control leaves the try statement. The process of raising an exception via the throw
statement is described in [§8.5.3][§8.5.3].

A *try block* is the *statement-block* associated with the try statement. A *catch block* is the
*statement-block* associated with a *catch-clause*. A *finally block* is the *statement-block*
associated with a *finally-clause*.

A *catch-clause* without a *catch-type-list* is called a *general catch clause*.

Each *catch-clause* is an *exception handler*, and a *catch-clause* whose *catch-type-list* contains
the type of the raised exception is a *matching catch clause*. A general catch clause matches all
exception types.

Although *catch-clauses* and *finally-clause* are optional, at least one of them must be present.

The processing of a thrown exception consists of evaluating the following steps repeatedly until a
catch clause that matches the exception is found.

- In the current scope, each try statement that encloses the throw point is examined. For each try
  statement *S*, starting with the innermost try statement and ending with the outermost try
  statement, the following steps are evaluated:

  - If the `try` block of *S* encloses the throw point and if *S* has one or more catch clauses, the
    catch clauses are examined in lexical order to locate a suitable handler for the exception. The
    first catch clause that specifies the exception type or a base type of the exception type is
    considered a match. A general catch clause is considered a match for any exception type. If a
    matching catch clause is located, the exception processing is completed by transferring control
    to the block of that catch clause. Within a matching catch clause, the variable `$_` contains a
    description of the current exception.

  - Otherwise, if the `try` block or a `catch` block of *S* encloses the throw point and if *S* has
    a `finally` block, control is transferred to the finally block. If the `finally` block throws
    another exception, processing of the current exception is terminated. Otherwise, when control
    reaches the end of the `finally` block, processing of the current exception is continued.

- If an exception handler was not located in the current scope, the steps above are then repeated
  for the enclosing scope with a throw point corresponding to the statement from which the current
  scope was invoked.

- If the exception processing ends up terminating all scopes, indicating that no handler exists for
  the exception, then the behavior is unspecified.

To prevent unreachable catch clauses in a try block, a catch clause may not specify an exception
type that is equal to or derived from a type that was specified in an earlier catch clause within
that same try block.

The statements of a `finally` block are always executed when control leaves a `try` statement. This
is true whether the control transfer occurs as a result of normal execution, as a result of
executing a `break`, `continue`, or `return` statement, or as a result of an exception being thrown
out of the `try` statement.

If an exception is thrown during execution of a `finally` block, the exception is thrown out to the
next enclosing `try` statement. If another exception was in the process of being handled, that
exception is lost. The process of generating an exception is further discussed in the description of
the `throw` statement.

`try` statements can co-exist with `trap` statements; see [§8.8][§8.8] for details.

Examples:

```powershell
$a = new-object 'int[]' 10
$i = 20 # out-of-bounds subscript

while ($true) {
    try {
        $a[$i] = 10
        "Assignment completed without error"
        break
    }

    catch [IndexOutOfRangeException] {
        "Handling out-of-bounds index, >$_<`n"
        $i = 5
    }

    catch {
        "Caught unexpected exception"
    }

    finally {
        # ...
    }
}
```

Each exception thrown is raised as a `System.Management.Automation.RuntimeException`. If there are
type-specific *catch-clause*s in the `try` block, the **InnerException** property of the exception
is inspected to try and find a match, such as with the type `System.IndexOutOfRangeException` above.

## 8.8 The trap statement

Syntax:

```Syntax
trap-statement:
    *trap* new-lines~opt~ type-literal~opt~ new-lines~opt~ statement-block
```

Description:

A `trap` statement with and without *type-literal* is analogous to a `catch` block ([§8.7][§8.7]) with
and without *catch-type-list*, respectively, except that a `trap` statement can trap only one type
at a time.

Multiple `trap` statements can be defined in the same *statement-block*, and their order of
definition is irrelevant. If two `trap` statements with the same *type-literal* are defined in the
same scope, the lexically first one is used to process an exception of matching type.

Unlike a `catch` block, a `trap` statement matches an exception type exactly; no derived type
matching is performed.

When an exception occurs, if no matching `trap` statement is present in the current scope, a
matching trap statement is searched for in the enclosing scope, which may involve looking in the
calling script, function, or filter, and then in its caller, and so on. If the lookup ends up
terminating all scopes, indicating that no handler exists for the exception, then the behavior is
unspecified.

A `trap` statement's *statement-body* only executes to process the corresponding exception;
otherwise, execution passes over it.

If a `trap`'s *statement-body* exits normally, by default, an error object is written to the error
stream, the exception is considered handled, and execution continues with the statement immediately
following the one in the scope containing the `trap` statement that made the exception visible. The
cause of the exception might be in a command called by the command containing the `trap` statement.

If the final statement executed in a `trap`'s *statement-body* is continue ([§8.5.2][§8.5.2]), the writing
of the error object to the error stream is suppressed, and execution continues with the statement
immediately following the one in the scope containing the trap statement that made the exception
visible. If the final statement executed in a `trap`'s *statement-body* is break ([§8.5.1][§8.5.1]), the
writing of the error object to the error stream is suppressed, and the exception is re-thrown.

Within a `trap` statement the variable `$_` contains a description of the current error.

Consider the case in which an exception raised from within a `try` block does not have a matching
`catch` block, but a matching `trap` statement exists at a higher block level. After the `try`
block's finally clause is executed, the `trap` statement gets control even if any parent scope has a
matching `catch` block. If a `trap` statement is defined within the `try` block itself, and that
`try` block has a matching `catch` block, the `trap` statement gets control.

Examples:

In the following example, the error object is written and execution continues with the statement
immediately following the one that caused the trap; that is, "Done" is written to the pipeline.

```powershell
$j = 0; $v = 10/$j; "Done"
trap { $j = 2 }
```

In the following example, the writing of the error object is suppressed and execution continues with
the statement immediately following the one that caused the trap; that is, "Done" is written to the
pipeline.

```powershell
$j = 0; $v = 10/$j; "Done"
trap { $j = 2; continue }
```

In the following example, the writing of the error object is suppressed and the exception is
re-thrown.

```powershell
$j = 0; $v = 10/$j; "Done"
trap { $j = 2; break }
```

In the following example, the trap and exception-generating statements are in the same scope. After
the exception is caught and handled, execution resumes with writing 1 to the pipeline.

```powershell
&{trap{}; throw '\...'; 1}
```

In the following example, the trap and exception-generating statements are in different scopes.
After the exception is caught and handled, execution resumes with writing 2 (not 1) to the pipeline.

```powershell
trap{} &{throw '\...'; 1}; 2
```

## 8.9 The data statement

Syntax:

```Syntax
data-statement:
    data new-lines~opt~ data-name data-commands-allowed~opt~ statement-block

data-name:
    simple-name

data-commands-allowed:
    new-lines~opt~ -supportedcommand data-commands-list

data-commands-list:
    new-lines~opt~ data-command
    data-commands-list , new-lines~opt~ data-command

data-command:
    command-name-expr
```

Description:

A data statement creates a *data section*, keeping that section's data separate from the code. This
separation supports facilities like separate string resource files for text, such as error messages
and Help strings. It also helps support internationalization by making it easier to isolate, locate,
and process strings that will be translated into different languages.

A script or function can have zero or more data sections.

The *statement-block* of a data section is limited to containing the following PowerShell features
only:

- All operators except `-match`
- The `if` statement
- The following automatic variables: `$PsCulture`, `$PsUICulture`, `$true`, `$false`, and `$null`.
- Comments
- Pipelines
- Statements separated by semicolons (`;`)
- Literals
- Calls to the [ConvertFrom-StringData](xref:Microsoft.PowerShell.Utility.ConvertFrom-StringData)
  cmdlet
- Any other cmdlets identified via the **supportedcommand** parameter

If the `ConvertFrom-StringData` cmdlet is used, the key/value pairs can be expressed using any form
of string literal. However, *expandable-string-literal*s and *expandable-here-string-literal*s must
not contain any variable substitutions or sub-expression expansions.

Examples:

The **SupportedCommand** parameter indicates that the given cmdlets or functions generate data only.
For example, the following data section includes a user-written cmdlet, `ConvertTo-XML`, which
formats data in an XML file:

```powershell
data -supportedCommand ConvertTo-XML {
    Format-XML -strings string1, string2, string3
}
```

Consider the following example, in which the data section contains a `ConvertFrom-StringData`
command that converts the strings into a hash table, whose value is assigned to `$messages`.

```powershell
$messages = data {
    ConvertFrom-StringData -stringdata @'
    Greeting = Hello
    Yes = yes
    No = no
'@
}
```

The keys and values of the hash table are accessed using `$messages.Greeting`, `$messages.Yes`, and
`$messages.No`, respectively.

Now, this can be saved as an English-language resource. German- and Spanish-language resources can
be created in separate files, with the following data sections:

```powershell
$messages = data {
    ConvertFrom-StringData -stringdata @"
    Greeting = Guten Tag
    Yes = ja
    No = nein
"@
}

$messagesS = data {
    ConvertFrom-StringData -stringdata @"
    Greeting = Buenos días
    Yes = sí
    No = no
"@
}
```

If *dataname* is present, it names the variable (without using a leading `$`) into which the value
of the data statement is to be stored. Specifically, `$name = data { ... }` is equivalent to
`data name { ... }`.

## 8.10 Function definitions

Syntax:

```Syntax
function-statement:
    function new-lines~opt~ function-name function-parameter-declaration~opt~ { script-block }
    filter new-lines~opt~ function-name function-parameter-declaration~opt~ { script-block }
    workflow new-lines~opt~ function-name function-parameter-declaration~opt~ { script-block }

function-name:
    command-argument

command-argument:
    command-name-expr

function-parameter-declaration:
    new-lines~opt~ ( parameter-list new-lines~opt~ )

parameter-list:
    script-parameter
    parameter-list new-lines~opt~ , script-parameter

script-parameter:
    new-lines~opt~ attribute-list~opt~ new-lines~opt~ variable script-parameter-default~opt~

script-block:
    param-block~opt~ statement-terminators~opt~ script-block-body~opt~

param-block:
    new-lines~opt~ attribute-list~opt~ new-lines~opt~ param new-lines~opt~
        ( parameter-list~opt~ new-lines~opt~ )

parameter-list:
    script-parameter
    parameter-list new-lines~opt~ , script-parameter

script-parameter-default:
    new-lines~opt~ = new-lines~opt~ expression

script-block-body:
    named-block-list
    statement-list

named-block-list:
    named-block
    named-block-list named-block

named-block:
    block-name statement-block statement-terminators~opt~

block-name: one of
    dynamicparam   begin   process   end
```

Description:

A *function definition* specifies the name of the function, filter, or workflow being defined and
the names of its parameters, if any. It also contains zero or more statements that are executed to
achieve that function's purpose.

Each function is an instance of the class `System.Management.Automation.FunctionInfo`.

### 8.10.1 Filter functions

Whereas an ordinary function runs once in a pipeline and accesses the input collection via `$input`,
a *filter* is a special kind of function that executes once for each object in the input collection.
The object currently being processed is available via the variable `$_`.

A filter with no named blocks ([§8.10.7][§8.10.7]) is equivalent to a function with a process block, but
without any begin block or end block.

Consider the following filter function definition and calls:

```powershell
filter Get-Square2 { # make the function a filter
    $_ * $_ # access current object from the collection
}

-3..3 | Get-Square2 # collection has 7 elements
6, 10, -3 | Get-Square2 # collection has 3 elements
```

Each filter is an instance of the class `System.Management.Automation.FilterInfo` ([§4.5.11][§4.5.11]).

### 8.10.2 Workflow functions

A workflow function is like an ordinary function with implementation defined semantics. A workflow
function is translated to a sequence of Windows Workflow Foundation activities and executed in the
Windows Workflow Foundation engine.

### 8.10.3 Argument processing

Consider the following definition for a function called `Get-Power`:

```powershell
function Get-Power ([long]$base, [int]$exponent) {
    $result = 1
    for ($i = 1; $i -le $exponent; ++$i) {
        $result *= $base
    }
    return $result
}
```

This function has two parameters, `$base` and `$exponent`. It also contains a set of statements
that, for non-negative exponent values, computes `$base^$exponent^` and returns the result to
`Get-Power`'s caller.

When a script, function, or filter begins execution, each parameter is initialized to its
corresponding argument's value. If there is no corresponding argument and a default value
([§8.10.4][§8.10.4]) is supplied, that value is used; otherwise, the value `$null` is used. As such, each
parameter is a new variable just as if it was initialized by assignment at the start of the
*script-block*.

If a *script-parameter* contains a type constraint (such as `[long]` and `[int]` above), the value
of the corresponding argument is converted to that type, if necessary; otherwise, no conversion
occurs.

When a script, function, or filter begins execution, variable `$args` is defined inside it as an
unconstrained 1-dimensional array, which contains all arguments not bound by name or position, in
lexical order.

Consider the following function definition and calls:

```powershell
function F ($a, $b, $c, $d) { ... }

F -b 3 -d 5 2 4       # $a is 2, $b is 3, $c is 4, $d is 5, $args Length 0
F -a 2 -d 3 4 5       # $a is 2, $b is 4, $c is 5, $d is 3, $args Length 0
F 2 3 4 5 -c 7 -a 1   # $a is 1, $b is 2, $c is 7, $d is 3, $args Length 2
```

For more information about parameter binding see [§8.14][§8.14].

### 8.10.4 Parameter initializers

The declaration of a parameter *p* may contain an initializer, in which case, that initializer's
value is used to initialize *p* provided *p* is not bound to any arguments in the call.

Consider the following function definition and calls:

```powershell
function Find-Str ([string]$str, [int]$start_pos = 0) { ... }

Find-Str "abcabc" # 2nd argument omitted, 0 used for $start_pos
Find-Str "abcabc" 2 # 2nd argument present, so it is used for $start_pos
```

### 8.10.5 The [switch] type constraint

When a switch parameter is passed, the corresponding parameter in the command must be constrained by
the type switch. Type switch has two values, True and False.

Consider the following function definition and calls:

```powershell
function Process ([switch]$trace, $p1, $p2) { ... }

Process 10 20                # $trace is False, $p1 is 10, $p2 is 20
Process 10 -trace 20         # $trace is True, $p1 is 10, $p2 is 20
Process 10 20 -trace         # $trace is True, $p1 is 10, $p2 is 20
Process 10 20 -trace:$false  # $trace is False, $p1 is 10, $p2 is 20
Process 10 20 -trace:$true   # $trace is True, $p1 is 10, $p2 is 20
```

### 8.10.6 Pipelines and functions

When a script, function, or filter is used in a pipeline, a collection of values is delivered to
that script or function. The script, function, or filter gets access to that collection via the
enumerator $input ([§2.3.2.2][§2.3.2.2], [§4.5.16][§4.5.16]), which is defined on entry to that script, function,
or filter.

Consider the following function definition and calls:

```powershell
function Get-Square1 {
    foreach ($i in $input) {   # iterate over the collection
        $i * $i
    }
}

-3..3 | Get-Square1            # collection has 7 elements
6, 10, -3 | Get-Square1        # collection has 3 elements
```

### 8.10.7 Named blocks

The statements within a *script-block* can belong to one large unnamed block, or they can be
distributed into one or more named blocks. Named blocks allow custom processing of collections
coming from pipelines; named blocks can be defined in any order.

The statements in a *begin block* (i.e.; one marked with the keyword begin) are executed once,
before the first pipeline object is delivered.

The statements in a *process block* (i.e.; one marked with the keyword process) are executed for
each pipeline object delivered. (`$_` provides access to the current object being processed from the
input collection coming from the pipeline.) This means that if a collection of zero elements is sent
via the pipeline, the process block is not executed at all. However, if the script or function is
called outside a pipeline context, this block is executed exactly once, and `$_` is set to `$null`,
as there is no current collection object.

The statements in an *end block* (i.e.; one marked with the keyword end) are executed once, after
the last pipeline object has been delivered.

### 8.10.8 dynamicparam block

The subsections of [§8.10][§8.10] thus far deal with *static parameters*, which are defined as part of
the source code. It is also possible to define *dynamic parameters* via a *dynamicparam block*,
another form of named block ([§8.10.7][§8.10.7]), which is marked with the keyword `dynamicparam`. Much of
this machinery is implementation defined.

Dynamic parameters are parameters of a cmdlet, function, filter, or script that are available under
certain conditions only. One such case is the **Encoding** parameter of the `Set-Item` cmdlet.

In the *statement-block*, use an if statement to specify the conditions under which the parameter is
available in the function. Use the [New-Object](xref:Microsoft.PowerShell.Utility.New-Object) cmdlet
to create an object of an implementation-defined type to represent the parameter, and specify its
name. Also, use `New-Object` to create an object of a different implementation-defined type to
represent the implementation-defined attributes of the parameter.

The following example shows a function with standard parameters called Name and Path, and an
optional dynamic parameter named **DP1**. The **DP1** parameter is in the PSet1 parameter set and
has a type of `Int32`. The **DP1** parameter is available in the Sample function only when the value
of the Path parameter contains "HKLM:", indicating that it is being used in the `HKEY_LOCAL_MACHINE`
registry drive.

```powershell
function Sample {
    Param ([String]$Name, [String]$Path)
    dynamicparam {
        if ($path -match "*HKLM*:") {
            $dynParam1 = New-Object System.Management.Automation.RuntimeDefinedParameter("dp1", [Int32], $attributeCollection)

            $attributes = New-Object System.Management.Automation.ParameterAttribute
            $attributes.ParameterSetName = 'pset1'
            $attributes.Mandatory = $false

            $attributeCollection = New-Object -Type System.Collections.ObjectModel.Collection``1[System.Attribute]
            $attributeCollection.Add($attributes)

            $paramDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
            $paramDictionary.Add("dp1", $dynParam1)
            return $paramDictionary
        }
    }
}
```

The type used to create an object to represent a dynamic parameter is
`System.Management.Automation.RuntimeDefinedParameter`.

The type used to create an object to represent the attributes of the parameter is
`System.Management.Automation.ParameterAttribute`.

The implementation-defined attributes of the parameter include **Mandatory**, **Position**, and
**ValueFromPipeline**.

### 8.10.9 param block

A *param-block* provides an alternate way of declaring parameters. For example, the following sets
of parameter declarations are equivalent:

```powershell
function FindStr1 ([string]$str, [int]$start_pos = 0) { ... }
function FindStr2 {
    param ([string]$str, [int]$start_pos = 0) ...
}
```

A *param-block* allows an *attribute-list* on the *param-block* whereas a
*function-parameter-declaration* does not.

A script may have a *param-block* but not a *function-parameter-declaration*. A function or filter
definition may have a *function-parameter-declaration* or a *param-block*, but not both.

Consider the following example:

```powershell
param ( [Parameter(Mandatory = $true, ValueFromPipeline=$true)]
        [string[]] $ComputerName )
```

The one parameter, `$ComputerName`, has type `string[]`, it is required, and it takes input from the
pipeline.

See [§12.3.7][§12.3.7] for a discussion of the **Parameter** attribute and for more examples.

## 8.11 The parallel statement

Syntax:

```Syntax
parallel-statement:
    *parallel* statement-block
```

The parallel statement contains zero or more statements that are executed in an implementation
defined manner.

A parallel statement is only allowed in a workflow ([§8.10.2][§8.10.2]).

## 8.12 The sequence statement

Syntax:

```Syntax
sequence-statement:
    *sequence* statement-block
```

The sequence statement contains zero or more statements that are executed in an implementation
defined manner.

A sequence statement is only allowed in a workflow ([§8.10.2][§8.10.2]).

## 8.13 The inlinescript statement

Syntax:

```Syntax
inlinescript-statement:
    inlinescript statement-block
```

The inlinescript statement contains zero or more statements that are executed in an implementation
defined manner.

An inlinescript statement is only allowed in a workflow ([§8.10.2][§8.10.2]).

## 8.14 Parameter binding

When a script, function, filter, or cmdlet is invoked, each argument can be bound to the
corresponding parameter by position, with the first parameter having position zero.

Consider the following definition fragment for a function called `Get-Power`, and the calls to it:

```powershell
function Get-Power ([long]$base, [int]$exponent) { ... }

Get-Power 5 3       # argument 5 is bound to parameter $base in position 0
                    # argument 3 is bound to parameter $exponent in position 1
                    # no conversion is needed, and the result is 5 to the power 3

Get-Power 4.7 3.2   # double argument 4.7 is rounded to int 5, double argument
                    # 3.2 is rounded to int 3, and result is 5 to the power 3

Get-Power 5         # $exponent has value $null, which is converted to int 0

Get-Power           # both parameters have value $null, which is converted to int 0
```

When a script, function, filter, or cmdlet is invoked, an argument can be bound to the corresponding
parameter by name. This is done by using a *parameter with argument*, which is an argument that is
the parameter's name with a leading dash (-), followed by the associated value for that argument.
The parameter name used can have any case-insensitive spelling and can use any prefix that uniquely
designates the corresponding parameter. When choosing parameter names, avoid using the names of the
[common parameters](/powershell/module/microsoft.powershell.core/about/about_commonparameters).

Consider the following calls to function `Get-Power`:

```powershell
Get-Power -base 5 -exponent 3   # -base designates $base, so 5 is
                                # bound to that, exponent designates
                                # $exponent, so 3 is bound to that

Get-Power -Exp 3 -BAs 5         # $base takes on 5 and $exponent takes on 3

Get-Power -e 3 -b 5             # $base takes on 5 and $exponent takes on 3
```

On the other hand, calls to the following function

```powershell
function Get-Hypot ([double]$side1, [double]$side2) {
    return [Math]::Sqrt($side1 * $side1 + $side2 * $side2)
}
```

must use parameters `-side1` and `-side2`, as there is no prefix that uniquely designates the
parameter.

The same parameter name cannot be used multiple times with or without different associated argument
values.

Parameters can have attributes (§12). For information about the individual attributes see the
sections within [§12.3][§12.3]. For information about parameter sets see [§12.3][§12.3].7.

A script, function, filter, or cmdlet can receive arguments via the invocation command line, from
the pipeline, or from both. Here are the steps, in order, for resolving parameter binding:

1. Bind all named parameters, then
1. Bind positional parameters, then
1. Bind from the pipeline by value ([§12.3.7][§12.3.7]) with exact match, then
1. Bind from the pipeline by value ([§12.3.7][§12.3.7]) with conversion, then
1. Bind from the pipeline by name ([§12.3.7][§12.3.7]) with exact match, then
1. Bind from the pipeline by name ([§12.3.7][§12.3.7]) with conversion

Several of these steps involve conversion, as described in [§6.][§6.] However, the set of conversions
used in binding is not exactly the same as that used in language conversions. Specifically,

- Although the value `$null` can be cast to bool, `$null` cannot be bound to `bool`.
- When the value `$null` is passed to a switch parameter for a cmdlet, it is treated as if `$true`
  was passed. However, when passed to a switch parameter for a function, it is treated as if
  `$false` was passed.
- Parameters of type bool or switch can only bind to numeric or bool arguments.
- If the parameter type is not a collection, but the argument is some sort of collection, no
  conversion is attempted unless the parameter type is object or PsObject. (The main point of this
  restriction is to disallow converting a collection to a string parameter.) Otherwise, the usual
  conversions are attempted.

If the parameter type is `IList` or `ICollection<T>`, only those conversions via Constructor,
op_Implicit, and op_Explicit are attempted. If no such conversions exist, a special conversion for
parameters of "collection" type is used, which includes `IList`, `ICollection<T>`, and arrays.

Positional parameters prefer to be bound without type conversion, if possible. For example,

```powershell
function Test {
    [CmdletBinding(DefaultParameterSetname = "SetB")]
    param([Parameter(Position = 0, ParameterSetname = "SetA")]
        [decimal]$dec,
        [Parameter(Position = 0, ParameterSetname = "SetB")]
        [int]$in
    )
    $PsCmdlet.ParameterSetName
}

Test 42d   # outputs "SetA"
Test 42    # outputs "SetB"
```

<!-- reference links -->
[§12.3.7]: chapter-12.md#1237-the-parameter-attribute
[§12.3]: chapter-12.md#123-reserved-attributes
[§2.3.2.2]: chapter-02.md#2322-automatic-variables
[§2.3.4]: chapter-02.md#234-parameters
[§2.3.5.2]: chapter-02.md#2352-string-literals
[§3.15]: chapter-03.md#315-wildcard-expressions
[§3.16]: chapter-03.md#316-regular-expressions
[§3.5.5]: chapter-03.md#355-dot-source-notation
[§3.8]: chapter-03.md#38-name-lookup
[§4.5.11]: chapter-04.md#4511-filter-description-type
[§4.5.16]: chapter-04.md#4516-enumerator-description-type
[§6.]: chapter-06.md#6-conversions
[§7.11]: chapter-07.md#711-assignment-operators
[§7.12]: chapter-07.md#712-redirection-operators
[§7.8.1]: chapter-07.md#781-equality-and-relational-operators
[§8.1.1]: chapter-08.md#811-labeled-statements
[§8.10.2]: chapter-08.md#8102-workflow-functions
[§8.10.4]: chapter-08.md#8104-parameter-initializers
[§8.10.5]: chapter-08.md#8105-the-switch-type-constraint
[§8.10.7]: chapter-08.md#8107-named-blocks
[§8.10]: chapter-08.md#810-function-definitions
[§8.14]: chapter-08.md#814-parameter-binding
[§8.4]: chapter-08.md#84-iteration-statements
[§8.5.1]: chapter-08.md#851-the-break-statement
[§8.5.2]: chapter-08.md#852-the-continue-statement
[§8.5.3]: chapter-08.md#853-the-throw-statement
[§8.5.4]: chapter-08.md#854-the-return-statement
[§8.5.5]: chapter-08.md#855-the-exit-statement
[§8.6]: chapter-08.md#86-the-switch-statement
[§8.7]: chapter-08.md#87-the-tryfinally-statement
[§8.8]: chapter-08.md#88-the-trap-statement

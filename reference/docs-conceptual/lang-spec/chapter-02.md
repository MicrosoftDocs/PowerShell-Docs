---
description: This specification shows the syntax of the PowerShell language using a lexical grammar and a syntactic grammar.
ms.date: 05/19/2021
title: Lexical structure
---
# 2. Lexical Structure

[!INCLUDE [Disclaimer](../../includes/language-spec.md)]

## 2.1 Grammars

This specification shows the syntax of the PowerShell language using two grammars. The _lexical
grammar_ ([§B.1][§B.1]) shows how Unicode characters are combined to form line terminators,
comments, white space, and tokens. The _syntactic grammar_ ([§B.2][§B.2]) shows how the tokens
resulting from the lexical grammar are combined to form PowerShell scripts.

For convenience, fragments of these grammars are replicated in appropriate places throughout this
specification.

Any use of the characters 'a' through 'z' in the grammars is case insensitive. This means that
letter case in variables, aliases, function names, keywords, statements, and operators is ignored.
However, throughout this specification, such names are written in lowercase, except for some
automatic and preference variables.

## 2.2 Lexical analysis

### 2.2.1 Scripts

Syntax:

> [!TIP]
> The `~opt~` notation in the syntax definitions indicates that the lexical entity is optional in
> the syntax.

```Syntax
input:
    input-elements~opt~   signature-block~opt~

input-elements:
    input-element
    input-elements   input-element

input-element:
    whitespace
    comment
    token

signature-block:
    signature-begin   signature   signature-end

signature-begin:
    new-line-character   # SIG # Begin signature block   new-line-character

signature:
    base64 encoded signature blob in multiple single-line-comments

signature-end:
    new-line-character   # SIG # End signature block   new-line-character
```

Description:

The input source stream to a PowerShell translator is the _input_ in a script, which contains a
sequence of Unicode characters. The lexical processing of this stream involves the reduction of
those characters into a sequence of tokens, which go on to become the input of syntactic analysis.

A script is a group of PowerShell commands stored in a _script-file_. The script itself has no name,
per se, and takes its name from its source file. The end of that file indicates the end of the
script.

A script may optionally contain a digital signature. A host environment is not required to process
any text that follows a signature or anything that looks like a signature. The creation and use of
digital signatures are not covered by this specification.

### 2.2.2 Line terminators

Syntax:

```Syntax
new-line-character:
    Carriage return character (U+000D)
    Line feed character (U+000A)
    Carriage return character (U+000D) followed by line feed character (U+000A)

new-lines:
    new-line-character
    new-lines new-line-character
```

Description:

The presence of *new-line-character*s in the input source stream divides it into lines that can be
used for such things as error reporting and the detection of the end of a single-line comment.

A line terminator can be treated as white space ([§2.2.4][§2.2.4]).

### 2.2.3 Comments

Syntax:

```Syntax
comment:
    single-line-comment
    requires-comment
    delimited-comment

single-line-comment:
    # input-characters~opt~

input-characters:
    input-character
    input-characters input-character

input-character:
    Any Unicode character except a new-line-character

requires-comment:
    #requires whitespace command-arguments

dash:
    - (U+002D)
    EnDash character (U+2013)
    EmDash character (U+2014)
    Horizontal bar character (U+2015)

dashdash:
    dash dash

delimited-comment:
    < # delimited-comment-text~opt~ hashes >

delimited-comment-text:
    delimited-comment-section
    delimited-comment-text delimited-comment-section

delimited-comment-section:
    >
    hashes~opt~  not-greater-than-or-hash

hashes:
    #
    hashes #

not-greater-than-or-hash:
    Any Unicode character except > or #
```

Description:

Source code can be annotated by the use of _comments_.

A _single-line-comment_ begins with the character `#` and ends with a _new-line-character_.

A _delimited-comment_ begins with the character pair `<#` and ends with the character pair `#>`.
It can occur as part of a source line, as a whole source line, or it can span any number of source
lines.

A comment is treated as white space.

The productions above imply that

- Comments do not nest.
- The character sequences <# and #> have no special meaning in a single-line comment.
- The character # has no special meaning in a delimited comment.

The lexical grammar implies that comments cannot occur inside tokens.

(See §A for information about creating script files that contain special-valued comments that are
used to generate documentation from script files.)

A _requires-comment_ specifies the criteria that have to be met for its containing script to be
allowed to run. The primary criterion is the version of PowerShell being used to run the script. The
minimum version requirement is specified as follows:

`#requires -Version N[.n]`

Where _N_ is the (required) major version and _n_ is the (optional) minor version.

A _requires-comment_ can be present in any script file; however, it cannot be present inside a
function or cmdlet. It must be the first item on a source line. A script can contain multiple
*requires-comment*s.

A character sequence is only recognized as a comment if that sequence begins with `#` or `<#`. For
example, hello#there is considered a single token whereas hello #there is considered the token hello
followed by a single-line comment. As well as following white space, the comment start sequence can
also be preceded by any expression-terminating or statement-terminating character (such as `)`, `}`,
`]`, `'`, `"`, or `;`).

A _requires-comment_ cannot be present inside a snap-in.

There are four other forms of a _requires-comment_:

```Syntax
#requires --Assembly AssemblyId
#requires --Module ModuleName
#requires --PsSnapIn PsSnapIn [ -Version *N* [.n] ]
#requires --ShellId ShellId
```

### 2.2.4 White space

Syntax:

```Syntax
whitespace:
    Any character with Unicode class Zs, Zl, or Zp
    Horizontal tab character (U+0009)
    Vertical tab character (U+000B)
    Form feed character (U+000C)
    ` (The backtick character U+0060) followed by new-line-character
```

Description:

_White space_ consists of any sequence of one or more _whitespace_ characters.

Except for the fact that white space may act as a separator for tokens, it is ignored.

Unlike some popular languages, PowerShell does not consider line-terminator characters ([§2.2.2][§2.2.2])
to be white space. However, a line terminator can be treated as white space by preceding it
immediately by a backtick character, `` ` `` (U+0060). This is necessary when the contents of a line
are complete syntactically, yet the following line contains tokens intended to be associated with
the previous line. For example,

```powershell
$number = 10 # assigns 10 to $number; nothing is written to the pipeline
+ 20 # writes 20 to the pipeline
- 50 # writes -50 to the pipeline
$number # writes $number's value, 10, to the pipeline
```

In this example, the backtick indicates the source line is continued. The following expression is
equivalent to `$number = 10 + 20 - 50`.

```powershell
$number = 10 `
+ 20 `
- 50
$number # writes $number's value to the pipeline
-20
```

## 2.3 Tokens

Syntax:

```Syntax
token:
    keyword
    variable
    command
    command-parameter
    command-argument-token
    integer-literal
    real-literal
    string-literal
    type-literal
    operator-or-punctuator
```

Description:

A _token_ is the smallest lexical element within the PowerShell language.

Tokens can be separated by _new-lines_, comments, white space, or any combination thereof.

### 2.3.1 Keywords

Syntax:

```Syntax
keyword: one of
    begin          break          catch       class
    continue       data           define      do
    dynamicparam   else           elseif      end
    exit           filter         finally     for
    foreach        from           function    if
    in             inlinescript   parallel    param
    process        return         switch      throw
    trap           try            until       using
    var            while          workflow
```

Description:

A _keyword_ is a sequence of characters that has a special meaning when used in a context-dependent
place. Most often, this is as the first token in a _statement_; however, there are other locations,
as indicated by the grammar. (A token that looks like a keyword, but is not being used in a keyword
context, is a _command-name_ or a _command-argument_.)

The keywords `class`, `define`, `from`, `using`, and `var` are reserved for future use.

> [!NOTE]
> Editor's Note: The `class` and `using` keywords were introduced in PowerShell 5.0. See
> [about_Classes](/powershell/module/microsoft.powershell.core/about/about_classes) and
> [about_Using](/powershell/module/microsoft.powershell.core/about/about_using).

### 2.3.2 Variables

Syntax:

```Syntax
variable:
    $$
    $?
    $^
    $   variable-scope~opt~  variable-characters
    @   variable-scope~opt~  variable-characters
    braced-variable


braced-variable:
    ${   variable-scope~opt~   braced-variable-characters   }

variable-scope:
    global:
    local:
    private:
    script:
    using:
    workflow:
    variable-namespace

variable-namespace:
    variable-characters   :

variable-characters:
    variable-character
    variable-characters   variable-character

variable-character:
    A Unicode character of classes Lu, Ll, Lt, Lm, Lo, or Nd
    _   (The underscore character U+005F)
    ?

braced-variable-characters:
    braced-variable-character
    braced-variable-characters   braced-variable-character

braced-variable-character:
    Any Unicode character except
        }   (The closing curly brace character U+007D)
        `   (The backtick character U+0060)
    escaped-character

escaped-character:
    `   (The backtick character U+0060) followed by any Unicode character
```

Description:

Variables are discussed in detail in (§5). The variable $? is discussed in [§2.3.2.2][§2.3.2.2]. Scopes are
discussed in [§3.5][§3.5].

The variables `$$` and `$^` are reserved for use in an interactive environment, which is outside the
scope of this specification.

There are two ways of writing a variable name: A _braced variable name_, which begins with `$`,
followed by a curly bracket-delimited set of one or more almost-arbitrary characters; and an
_ordinary variable name_, which also begins with `$`, followed by a set of one or more characters
from a more restrictive set than a braced variable name allows. Every ordinary variable name can be
expressed using a corresponding braced variable name.

```powershell
$totalCost
$Maximum_Count_26

$végösszeg # Hungarian
$итог # Russian
$総計 # Japanese (Kanji)

${Maximum_Count_26}
${Name with`twhite space and `{punctuation`}}
${E:\\File.txt}
```

There is no limit on the length of a variable name, all characters in a variable name are
significant, and letter case is _not_ distinct.

There are several different kinds of variables: user-defined ([§2.3.2.1][§2.3.2.1]), automatic
([§2.3.2.2][§2.3.2.2]), and preference ([§2.3.2.3][§2.3.2.3]). They can all coexist in the same scope ([§3.5][§3.5]).

Consider the following function definition and calls:

```powershell
function Get-Power ([long]$base, [int]$exponent) { ... }

Get-Power 5 3 # $base is 5, $exponent is 3
Get-Power -exponent 3 -base 5 # " " "
```

Each argument is passed by position or name, one at a time. However, a set of arguments can be
passed as a group with expansion into individual arguments being handled by the runtime environment.
This automatic argument expansion is known as _splatting_. For example,

```powershell
$values = 5,3 # put arguments into an array
Get-Power @values

$hash = @{ exponent = 3; base = 5 } # put arguments into a Hashtable
Get-Power @hash

function Get-Power2 { Get-Power @args } # arguments are in an array

Get-Power2 --exponent 3 --base 5 # named arguments splatted named in
@args
Get-Power2 5 3 # position arguments splatted positionally in @args
```

This is achieved by using `@` instead of `$` as the first character of the variable being passed.
This notation can only be used in an argument to a command.

Names are partitioned into various namespaces each of which is stored on a virtual drive
([§3.1][§3.1]). For example, variables are stored on `Variable:`, environment variables are stored on
`Env:`, functions are stored on `Function:`, and aliases are stored on `Alias:`. All of these names
can be accessed as variables using the _variable-namespace_ production within _variable-scope_. For
example,

```powershell
function F { "Hello from F" }
$Function:F # invokes function F

Set-Alias A F
$Alias:A # invokes function F via A

$Count = 10
$Variable:Count # accesses variable Count
$Env:Path # accesses environment variable Path
```

Any use of a variable name with an explicit `Variable:` namespace is equivalent to the use of that
same variable name without that qualification. For example, `$v` and `$Variable:v` are
interchangeable.

As well as being defined in the language, variables can also be defined by the cmdlet
[New-Variable](xref:Microsoft.PowerShell.Utility.New-Variable).

#### 2.3.2.1 User-defined variables

Any variable name allowed by the grammar but not used by automatic or preference variables is
available for user-defined variables.

User-defined variables are created and managed by user-defined script.

#### 2.3.2.2 Automatic variables

Automatic variables store state information about the PowerShell environment. Their values can be
read in user-written script but not written.

> [!NOTE]
> The table originally found in this document was removed to reduce duplication. For a complete list
> of automatic variables, see
> [about_Automatic_Variables](/powershell/module/microsoft.powershell.core/about/about_automatic_variables).

#### 2.3.2.3 Preference variables

Preference variables store user preferences for the session. They are created and initialized by the
PowerShell runtime environment. Their values can be read and written in user-written script.

> [!NOTE]
> The table originally found in this document was removed to reduce duplication. For a complete list
> of preference variables, see
> [about_Preference_Variables](/powershell/module/microsoft.powershell.core/about/about_preference_variables).

### 2.3.3 Commands

Syntax:

```Syntax
generic-token:
    generic-token-parts

generic-token-parts:
    generic-token-part
    generic-token-parts generic-token-part

generic-token-part:
    expandable-string-literal
    verbatim-here-string-literal
    variable
    generic-token-char

generic-token-char:
    Any Unicode character except
        {   }   (   )   ;   ,   |   &   $
        ` (The backtick character U+0060)
        double-quote-character
        single-quote-character
        whitespace
        new-line-character
        escaped-character

generic-token-with-subexpr-start:
    generic-token-parts $(
```

### 2.3.4 Parameters

Syntax:

```Syntax
command-parameter:
    dash first-parameter-char parameter-chars colon~opt~

first-parameter-char:
    A Unicode character of classes Lu, Ll, Lt, Lm, or Lo
    _ (The underscore character U+005F)
    ?

parameter-chars:
    parameter-char
    parameter-chars parameter-char

parameter-char:
    Any Unicode character except
        { } ( ) ; , \| & . [
        colon
        whitespace
        new-line-character

colon:
    : (The colon character U+003A)

verbatim-command-argument-chars:
    verbatim-command-argument-part
    verbatim-command-argument-chars verbatim-command-argument-part

verbatim-command-argument-part:
    verbatim-command-string
    & non-ampersand-character
    Any Unicode character except
        |
        new-line-character

non-ampersand-character:
    Any Unicode character except &

verbatim-command-string:
    double-quote-character non-double-quote-chars
    double-quote-character

non-double-quote-chars:
    non-double-quote-char
    non-double-quote-chars non-double-quote-char

non-double-quote-char:
    Any Unicode character except
        double-quote-character
```

Description:

When a command is invoked, information may be passed to it via one or more _arguments_ whose values
are accessed from within the command through a set of corresponding _parameters_. The process of
matching parameters to arguments is called _parameter binding_.

There are three kinds of argument:

- Switch parameter ([§8.10.5][§8.10.5]) -- This has the form _command-parameter_ where
  _first-parameter-char_ and _parameter-chars_ together make up the switch name, which corresponds
  to the name of a parameter (without its leading `-`) in the command being invoked. If the trailing
  colon is omitted, the presence of this argument indicates that the corresponding parameter be set
  to `$true`. If the trailing colon is present, the argument immediately following must designate a
  value of type bool, and the corresponding parameter is set to that value. For example, the
  following invocations are equivalent:

  ```powershell
  Set-MyProcess -Strict
  Set-MyProcess -Strict: $true
  ```

- Parameter with argument ([§8.10.2][§8.10.2]) -- This has the form _command-parameter_ where
  _first-parameter-char_ and _parameter-chars_ together make up the parameter name, which
  corresponds to the name of a parameter (without its leading -) in the command being invoked. There
  must be no trailing colon. The argument immediately following designates an associated value. For
  example, given a command `Get-Power`, which has parameters `$base` and `$exponent`, the following
  invocations are equivalent:

  ```powershell
  Get-Power -base 5 -exponent 3
  Get-Power -exponent 3 -base 5
  ```

- Positional argument ([§8.10.2][§8.10.2]) - Arguments and their corresponding parameters inside commands
  have positions with the first having position zero. The argument in position 0 is bound to the
  parameter in position 0; the argument in position 1 is bound to the parameter in position 1; and
  so on. For example, given a command `Get-Power`, that has parameters `$base` and `$exponent` in
  positions 0 and 1, respectively, the following invokes that command:

  ```powershell
  Get-Power 5 3
  ```

See [§8.2][§8.2] for details of the special parameters `--` and `--%`.

When a command is invoked, a parameter name may be abbreviated; any distinct leading part of the
full name may be used, provided that is unambiguous with respect to the names of the other
parameters accepted by the same command.

For information about parameter binding see [§8.14][§8.14].

### 2.3.5 Literals

Syntax:

```Syntax
literal:
    integer-literal
    real-literal
    string-literal
```

#### 2.3.5.1 Numeric literals

There are two kinds of numeric literals: integer ([§2.3.5.1.1][§2.3.5.1.1]) and real ([§2.3.5.1.2][§2.3.5.1.2]). Both
can have multiplier suffixes ([§2.3.5.1.3][§2.3.5.1.3]).

##### 2.3.5.1.1 Integer literals

Syntax:

```Syntax
integer-literal:
    decimal-integer-literal
    hexadecimal-integer-literal

decimal-integer-literal:
    decimal-digits numeric-type-suffix~opt~ numeric-multiplier~opt~

decimal-digits:
    decimal-digit
    decimal-digit decimal-digits

decimal-digit: one of
    0  1  2  3  4  5  6  7  8  9

numeric-type-suffix:
    long-type-suffix
    decimal-type-suffix

hexadecimal-integer-literal:
    0x hexadecimal-digits long-type-suffix~opt~
    numeric-multiplier~opt~

hexadecimal-digits:
    hexadecimal-digit
    hexadecimal-digit decimal-digits

hexadecimal-digit: one of
    0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f

long-type-suffix:
    l

numeric-multiplier: one of
    kb mb gb tb pb
```

Description:

The type of an integer literal is determined by its value, the presence or absence of
_long-type-suffix_, and the presence of a _numeric-multiplier_ ([§2.3.5.1.3][§2.3.5.1.3]).

For an integer literal with no _long-type-suffix_

- If its value can be represented by type int ([§4.2.3][§4.2.3]), that is its type;
- Otherwise, if its value can be represented by type long ([§4.2.3][§4.2.3]), that is its type.
- Otherwise, if its value can be represented by type decimal ([§2.3.5.1.2][§2.3.5.1.2]), that is its type.
- Otherwise, it is represented by type double ([§2.3.5.1.2][§2.3.5.1.2]).

For an integer literal with _long-type-suffix_

- If its value can be represented by type long ([§4.2.3][§4.2.3]), that is its type;
- Otherwise, that literal is ill formed.

In the twos-complement representation of integer values, there is one more negative value than there
is positive. For the int type, that extra value is ‑2147483648. For the long type, that extra value
is ‑9223372036854775808. Even though the token 2147483648 would ordinarily be treated as a literal
of type long, if it is preceded immediately by the unary - operator, that operator and literal are
treated as a literal of type int having the smallest value. Similarly, even though the token
9223372036854775808 would ordinarily be treated as a real literal of type decimal, if it is
immediately preceded by the unary - operator, that operator and literal are treated as a literal of
type long having the smallest value.

Some examples of integer literals are 123 (int), 123L (long), and 200000000000 (long).

There is no such thing as an integer literal of type byte.

##### 2.3.5.1.2 Real literals

Syntax:

```Syntax
real-literal:
    decimal-digits . decimal-digits exponent-part~opt~ decimal-type-suffix~opt~ numeric-multiplier~opt~
    . decimal-digits exponent-part~opt~ decimal-type-suffix~opt~ numeric-multiplier~opt~
    decimal-digits exponent-part decimal-type-suffix~opt~ numeric-multiplier~opt~

exponent-part:
    e sign~opt~  decimal-digits

sign: one of
    +
    dash

decimal-type-suffix:
    d
    l

numeric-multiplier: one of
    kb mb gb tb pb

dash:
    - (U+002D)
    EnDash character (U+2013)
    EmDash character (U+2014)
    Horizontal bar character (U+2015)
```

Description:

A real literal may contain a _numeric-multiplier_ ([§2.3.5.1.3][§2.3.5.1.3]).

There are two kinds of real literal: _double_ and _decimal_. These are indicated by the absence or
presence, respectively, of _decimal-type-suffix_. (There is no such thing as a _float real
literal_.)

A double real literal has type double ([§4.2.4.1][§4.2.4.1]). A decimal real literal has type decimal
([§4.2.4.2][§4.2.4.2]). Trailing zeros in the fraction part of a decimal real literal are significant.

If the value of _exponent-part_'s _decimal-digits_ in a double real literal is less than the
minimum supported, the value of that double real literal is 0. If the value of _exponent-part_'s
_decimal-digits_ in a decimal real literal is less than the minimum supported, that literal is ill
formed. If the value of _exponent-part_'s _decimal-digits_ in a double or decimal real literal is
greater than the maximum supported, that literal is ill formed.

Some examples of double real literals are 1., 1.23, .45e35, 32.e+12, and 123.456E-231.

Some examples of decimal real literals are 1d (which has scale 0), 1.20d (which has scale 2),
1.23450e1d (i.e., 12.3450, which has scale 4), 1.2345e3d (i.e., 1234.5, which has scale 1),
1.2345e-1d (i.e., 0.12345, which has scale 5), and 1.2345e-3d (i.e., 0.0012345, which has scale 7).

> [!NOTE]
> Because a double real literal need not have a fraction or exponent part, the grouping parentheses
> in (123).M are needed to ensure that the property or method M is being selected for the integer
> object whose value is 123. Without those parentheses, the real literal would be ill-formed.

> [!NOTE]
> Although PowerShell does not provide literals for infinities and NaNs, double real literal-like
> equivalents can be obtained from the static read-only properties PositiveInfinity,
> NegativeInfinity, and NaN of the types float and double ([§4.2.4.1][§4.2.4.1]).

The grammar permits what starts out as a double real literal to have an `l` or `L` type suffix. Such
a token is really an integer literal whose value is represented by type long.

> [!NOTE]
> This feature has been retained for backwards compatibility with earlier versions of PowerShell.
> However, programmers are discouraged from using integer literals of this form as they can easily
> obscure the literal's actual value. For example, 1.2L has value 1, 1.2345e1L has value 12, and
> 1.2345e-5L has value 0, none of which is immediately obvious.

##### 2.3.5.1.3 Multiplier suffixes

Syntax:

```Syntax
numeric-multiplier: *one of*
    kb mb gb tb pb
```

Description:

For convenience, integer and real literals can contain a _numeric-multiplier_, which indicates one
of a set of commonly used powers of 10. _numeric-multiplier_ can be written in any combination of
upper- or lowercase letters.

| **Multiplier** | **Meaning**                                 | **Example**                    |
|----------------|---------------------------------------------|--------------------------------|
| kb             | kilobyte (1024)                             | 1kb ≡ 1024                     |
| mb             | megabyte (1024 x 1024)                      | 1.30Dmb ≡ 1363148.80           |
| gb             | gigabyte (1024 x 1024 x 1024)               | 0x10Gb ≡ 17179869184           |
| tb             | terabyte (1024 x 1024 x 1024 x 1024)        | 1.4e23tb ≡ 1.5393162788864E+35 |
| pb             | petabyte (1024 x 1024 x 1024 x 1024 x 1024) | 0x12Lpb ≡ 20266198323167232    |

#### 2.3.5.2 String literals

Syntax:

```Syntax
string-literal:
    expandable-string-literal
    expandable-here-string-literal
    verbatim-string-literal
    verbatim-here-string-literal

expandable-string-literal:
    double-quote-character expandable-string-characters~opt~  dollars~opt~ double-quote-character

double-quote-character:
    " (U+0022)
    Left double quotation mark (U+201C)
    Right double quotation mark (U+201D)
    Double low-9 quotation mark (U+201E)

expandable-string-characters:
      expandable-string-part
      expandable-string-characters
      expandable-string-part

expandable-string-part:
    Any Unicode character except
        $
        double-quote-character
        ` (The backtick character U+0060)
    braced-variable
    $ Any Unicode character except
        (
        {
        double-quote-character
        ` (The backtick character U+0060)*
    $ escaped-character
    escaped-character
    double-quote-character double-quote-character

dollars:
    $
    dollars $

expandable-here-string-literal:
    @  double-quote-character  whitespace~opt~  new-line-character
        expandable-here-string-characters~opt~  new-line-character  double-quote-character  @

expandable-here-string-characters:
    expandable-here-string-part
    expandable-here-string-characters  expandable-here-string-part

expandable-here-string-part:
    Any Unicode character except
        $
        new-line-character
    braced-variable
    $ Any Unicode character except
        (
        new-line-character
    $ new-line-character  Any Unicode character except double-quote-char
    $ new-line-character double-quote-char  Any Unicode character except @
    new-line-character  Any Unicode character except double-quote-char
    new-line-character double-quote-char  Any Unicode character except @

expandable-string-with-subexpr-start:
    double-quote-character  expandable-string-chars~opt~  $(

expandable-string-with-subexpr-end:
    double-quote-char

expandable-here-string-with-subexpr-start:
    @  double-quote-character  whitespace~opt~  new-line-character  expandable-here-string-chars~opt~  $(

expandable-here-string-with-subexpr-end:
    new-line-character  double-quote-character  @

verbatim-string-literal:
    single-quote-character verbatim-string-characters~opt~ single-quote-char

single-quote-character:
    ' (U+0027)
    Left single quotation mark (U+2018)
    Right single quotation mark (U+2019)
    Single low-9 quotation mark (U+201A)
    Single high-reversed-9 quotation mark (U+201B)

verbatim-string-characters:
    verbatim-string-part
    verbatim-string-characters verbatim-string-part

verbatim-string-part:
    *Any Unicode character except* single-quote-character
    single-quote-character  single-quote-character

verbatim-here-string-literal:
    @ single-quote-character whitespace~opt~  new-line-character
        verbatim-here-string-characters~opt~  new-line-character
            single-quote-character *@*

verbatim-*here-string-characters:
    verbatim-here-string-part
    verbatim-here-string-characters  verbatim-here-string-part

verbatim-here-string-part:
    Any Unicode character except* new-line-character
    new-line-character  Any Unicode character except single-quote-character
    new-line-character  single-quote-character  Any Unicode character except @
```

Description:

There are four kinds of string literals:

- _verbatim-string-literal_ (single-line single-quoted), which is a sequence of zero or more
  characters delimited by a pair of *single-quote-character*s. Examples are '' and 'red'.
- _expandable-string-literal_ (single-line double-quoted), which is a sequence of zero or more
  characters delimited by a pair of *double-quote-character*s. Examples are "" and "red".
- _verbatim-here-string-literal_ (multi-line single-quoted), which is a sequence of zero or more
  characters delimited by the character pairs @_single-quote-character_ and
  _single-quote-character_@, respectively, all contained on two or more source lines. Examples are:

  ```powershell
  @'
  '@

  @'
  line 1
  '@

  @'
  line 1
  line 2
  '@
  ```

- _expandable-here-string-literal_ (multi-line double-quoted), which is a sequence of zero or more
  characters delimited by the character pairs @_double-quote-character_ and
  _double-quote-character_@, respectively, all contained on two or more source lines. Examples are:

  ```powershell
  @"
  "@

  @"
  line 1
  "@

  @"
  line 1
  line 2
  "@
  ```

For *verbatim-here-string-literal*s and *expandable-here-string-literal*s, except for white space
(which is ignored) no characters may follow on the same source line as the opening
delimiter-character pair, and no characters may precede on the same source line as the closing
delimiter character pair.

The _body_ of a _verbatim-here-string-literal_ or an _expandable-here-string-literal_ begins at the
start of the first source line following the opening delimiter, and ends at the end of the last
source line preceding the closing delimiter. The body may be empty. The line terminator on the last
source line preceding the closing delimiter is not part of that literal's body.

A literal of any of these kinds has type string ([§4.3.1][§4.3.1]).

The character used to delimit a _verbatim-string-literal_ or _expandable-string-literal_ can be
contained in such a string literal by writing that character twice, in succession. For example,
`'What''s the time?'` and `"I said, ""Hello""."`. However, a _single-quote-character_ has no
special meaning inside an _expandable-string-literal_, and a _double-quote-character_ has no special
meaning inside a _verbatim-string-literal_.

An _expandable-string-literal_ and an _expandable-here-string-literal_ may contain
*escaped-character*s ([§2.3.7][§2.3.7]). For example, when the following string literal is written to the
pipeline, the result is as shown below:

```powershell
"column1`tcolumn2`nsecond line, `"Hello`", ```Q`5`!"
```

```Output
column1<horizontal-tab>column2<new-line>
second line, "Hello", `Q5!
```

If an _expandable-string-literal_ or _expandable-here-string-literal_ contains the name of a
variable, unless that name is preceded immediately by an escape character, it is replaced by the
string representation of that variable's value ([§6.7][§6.7]). This is known as _variable substitution_.

> [!NOTE]
> If the variable name is part of some larger expression, only the variable name is replaced. For
> example, if `$a` is an array containing the elements 100 and 200, `">$a.Length<"` results in
> `>100 200.Length<` while `">$($a.Length)<"` results in `>2<`. See sub-expression expansion below.

For example, the source code

```powershell
$count = 10
"The value of `$count is $count"
```

results in the _expandable-string-literal_

```Output
The value of $count is 10.
```

Consider the following:

```powershell
$a = "red","blue"
"`$a[0] is $a[0], `$a[0] is $($a[0])" # second [0] is taken literally
```

The result is

```Output
$a[0] is red blue[0], $a[0] is red
```

*expandable-string-literal*s and *expandable-here-string-literal*s also support a kind of
substitution called _sub-expression expansion_, by treating text of the form `$( ... )` as a
_sub-expression_ ([§7.1.6][§7.1.6]). Such text is replaced by the string representation of that
expression's value ([§6.8][§6.8]). Any white space used to separate tokens within _sub-expression_'s
_statement-list_ is ignored as far as the result string's construction is concerned.

The examples,

```powershell
$count = 10
"$count + 5 is $($count + 5)"
"$count + 5 is `$($count + 5)"
"$count + 5 is `$(`$count + 5)"
```

result in the following *expandable-string-literal*s:

```Output
10 + 5 is 15
10 + 5 is $(10 + 5)
10 + 5 is $($count + 5)
```

The following source,

```powershell
$i = 5; $j = 10; $k = 15
"`$i, `$j, and `$k have the values $( $i; $j; $k )"
```

results in the following _expandable-string-literal_:

```Output
$i, $j, and $k have the values 5 10 15
```

These four lines could have been written more succinctly as follows:

```powershell
"`$i, `$j, and `$k have the values $(($i = 5); ($j = 10); ($k = 15))"
```

In the following example,

```powershell
"First 10 squares: $(for ($i = 1; $i -le 10; ++$i) { "$i $($i*$i) " })"
```

the resulting _expandable-string-literal_ is as follows:

```Output
First 10 squares: 1 1 2 4 3 9 4 16 5 25 6 36 7 49 8 64 9 81 10 100
```

As shown, a _sub-expression_ can contain string literals having both variable substitution and
sub-expression expansion. Note also that the inner _expandable-string-literal_'s delimiters need
not be escaped; the fact that they are inside a _sub-expression_ means they cannot be terminators
for the outer _expandable-string-literal_.

An _expandable-string-literal_ or _expandable-here-string-literal_ containing a variable
substitution or sub-expression expansion is evaluated each time that literal is used; for example,

```powershell
$a = 10
$s1 = "`$a = $($a; ++$a)"
"`$s1 = >$s1<"
$s2 = "`$a = $($a; ++$a)"
"`$s2 = >$s2<"
$s2 = $s1
"`$s2 = >$s2<"
```

which results in the following *expandable-string-literal*s:

```Output
$s1 = >$a = 10<
$s2 = >$a = 11<
$s2 = >$a = 10<
```

The contents of a _verbatim-here-string-literal_ are taken verbatim, including any leading or
trailing white space within the body. As such, embedded *single-quote-character*s need not be
doubled-up, and there is no substitution or expansion. For example,

```powershell
$lit = @'
That's it!
2 * 3 = $(2*3)
'@
```

which results in the literal

```Output
That's it!
2 * 3 = $(2*3)
```

The contents of an _expandable-here-string-literal_ are subject to substitution and expansion, but
any leading or trailing white space within the body but outside any *sub-expression*s is taken
verbatim, and embedded *double-quote-character*s need not be doubled-up. For example,

```powershell
$lit = @"
That's it!
2 * 3 = $(2*3)
"@
```

which results in the following literal when expanded:

```powershell
That's it!
2 * 3 = 6
```

For both *verbatim-here-string-literal*s and *expandable-here-string-literal*s, each line terminator
within the body is represented in the resulting literal in an implementation-defined manner. For
example, in

```powershell
$lit = @"
abc
xyz
"@
```

the second line of the body has two leading spaces, and the first and second lines of the body have
line terminators; however, the terminator for the second line of the body is _not_ part of that
body. The resulting literal is equivalent to:
`"abc<implementation-defined character sequence>xyz"`.

> [!NOTE]
> To aid readability of source, long string literals can be broken across multiple source lines
> without line terminators being inserted. This is done by writing each part as a separate literal
> and concatenating the parts with the + operator ([§7.7.2][§7.7.2]). This operator allows its operands to
> designate any of the four kinds of string literal.

> [!NOTE]
> Although there is no such thing as a character literal per se, the same effect can be achieved by
> accessing the first character in a 1-character string, as follows: `[char]"A"` or `"A"[0]`.

For both *verbatim-here-string-literal*s and *expandable-here-string-literal*s, each line terminator
within the body is represented exactly as it was provided.

#### 2.3.5.3 Null literal

See the automatic variable `$null` ([§2.3.2.2][§2.3.2.2]).

#### 2.3.5.4 Boolean literals

See the automatic variables `$false` and `$true` ([§2.3.2.2][§2.3.2.2]).

#### 2.3.5.5 Array literals

PowerShell allows expressions of array type (§9) to be written using the unary comma operator
([§7.2.1][§7.2.1]), _array-expression_ ([§7.1.7][§7.1.7]), the binary comma operator ([§7.3][§7.3]), and the range
operator ([§7.4][§7.4]).

#### 2.3.5.6 Hash literals

PowerShell allows expressions of type Hashtable (§10) to be written using a
_hash-literal-expression_ ([§7.1.9][§7.1.9])

#### 2.3.5.7 Type names

Syntax:

```Syntax
type-name:
    type-identifier
    type-name . type-identifier

type-identifier:
    type-characters

type-characters:
    type-character
    type-characters type-character

type-character:
    A Unicode character of classes Lu, Ll, Lt, Lm, Lo, or Nd
    _ (The underscore character U+005F)

array-type-name:
    type-name [

generic-type-name:
    type-name [
```

### 2.3.6 Operators and punctuators

Syntax:

```Syntax
operator-or-punctuator: one of
    {   }   [   ]   (   )   @(   @{   $(   ;
    &&  ||  &   |   ,   ++  ..   ::   .
    !   *   /   %   +   -   --
    -and   -band   -bnot   -bor
    -bxor   -not   -or     -xor
    assignment-operator
    merging-redirection-operator
    file-redirection-operator
    comparison-operator
    format-operator

assignment-operator: one of
    =  -=  +=  *=  /=  %=

file-redirection-operator: one of
    >  >>  2>  2>>  3>  3>>  4>  4>>
    5>  5>>  6>  6>>  *>  *>>  <

merging-redirection-operator: one of
    *>&1  2>&1  3>&1  4>&1  5>&1  6>&1
    *>&2  1>&2  3>&2  4>&2  5>&2  6>&2

comparison-operator: *one of
    -as           -ccontains      -ceq
    -cge          -cgt            -cle
    -clike        -clt            -cmatch
    -cne          -cnotcontains   -cnotlike
    -cnotmatch    -contains       -creplace
    -csplit       -eq             -ge
    -gt           -icontains      -ieq
    -ige          -igt            -ile
    -ilike        -ilt            -imatch
    -in           -ine            -inotcontains
    -inotlike     -inotmatch      -ireplace
    -is           -isnot          -isplit
    -join         -le             -like
    -lt           -match          -ne
    -notcontains  -notin         -notlike
    -notmatch     -replace       -shl*
    -shr          -split

format-operator:
    -f
```

Description:

`&&` and `||` are reserved for future use.

> [!NOTE]
> Editor's Note: The pipeline chain operators `&&` and `||` were introduced in PowerShell 7. See
> [about_Pipeline_Chain_Operators](/powershell/module/microsoft.powershell.core/about/about_pipeline_chain_operators).

The name following _dash_ in an operator is reserved for that purpose only in an operator context.

An operator that begins with _dash_ must not have any white space between that _dash_ and the token
that follows it.

### 2.3.7 Escaped characters

Syntax:

```Syntax
escaped-character:
    ` (The backtick character U+0060) followed by any Unicode character
```

Description:

An _escaped character_ is a way to assign a special interpretation to a character by giving it a
prefix Backtick character (U+0060). The following table shows the meaning of each
_escaped-character_:

| Escaped Character |                                                           Meaning                                                            |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| `` `a ``          | Alert (U+0007)                                                                                                               |
| `` `b ``          | Backspace (U+0008)                                                                                                           |
| `` `f ``          | Form-feed (U+000C)                                                                                                           |
| `` `n ``          | New-line (U+000A)                                                                                                            |
| `` `r ``          | Carriage return (U+000D)                                                                                                     |
| `` `t ``          | Horizontal tab (U+0009)                                                                                                      |
| `` `v ``          | Vertical tab (U+0009)                                                                                                        |
| `` `' ``          | Single quote (U+0027)                                                                                                        |
| `` `" ``          | Double quote (U+0022)                                                                                                        |
| ` `` `            | Backtick (U+0060)                                                                                                            |
| `` `0 ``          | NUL (U+0000)                                                                                                                 |
| `` `x ``          | If `x` is a character other than those characters shown above, the backtick character is ignored and `x` is taken literally. |

The implication of the final entry in the table above is that spaces that would otherwise separate
tokens can be made part of a token instead. For example, a file name containing a space can be
written as ``Test` Data.txt`` (as well as `'Test Data.txt'` or `"Test Data.txt"`).

<!-- reference links -->
[§2.2.2]: chapter-02.md#222-line-terminators
[§2.2.4]: chapter-02.md#224-white-space
[§2.3.2.1]: chapter-02.md#2321-user-defined-variables
[§2.3.2.2]: chapter-02.md#2322-automatic-variables
[§2.3.2.3]: chapter-02.md#2323-preference-variables
[§2.3.5.1.1]: chapter-02.md#23511-integer-literals
[§2.3.5.1.2]: chapter-02.md#23512-real-literals
[§2.3.5.1.3]: chapter-02.md#23513-multiplier-suffixes
[§2.3.7]: chapter-02.md#237-escaped-characters
[§3.1]: chapter-03.md#31-providers-and-drives
[§3.5]: chapter-03.md#35-scopes
[§4.2.3]: chapter-04.md#423-integer
[§4.2.4.1]: chapter-04.md#4241-float-and-double
[§4.2.4.2]: chapter-04.md#4242-decimal
[§4.3.1]: chapter-04.md#431-strings
[§6.7]: chapter-06.md#67-conversion-to-object
[§6.8]: chapter-06.md#68-conversion-to-string
[§7.1.6]: chapter-07.md#716--operator
[§7.1.7]: chapter-07.md#717--operator
[§7.1.9]: chapter-07.md#719-hash-literal-expression
[§7.2.1]: chapter-07.md#721-unary-comma-operator
[§7.3]: chapter-07.md#73-binary-comma-operator
[§7.4]: chapter-07.md#74-range-operator
[§7.7.2]: chapter-07.md#772-string-concatenation
[§8.10.2]: chapter-08.md#8102-workflow-functions
[§8.10.5]: chapter-08.md#8105-the-switch-type-constraint
[§8.14]: chapter-08.md#814-parameter-binding
[§8.2]: chapter-08.md#82-pipeline-statements
[§B.1]: chapter-15.md#b1-lexical-grammar
[§B.2]: chapter-15.md#b2-syntactic-grammar

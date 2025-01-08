---
description: This appendix contains summaries of the lexical and syntactic grammars found in the main documents.
ms.date: 05/19/2021
title: Appendix A - Grammar
---
# B. Grammar

[!INCLUDE [Disclaimer](../../includes/language-spec.md)]

This appendix contains summaries of the lexical and syntactic grammars found in the main document.

> [!TIP]
> The `~opt~` notation in the syntax definitions indicates that the lexical entity is optional in
> the syntax.

## B.1 Lexical grammar

```Syntax
input:
    input-elements~opt~ signature-block~opt~

input-elements:
    input-element
    input-elements input-element

input-element:
    whitespace
    comment
    token

signature-block:
    signature-begin signature signature-end

signature-begin:
    new-line-character # SIG # Begin signature block new-line-character

signature:
    base64 encoded signature blob in multiple single-line-comments

signature-end:
    new-line-character # SIG # End signature block new-line-character
```

### B.1.1 Line terminators

```Syntax
new-line-character:
    Carriage return character (U+000D)
    Line feed character (U+000A)
    Carriage return character (U+000D) followed by line feed character (U+000A)

new-lines:
    new-line-character
    new-lines new-line-character
```

### B.1.2 Comments

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
    <# delimited-comment-text~opt~ hashes >

delimited-comment-text:
    delimited-comment-section
    delimited-comment-text delimited-comment-section

delimited-comment-section:
    >
    hashes~opt~ not-greater-than-or-hash

hashes:
    #
    hashes #

not-greater-than-or-hash:
    Any Unicode character except > or #
```

### B.1.3 White space

```Syntax
whitespace:
    Any character with Unicode class Zs, Zl, or Zp
    Horizontal tab character (U+0009)
    Vertical tab character (U+000B)
    Form feed character (U+000C)
    ` (The backtick character U+0060) followed by new-line-character
```

### B.1.4 Tokens

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

### B.1.5 Keywords

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

### B.1.6 Variables

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

### B.1.7 Commands

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

### B.1.8 Parameters

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
        { } ( ) ; , | & . [
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

### B.1.9 Literals

```Syntax
literal:
    integer-literal
    real-literal
    string-literal
```

#### B.1.9.1 Integer Literals

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

#### B.1.9.2 Real Literals

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
```

#### B.1.9.3 String Literals

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
    @  double-quote-character whitespace~opt~ new-line-character expandable-here-string-chars~opt~  $(

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

### B.1.10 Simple Names

```Syntax
simple-name:
    simple-name-first-char simple-name-chars

simple-name-first-char:
    A Unicode character of classes Lu, Ll, Lt, Lm, or Lo
    _ (The underscore character U+005F)

simple-name-chars:
    simple-name-char
    simple-name-chars simple-name-char

simple-name-char:
    A Unicode character of classes Lu, Ll, Lt, Lm, Lo, or Nd
    _ (The underscore character U+005F)
```

### B.1.11 Type Names

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

### B.1.12 Operators and punctuators

```Syntax
operator-or-punctuator: one of
    {   }   [   ]   (   )   @(   @{   $(   ;
    &&  ||  &   |   ,   ++  ..   ::   .
    !   *   /   %   +
    dash       dashdash
    dash and   dash band   dash bnot   dash bor
    dash bxor  dash not    dash or     dash xor
    assignment-operator
    merging-redirection-operator
    file-redirection-operator
    comparison-operator
    format-operator

assignment-operator: one of
    =    dash =    +=    *=    /=    %=

file-redirection-operator: one of
    >  >>  2>  2>>  3>  3>>  4>  4>>
    5>  5>>  6>  6>>  *>  *>>  <

merging-redirection-operator: one of
    *>&1  2>&1  3>&1  4>&1  5>&1  6>&1
    *>&2  1>&2  3>&2  4>&2  5>&2  6>&2

comparison-operator: one of
    dash as           dash ccontains      dash ceq
    dash cge          dash cgt            dash cle
    dash clike        dash clt            dash cmatch
    dash cne          dash cnotcontains   dash cnotlike
    dash cnotmatch    dash contains       dash creplace
    dash csplit       dash eq             dash ge
    dash gt           dash icontains      dash ieq
    dash ige          dash igt            dash ile
    dash ilike        dash ilt            dash imatch
    dash in           dash ine            dash inotcontains
    dash inotlike     dash inotmatch      dash ireplace
    dash is           dash isnot          dash isplit
    dash join         dash le             dash like
    dash lt           dash match          dash ne
    dash notcontains  dash notin         dash notlike
    dash notmatch     dash replace       dash shl*
    dash shr          dash split

format-operator:
    dash f
```

## B.2 Syntactic grammar

### B.2.1 Basic concepts

```Syntax
script-file:
    script-block

module-file:
    script-block

interactive-input:
    script-block

data-file:
    statement-list
```

### B.2.2 Statements

```Syntax
script-block:
    param-block~opt~ statement-terminators~opt~ script-block-body~opt~

param-block:
    new-lines~opt~ attribute-list~opt~ new-lines~opt~ param new-lines~opt~
        ( parameter-list~opt~ new-lines~opt~ )

parameter-list:
    script-parameter
    parameter-list new-lines~opt~ , script-parameter

script-parameter:
    new-lines~opt~ attribute-list~opt~ new-lines~opt~ variable script-parameter-default~opt~

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
    dynamicparam begin process end

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

statement-terminators:
    statement-terminator
    statement-terminators statement-terminator

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

labeled-statement:
    switch-statement
    foreach-statement
    for-statement
    while-statement
    do-statement

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

foreach-statement:
    foreach new-lines~opt~ foreach-parameter~opt~ new-lines~opt~
        ( new-lines~opt~ variable new-lines~opt~ in new-lines~opt~ pipeline
        new-lines~opt~ ) statement-block

foreach-parameter:
    -parallel

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

while-statement:
    while new-lines~opt~ ( new-lines~opt~ while-condition new-lines~opt~ ) statement-block

do-statement:
    do statement-block new-lines~opt~ while new-lines~opt~ ( while-condition new-lines~opt~ )
    do statement-block new-lines~opt~ until new-lines~opt~ ( while-condition new-lines~opt~ )

while-condition:
    new-lines~opt~ pipeline

function-statement:
    function new-lines~opt~ function-name function-parameter-declaration~opt~ { script-block }
    filter new-lines~opt~ function-name function-parameter-declaration~opt~ { script-block }
    workflow new-lines~opt~ function-name function-parameter-declaration~opt~ { script-block }

function-name:
    command-argument

function-parameter-declaration:
    new-lines~opt~ ( parameter-list new-lines~opt~ )

flow-control-statement:
    break label-expression~opt~
    continue label-expression~opt~
    throw pipeline~opt~
    return pipeline~opt~
    exit pipeline~opt~

label-expression:
    simple-name
    unary-expression

trap-statement:
    trap new-lines~opt~ type-literal~opt~ new-lines~opt~ statement-block

try-statement:
    try statement-block catch-clauses
    try statement-block finally-clause
    try statement-block catch-clauses finally-clause

catch-clauses:
    catch-clause
    catch-clauses catch-clause

catch-clause:
    new-lines~opt~ catch catch-type-list~opt~ statement-block

catch-type-list:
    new-lines~opt~ type-literal
    catch-type-list new-lines~opt~ , new-lines~opt~ type-literal

finally-clause:
    new-lines~opt~ finally statement-block

data-statement:
    data new-lines~opt~ data-name data-commands-allowed~opt~
    statement-block

data-name:
    simple-name

data-commands-allowed:
    new-lines~opt~ -supportedcommand data-commands-list

data-commands-list:
    new-lines~opt~ data-command
    data-commands-list , new-lines~opt~ data-command

data-command:
    command-name-expr

inlinescript-statement:
    inlinescript statement-block

parallel-statement:
    parallel statement-block

sequence-statement:
    sequence statement-block

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
    generic-token-with-subexpr-start statement-list~opt~ ) command-name

command-name-expr:
    command-name
    primary-expression

command-elements:
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

redirections:
    redirection
    redirections redirection

redirection:
    merging-redirection-operator
    file-redirection-operator redirected-file-name

redirected-file-name:
    command-argument
    primary-expression
```

### B.2.3 Expressions

```Syntax
expression:
    logical-expression

logical-expression:
    bitwise-expression
    logical-expression -and new-lines~opt~ bitwise-expression
    logical-expression -or new-lines~opt~ bitwise-expression
    logical-expression -xor new-lines~opt~ bitwise-expression

bitwise-expression:
    comparison-expression
    bitwise-expression -band new-lines~opt~ comparison-expression
    bitwise-expression -bor new-lines~opt~ comparison-expression
    bitwise-expression -bxor new-lines~opt~ comparison-expression

comparison-expression:
    additive-expression
    comparison-expression comparison-operator new-lines~opt~
    additive-expression

additive-expression:
    multiplicative-expression
    additive-expression + new-lines~opt~ multiplicative-expression
    additive-expression dash new-lines~opt~ multiplicative-expression

multiplicative-expression:
    format-expression
    multiplicative-expression \ new-lines~opt~ format-expression
    multiplicative-expression / new-lines~opt~ format-expression
    multiplicative-expression % new-lines~opt~ format-expression

format-expression:
    range-expression
    format-expression format-operator new-lines~opt~ range-expression

range-expression:
    array-literal-expression
    range-expression .. new-lines~opt~ array-literal-expression

array-literal-expression:
    unary-expression
    unary-expression , new-lines~opt~ array-literal-expression

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

pre-increment-expression:
    ++ new-lines~opt~ unary-expression

pre-decrement-expression:
    dashdash new-lines~opt~ unary-expression

cast-expression:
    type-literal unary-expression

attributed-expression:
    type-literal variable

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

parenthesized-expression:
    ( new-lines~opt~ pipeline new-lines~opt~ )

sub-expression:
    $( new-lines~opt~ statement-list~opt~ new-lines~opt~ )

array-expression:
    @( new-lines~opt~ statement-list~opt~ new-lines~opt~ )

script-block-expression:
    { new-lines~opt~ script-block new-lines~opt~ }

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

post-increment-expression:
    primary-expression ++

post-decrement-expression:
    primary-expression dashdash

member-access: Note no whitespace is allowed after
    primary-expression.
    primary-expression . member-name
    primary-expression :: member-name

element-access: Note no whitespace is allowed between primary-expression and [.
    primary-expression [ new-lines~opt~ expression new-lines~opt~ ]

invocation-expression: Note no whitespace is allowed after
    primary-expression.
    primary-expression . member-name argument-list
    primary-expression :: member-name argument-list

argument-list:
    ( argument-expression-list~opt~ new-lines~opt~ )

argument-expression-list:
    argument-expression
    argument-expression new-lines~opt~ , argument-expression-list

argument-expression:
    new-lines~opt~ logical-argument-expression

logical-argument-expression:
    bitwise-argument-expression
    logical-argument-expression -and new-lines~opt~ bitwise-argument-expression
    logical-argument-expression -or  new-lines~opt~ bitwise-argument-expression
    logical-argument-expression -xor new-lines~opt~ bitwise-argument-expression

bitwise-argument-expression:
    comparison-argument-expression
    bitwise-argument-expression -band new-lines~opt~ comparison-argument-expression
    bitwise-argument-expression -bor  new-lines~opt~ comparison-argument-expression
    bitwise-argument-expression -bxor new-lines~opt~ comparison-argument-expression

comparison-argument-expression:
    additive-argument-expression
    comparison-argument-expression comparison-operator
        new-lines~opt~ additive-argument-expression

additive-argument-expression:
    multiplicative-argument-expression
    additive-argument-expression +    new-lines~opt~ multiplicative-argument-expression
    additive-argument-expression dash new-lines~opt~ multiplicative-argument-expression

multiplicative-argument-expression:
    format-argument-expression
    multiplicative-argument-expression \ new-lines~opt~ format-argument-expression
    multiplicative-argument-expression / new-lines~opt~ format-argument-expression
    multiplicative-argument-expression % new-lines~opt~ format-argument-expression

format-argument-expression:
    range-argument-expression
    format-argument-expression format-operator new-lines~opt~ range-argument-expression

range-argument-expression:
    unary-expression
    range-expression .. new-lines~opt~ unary-expression

member-name:
    simple-name
    string-literal
    string-literal-with-subexpression
    expression-with-unary-operator
    value

string-literal-with-subexpression:
    expandable-string-literal-with-subexpr
    expandable-here-string-literal-with-subexpr

expandable-string-literal-with-subexpr:
    expandable-string-with-subexpr-start statement-list~opt~ )
        expandable-string-with-subexpr-characters expandable-string-with-subexpr-end
    expandable-here-string-with-subexpr-start statement-list~opt~ )
        expandable-here-string-with-subexpr-characters
        expandable-here-string-with-subexpr-end

expandable-string-with-subexpr-characters:
    expandable-string-with-subexpr-part
    expandable-string-with-subexpr-characters expandable-string-with-subexpr-part

expandable-string-with-subexpr-part:
    sub-expression
    expandable-string-part

expandable-here-string-with-subexpr-characters:
    expandable-here-string-with-subexpr-part
    expandable-here-string-with-subexpr-characters expandable-here-string-with-subexpr-part

expandable-here-string-with-subexpr-part:
    sub-expression
    expandable-here-string-part

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
```

### B.2.4 Attributes

```Syntax
attribute-list:
    attribute
    attribute-list new-lines~opt~ attribute

attribute:
    [ new-lines~opt~ attribute-name ( attribute-arguments new-lines~opt~ ) new-lines~opt~ ]
    type-literal

attribute-name:
    type-spec

attribute-arguments:
    attribute-argument
    attribute-argument new-lines~opt~ , attribute-arguments

attribute-argument:
    new-lines~opt~ expression
    new-lines~opt~ simple-name
    new-lines~opt~ simple-name = new-lines~opt~ expression
```

<!-- reference links -->

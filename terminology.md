---
ms.date: 01/05/2026
---
# Terminology and format guidelines

When writing about PowerShell, use the following terminology guidelines to ensure consistency across
documentation. This is a draft document that's subject to change. Eventually, we will move this
content to the PowerShell-Docs style guide.

## Punctuation

For general rules, see [Punctuation - Microsoft Style Guide][01].

For PowerShell-specific terminology, see [PowerShell-Docs style guide][03]

### Hyphenation

See [Hyphens - Microsoft Style Guide][08].

In general, don't include a hyphen after prefixes unless omitting the hyphen could confuse the
reader. See the style guide for specific examples.

- _subexpression_ not _sub-expression_

Hyphenate two or more words that precede and modify a noun.

- dot-source

  Use the _dot-source operator_ to _dot-source_ a script.

- _built-in_ drive
- _high-level-language_ compiler
- _member-access_ operator

## Capitalization and space conventions

For general guidelines, see [Capitalization - Microsoft Style Guide][07]. For PowerShell:

Microsoft product names have specific capitalization requirements that must be followed. See
[Microsoft Product Style Guide][05].

All keywords should be lowercase and backticked in a paragraph. See [about_Language_Keywords][02].
When referring to statements that consist of multiple keywords, use slashes to separate the
keywords rather than spaces or dashes.

- `do/until`
- `do/while`
- `try/catch/finally`
- `if/elseif/else`

Example:

> A `do/until` loop consists of a `do` statement block followed by an `until` statement block
> containing a conditional expression.

Cmdlet names and parameters usually use PascalCase, but verify the correct casing by inspecting the
commands.

### Specific examples

- _filesystem_ - no space
- _filename_ - no space
- _localhost_ - lowercase
- _CIM session_ - refers to the concept of a CIM session
- _CimSession_ - refers to the PowerShell object of type `[CimSession]`
- _PSSnapin_ - refers to an instance of a PowerShell snap-in assembly (such as
  Microsoft.PowerShell.Core)
- _snap-in_ - the general term for a PowerShell snap-in assembly
- _SDDL_ - abbreviation of Security Descriptor Definition Language
- _WSMan_ and _WinRM_
  - _WSMan_ - Microsoft's abbreviation for the WS-Management (Web Services-Management) open standard
  - _WinRM_ - Windows Remote Management - Microsoft's implementation of the WSMan standard
  - Use lowercase instances only where the name is lowercase in the service interfaces (such as
    `winrm` command-line tool, or in schema URIs and other properties).
- Variable scopes and scope modifiers

  See [Appendix A - Grammar - B.1.6 Variables][04]

  Scope names and modifiers are capitalized:

  - `Global:`
  - `Local:`
  - `Private:`
  - `Script:`
  - `Using:`
  - `Workflow:`

## Terms

### Declare vs. initialize

PowerShell has no concept of declaring variables, unless you count using `New-Variable` as a
declaration. Even then, the new variable is given a default value. Essentially, variables are
declared on first use. If the variable was not assigned a value, it is initialized to a default
value depending on its type.

_Initialize_ is the correct term to use when referring to assigning a value to a variable for the
first time.

### Native vs. external commands

Not all external commands are native commands. A PowerShell script can be an _external command_, but
it's not a native command.

_Native commands_ are executables that can be run from any shell or other invocation method
supported by the OS.

### Scalar vs. single vs. singleton

See [Scalar data type - Wikipedia][10].

A scalar data type, or just scalar, is any non-composite value.

Generally, all basic primitive data types are considered scalar:

- The Boolean data type (bool)
- Numeric types (int, the floating point types float and double)
- Character types (char)

The term _single_ should only refer to a single-precision floating point type `[single]`.

A _singleton_ is a single instance of an object that may be scalar or complex.

## Language elements and terms

### Null values

See [null, NULL, Null - Microsoft Style Guide][06].

Use lowercase _null_ to refer to a null value. Better yet, use _null value_ to avoid confusion with
the constant.

Use `$null`, `NULL`, or `Null` (depending on the language context) only to refer to the constant.
Use `DBNull` to refer to the `[System.DBNull]` type.

### Boolean values

Use _FALSE_ or _TRUE_ (all uppercase) to refer to boolean values in general writing. Use `$true` and
`$false` (all lowercase) when referring to the boolean constants.

### Hash tables

- Use _hash table_ (two words, all lowercase) to refer to the computer science concept in general
  writing. See [Hash table - Wikipedia][09].
- Use _hashtable_ (all lowercase) when referring to the PowerShell objects of type `[hashtable]`.
  May be capitalized as _Hashtable_ when it begins a sentence.
- `[hashtable]` (with backticks) when referring to the type more specifically.
- Full type names should match the .NET definition: `[System.Collections.Hashtable]`

### Statements and script blocks

A _script block_ is a generic description we have used historically, but can be a source of
confusion. Use the following terminology instead:

- A _statement block_ to refers to `{}` expressions in a statement. This is how the AST refers to
  them. Statement blocks don't take parameters.
- _scriptblock_ should be used to refer to `{}` expressions of type `[scriptblock]`. For example,
  the **FilterScript** parameter of `Where-Object` expects a scriptblock. Scriptblocks can take
  parameters.

<!-- link references -->
[01]: https://learn.microsoft.com/en-us/style-guide/punctuation/
[02]: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_language_keywords
[03]: https://learn.microsoft.com/powershell/scripting/community/contributing/powershell-style-guide
[04]: https://learn.microsoft.com/powershell/scripting/lang-spec/chapter-15#b16-variables
[05]: https://learn.microsoft.com/product-style-guide-msft-internal/welcome/
[06]: https://learn.microsoft.com/style-guide/a-z-word-list-term-collections/n/null
[07]: https://learn.microsoft.com/style-guide/capitalization
[08]: https://learn.microsoft.com/style-guide/punctuation/dashes-hyphens/hyphens
[09]: https://wikipedia.org/wiki/Hash_table
[10]: https://wikipedia.org/wiki/Scalar_processor#Scalar_data_type

---
ms.date:  12/01/2017
schema:  2.0.0
locale:  en-us
keywords:  powershell,cmdlet
title:  about_Using
---
# About Using

## SHORT DESCRIPTION
Allows to indicate which namespaces are used in the session.

## LONG DESCRIPTION

The `using` statement allows to indicate which namespaces are used in the
session. Making easier to mention classes and members, as it requires less
typing to mention them; also, classes from modules can be referenced too.

The `using` statement needs to be the first statement in the script.

Syntax #1, to reference .Net Framework namespaces:

```
using namespace <.Net-framework-namespace>
```

Syntax #2, to reference PowerShell modules:

```
using module <module-name>
```

**Note**: The `using` statement, for modules, is intended to surface the
classes in the module. If the module isn't loaded, the `using` fails.

## Examples

The following script gets the cryptographic hash for the "Hello World" string.

Note how the `using namespace System.Text` and `using namespace System.IO`
simplify the references to `[UnicodeEncoding]` in *System.Text*; and, to
`[Stream]` and to `[MemoryStream]` in *System.IO*.

```powershell
using namespace System.Text
using namespace System.IO

[string]$string = "Hello World"
## Valid values are "SHA1", "SHA256", "SHA384", "SHA512", "MD5"
[string]$algorithm = "SHA256"

[byte[]]$stringbytes = [UnicodeEncoding]::Unicode.GetBytes($string)

[Stream]$memorystream = [MemoryStream]::new($stringbytes)
$hashfromstream = Get-FileHash -InputStream $memorystream `
  -Algorithm $algorithm
$hashfromstream.Hash.ToString()
```

The following script assumes a module named 'CardGames' was loaded
automatically.

The following classes are defined in the module:

- *Deck*
- *Card*

```powershell
using module CardGames

[Deck]$deck = [Deck]::new()
$deck.Shuffle()
[Card[]]$hand1 = $deck.Deal(5)
[Card[]]$hand2 = $deck.Deal(5)
[Card[]]$hand3 = $deck.Deal(5)
```
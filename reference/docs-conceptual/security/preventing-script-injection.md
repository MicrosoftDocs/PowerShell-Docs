---
description: This article explains how to prevent script injection attacks using single quote escaping.
ms.date: 02/10/2023
title: Preventing script injection attacks
---
# Preventing script injection attacks

PowerShell scripts, like other programming languages, can be vulnerable to injection attacks. An
injection attack occurs when a user provides input to a vulnerable function that includes extra
commands. The vulnerable function runs the extra commands, which can be a serious security
vulnerability. For example, a malicious user could abuse the vulnerable function to run arbitrary
code on a remote computer, possibly compromising that computer and gaining access to other machines
on the network.

Once you are aware of the issue, there are several ways to protect against injection attacks.

## Example of vulnerable code

PowerShell code injection vulnerabilities involve user input that contains script code. The user
input is added to vulnerable script where it's parsed and run by PowerShell.

```powershell
function Get-ProcessById
{
    param ($ProcId)

    Invoke-Expression -Command "Get-Process -Id $ProcId"
}
```

The `Get-ProcessById` function looks up a local process by its Id value. It takes a `$ProcId`
parameter argument of any type. The `$ProcId` is then converted to a string and inserted into
another script that's parsed and run using the `Invoke-Expression` cmdlet. This function works fine
when a valid process Id integer is passed in.

```powershell
Get-ProcessById $pid

 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
     97    50.09     132.72       1.20   12528   3 pwsh
```

However, the `$ProcId` parameter doesn't specify a type. It accepts any arbitrary string value that
can include other commands.

```powershell
Get-ProcessById "$pid; Write-Host 'pwnd!'"
```

In this example, the function correctly retrieved the process identified by `$pid`, but also ran the
injected script `Write-Host 'pwnd!'`.

```Output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
     92    45.66     122.52       1.06   21736   3 pwsh
pwnd!
```

## Ways to guard against injection attacks

The are several ways to guard against an injection attack.

### Use typed input

You can specify a type for the `$ProcId` argument.

```powershell
function Get-ProcessById
{
    param ([int] $ProcId)

    Invoke-Expression -Command "Get-Process -Id $ProcId"
}
Get-ProcessById "$pid; Write-Host 'pwnd!'"
```

```Output
Get-ProcessById:
Line |
   7 |  Get-ProcessById "$pid; Write-Host 'pwnd!'"
     |                  ~~~~~~~~~~~~~~~~~~~~~~~~~
     | Cannot process argument transformation on parameter 'ProcId'. Cannot convert value
"8064; Write-Host 'pwnd!'" to type "System.Int32". Error: "The input string '8064; Write-Host 'pwnd!'
was not in a correct format."
```

Here, the `$ProcId` input parameter is restricted to an integer type, so an error occurs when a
string is passed in that can't be converted to an integer.

### Don't use `Invoke-Expression`

Instead of using `Invoke-Expression`, directly call `Get-Process`, and let PowerShell's parameter
binder validate the input.

```powershell
function Get-ProcessById
{
    param ($ProcId)

    Get-Process -Id $ProcId
}
Get-ProcessById "$pid; Write-Host 'pwnd!'"
```

```Output
Get-Process:
Line |
   5 |      Get-Process -Id $ProcId
     |                      ~~~~~~~
     | Cannot bind parameter 'Id'. Cannot convert value "8064; Write-Host 'pwnd!'" to type
"System.Int32". Error: "The input string '8064; Write-Host 'pwnd!' was not in a correct
format."
```

As a best practice, you should avoid using `Invoke-Expression`, especially when handling user input.
`Invoke-Expression` is dangerous because it parses and runs whatever string content you provide,
making it vulnerable to injection attacks. It's better to rely on PowerShell parameter binding.

### Wrap strings in single quotes

However, there are times when using `Invoke-Expression` is unavoidable and you also need to handle
user string input. You can safely handle user input using single quotes around each string input
variable. The single quote ensures that PowerShell's parser treats the user input as a single string
literal.

```powershell
function Get-ProcessById
{
    param ($ProcId)

    Invoke-Expression -Command "Get-Process -Id '$ProcId'"
}

Get-ProcessById "$pid; Write-Host 'pwnd!'"
```

```Output
Get-Process: Cannot bind parameter 'Id'. Cannot convert value "8064; Write-Host " to type
"System.Int32". Error: "The input string '8064; Write-Host' was not in a correct format."
```

However, this version of the function isn't yet completely safe from injection attacks. A malicious
user can still use single quotes in their input to inject code.

```powershell
Get-ProcessById "$pid'; Write-Host 'pwnd!';'"
```

This example uses single quotes in the user input to force the function to run three separate
statements, one of which is arbitrary code injected by the user.

```Output
 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
     97    46.08     183.10       1.08    2524   3 pwsh
pwnd!
```

#### Use the `EscapeSingleQuotedStringContent()` method

To protect against the user inserting their own single quote characters to exploit the function you
must use the `EscapeSingleQuotedStringContent()` API. This is a static public method of the PowerShell
**System.Management.Automation.Language.CodeGeneration** class. This method makes the user input safe
by escaping any single quotes included in the user input.

```powershell
function Get-ProcessById
{
    param ($ProcId)

    $ProcIdClean = [System.Management.Automation.Language.CodeGeneration]::
        EscapeSingleQuotedStringContent("$ProcId")
    Invoke-Expression -Command "Get-Process -Id '$ProcIdClean'"
}
Get-ProcessById "$pid'; Write-Host 'pwnd!';'"
```

```Output
Get-Process: Cannot bind parameter 'Id'. Cannot convert value "8064'; Write-Host 'pwnd!';'" to type
"System.Int32". Error: "The input string '8064'; Write-Host 'pwnd!';'' was not in a correct format."
```

For more information, see [EscapeSingleQuotedStringContent()][01].

## Detecting vulnerable code with Injection Hunter

**Injection Hunter** is a module written by Lee Holmes that contains PowerShell Script Analyzer
rules for detecting code injection vulnerabilities. Use one of the following commands to install the
module from the PowerShell Gallery:

```powershell
# Use PowerShellGet v2.x
Install-Module InjectionHunter

# Use PowerShellGet v3.x
Install-PSResource InjectionHunter
```

You can use this to automate security analysis during builds, continuous integration processes,
deployments, and other scenarios.

```powershell
$RulePath = (Get-Module -list InjectionHunter).Path
Invoke-ScriptAnalyzer -CustomRulePath $RulePath -Path .\Invoke-Dangerous.ps1
```

```Output
RuleName                            Severity     ScriptName Line  Message
--------                            --------     ---------- ----  -------
InjectionRisk.InvokeExpression      Warning      Invoke-Dan 3     Possible script injection risk via the
                                                 gerous.ps1       Invoke-Expression cmdlet. Untrusted input can cause
                                                                  arbitrary PowerShell expressions to be run.
                                                                  Variables may be used directly for dynamic parameter
                                                                  arguments, splatting can be used for dynamic
                                                                  parameter names, and the invocation operator can be
                                                                  used for dynamic command names. If content escaping
                                                                  is truly needed, PowerShell has several valid quote
                                                                  characters, so  [System.Management.Automation.Languag
                                                                  e.CodeGeneration]::Escape* should be used.
```

For more information, see [PSScriptAnalyzer][02].

<!-- TODO: Add instructions for VS Code once it gets fixed -->

## Related links

- [Lee Holmes' blog post about Injection Hunter][03]
- [Injection Hunter][04]

<!-- link references -->
[01]: /dotnet/api/system.management.automation.language.codegeneration.escapesinglequotedstringcontent
[02]: /powershell/utility-modules/psscriptanalyzer/overview
[03]: https://devblogs.microsoft.com/powershell/powershell-injection-hunter-security-auditing-for-powershell-scripts/
[04]: https://www.powershellgallery.com/packages/InjectionHunter

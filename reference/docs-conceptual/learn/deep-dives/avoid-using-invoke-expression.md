---
description: This article explains why Invoke-Expression should only be used as a last resort.
ms.custom: wiki-migration
ms.date: 11/16/2022
title: Avoid using Invoke-Expression
---
# Avoid using Invoke-Expression

The `Invoke-Expression` cmdlet should only be used as a _last resort_. In most scenarios, safer and
more robust alternatives are available. Forums like Stack Overflow are filled with examples of
`Invoke-Expression` misuse. Also note that **PSScriptAnalyzer** has a rule for this. For more
information, see
[AvoidUsingInvokeExpression](/powershell/utility-modules/psscriptanalyzer/rules/avoidusinginvokeexpression).

Carefully consider the security implications. When a string from an untrusted source such as user
input is passed directly to `Invoke-Expression`, arbitrary commands can be executed. Always consider
a different, more robust and secure solution first.

## Common scenarios

Consider the following usage scenarios:

- **It's simpler to redirect PowerShell to execute something naturally.** For example:

  ```powershell
  Get-Content ./file.ps1 | Invoke-Expression
  ```

  These cases are trivially avoidable. The script or code already exists in file or AST form, so you
  should write a script with parameters and invoke it directly instead of using `Invoke-Expression`
  on a string.

- **Running a script from a trusted source.** For example, running the install script from the
  PowerShell repository:

  ```powershell
  Invoke-WebRequest https://aka.ms/install-powershell.ps1 | Invoke-Expression
  ```

  You should only use this interactively. And, while this does make life simpler, this practice
  should be discouraged.

- **Testing for parsing errors.** The PowerShell team tests for parse errors in the source code
  using `Invoke-Expression` because that's the only way to turn a parse-time error into a runtime
  one.

## Conclusion

Most other scripting languages have a way to evaluate a string as code, and as an interpreted
language, PowerShell must have a way to dynamically run itself. But there's no good reason to use
`Invoke-Expression` in a production environment.

## References

- Stack Overflow discussion -
  [In what scenario was Invoke-Expression designed to be used?](https://stackoverflow.com/a/51252636/45375)
- PowerShell Blog post -
  [Invoke-Expression Considered Harmful](https://devblogs.microsoft.com/powershell/invoke-expression-considered-harmful/)

---
ms.date:  12/12/2018
keywords:  dsc,powershell,configuration,setup
title:  Conditional statements and loops in Configurations
description: This article shows you how you can use conditional statements and loops to make your Configuration more dynamic. Combining conditional statements and loops with parameters and Configuration Data allows you more flexibility and control when compiling your Configuration.
---

# Conditional statements and loops in a Configuration

You can make your [Configuration](configurations.md) more dynamic by using PowerShell flow-control
keywords. This article shows you how you can use conditional statements and loops to make your
`Configuration` more dynamic. Combining conditional statements and loops with
[parameters](add-parameters-to-a-configuration.md) and [Configuration Data](configData.md) allows
you more flexibility and control when compiling your `Configuration`.

Just like a function or a script block, you can use any PowerShell language feature within a
`Configuration`. The statements you use will only be evaluated when you call your `Configuration` to
compile a `.mof` file. The examples below show scenarios to demonstrate concepts. Conditional
statements and loops are more often used with parameters and configuration Data.

In this  example, the **Service** resource block retrieves the current state of a service at
compile time to generate a `.mof` file that maintains its current state.

> [!NOTE]
> Using dynamic Resource blocks will preempt the effectiveness of Intellisense. The PowerShell
> parser cannot determine if the values specified are acceptable until the `Configuration` is
> compiled.

```powershell
Configuration ServiceState
{
    # It is best practice to explicitly import any resources used in your Configurations.
    Import-DSCResource -Name Service -Module PSDesiredStateConfiguration
    Node localhost
    {
        Service Spooler
        {
            Name = "Spooler"
            State = $(Get-Service -Name 'spooler').Status
            StartType = $(Get-Service -Name 'spooler').StartType
        }
    }
}
```

Additionally, you could create a **Service** resource block for every service on the current
machine using a `foreach` loop.

```powershell
Configuration ServiceState
{
    # It is best practice to explicitly import any resources used in your Configurations.
    Import-DSCResource -Name Service -Module PSDesiredStateConfiguration
    Node localhost
    {
        foreach ($service in $(Get-Service))
        {
            Service $service.Name
            {
                Name = $service.Name
                State = $service.Status
                StartType = $service.StartType
            }
        }
    }
}
```

You could also create a `Configuration` only for machines that are online by using an `if`
statement.

```powershell
Configuration ServiceState
{
    # It is best practice to explicitly import any resources used in your Configurations.
    Import-DSCResource -Name Service -Module PSDesiredStateConfiguration

    foreach ($computer in @('Server01', 'Server02', 'Server03'))
    {
        if (Test-Connection -ComputerName $computer)
        {
            Node $computer
            {
                Service "Spooler"
                {
                    Name = "Spooler"
                    State = "Started"
                }
            }
        }
    }
}
```

> [!NOTE]
> The dynamic resource blocks in the above examples reference the current machine. In this instance,
> that would be the machine you are authoring the `Configuration` on, not the target Node.

<!---
Mention Get-DSCConfigurationFromSystem
-->

## Summary

In summary, you can use any PowerShell language feature within a `Configuration`.

This includes things like:

- Custom Objects
- Hashtables
- String manipulation
- Remoting
- WMI and CIM
- ActiveDirectory objects
- and more...

Any PowerShell code defined in a `Configuration` is evaluated at compile time, but you can also
place code in the script containing your `Configuration`. Any code outside of the `Configuration`
block is executed when you import your `Configuration`.

## See also

- [Add parameters to a Configuration](add-parameters-to-a-configuration.md)
- [Separate Configuration data from Configurations](configData.md)

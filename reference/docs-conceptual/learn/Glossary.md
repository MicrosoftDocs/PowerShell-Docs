---
ms.date: 06/11/2020
keywords:  powershell,cmdlet
title:  PowerShell Glossary
description: A glossary of PowerShell-related terminology.
---

# PowerShell Glossary

|            Term             | Definition |
| --------------------------- | ---------- |
| binary module               | A PowerShell module whose root module is a binary module file (.dll). A binary module may or may not include a module manifest. |
| common parameter            | A parameter that is added to all cmdlets, advanced functions, and workflows by the PowerShell engine. |
| dot source                  | In PowerShell, to start a command by typing a dot and a space before the command. Commands that are dot sourced run in the current scope instead of in a new scope. Any variables, aliases, functions, or drives that command creates are created in the current scope and are available to users when the command is completed. |
| dynamic module              | A module that exists only in memory. The New-Module and Import-PSSession cmdlets create dynamic modules. |
| dynamic parameter           | A parameter that is added to a PowerShell cmdlet, function, or script under certain conditions. Cmdlets, functions, providers, and scripts can add dynamic parameters. |
| formatting file             | A PowerShell XML file that has the `.format.ps1xml` extension and that defines how PowerShell displays an object based on its .NET Framework type. |
| global session state        | The session state that contains the data that is accessible to the user of a PowerShell session. |
| host                        | The interface that the PowerShell engine uses to communicate with the user. For example, the host specifies how prompts are handled between PowerShell and the user. |
| host application            | A program that loads the PowerShell engine into its process and uses it to perform operations. |
| input processing method     | A method that a cmdlet can use to process the records it receives as input. The input processing methods include the BeginProcessing method, the ProcessRecord method, the EndProcessing method, and the StopProcessing method. |
| manifest module             | A PowerShell module that has a manifest and whose RootModule key is empty. |
| module                      | A self-contained reusable unit that allows you to partition, organize, and abstract your PowerShell  code. A module can contain cmdlets, providers, functions, variables, and other types of resources that can be imported as a single unit. |
| module manifest             | A PowerShell data file (`.psd1`) that describes the contents of a module and that controls how a module is processed. |
| module session state        | The session state that contains the public and private data of a PowerShell module. The private data in this session state is not available to the user of a PowerShell session. |
| non-terminating error       | An error that does not stop PowerShell from continuing to process the command. |
| noun                        | The word that follows the hyphen in a PowerShell cmdlet name. The noun describes the resources upon which the cmdlet acts. |
| parameter set               | A group of parameters that can be used in the same command to perform a specific action. |
| pipe                        | In PowerShell, to send the results of the preceding command as input to the next command in the pipeline. |
| pipeline                    | A series of commands connected by pipeline operators (&#124;) (ASCII 124). Each pipeline operator sends the results of the preceding command as input to the next command. |
| PowerShell cmdlet           | A single command that participates in the pipeline semantics of PowerShell. This includes binary (C#) cmdlets, advanced script functions, CDXML, and Workflows. |
| PowerShell command          | The elements in a pipeline that cause an action to be carried out. PowerShell commands are either typed at the keyboard or invoked programmatically. |
| PowerShell data file        | A text file that has the `.psd1` filename extension. PowerShell uses data files for various purposes such as storing module manifest data and storing translated strings for script internationalization. |
| PowerShell drive            | A virtual drive that provides direct access to a data store. It can be defined by a PowerShell provider or created at the command line. Drives created at the command line are session-specific drives and are lost when the session is closed. |
| provider                    | A Microsoft .NET Framework-based program that makes the data in a specialized data store available in PowerShell so that you can view and manage it. |
| PSSession                   | A type of PowerShell session that is created, managed, and closed by the user. |
| root module                 | The module specified in the RootModule key in a module manifest. |
| runspace                    | In PowerShell, the operating environment in which each command in a pipeline is executed. |
| script block                | In the PowerShell programming language, a collection of statements or expressions that can be used as a single unit. A script block can accept arguments and return values. |
| script file                 | A file that has the `.ps1` extension and that contains a script that is written in the PowerShell language. |
| script module               | A PowerShell module whose root module is a script module file (`.psm1`). A script module may or may not include a module manifest. |
| script module file          | A file that contains a PowerShell script. The script defines the members that the script module exports. Script module files have the `.psm1` filename extension. |
| shell                       | The command interpreter that is used to pass commands to the operating system. |
| switch parameter            | A parameter that does not take an argument. |
| terminating error           | An error that stops PowerShell from processing the command. |
| transaction                 | An atomic unit of work. The work in a transaction must be completed as a whole; if any part of the transaction fails, the entire transaction fails. |
| types file                  | A PowerShell XML file that has the `.ps1xml` extension and that extends the properties of Microsoft .NET Framework types in PowerShell. |
| verb                        | The word that precedes the hyphen in a PowerShell cmdlet  name. The verb describes the action that the cmdlet performs. |
| Windows PowerShell ISE      | The Integrated Scripting Environment - A Windows PowerShell host application that enables you to run commands and to write, test, and debug scripts in a friendly, syntax-colored, Unicode-compliant environment. |
| Windows PowerShell snap-in  | A resource that defines a set of cmdlets, providers, and Microsoft .NET Framework types that can be added to the Windows PowerShell environment. |
| Windows PowerShell Workflow | A workflow is a sequence of programmed, connected steps that perform long-running tasks or require the coordination of multiple steps across multiple devices or managed nodes. Windows PowerShell Workflow lets IT pros and developers author sequences of multi-device management activities, or single tasks within a workflow, as workflows. Windows PowerShell Workflow lets you adapt and run both PowerShell scripts and XAML files as workflows. |

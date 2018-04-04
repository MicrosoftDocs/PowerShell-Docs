---
ms.date:  06/05/2017
keywords:  powershell,cmdlet
title:  Windows PowerShell Glossary
ms.assetid:  b0f88cbe-cb83-4912-a301-184534cb35c7
---

# Windows PowerShell Glossary


|Term|Definition|
|--------|--------------|
|binary module|A Windows PowerShell module whose root module is a binary module file (.dll). A binary module may or may not include a module manifest.|
|common parameter|A parameter that is added to all cmdlets, advanced functions, and workflows by the Windows PowerShell engine.|
|dot source|In Windows PowerShell, to start a command by typing a dot and a space before the command. Commands that are dot sourced run in the current scope instead of in a new scope. Any variables, aliases, functions, or drives that command creates are created in the current scope and are available to users when the command is completed.|
|dynamic module|A module that exists only in memory. The New-Module and Import-PSSession cmdlets create dynamic modules.|
|dynamic parameter|A parameter that is added to a Windows PowerShell cmdlet, function, or script under certain conditions. Cmdlets, functions, providers, and scripts can add dynamic parameters.|
|formatting file|A Windows PowerShell XML file that has the .format.ps1xml extension and that defines how Windows PowerShell displays an object based on its .NET Framework type.|
|global session state|The session state that contains the data that is accessible to the user of a Windows PowerShell session.|
|host|The interface that the Windows PowerShell engine uses to communicate with the user. For example, the host specifies how prompts are handled between Windows PowerShell and the user.|
|host application|A program that loads the Windows PowerShell engine into its process and uses it to perform operations.|
|input processing method|A method that a cmdlet can use to process the records it receives as input. The input processing methods include the BeginProcessing method, the ProcessRecord method, the EndProcessing method, and the StopProcessing method.|
|manifest module|A Windows PowerShell module that has a manifest and whose RootModule key is empty.|
|module manifest|A Windows PowerShell data file (.psd1) that describes the contents of a module and that controls how a module is processed.|
|module session state|The session state that contains the public and private data of a Windows PowerShell module. The private data in this session state is not available to the user of a Windows PowerShell session.|
|non-terminating error|An error that does not stop Windows PowerShell from continuing to process the command.|
|noun|The word that follows the hyphen in a Windows PowerShell cmdlet name. The noun describes the resources upon which the cmdlet acts.|
|parameter set|A group of parameters that can be used in the same command to perform a specific action.|
|pipe|In Windows PowerShell, to send the results of the preceding command as input to the next command in the pipeline.|
|pipeline|A series of commands connected by pipeline operators (&#124;) (ASCII 124). Each pipeline operator sends the results of the preceding command as input to the next command.|
|PSSession|A type of Windows PowerShell session that is created, managed, and closed by the user.|
|root module|The module specified in the RootModule key in a module manifest.|
|runspace|In Windows PowerShell, the operating environment in which each command in a pipeline is executed.|
|script block|In the Windows PowerShell programming language, a collection of statements or expressions that can be used as a single unit. A script block can accept arguments and return values.|
|script module|A Windows PowerShell module whose root module is a script module file (.psm1). A script module may or may not include a module manifest.|
|script module file|A file that contains a Windows PowerShell script. The script defines the members that the script module exports. Script module files have the .psm1 file name extension.|
|shell|The command interpreter that is used to pass commands to the operating system.|
|switch parameter|A parameter that does not take an argument.|
|terminating error|An error that stops Windows PowerShell from processing the command.|
|transaction|An atomic unit of work. The work in a transaction must be completed as a whole; if any part of the transaction fails, the entire transaction fails.|
|types file|A Windows PowerShell XML file that has the .ps1xml extension and that extends the properties of Microsoft .NET Framework types in Windows PowerShell.|
|verb|The word that precedes the hyphen in a Windows PowerShell cmdlet  name. The verb describes the action that the cmdlet performs.|
|Windows PowerShell|A command-line shell and task-based scripting technology that provides IT administrators comprehensive control and automation of system administration tasks.|
|Windows PowerShell command|The elements in a pipeline that cause an action to be carried out. Windows PowerShell commands are either typed at the keyboard or invoked programmatically.|
|Windows PowerShell data file|A text file that has the .psd1 file name extension. Windows PowerShell uses data files for various purposes such as storing module manifest data and storing translated strings for script internationalization.|
|Windows PowerShell drive|A virtual drive that provides direct access to a data store. It can be defined by a Windows PowerShell provider or created at the command line. Drives created at the command line are session-specific drives and are lost when the session is closed.|
|Windows PowerShell Integrated Scripting Environment (ISE)|A Windows PowerShell host application that enables you to run commands and to write, test, and debug scripts in a friendly, syntax-colored, Unicode-compliant environment.|
|Windows PowerShell module|A self-contained reusable unit that allows you to partition, organize, and abstract your Windows PowerShell  code. A module can contain cmdlets, providers, functions, variables, and other types of resources that can be imported as a single unit.|
|Windows PowerShell provider|A Microsoft .NET Framework-based program that makes the data in a specialized data store available in Windows PowerShell so that you can view and manage it.|
|Windows PowerShell script|A script that is written in the Windows PowerShell language.|
|Windows PowerShell script file|A file that has the .ps1 extension and that contains a script that is written in the Windows PowerShell language.|
|Windows PowerShell snap-in|A resource that defines a set of cmdlets, providers, and Microsoft .NET Framework types that can be added to the Windows PowerShell environment.|
|Windows PowerShell Workflow|A workflow is a sequence of programmed, connected steps that perform long-running tasks or require the coordination of multiple steps across multiple devices or managed nodes. Windows PowerShell Workflow lets IT pros and developers author sequences of multi-device management activities, or single tasks within a workflow, as workflows. Windows PowerShell Workflow lets you adapt and run both Windows PowerShell scripts and XAML files as workflows.|
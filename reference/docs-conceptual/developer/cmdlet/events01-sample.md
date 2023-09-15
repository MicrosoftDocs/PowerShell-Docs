---
description: Events01 Sample
ms.date: 09/13/2016
ms.topic: reference
title: Events01 Sample
---
# Events01 Sample

This sample shows how to create a cmdlet that allows the user to register for events that are raised
by [System.IO.FileSystemWatcher](/dotnet/api/System.IO.FileSystemWatcher). With this cmdlet, users
can register an action to execute when a file is created under a specific directory. This sample
derives from the [Microsoft.PowerShell.Commands.ObjectEventRegistrationBase][1] base class.

## How to build the sample by using Visual Studio

1. With the Windows PowerShell 2.0 SDK installed, navigate to the Events01 folder. The default
   location is
   `C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0\Samples\sysmgmt\WindowsPowerShell\csharp\Events01`.

1. Double-click the icon for the solution (.sln) file. This opens the sample project in Microsoft
   Visual Studio.

1. In the **Build** menu, select **Build Solution** to build the library for the sample in the
   default `\bin` or `\bin\debug` folders.

## How to run the sample

1. Create the following module folder:

    `[user]\Documents\WindowsPowerShell\Modules\events01`

1. Copy the library file for the sample to the module folder.

1. Start Windows PowerShell.

1. Run the following command to load the cmdlet into Windows PowerShell:

    ```powershell
    Import-Module events01
    ```

1. Use the Register-FileSystemEvent cmdlet to register an action that will write a message when a
   file is created under the TEMP directory.

    ```powershell
    Register-FileSystemEvent $env:temp Created -filter "*.txt" -action { Write-Host "A file was created in the TEMP directory" }
    ```

1. Create a file under the TEMP directory and note that the action is executed (the message is
   displayed).

This is a sample output that results by following these steps.

```output
Id              Name            State      HasMoreData     Location             Command
--              ----            -----      -----------     --------             -------
1               26932870-d3b... NotStarted False                                 Write-Host "A f...

```

```powershell
Set-Content $env:temp\test.txt "This is a test file"
```

```output
A file was created in the TEMP directory
```

## Requirements

This sample requires Windows PowerShell 2.0.

## Demonstrates

This sample demonstrates the following.

### How to write a cmdlet for event registration

The cmdlet derives from the [Microsoft.PowerShell.Commands.ObjectEventRegistrationBase][1] class,
which provides support for parameters common to the `Register-*Event` cmdlets. Cmdlets that are
derived from [Microsoft.PowerShell.Commands.ObjectEventRegistrationBase][1] need only to define
their particular parameters and override the `GetSourceObject` and `GetSourceObjectEventName`
abstract methods.

## Example

This sample shows how to register for events raised by
[System.IO.FileSystemWatcher](/dotnet/api/System.IO.FileSystemWatcher).

```csharp
namespace Sample
{
    using System;
    using System.IO;
    using System.Management.Automation;
    using System.Management.Automation.Runspaces;
    using Microsoft.PowerShell.Commands;

    [Cmdlet(VerbsLifecycle.Register, "FileSystemEvent")]
    public class RegisterObjectEventCommand : ObjectEventRegistrationBase
    {
        /// <summary>The FileSystemWatcher that exposes the events.</summary>
        private FileSystemWatcher fileSystemWatcher = new FileSystemWatcher();

        /// <summary>Name of the event to which the cmdlet registers.</summary>
        private string eventName = null;

        /// <summary>
        /// Gets or sets the path that will be monitored by the FileSystemWatcher.
        /// </summary>
        [Parameter(Mandatory = true, Position = 0)]
        public string Path
        {
            get
            {
                return this.fileSystemWatcher.Path;
            }

            set
            {
                this.fileSystemWatcher.Path = value;
            }
        }

        /// <summary>
        /// Gets or sets the name of the event to which the cmdlet registers.
        /// <para>
        /// Currently System.IO.FileSystemWatcher exposes 6 events: Changed, Created,
        /// Deleted, Disposed, Error, and Renamed. Check the documentation of
        /// FileSystemWatcher for details on each event.
        /// </para>
        /// </summary>
        [Parameter(Mandatory = true, Position = 1)]
        public string EventName
        {
            get
            {
                return this.eventName;
            }

            set
            {
                this.eventName = value;
            }
        }

        /// <summary>
        /// Gets or sets the filter that will be user by the FileSystemWatcher.
        /// </summary>
        [Parameter(Mandatory = false)]
        public string Filter
        {
            get
            {
                return this.fileSystemWatcher.Filter;
            }

            set
            {
                this.fileSystemWatcher.Filter = value;
            }
        }

        /// <summary>
        /// Derived classes must implement this method to return the object that generates
        /// the events to be monitored.
        /// </summary>
        /// <returns> This sample returns an instance of System.IO.FileSystemWatcher</returns>
        protected override object GetSourceObject()
        {
            return this.fileSystemWatcher;
        }

        /// <summary>
        /// Derived classes must implement this method to return the name of the event to
        /// be monitored. This event must be exposed by the input object.
        /// </summary>
        /// <returns> This sample returns the event specified by the user with the -EventName parameter.</returns>
        protected override string GetSourceObjectEventName()
        {
            return this.eventName;
        }
    }
}
```

## See Also

- [Writing a Windows PowerShell Cmdlet](writing-a-windows-powershell-cmdlet.md)

[1]: /dotnet/api/Microsoft.PowerShell.Commands.ObjectEventRegistrationBase

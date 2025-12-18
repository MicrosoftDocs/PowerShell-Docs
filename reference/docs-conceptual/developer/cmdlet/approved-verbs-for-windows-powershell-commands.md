---
description: Approved Verbs for PowerShell Commands
ms.date: 12/18/2025
title: Approved Verbs for PowerShell Commands
---
# Approved Verbs for PowerShell Commands

PowerShell uses a verb-noun pair for the names of cmdlets and for their derived .NET classes.
The verb part of the name identifies the action that the cmdlet performs. The noun part of
the name identifies the entity on which the action is performed. For example, the `Get-Command`
cmdlet retrieves all the commands that are registered in PowerShell.

> [!NOTE]
> PowerShell uses the term _verb_ to describe a word that implies an action even if that word isn't
> a standard verb in the English language. For example, the term `New` is a valid PowerShell verb
> name because it implies an action even though it isn't a verb in the English language.

Each approved verb has a corresponding _alias prefix_ defined. We use this alias prefix in aliases
for commands using that verb. For example, the alias prefix for `Import` is `ip` and, accordingly,
the alias for `Import-Module` is `ipmo`. This is a recommendation but not a rule; in particular, it
need not be respected for command aliases mimicking well known commands from other environments.

## Verb Naming Recommendations

The following recommendations help you choose an appropriate verb for your cmdlet, to ensure
consistency between the cmdlets that you create, the cmdlets that are provided by PowerShell, and
the cmdlets that are designed by others.

- Use one of the predefined verb names provided by PowerShell
- Use the verb to describe the general scope of the action, and use parameters to further refine the
  action of the cmdlet.
- Don't use a synonym of an approved verb. For example, always use `Remove`, never use `Delete` or
  `Eliminate`.
- Use only the form of each verb that's listed in this topic. For example, use `Get`, but don't
  use `Getting` or `Gets`.
- Don't use the following reserved verbs or aliases. The PowerShell language and a rare few cmdlets
  use these verbs under exceptional circumstances.
  - `ForEach` (`foreach`)
  - `Ping` (`pi`)
  - `Sort` (`sr`)
  - `Tee` (`te`)
  - `Where` (`wh`)

You may get a complete list of verbs using the `Get-Verb` cmdlet.

## Similar Verbs for Different Actions

The following similar verbs represent different actions.

### `New` vs. `Add`

Use the `New` verb to create a new resource. Use the `Add` to add something to an existing container
or resource. For example, `Add-Content` adds output to an existing file.

### `New` vs. `Set`

Use the `New` verb to create a new resource. Use the `Set` verb to modify an existing resource,
optionally creating it if it doesn't exist, such as the `Set-Variable` cmdlet.

### `Find` vs. `Search`

Use the `Find` verb to look for an object. Use the `Search` verb to create a reference to a resource
in a container.

### `Get` vs. `Read`

Use the `Get` verb to obtain information about a resource (such as a file) or to obtain an object
with which you can access the resource in future. Use the `Read` verb to open a resource and extract
information contained within.

### `Invoke` vs. `Start`

Use the `Invoke` verb to perform synchronous operations, such as running a command and waiting for
it to end. Use the `Start` verb to begin asynchronous operations, such as starting an autonomous
process.

### `Ping` vs. `Test`

Use the `Test` verb.

## Common Verbs

PowerShell uses the [System.Management.Automation.VerbsCommon][03] enumeration class to define
generic actions that can apply to almost any cmdlet. The following table lists most of the defined
verbs.

|      Verb (alias)       |                                                                                                                             Action                                                                                                                             |                            Synonyms to avoid                             |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| [`Add`][04] (`a`)       | Adds a resource to a container, or attaches an item to another item. For example, the `Add-Content` cmdlet adds content to a file. This verb is paired with `Remove`.                                                                                          | Append, Attach, Concatenate, Insert                                      |
| [`Clear`][05] (`cl`)    | Removes all the resources from a container but doesn't delete the container. For example, the `Clear-Content` cmdlet removes the contents of a file but doesn't delete the file.                                                                               | Flush, Erase, Release, Unmark, Unset, Nullify                            |
| [`Close`][06] (`cs`)    | Changes the state of a resource to make it inaccessible, unavailable, or unusable. This verb is paired with `Open.`                                                                                                                                            |                                                                          |
| [`Copy`][07] (`cp`)     | Copies a resource to another name or to another container. For example, the `Copy-Item` cmdlet copies an item (such as a file) from one location in the data store to another location.                                                                        | Duplicate, Clone, Replicate, Sync                                        |
| [`Enter`][08] (`et`)    | Specifies an action that allows the user to move into a resource. For example, the `Enter-PSSession` cmdlet places the user in an interactive session. This verb is paired with `Exit`.                                                                        | Push, Into                                                               |
| [`Exit`][09] (`ex`)     | Sets the current environment or context to the most recently used context. For example, the `Exit-PSSession` cmdlet places the user in the session that was used to start the interactive session. This verb is paired with `Enter`.                           | Pop, Out                                                                 |
| [`Find`][10] (`fd`)     | Looks for an object in a container that's unknown, implied, optional, or specified.                                                                                                                                                                            | Search                                                                   |
| [`Format`][11] (`f`)    | Arranges objects in a specified form or layout                                                                                                                                                                                                                 |                                                                          |
| [`Get`][12] (`g`)       | Specifies an action that retrieves a resource. This verb is paired with `Set`.                                                                                                                                                                                 | Read, Open, Cat, Type, Dir, Obtain, Dump, Acquire, Examine, Find, Search |
| [`Hide`][13] (`h`)      | Makes a resource undetectable. For example, a cmdlet whose name includes the Hide verb might conceal a service from a user. This verb is paired with `Show`.                                                                                                   | Block                                                                    |
| [`Join`][14] (`j`)      | Combines resources into one resource. For example, the `Join-Path` cmdlet combines a path with one of its child paths to create a single path. This verb is paired with `Split`.                                                                               | Combine, Unite, Connect, Associate                                       |
| [`Lock`][15] (`lk`)     | Secures a resource. This verb is paired with `Unlock`.                                                                                                                                                                                                         | Restrict, Secure                                                         |
| [`Move`][16] (`m`)      | Moves a resource from one location to another. For example, the `Move-Item` cmdlet moves an item from one location in the data store to another location.                                                                                                      | Transfer, Name, Migrate                                                  |
| [`New`][17] (`n`)       | Creates a resource. (The `Set` verb can also be used when creating a resource that includes data, such as the `Set-Variable` cmdlet.)                                                                                                                          | Create, Generate, Build, Make, Allocate                                  |
| [`Open`][18] (`op`)     | Changes the state of a resource to make it accessible, available, or usable. This verb is paired with `Close`.                                                                                                                                                 |                                                                          |
| [`Optimize`][19] (`om`) | Increases the effectiveness of a resource.                                                                                                                                                                                                                     |                                                                          |
| [`Pop`][20] (`pop`)     | Removes an item from the top of a stack. For example, the `Pop-Location` cmdlet changes the current location to the location that was most recently pushed onto the stack.                                                                                     |                                                                          |
| [`Push`][21] (`pu`)     | Adds an item to the top of a stack. For example, the `Push-Location` cmdlet pushes the current location onto the stack.                                                                                                                                        |                                                                          |
| [`Redo`][22] (`re`)     | Resets a resource to the state that was undone.                                                                                                                                                                                                                |                                                                          |
| [`Remove`][23] (`r`)    | Deletes a resource from a container. For example, the `Remove-Variable` cmdlet deletes a variable and its value. This verb is paired with `Add`.                                                                                                               | Clear, Cut, Dispose, Discard, Erase                                      |
| [`Rename`][24] (`rn`)   | Changes the name of a resource. For example, the `Rename-Item` cmdlet, which is used to access stored data, changes the name of an item in the data store.                                                                                                     | Change                                                                   |
| [`Reset`][25] (`rs`)    | Sets a resource back to its original state.                                                                                                                                                                                                                    |                                                                          |
| [`Resize`][26] (`rz`)    | Changes the size of a resource.                                                                                                                                                                                                                                |                                                                          |
| [`Search`][27] (`sr`)   | Creates a reference to a resource in a container.                                                                                                                                                                                                              | Find, Locate                                                             |
| [`Select`][28] (`sc`)   | Locates a resource in a container. For example, the `Select-String` cmdlet finds text in strings and files.                                                                                                                                                    | Find, Locate                                                             |
| [`Set`][29] (`s`)       | Replaces data on an existing resource or creates a resource that contains some data. For example, the `Set-Date` cmdlet changes the system time on the local computer. (The `New` verb can also be used to create a resource.) This verb is paired with `Get`. | Write, Reset, Assign, Configure, Update                                  |
| [`Show`][30] (`sh`)     | Makes a resource visible to the user. This verb is paired with `Hide`.                                                                                                                                                                                         | Display, Produce                                                         |
| [`Skip`][31] (`sk`)     | Bypasses one or more resources or points in a sequence.                                                                                                                                                                                                        | Bypass, Jump                                                             |
| [`Split`][32] (`sl`)    | Separates parts of a resource. For example, the `Split-Path` cmdlet returns different parts of a path. This verb is paired with `Join`.                                                                                                                        | Separate                                                                 |
| [`Step`][33] (`st`)     | Moves to the next point or resource in a sequence.                                                                                                                                                                                                             |                                                                          |
| [`Switch`][34] (`sw`)   | Specifies an action that alternates between two resources, such as to change between two locations, responsibilities, or states.                                                                                                                               |                                                                          |
| [`Undo`][35] (`un`)     | Sets a resource to its previous state.                                                                                                                                                                                                                         |                                                                          |
| [`Unlock`][36] (`uk`)   | Releases a resource that was locked. This verb is paired with `Lock`.                                                                                                                                                                                          | Release, Unrestrict, Unsecure                                            |
| [`Watch`][37] (`wc`)    | Continually inspects or monitors a resource for changes.                                                                                                                                                                                                       |                                                                          |

## Communications Verbs

PowerShell uses the [System.Management.Automation.VerbsCommunications][38] class to define actions
that apply to communications. The following table lists most of the defined verbs.

|       Verb (alias)        |                                          Action                                           |     Synonyms to avoid     |
| ------------------------- | ----------------------------------------------------------------------------------------- | ------------------------- |
| [`Connect`][39] (`cc`)    | Creates a link between a source and a destination. This verb is paired with `Disconnect`. | Join, Telnet, Login       |
| [`Disconnect`][40] (`dc`) | Breaks the link between a source and a destination. This verb is paired with `Connect`.   | Break, Logoff             |
| [`Read`][41] (`rd`)       | Acquires information from a source. This verb is paired with `Write`.                     | Acquire, Prompt, Get      |
| [`Receive`][42] (`rc`)    | Accepts information sent from a source. This verb is paired with `Send`.                  | Read, Accept, Peek        |
| [`Send`][43] (`sd`)       | Delivers information to a destination. This verb is paired with `Receive`.                | Put, Broadcast, Mail, Fax |
| [`Write`][44] (`wr`)      | Adds information to a target. This verb is paired with `Read`.                            | Put, Print                |

## Data Verbs

PowerShell uses the
[System.Management.Automation.VerbsData][45] class
to define actions that apply to data handling. The following table lists most of the defined verbs.

|     Verb Name (alias)      |                                                                                                                                              Action                                                                                                                                              |                Synonyms to avoid                 |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------ |
| [`Backup`][46] (`ba`)      | Stores data by replicating it.                                                                                                                                                                                                                                                                   | Save, Burn, Replicate, Sync                      |
| [`Checkpoint`][47] (`ch`)  | Creates a snapshot of the current state of the data or of its configuration.                                                                                                                                                                                                                     | Diff                                             |
| [`Compare`][48] (`cr`)     | Evaluates the data from one resource against the data from another resource.                                                                                                                                                                                                                     | Diff                                             |
| [`Compress`][49] (`cm`)    | Compacts the data of a resource. Pairs with `Expand`.                                                                                                                                                                                                                                            | Compact                                          |
| [`Convert`][50] (`cv`)     | Changes the data from one representation to another when the cmdlet supports bidirectional conversion or when the cmdlet supports conversion between multiple data types.                                                                                                                        | Change, Resize, Resample                         |
| [`ConvertFrom`][51] (`cf`) | Converts one primary type of input (the cmdlet noun indicates the input) to one or more supported output types.                                                                                                                                                                                  | Export, Output, Out                              |
| [`ConvertTo`][52] (`ct`)   | Converts from one or more types of input to a primary output type (the cmdlet noun indicates the output type).                                                                                                                                                                                   | Import, Input, In                                |
| [`Dismount`][53] (`dm`)    | Detaches a named entity from a location. This verb is paired with `Mount`.                                                                                                                                                                                                                       | Unmount, Unlink                                  |
| [`Edit`][54] (`ed`)        | Modifies existing data by adding or removing content.                                                                                                                                                                                                                                            | Change, Update, Modify                           |
| [`Expand`][55] (`en`)      | Restores the data of a resource that has been compressed to its original state. This verb is paired with `Compress`.                                                                                                                                                                             | Explode, Uncompress                              |
| [`Export`][56] (`ep`)      | Encapsulates the primary input into a persistent data store, such as a file, or into an interchange format. This verb is paired with `Import`.                                                                                                                                                   | Extract, Backup                                  |
| [`Group`][57] (`gp`)       | Arranges or associates one or more resources                                                                                                                                                                                                                                                     |                                                  |
| [`Import`][58] (`ip`)      | Creates a resource from data that's stored in a persistent data store (such as a file) or in an interchange format. For example, the `Import-Csv` cmdlet imports data from a comma-separated value (`CSV`) file to objects that can be used by other cmdlets. This verb is paired with `Export`. | BulkLoad, Load                                   |
| [`Initialize`][59] (`in`)  | Prepares a resource for use, and sets it to a default state.                                                                                                                                                                                                                                     | Erase, Init, Renew, Rebuild, Reinitialize, Setup |
| [`Limit`][60] (`l`)        | Applies constraints to a resource.                                                                                                                                                                                                                                                               | Quota                                            |
| [`Merge`][61] (`mg`)       | Creates a single resource from multiple resources.                                                                                                                                                                                                                                               | Combine, Join                                    |
| [`Mount`][62] (`mt`)       | Attaches a named entity to a location. This verb is paired with `Dismount`.                                                                                                                                                                                                                      | Connect                                          |
| [`Out`][63] (`o`)          | Sends data out of the environment. For example, the `Out-Printer` cmdlet sends data to a printer.                                                                                                                                                                                                |                                                  |
| [`Publish`][64] (`pb`)     | Makes a resource available to others. This verb is paired with `Unpublish`.                                                                                                                                                                                                                      | Deploy, Release, Install                         |
| [`Restore`][65] (`rr`)     | Sets a resource to a predefined state, such as a state set by `Checkpoint`. For example, the `Restore-Computer` cmdlet starts a system restore on the local computer.                                                                                                                            | Repair, Return, Undo, Fix                        |
| [`Save`][66] (`sv`)        | Preserves data to avoid loss.                                                                                                                                                                                                                                                                    |                                                  |
| [`Sync`][67] (`sy`)        | Assures that two or more resources are in the same state.                                                                                                                                                                                                                                        | Replicate, Coerce, Match                         |
| [`Unpublish`][68] (`ub`)   | Makes a resource unavailable to others. This verb is paired with `Publish`.                                                                                                                                                                                                                      | Uninstall, Revert, Hide                          |
| [`Update`][69] (`ud`)      | Brings a resource up-to-date to maintain its state, accuracy, conformance, or compliance. For example, the `Update-FormatData` cmdlet updates and adds formatting files to the current PowerShell console.                                                                                       | Refresh, Renew, Recalculate, Re-index            |

## Diagnostic Verbs

PowerShell uses the
[System.Management.Automation.VerbsDiagnostic][70]
class to define actions that apply to diagnostics. The following table lists most of the defined
verbs.

|      Verb (alias)      |                                                   Action                                                   |         Synonyms to avoid          |
| ---------------------- | ---------------------------------------------------------------------------------------------------------- | ---------------------------------- |
| [`Debug`][71] (`db`)   | Examines a resource to diagnose operational problems.                                                      | Diagnose                           |
| [`Measure`][72] (`ms`) | Identifies resources that are consumed by a specified operation, or retrieves statistics about a resource. | Calculate, Determine, Analyze      |
| [`Ping`][73] (`pi`)    | Deprecated - Use the Test verb instead.                                                                    |                                    |
| [`Repair`][74] (`rp`)  | Restores a resource to a usable condition                                                                  | Fix, Restore                       |
| [`Resolve`][75] (`rv`) | Maps a shorthand representation of a resource to a more complete representation.                           | Expand, Determine                  |
| [`Test`][76] (`t`)     | Verifies the operation or consistency of a resource.                                                       | Diagnose, Analyze, Salvage, Verify |
| [`Trace`][77] (`tr`)   | Tracks the activities of a resource.                                                                       | Track, Follow, Inspect, Dig        |

## Lifecycle Verbs

PowerShell uses the
[System.Management.Automation.VerbsLifecycle][78]
class to define actions that apply to the lifecycle of a resource. The following table lists most of
the defined verbs.

|        Verb (alias)        |                                                                                              Action                                                                                              |               Synonyms to avoid               |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------- |
| [`Approve`][79] (`ap`)     | Confirms or agrees to the status of a resource or process.                                                                                                                                       |                                               |
| [`Assert`][80] (`as`)      | Affirms the state of a resource.                                                                                                                                                                 | Certify                                       |
| [`Build`][81] (`bd`)       | Creates an artifact (usually a binary or document) out of some set of input files (usually source code or declarative documents.) This verb was added in PowerShell 6.                           |                                               |
| [`Complete`][82] (`cp`)    | Concludes an operation.                                                                                                                                                                          |                                               |
| [`Confirm`][83] (`cn`)     | Acknowledges, verifies, or validates the state of a resource or process.                                                                                                                         | Acknowledge, Agree, Certify, Validate, Verify |
| [`Deny`][84] (`dn`)        | Refuses, objects, blocks, or opposes the state of a resource or process.                                                                                                                         | Block, Object, Refuse, Reject                 |
| [`Deploy`][85] (`dp`)      | Sends an application, website, or solution to a remote target[s] in such a way that a consumer of that solution can access it after deployment is complete. This verb was added in PowerShell 6. |                                               |
| [`Disable`][86] (`d`)      | Configures a resource to an unavailable or inactive state. For example, the `Disable-PSBreakpoint` cmdlet makes a breakpoint inactive. This verb is paired with `Enable`.                        | Halt, Hide                                    |
| [`Enable`][87] (`e`)       | Configures a resource to an available or active state. For example, the `Enable-PSBreakpoint` cmdlet makes a breakpoint active. This verb is paired with `Disable`.                              | Start, Begin                                  |
| [`Install`][88] (`is`)     | Places a resource in a location, and optionally initializes it. This verb is paired with `Uninstall`.                                                                                            | Setup                                         |
| [`Invoke`][89] (`i`)       | Performs an action, such as running a command or a method.                                                                                                                                       | Run, Start                                    |
| [`Register`][90] (`rg`)    | Creates an entry for a resource in a repository such as a database. This verb is paired with `Unregister`.                                                                                       |                                               |
| [`Request`][91] (`rq`)     | Asks for a resource or asks for permissions.                                                                                                                                                     |                                               |
| [`Restart`][92] (`rt`)     | Stops an operation and then starts it again. For example, the `Restart-Service` cmdlet stops and then starts a service.                                                                          | Recycle                                       |
| [`Resume`][93] (`ru`)      | Starts an operation that has been suspended. For example, the `Resume-Service` cmdlet starts a service that has been suspended. This verb is paired with `Suspend`.                              |                                               |
| [`Start`][94] (`sa`)       | Initiates an operation. For example, the `Start-Service` cmdlet starts a service. This verb is paired with `Stop`.                                                                               | Launch, Initiate, Boot                        |
| [`Stop`][95] (`sp`)        | Discontinues an activity. This verb is paired with `Start`.                                                                                                                                      | End, Kill, Terminate, Cancel                  |
| [`Submit`][96] (`sb`)      | Presents a resource for approval.                                                                                                                                                                | Post                                          |
| [`Suspend`][97] (`ss`)     | Pauses an activity. For example, the `Suspend-Service` cmdlet pauses a service. This verb is paired with `Resume`.                                                                               | Pause                                         |
| [`Uninstall`][98] (`us`)   | Removes a resource from an indicated location. This verb is paired with `Install`.                                                                                                               |                                               |
| [`Unregister`][99] (`ur`) | Removes the entry for a resource from a repository. This verb is paired with `Register`.                                                                                                         | Remove                                        |
| [`Wait`][100] (`w`)        | Pauses an operation until a specified event occurs. For example, the `Wait-Job` cmdlet pauses operations until one or more of the background jobs are complete.                                  | Sleep, Pause                                  |

## Security Verbs

PowerShell uses the
[System.Management.Automation.VerbsSecurity][103]
class to define actions that apply to security. The following table lists most of the defined verbs.

|       Verb (alias)        |                                                          Action                                                           |    Synonyms to avoid     |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| [`Block`][104] (`bl`)     | Restricts access to a resource. This verb is paired with `Unblock`.                                                       | Prevent, Limit, Deny     |
| [`Grant`][105] (`gr`)     | Allows access to a resource. This verb is paired with `Revoke`.                                                           | Allow, Enable            |
| [`Protect`][106] (`pt`)   | Safeguards a resource from attack or loss. This verb is paired with `Unprotect`.                                          | Encrypt, Safeguard, Seal |
| [`Revoke`][107] (`rk`)    | Specifies an action that doesn't allow access to a resource. This verb is paired with `Grant`.                            | Remove, Disable          |
| [`Unblock`][108] (`ul`)   | Removes restrictions to a resource. This verb is paired with `Block`.                                                     | Clear, Allow             |
| [`Unprotect`][109] (`up`) | Removes safeguards from a resource that were added to prevent it from attack or loss. This verb is paired with `Protect`. | Decrypt, Unseal          |

## Other Verbs

PowerShell uses the [System.Management.Automation.VerbsOther][101] class to define canonical verb
names that don't fit into a specific verb name category such as the common, communications, data,
lifecycle, or security verb names verbs.

|    Verb (alias)    |                    Action                    | Synonyms to avoid |
| ------------------ | -------------------------------------------- | ----------------- |
| [`Use`][102] (`u`) | Uses or includes a resource to do something. |                   |

## See Also

- [System.Management.Automation.VerbsCommon][03]
- [System.Management.Automation.VerbsCommunications][38]
- [System.Management.Automation.VerbsData][45]
- [System.Management.Automation.VerbsDiagnostic][70]
- [System.Management.Automation.VerbsLifecycle][78]
- [System.Management.Automation.VerbsSecurity][103]
- [System.Management.Automation.VerbsOther][101]
- [Cmdlet Declaration][02]
- [Windows PowerShell Shell SDK][01]

<!-- link references -->
[01]: ../windows-powershell-reference.md
[02]: ./cmdlet-class-declaration.md
[03]: xref:System.Management.Automation.VerbsCommon
[04]: xref:System.Management.Automation.VerbsCommon.Add%2A
[05]: xref:System.Management.Automation.VerbsCommon.Clear%2A
[06]: xref:System.Management.Automation.VerbsCommon.Close%2A
[07]: xref:System.Management.Automation.VerbsCommon.Copy%2A
[08]: xref:System.Management.Automation.VerbsCommon.Enter%2A
[09]: xref:System.Management.Automation.VerbsCommon.Exit%2A
[10]: xref:System.Management.Automation.VerbsCommon.Find%2A
[11]: xref:System.Management.Automation.VerbsCommon.Format%2A
[12]: xref:System.Management.Automation.VerbsCommon.Get%2A
[13]: xref:System.Management.Automation.VerbsCommon.Hide%2A
[14]: xref:System.Management.Automation.VerbsCommon.Join%2A
[15]: xref:System.Management.Automation.VerbsCommon.Lock%2A
[16]: xref:System.Management.Automation.VerbsCommon.Move%2A
[17]: xref:System.Management.Automation.VerbsCommon.New%2A
[18]: xref:System.Management.Automation.VerbsCommon.Open%2A
[19]: xref:System.Management.Automation.VerbsCommon.Optimize%2A
[20]: xref:System.Management.Automation.VerbsCommon.Pop%2A
[21]: xref:System.Management.Automation.VerbsCommon.Push%2A
[22]: xref:System.Management.Automation.VerbsCommon.Redo%2A
[23]: xref:System.Management.Automation.VerbsCommon.Remove%2A
[24]: xref:System.Management.Automation.VerbsCommon.Rename%2A
[25]: xref:System.Management.Automation.VerbsCommon.Reset%2A
[26]: xref:System.Management.Automation.VerbsCommon.Resize%2A
[27]: xref:System.Management.Automation.VerbsCommon.Search%2A
[28]: xref:System.Management.Automation.VerbsCommon.Select%2A
[29]: xref:System.Management.Automation.VerbsCommon.Set%2A
[30]: xref:System.Management.Automation.VerbsCommon.Show%2A
[31]: xref:System.Management.Automation.VerbsCommon.Skip%2A
[32]: xref:System.Management.Automation.VerbsCommon.Split%2A
[33]: xref:System.Management.Automation.VerbsCommon.Step%2A
[34]: xref:System.Management.Automation.VerbsCommon.Switch%2A
[35]: xref:System.Management.Automation.VerbsCommon.Undo%2A
[36]: xref:System.Management.Automation.VerbsCommon.Unlock%2A
[37]: xref:System.Management.Automation.VerbsCommon.Watch%2A
[38]: xref:System.Management.Automation.VerbsCommunications
[39]: xref:System.Management.Automation.VerbsCommunications.Connect%2A
[40]: xref:System.Management.Automation.VerbsCommunications.Disconnect%2A
[41]: xref:System.Management.Automation.VerbsCommunications.Read%2A
[42]: xref:System.Management.Automation.VerbsCommunications.Receive%2A
[43]: xref:System.Management.Automation.VerbsCommunications.Send%2A
[44]: xref:System.Management.Automation.VerbsCommunications.Write%2A
[45]: xref:System.Management.Automation.VerbsData
[46]: xref:System.Management.Automation.VerbsData.Backup%2A
[47]: xref:System.Management.Automation.VerbsData.Checkpoint%2A
[48]: xref:System.Management.Automation.VerbsData.Compare%2A
[49]: xref:System.Management.Automation.VerbsData.Compress%2A
[50]: xref:System.Management.Automation.VerbsData.Convert%2A
[51]: xref:System.Management.Automation.VerbsData.ConvertFrom%2A
[52]: xref:System.Management.Automation.VerbsData.ConvertTo%2A
[53]: xref:System.Management.Automation.VerbsData.Dismount%2A
[54]: xref:System.Management.Automation.VerbsData.Edit%2A
[55]: xref:System.Management.Automation.VerbsData.Expand%2A
[56]: xref:System.Management.Automation.VerbsData.Export%2A
[57]: xref:System.Management.Automation.VerbsData.Group%2A
[58]: xref:System.Management.Automation.VerbsData.Import%2A
[59]: xref:System.Management.Automation.VerbsData.Initialize%2A
[60]: xref:System.Management.Automation.VerbsData.Limit%2A
[61]: xref:System.Management.Automation.VerbsData.Merge%2A
[62]: xref:System.Management.Automation.VerbsData.Mount%2A
[63]: xref:System.Management.Automation.VerbsData.Out%2A
[64]: xref:System.Management.Automation.VerbsData.Publish%2A
[65]: xref:System.Management.Automation.VerbsData.Restore%2A
[66]: xref:System.Management.Automation.VerbsData.Save%2A
[67]: xref:System.Management.Automation.VerbsData.Sync%2A
[68]: xref:System.Management.Automation.VerbsData.Unpublish%2A
[69]: xref:System.Management.Automation.VerbsData.Update%2A
[70]: xref:System.Management.Automation.VerbsDiagnostic
[71]: xref:System.Management.Automation.VerbsDiagnostic.Debug%2A
[72]: xref:System.Management.Automation.VerbsDiagnostic.Measure%2A
[73]: xref:System.Management.Automation.VerbsDiagnostic.Ping%2A
[74]: xref:System.Management.Automation.VerbsDiagnostic.Repair%2A
[75]: xref:System.Management.Automation.VerbsDiagnostic.Resolve%2A
[76]: xref:System.Management.Automation.VerbsDiagnostic.Test%2A
[77]: xref:System.Management.Automation.VerbsDiagnostic.Trace%2A
[78]: xref:System.Management.Automation.VerbsLifecycle
[79]: xref:System.Management.Automation.VerbsLifecycle.Approve%2A
[80]: xref:System.Management.Automation.VerbsLifecycle.Assert%2A
[81]: xref:System.Management.Automation.VerbsLifecycle.Build%2A
[82]: xref:System.Management.Automation.VerbsLifecycle.Complete%2A
[83]: xref:System.Management.Automation.VerbsLifecycle.Confirm%2A
[84]: xref:System.Management.Automation.VerbsLifecycle.Deny%2A
[85]: xref:System.Management.Automation.VerbsLifecycle.Deploy%2A
[86]: xref:System.Management.Automation.VerbsLifecycle.Disable%2A
[87]: xref:System.Management.Automation.VerbsLifecycle.Enable%2A
[88]: xref:System.Management.Automation.VerbsLifecycle.Install%2A
[89]: xref:System.Management.Automation.VerbsLifecycle.Invoke%2A
[90]: xref:System.Management.Automation.VerbsLifecycle.Register%2A
[91]: xref:System.Management.Automation.VerbsLifecycle.Request%2A
[92]: xref:System.Management.Automation.VerbsLifecycle.Restart%2A
[93]: xref:System.Management.Automation.VerbsLifecycle.Resume%2A
[94]: xref:System.Management.Automation.VerbsLifecycle.Start%2A
[95]: xref:System.Management.Automation.VerbsLifecycle.Stop%2A
[96]: xref:System.Management.Automation.VerbsLifecycle.Submit%2A
[97]: xref:System.Management.Automation.VerbsLifecycle.Suspend%2A
[98]: xref:System.Management.Automation.VerbsLifecycle.Uninstall%2A
[99]: xref:System.Management.Automation.VerbsLifecycle.Unregister%2A
[100]: xref:System.Management.Automation.VerbsLifecycle.Wait%2A
[101]: xref:System.Management.Automation.VerbsOther
[102]: xref:System.Management.Automation.VerbsOther.Use%2A
[103]: xref:System.Management.Automation.VerbsSecurity
[104]: xref:System.Management.Automation.VerbsSecurity.Block%2A
[105]: xref:System.Management.Automation.VerbsSecurity.Grant%2A
[106]: xref:System.Management.Automation.VerbsSecurity.Protect%2A
[107]: xref:System.Management.Automation.VerbsSecurity.Revoke%2A
[108]: xref:System.Management.Automation.VerbsSecurity.Unblock%2A
[109]: xref:System.Management.Automation.VerbsSecurity.Unprotect%2A

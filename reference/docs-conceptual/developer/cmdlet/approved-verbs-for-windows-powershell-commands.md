---
ms.date: 09/07/2018
ms.topic: reference
title: Approved Verbs for PowerShell Commands
description: Approved Verbs for PowerShell Commands
---
# Approved Verbs for PowerShell Commands

PowerShell uses a verb-noun pair for the names of cmdlets and for their derived .NET classes.
The verb part of the name identifies the action that the cmdlet performs. The noun part of
the name identifies the entity on which the action is performed. For example, the `Get-Command`
cmdlet retrieves all the commands that are registered in PowerShell.

> [!NOTE]
> PowerShell uses the term _verb_ to describe a word that implies an action even if that word is not
> a standard verb in the English language. For example, the term _New_ is a valid PowerShell verb
> name because it implies an action even though it is not a verb in the English language.

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
- Do not use a synonym of an approved verb. For example, always use `Remove`, never use `Delete` or
  `Eliminate`.
- Use only the form of each verb that is listed in this topic. For example, use `Get`, but do not
  use `Getting` or `Gets`.
- Do not use the following reserved verbs or aliases. The PowerShell language or a rare few of its
  cmdlet uses these verbs under exceptional circumstances.
  - ForEach (foreach)
  - [Format](/dotnet/api/System.Management.Automation.VerbsCommon.Format) (f): Arranges objects in a
    specified form or layout
  - [Group](/dotnet/api/System.Management.Automation.VerbsData.Group) (gp): Arranges or associates
    one or more resources
  - [Ping](/dotnet/api/System.Management.Automation.VerbsDiagnostic.Ping) (pi)
  - Sort (sr)
  - Tee (te)
  - Where (wh)

You may get a complete list of verbs using the `Get-Verb` cmdlet.

## Similar Verbs for Different Actions

The following similar verbs represent different actions.

### New vs. Set

Use the `New` verb to create a new resource. Use the `Set` verb to modify an existing
resource, optionally creating it if it does not exist, such as the `Set-Variable` cmdlet.

### Find vs. Search

Use the `Find` verb to look for an object. Use the `Search` verb to create a reference to a
resource in a container.

### Get vs. Read

Use the `Get` verb to obtain information about a resource (such as a file) or to obtain an object
with which you can access the resource in future. Use the `Read` verb to open a resource and either
extract information contained within.

### Invoke vs. Start

Use the `Invoke` verb to perform synchronous operations, such as
running a command and waiting for it to end. Use the `Start` verb is used to begin asynchronous
operations, such as starting an autonomous process.

### Ping vs. Test

Use the `Test` verb.

## Common Verbs

PowerShell uses the
[System.Management.Automation.VerbsCommon](/dotnet/api/System.Management.Automation.VerbsCommon)
enumeration class to define generic actions that can apply to almost any cmdlet. The following table
lists most of the defined verbs.

|Verb (alias)|Action|Synonyms to avoid|
|--------------------|------------|--------------|
|[Add](/dotnet/api/System.Management.Automation.VerbsCommon.Add) (a)|Adds a resource to a container, or attaches an item to another item. For example, the `Add-Content` cmdlet adds content to a file. This verb is paired with `Remove`.|Append, Attach, Concatenate, Insert|
|[Clear](/dotnet/api/System.Management.Automation.VerbsCommon.Clear) (cl)|Removes all the resources from a container but does not delete the container. For example, the `Clear-Content` cmdlet removes the contents of a file but does not delete the file.|Flush, Erase, Release, Unmark, Unset, Nullify|
|[Close](/dotnet/api/System.Management.Automation.VerbsCommon.Close) (cs)|Changes the state of a resource to make it inaccessible, unavailable, or unusable. This verb is paired with `Open.`||
|[Copy](/dotnet/api/System.Management.Automation.VerbsCommon.Copy) (cp)|Copies a resource to another name or to another container. For example, the `Copy-Item` cmdlet copies an item (such as a file) from one location in the data store to another location.|Duplicate, Clone, Replicate, Sync|
|[Enter](/dotnet/api/System.Management.Automation.VerbsCommon.Enter) (et)|Specifies an action that allows the user to move into a resource. For example, the `Enter-PSSession` cmdlet places the user in an interactive session. This verb is paired with `Exit`.|Push, Into|
|[Exit](/dotnet/api/System.Management.Automation.VerbsCommon.Exit) (ex)|Sets the current environment or context to the most recently used context. For example, the `Exit-PSSession` cmdlet places the user in the session that was used to start the interactive session. This verb is paired with `Enter`.|Pop, Out|
|[Find](/dotnet/api/System.Management.Automation.VerbsCommon.Find) (fd)|Looks for an object in a container that is unknown, implied, optional, or specified.|Search|
|[Get](/dotnet/api/System.Management.Automation.VerbsCommon.Get) (g)|Specifies an action that retrieves a resource. This verb is paired with `Set`.|Read, Open, Cat, Type, Dir, Obtain, Dump, Acquire, Examine, Find, Search|
|[Hide](/dotnet/api/System.Management.Automation.VerbsCommon.Hide) (h)|Makes a resource undetectable. For example, a cmdlet whose name includes the Hide verb might conceal a service from a user. This verb is paired with `Show`.|Block|
|[Join](/dotnet/api/System.Management.Automation.VerbsCommon.Join) (j)|Combines resources into one resource. For example, the `Join-Path` cmdlet combines a path with one of its child paths to create a single path. This verb is paired with `Split`.|Combine, Unite, Connect, Associate|
|[Lock](/dotnet/api/System.Management.Automation.VerbsCommon.Lock) (lk)|Secures a resource. This verb is paired with `Unlock`.|Restrict, Secure|
|[Move](/dotnet/api/System.Management.Automation.VerbsCommon.Move) (m)|Moves a resource from one location to another. For example, the `Move-Item` cmdlet moves an item from one location in the data store to another location.|Transfer, Name, Migrate|
|[New](/dotnet/api/System.Management.Automation.VerbsCommon.New) (n)|Creates a resource. (The `Set` verb can also be used when creating a resource that includes data, such as the `Set-Variable` cmdlet.)|Create, Generate, Build, Make, Allocate|
|[Open](/dotnet/api/System.Management.Automation.VerbsCommon.Open) (op)|Changes the state of a resource to make it accessible, available, or usable. This verb is paired with `Close`.||
|[Optimize](/dotnet/api/System.Management.Automation.VerbsCommon.Optimize) (om)|Increases the effectiveness of a resource.||
|[Pop](/dotnet/api/System.Management.Automation.VerbsCommon.Pop) (pop)|Removes an item from the top of a stack. For example, the `Pop-Location` cmdlet changes the current location to the location that was most recently pushed onto the stack.||
|[Push](/dotnet/api/System.Management.Automation.VerbsCommon.Push) (pu)|Adds an item to the top of a stack. For example, the `Push-Location` cmdlet pushes the current location onto the stack.||
|[Redo](/dotnet/api/System.Management.Automation.VerbsCommon.Redo) (re)|Resets a resource to the state that was undone.||
|[Remove](/dotnet/api/System.Management.Automation.VerbsCommon.Remove) (r)|Deletes a resource from a container. For example, the `Remove-Variable` cmdlet deletes a variable and its value. This verb is paired with `Add`.|Clear, Cut, Dispose, Discard, Erase|
|[Rename](/dotnet/api/System.Management.Automation.VerbsCommon.Rename) (rn)|Changes the name of a resource. For example, the `Rename-Item` cmdlet, which is used to access stored data, changes the name of an item in the data store.|Change|
|[Reset](/dotnet/api/System.Management.Automation.VerbsCommon.Reset) (rs)|Sets a resource back to its original state.||
|[Resize](/dotnet/api/System.Management.Automation.VerbsCommon.Resize)(rz)|Changes the size of a resource.||
|[Search](/dotnet/api/System.Management.Automation.VerbsCommon.Search) (sr)|Creates a reference to a resource in a container.|Find, Locate|
|[Select](/dotnet/api/System.Management.Automation.VerbsCommon.Select) (sc)|Locates a resource in a container. For example, the `Select-String` cmdlet finds text in strings and files.|Find, Locate|
|[Set](/dotnet/api/System.Management.Automation.VerbsCommon.Set) (s)|Replaces data on an existing resource or creates a resource that contains some data. For example, the `Set-Date` cmdlet changes the system time on the local computer. (The `New` verb can also be used to create a resource.) This verb is paired with `Get`.|Write, Reset, Assign, Configure|
|[Show](/dotnet/api/System.Management.Automation.VerbsCommon.Show) (sh)|Makes a resource visible to the user. This verb is paired with `Hide`.|Display, Produce|
|[Skip](/dotnet/api/System.Management.Automation.VerbsCommon.Skip) (sk)|Bypasses one or more resources or points in a sequence.|Bypass, Jump|
|[Split](/dotnet/api/System.Management.Automation.VerbsCommon.Split) (sl)|Separates parts of a resource. For example, the `Split-Path` cmdlet returns different parts of a path. This verb is paired with `Join`.|Separate|
|[Step](/dotnet/api/System.Management.Automation.VerbsCommon.Step) (st)|Moves to the next point or resource in a sequence.||
|[Switch](/dotnet/api/System.Management.Automation.VerbsCommon.Switch) (sw)|Specifies an action that alternates between two resources, such as to change between two locations, responsibilities, or states.||
|[Undo](/dotnet/api/System.Management.Automation.VerbsCommon.Undo) (un)|Sets a resource to its previous state.||
|[Unlock](/dotnet/api/System.Management.Automation.VerbsCommon.Unlock) (uk)|Releases a resource that was locked. This verb is paired with `Lock`.|Release, Unrestrict, Unsecure|
|[Watch](/dotnet/api/System.Management.Automation.VerbsCommon.Watch) (wc)|Continually inspects or monitors a resource for changes.||

## Communications Verbs

PowerShell uses the
[System.Management.Automation.VerbsCommunications](/dotnet/api/System.Management.Automation.VerbsCommunications)
class to define actions that apply to communications. The following table lists most of the defined
verbs.

|Verb (alias)|Action|Synonyms to avoid|
|--------------------|------------|--------------|
|[Connect](/dotnet/api/System.Management.Automation.VerbsCommunications.Connect) (cc)|Creates a link between a source and a destination. This verb is paired with `Disconnect`.|Join, Telnet|
|[Disconnect](/dotnet/api/System.Management.Automation.VerbsCommunications.Disconnect) (dc)|Breaks the link between a source and a destination. This verb is paired with `Connect`.|Break, Logoff|
|[Read](/dotnet/api/System.Management.Automation.VerbsCommunications.Read) (rd)|Acquires information from a source. This verb is paired with `Write`.|Acquire, Prompt, Get|
|[Receive](/dotnet/api/System.Management.Automation.VerbsCommunications.Receive) (rc)|Accepts information sent from a source. This verb is paired with `Send`.|Read, Accept, Peek|
|[Send](/dotnet/api/System.Management.Automation.VerbsCommunications.Send) (sd)|Delivers information to a destination. This verb is paired with `Receive`.|Put, Broadcast, Mail, Fax|
|[Write](/dotnet/api/System.Management.Automation.VerbsCommunications.Write) (wr)|Adds information to a target. This verb is paired with `Read`.|Put, Print|

## Data Verbs

PowerShell uses the
[System.Management.Automation.VerbsData](/dotnet/api/System.Management.Automation.VerbsData) class
to define actions that apply to data handling. The following table lists most of the defined verbs.

|Verb Name (alias)|Action|Synonyms to avoid|
|-------------------------|------------|--------------|
|[Backup](/dotnet/api/System.Management.Automation.VerbsData.Backup) (ba)|Stores data by replicating it.|Save, Burn, Replicate, Sync|
|[Checkpoint](/dotnet/api/System.Management.Automation.VerbsData.Checkpoint) (ch)|Creates a snapshot of the current state of the data or of its configuration.|Diff|
|[Compare](/dotnet/api/System.Management.Automation.VerbsData.Compare) (cr)|Evaluates the data from one resource against the data from another resource.|Diff|
|[Compress](/dotnet/api/System.Management.Automation.VerbsData.Compress) (cm)|Compacts the data of a resource. Pairs with `Expand`.|Compact|
|[Convert](/dotnet/api/System.Management.Automation.VerbsData.Convert) (cv)|Changes the data from one representation to another when the cmdlet supports bidirectional conversion or when the cmdlet supports conversion between multiple data types.|Change, Resize, Resample|
|[ConvertFrom](/dotnet/api/System.Management.Automation.VerbsData.ConvertFrom) (cf)|Converts one primary type of input (the cmdlet noun indicates the input) to one or more supported output types.|Export, Output, Out|
|[ConvertTo](/dotnet/api/System.Management.Automation.VerbsData.ConvertTo) (ct)|Converts from one or more types of input to a primary output type (the cmdlet noun indicates the output type).|Import, Input, In|
|[Dismount](/dotnet/api/System.Management.Automation.VerbsData.Dismount) (dm)|Detaches a named entity from a location. This verb is paired with `Mount`.|Unmount, Unlink|
|[Edit](/dotnet/api/System.Management.Automation.VerbsData.Edit) (ed)|Modifies existing data by adding or removing content.|Change, Update, Modify|
|[Expand](/dotnet/api/System.Management.Automation.VerbsData.Expand) (en)|Restores the data of a resource that has been compressed to its original state. This verb is paired with `Compress`.|Explode, Uncompress|
|[Export](/dotnet/api/System.Management.Automation.VerbsData.Export) (ep)|Encapsulates the primary input into a persistent data store, such as a file, or into an interchange format. This verb is paired with `Import`.|Extract, Backup|
|[Import](/dotnet/api/System.Management.Automation.VerbsData.Import) (ip)|Creates a resource from data that is stored in a persistent data store (such as a file) or in an interchange format. For example, the `Import-CSV` cmdlet imports data from a comma-separated value (CSV) file to objects that can be used by other cmdlets. This verb is paired with `Export`.|BulkLoad, Load|
|[Initialize](/dotnet/api/System.Management.Automation.VerbsData.Initialize) (in)|Prepares a resource for use, and sets it to a default state.|Erase, Init, Renew, Rebuild, Reinitialize, Setup|
|[Limit](/dotnet/api/System.Management.Automation.VerbsData.Limit) (l)|Applies constraints to a resource.|Quota|
|[Merge](/dotnet/api/System.Management.Automation.VerbsData.Merge) (mg)|Creates a single resource from multiple resources.|Combine, Join|
|[Mount](/dotnet/api/System.Management.Automation.VerbsData.Mount) (mt)|Attaches a named entity to a location. This verb is paired with `Dismount`.|Connect|
|[Out](/dotnet/api/System.Management.Automation.VerbsData.Out) (o)|Sends data out of the environment. For example, the `Out-Printer` cmdlet sends data to a printer.||
|[Publish](/dotnet/api/System.Management.Automation.VerbsData.Publish) (pb)|Makes a resource available to others. This verb is paired with `Unpublish`.|Deploy, Release, Install|
|[Restore](/dotnet/api/System.Management.Automation.VerbsData.Restore) (rr)|Sets a resource to a predefined state, such as a state set by `Checkpoint`. For example, the `Restore-Computer` cmdlet starts a system restore on the local computer.|Repair, Return, Undo, Fix|
|[Save](/dotnet/api/System.Management.Automation.VerbsData.Save) (sv)|Preserves data to avoid loss.||
|[Sync](/dotnet/api/System.Management.Automation.VerbsData.Sync) (sy)|Assures that two or more resources are in the same state.|Replicate, Coerce, Match|
|[Unpublish](/dotnet/api/System.Management.Automation.VerbsData.Unpublish) (ub)|Makes a resource unavailable to others. This verb is paired with `Publish`.|Uninstall, Revert, Hide|
|[Update](/dotnet/api/System.Management.Automation.VerbsData.Update) (ud)|Brings a resource up-to-date to maintain its state, accuracy, conformance, or compliance. For example, the `Update-FormatData` cmdlet updates and adds formatting files to the current PowerShell console.|Refresh, Renew, Recalculate, Re-index|

## Diagnostic Verbs

PowerShell uses the
[System.Management.Automation.VerbsDiagnostic](/dotnet/api/System.Management.Automation.VerbsDiagnostic)
class to define actions that apply to diagnostics. The following table lists most of the defined
verbs.

|Verb (alias)|Action|Synonyms to avoid|
|--------------------|------------|--------------|
|[Debug](/dotnet/api/System.Management.Automation.VerbsDiagnostic.Debug) (db)|Examines a resource to diagnose operational problems.|Diagnose|
|[Measure](/dotnet/api/System.Management.Automation.VerbsDiagnostic.Measure) (ms)|Identifies resources that are consumed by a specified operation, or retrieves statistics about a resource.|Calculate, Determine, Analyze|
|[Repair](/dotnet/api/System.Management.Automation.VerbsDiagnostic.Repair) (rp)|Restores a resource to a usable condition|Fix, Restore|
|[Resolve](/dotnet/api/System.Management.Automation.VerbsDiagnostic.Resolve) (rv)|Maps a shorthand representation of a resource to a more complete representation.|Expand, Determine|
|[Test](/dotnet/api/System.Management.Automation.VerbsDiagnostic.Test) (t)|Verifies the operation or consistency of a resource.|Diagnose, Analyze, Salvage, Verify|
|[Trace](/dotnet/api/System.Management.Automation.VerbsDiagnostic.Trace) (tr)|Tracks the activities of a resource.|Track, Follow, Inspect, Dig|

## Lifecycle Verbs

PowerShell uses the
[System.Management.Automation.VerbsLifeCycle](/dotnet/api/System.Management.Automation.VerbsLifeCycle)
class to define actions that apply to the lifecycle of a resource. The following table lists most of
the defined verbs.

|Verb (alias)|Action|Synonyms to avoid|
|--------------------|------------|--------------|
|[Approve](/dotnet/api/System.Management.Automation.VerbsLifecycle.Approve) (ap)|Confirms or agrees to the status of a resource or process.||
|[Assert](/dotnet/api/System.Management.Automation.VerbsLifecycle.Assert) (as)|Affirms the state of a resource.|Certify|
|[Build](/dotnet/api/System.Management.Automation.VerbsLifecycle.Build) (bd)|Creates an artifact (usually a binary or document) out of some set of input files (usually source code or declarative documents.) This verb was added in PowerShell 6.||
|[Complete](/dotnet/api/system.management.automation.host.buffercelltype) (cp)|Concludes an operation.||
|[Confirm](/dotnet/api/System.Management.Automation.VerbsLifecycle.Confirm) (cn)|Acknowledges, verifies, or validates the state of a resource or process.|Acknowledge, Agree, Certify, Validate, Verify|
|[Deny](/dotnet/api/System.Management.Automation.VerbsLifecycle.Deny) (dn)|Refuses, objects, blocks, or opposes the state of a resource or process.|Block, Object, Refuse, Reject|
|[Deploy](/dotnet/api/System.Management.Automation.VerbsLifecycle.Deploy) (dp)|Sends an application, website, or solution to a remote target[s] in such a way that a consumer of that solution can access it after deployment is complete. This verb was added in PowerShell 6.||
|[Disable](/dotnet/api/System.Management.Automation.VerbsLifecycle.Disable) (d)|Configures a resource to an unavailable or inactive state. For example, the `Disable-PSBreakpoint` cmdlet makes a breakpoint inactive. This verb is paired with `Enable`.|Halt, Hide|
|[Enable](/dotnet/api/System.Management.Automation.VerbsLifecycle.Enable) (e)|Configures a resource to an available or active state. For example, the `Enable-PSBreakpoint` cmdlet makes a breakpoint active. This verb is paired with `Disable`.|Start, Begin|
|[Install](/dotnet/api/System.Management.Automation.VerbsLifecycle.Install) (is)|Places a resource in a location, and optionally initializes it. This verb is paired with `Uninstall`.|Setup|
|[Invoke](/dotnet/api/System.Management.Automation.VerbsLifecycle.Invoke) (i)|Performs an action, such as running a command or a method.|Run, Start|
|[Register](/dotnet/api/System.Management.Automation.VerbsLifecycle.Register) (rg)|Creates an entry for a resource in a repository such as a database. This verb is paired with `Unregister`.||
|[Request](/dotnet/api/System.Management.Automation.VerbsLifecycle.Request) (rq)|Asks for a resource or asks for permissions.||
|[Restart](/dotnet/api/System.Management.Automation.VerbsLifecycle.Restart) (rt)|Stops an operation and then starts it again. For example, the `Restart-Service` cmdlet stops and then starts a service.|Recycle|
|[Resume](/dotnet/api/System.Management.Automation.VerbsLifecycle.Resume) (ru)|Starts an operation that has been suspended. For example, the `Resume-Service` cmdlet starts a service that has been suspended. This verb is paired with `Suspend`.||
|[Start](/dotnet/api/System.Management.Automation.VerbsLifecycle.Start) (sa)|Initiates an operation. For example, the `Start-Service` cmdlet starts a service. This verb is paired with `Stop`.|Launch, Initiate, Boot|
|[Stop](/dotnet/api/System.Management.Automation.VerbsLifecycle.Stop) (sp)|Discontinues an activity. This verb is paired with `Start`.|End, Kill, Terminate, Cancel|
|[Submit](/dotnet/api/System.Management.Automation.VerbsLifecycle.Submit) (sb)|Presents a resource for approval.|Post|
|[Suspend](/dotnet/api/System.Management.Automation.VerbsLifecycle.Suspend) (ss)|Pauses an activity. For example, the `Suspend-Service` cmdlet pauses a service. This verb is paired with `Resume`.|Pause|
|[Uninstall](/dotnet/api/System.Management.Automation.VerbsLifecycle.Uninstall) (us)|Removes a resource from an indicated location. This verb is paired with `Install`.||
|[Unregister](/dotnet/api/System.Management.Automation.VerbsLifecycle.Unregister) (ur)|Removes the entry for a resource from a repository. This verb is paired with `Register`.|Remove|
|[Wait](/dotnet/api/System.Management.Automation.VerbsLifecycle.Wait) (w)|Pauses an operation until a specified event occurs. For example, the `Wait-Job` cmdlet pauses operations until one or more of the background jobs are complete.|Sleep, Pause|

## Security Verbs

PowerShell uses the
[System.Management.Automation.VerbsSecurity](/dotnet/api/System.Management.Automation.VerbsSecurity)
class to define actions that apply to security. The following table lists most of the defined verbs.

|Verb (alias)|Action|Synonyms to avoid|
|--------------------|------------|--------------|
|[Block](/dotnet/api/System.Management.Automation.VerbsSecurity.Block) (bl)|Restricts access to a resource. This verb is paired with `Unblock`.|Prevent, Limit, Deny|
|[Grant](/dotnet/api/System.Management.Automation.VerbsSecurity.Grant) (gr)|Allows access to a resource. This verb is paired with `Revoke`.|Allow, Enable|
|[Protect](/dotnet/api/System.Management.Automation.VerbsSecurity.Protect) (pt)|Safeguards a resource from attack or loss. This verb is paired with `Unprotect`.|Encrypt, Safeguard, Seal|
|[Revoke](/dotnet/api/System.Management.Automation.VerbsSecurity.Revoke) (rk)|Specifies an action that does not allow access to a resource. This verb is paired with `Grant`.|Remove, Disable|
|[Unblock](/dotnet/api/System.Management.Automation.VerbsSecurity.Unblock) (ul)|Removes restrictions to a resource. This verb is paired with `Block`.|Clear, Allow|
|[Unprotect](/dotnet/api/System.Management.Automation.VerbsSecurity.Unprotect) (up)|Removes safeguards from a resource that were added to prevent it from attack or loss. This verb is paired with `Protect`.|Decrypt, Unseal|

## Other Verbs

PowerShell uses the
[System.Management.Automation.VerbsOther](/dotnet/api/System.Management.Automation.VerbsOther) class
to define canonical verb names that do not fit into a specific verb name category such as the
common, communications, data, lifecycle, or security verb names verbs.

|Verb (alias)|Action|Synonyms to avoid|
|--------------------|------------|--------------|
|[Use](/dotnet/api/System.Management.Automation.VerbsOther.Use) (u)|Uses or includes a resource to do something.||

## See Also

- [System.Management.Automation.VerbsCommon](/dotnet/api/System.Management.Automation.VerbsCommon)
- [System.Management.Automation.VerbsCommunications](/dotnet/api/System.Management.Automation.VerbsCommunications)
- [System.Management.Automation.VerbsData](/dotnet/api/System.Management.Automation.VerbsData)
- [System.Management.Automation.VerbsDiagnostic](/dotnet/api/System.Management.Automation.VerbsDiagnostic)
- [System.Management.Automation.VerbsLifeCycle](/dotnet/api/System.Management.Automation.VerbsLifeCycle)
- [System.Management.Automation.VerbsSecurity](/dotnet/api/System.Management.Automation.VerbsSecurity)
- [System.Management.Automation.VerbsOther](/dotnet/api/System.Management.Automation.VerbsOther)
- [Cmdlet Declaration](./cmdlet-class-declaration.md)
- [Windows PowerShell Programmer's Guide](../prog-guide/windows-powershell-programmer-s-guide.md)
- [Windows PowerShell Shell SDK](../windows-powershell-reference.md)

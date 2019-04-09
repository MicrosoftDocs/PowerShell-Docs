---
title: "Approved Verbs for PowerShell Commands | Microsoft Docs"
ms.custom: ""
ms.date: "09/07/2018"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
helpviewer_keywords:
  - "action names [PowerShell SDK]"
  - "verb names [PowerShell SDK]"
  - "cmdlets [PowerShell SDK], verb names"
ms.assetid: 2d4e58a9-05bc-437c-86b9-d8d55cba7d48
caps.latest.revision: 36
---
# Approved Verbs for PowerShell Commands

PowerShell uses a verb-noun pair for the names of cmdlets and for their derived Microsoft .NET Framework classes.
For example, the `Get-Command` cmdlet provided by PowerShell is used to retrieve all the commands that are registered in PowerShell.
The verb part of the name identifies the action that the cmdlet performs.
The noun part of the name identifies the entity on which the action is performed.

> [!NOTE]
> PowerShell uses the term *verb* to describe a word that implies an action even if that word is not a standard verb in the English language.
> For example, the term *New* is a valid PowerShell verb name because it implies an action even though it is not a verb in the English language.

## Verb Naming Rules

The following list provides guidelines to consider when you choose the verb for a cmdlet name:

* When you specify the verb, we recommend that you use one of the predefined verb names provided by PowerShell (aliases for these predefined verbs are included in the following tables).
  When you use a predefined verb, you ensure consistency between the cmdlets that you create, the cmdlets that are provided by PowerShell, and the cmdlets that are designed by others.

* Use the predefined verbs to describe the general scope of the action, and use parameters to further refine the action of the cmdlet.

* To enforce consistency across cmdlets, do not use a synonym of an approved verb.

* Use only the form of each verb that is listed in this topic.
  For example, use "Get", but do not use "Getting" or "Gets".

* Use Pascal casing for verbs.
  In Pascal casing the initial letter of each word is capitalized, such as "ForEach".

* Do not use the following reserved verbs or aliases.
  These verbs are used by the PowerShell language, or by special case cmdlets provided by PowerShell.
  - ForEach (foreach)
  - Format (f)
  - Group (gp)
  - Sort (sr)
  - Tee (te)
  - Where (wh)

## Similar Verbs for Different Actions

The following similar verbs represent different actions.

### New vs. Set
The `New` verb is used to create a new resource.
The `Set` verb is used to modify an existing resource, optionally creating the resource if it does not exist, such as the `Set-Variable` cmdlet.

### Find vs. Search
The `Find` verb is used to look for an object.
The `Search` verb is used to create a reference to a resource in a container.

### Get vs. Read
The `Get` verb is used to retrieve a resource, such as a file.
The `Read` verb is used to get information from a source, such as a file.

### Invoke vs. Start
The `Invoke` verb is used to perform an operation that is generally a synchronous operation, such as running a command.
The `Start` verb is used to begin an operation that is generally an asynchronous operation, such as starting a process.

### Ping vs. Test
Use the `Test` verb.

## Common Verbs

PowerShell uses the [System.Management.Automation.VerbsCommon](/dotnet/api/System.Management.Automation.VerbsCommon) enumeration class to define generic actions that can apply to almost any cmdlet.
The following table lists most of the defined verbs.

|Verb (alias)|Action|Comments|
|--------------------|------------|--------------|
|[Add](/dotnet/api/System.Management.Automation.VerbsCommon.Add) (a)|Adds a resource to a container, or attaches an item to another item. For example, the `Add-Content` cmdlet adds content to a file. This verb is paired with `Remove`.|For this action, do not use verbs such as Append, Attach, Concatenate, or Insert.|
|[Clear](/dotnet/api/System.Management.Automation.VerbsCommon.Clear) (cl)|Removes all the resources from a container but does not delete the container. For example, the `Clear-Content` cmdlet removes the contents of a file but does not delete the file.|For this action, do not use verbs such as Flush, Erase, Release, Unmark, Unset, or Nullify.|
|[Close](/dotnet/api/System.Management.Automation.VerbsCommon.Close) (cs)|Changes the state of a resource to make it inaccessible, unavailable, or unusable. This verb is paired with `Open.`||
|[Copy](/dotnet/api/System.Management.Automation.VerbsCommon.Copy) (cp)|Copies a resource to another name or to another container. For example, the `Copy-Item` cmdlet that is used to access stored data copies an item from one location in the data store to another location.|For this action, do not use verbs such as Duplicate, Clone, Replicate, or Sync.|
|[Enter](/dotnet/api/System.Management.Automation.VerbsCommon.Enter) (et)|Specifies an action that allows the user to move into a resource. For example, the `Enter-PSSession` cmdlet places the user in an interactive session. This verb is paired with `Exit`.|For this action, do not use verbs such as Push or Into.|
|[Exit](/dotnet/api/System.Management.Automation.VerbsCommon.Exit) (ex)|Sets the current environment or context to the most recently used context. For example, the `Exit-PSSession` cmdlet places the user in the session that was used to start the interactive session. This verb is paired with `Enter`.|For this action, do not use verbs such as Pop or Out.|
|[Find](/dotnet/api/System.Management.Automation.VerbsCommon.Find) (fd)|Looks for an object in a container that is unknown, implied, optional, or specified.||
|[Format](/dotnet/api/System.Management.Automation.VerbsCommon.Format) (f)|Arranges objects in a specified form or layout.||
|[Get](/dotnet/api/System.Management.Automation.VerbsCommon.Get) (g)|Specifies an action that retrieves a resource. This verb is paired with `Set`.|For this action, do not use verbs such as Read, Open, Cat, Type, Dir, Obtain, Dump, Acquire, Examine, Find, or Search.|
|[Hide](/dotnet/api/System.Management.Automation.VerbsCommon.Hide) (h)|Makes a resource undetectable. For example, a cmdlet whose name includes the Hide verb might conceal a service from a user. This verb is paired with `Show`.|For this action, do not use a verb such as Block.|
|[Join](/dotnet/api/System.Management.Automation.VerbsCommon.Join) (j)|Combines resources into one resource. For example, the `Join-Path` cmdlet combines a path with one of its child paths to create a single path. This verb is paired with `Split`.|For this action, do not use verbs such as Combine, Unite, Connect, or Associate.|
|[Lock](/dotnet/api/System.Management.Automation.VerbsCommon.Lock) (lk)|Secures a resource. This verb is paired with `Unlock`.|For this action, do not use verbs such as Restrict or Secure.|
|[Move](/dotnet/api/System.Management.Automation.VerbsCommon.Move) (m)|Moves a resource from one location to another. For example, the `Move-Item` cmdlet moves an item from one location in the data store to another location.|For this action, do not use verbs such as Transfer, Name, or Migrate.|
|[New](/dotnet/api/System.Management.Automation.VerbsCommon.New) (n)|Creates a resource. (The `Set` verb can also be used when creating a resource that includes data, such as the `Set-Variable` cmdlet.)|For this action, do not use verbs such as Create, Generate, Build, Make, or Allocate.|
|[Open](/dotnet/api/System.Management.Automation.VerbsCommon.Open) (op)|Changes the state of a resource to make it accessible, available, or usable. This verb is paired with `Close`.||
|[Optimize](/dotnet/api/System.Management.Automation.VerbsCommon.Optimize) (om)|Increases the effectiveness of a resource.||
|[Pop](/dotnet/api/System.Management.Automation.VerbsCommon.Pop) (pop)|Removes an item from the top of a stack. For example, the `Pop-Location` cmdlet changes the current location to the location that was most recently pushed onto the stack.||
|[Push](/dotnet/api/System.Management.Automation.VerbsCommon.Push) (pu)|Adds an item to the top of a stack. For example, the `Push-Location` cmdlet pushes the current location onto the stack.||
|[Redo](/dotnet/api/System.Management.Automation.VerbsCommon.Redo) (re)|Resets a resource to the state that was undone.||
|[Remove](/dotnet/api/System.Management.Automation.VerbsCommon.Remove) (r)|Deletes a resource from a container. For example, the `Remove-Variable` cmdlet deletes a variable and its value. This verb is paired with `Add`.|For this action, do not use verbs such as Clear, Cut, Dispose, Discard, or Erase.|
|[Rename](/dotnet/api/System.Management.Automation.VerbsCommon.Rename) (rn)|Changes the name of a resource. For example, the `Rename-Item` cmdlet, which is used to access stored data, changes the name of an item in the data store.|For this action, do not use a verb such as Change.|
|[Reset](/dotnet/api/System.Management.Automation.VerbsCommon.Reset) (rs)|Sets a resource back to its original state.||
|[Search](/dotnet/api/System.Management.Automation.VerbsCommon.Search) (sr)|Creates a reference to a resource in a container.|For this action, do not use verbs such as Find or Locate.|
|[Select](/dotnet/api/System.Management.Automation.VerbsCommon.Select) (sc)|Locates a resource in a container. For example, the `Select-String` cmdlet finds text in strings and files.|For this action, do not use verbs such as Find or Locate.|
|[Set](/dotnet/api/System.Management.Automation.VerbsCommon.Set) (s)|Replaces data on an existing resource or creates a resource that contains some data. For example, the `Set-Date` cmdlet changes the system time on the local computer. (The `New` verb can also be used to create a resource.) This verb is paired with `Get`.|For this action, do not use verbs such as Write, Reset, Assign, or Configure.|
|[Show](/dotnet/api/System.Management.Automation.VerbsCommon.Show) (sh)|Makes a resource visible to the user. This verb is paired with `Hide`.|For this action, do not use verbs such as Display or Produce.|
|[Skip](/dotnet/api/System.Management.Automation.VerbsCommon.Skip) (sk)|Bypasses one or more resources or points in a sequence.|For this action, do not use a verb such as Bypass or Jump.|
|[Split](/dotnet/api/System.Management.Automation.VerbsCommon.Split) (sl)|Separates parts of a resource. For example, the `Split-Path` cmdlet returns different parts of a path. This verb is paired with `Join`.|For this action, do not use a verb such Separate.|
|[Step](/dotnet/api/System.Management.Automation.VerbsCommon.Step) (st)|Moves to the next point or resource in a sequence.||
|[Switch](/dotnet/api/System.Management.Automation.VerbsCommon.Switch) (sw)|Specifies an action that alternates between two resources, such as to change between two locations, responsibilities, or states.||
|[Undo](/dotnet/api/System.Management.Automation.VerbsCommon.Undo) (un)|Sets a resource to its previous state.||
|[Unlock](/dotnet/api/System.Management.Automation.VerbsCommon.Unlock) (uk)|Releases a resource that was locked. This verb is paired with `Lock`.|For this action, do not use verbs such as Release, Unrestrict, or Unsecure.|
|[Watch](/dotnet/api/System.Management.Automation.VerbsCommon.Watch) (wc)|Continually inspects or monitors a resource for changes.||

## Communications Verbs

PowerShell uses the [System.Management.Automation.VerbsCommunications](/dotnet/api/System.Management.Automation.VerbsCommunications) class to define actions that apply to communications.
The following table lists most of the defined verbs.

|Verb (alias)|Action|Comments|
|--------------------|------------|--------------|
|[Connect](/dotnet/api/System.Management.Automation.VerbsCommunications.Connect) (cc)|Creates a link between a source and a destination. This verb is paired with `Disconnect`.|For this action, do not use verbs such as Join or Telnet.|
|[Disconnect](/dotnet/api/System.Management.Automation.VerbsCommunications.Disconnect) (dc)|Breaks the link between a source and a destination. This verb is paired with `Connect`.|For this action, do not use verbs such as Break or Logoff.|
|[Read](/dotnet/api/System.Management.Automation.VerbsCommunications.Read) (rd)|Acquires information from a source. This verb is paired with `Write`.|For this action, do not use verbs such as Acquire, Prompt, or Get.|
|[Receive](/dotnet/api/System.Management.Automation.VerbsCommunications.Receive) (rc)|Accepts information sent from a source. This verb is paired with `Send`.|For this action, do not use verbs such as Read, Accept, or Peek.|
|[Send](/dotnet/api/System.Management.Automation.VerbsCommunications.Send) (sd)|Delivers information to a destination. This verb is paired with `Receive`.|For this action, do not use verbs such as Put, Broadcast, Mail, or Fax.|
|[Write](/dotnet/api/System.Management.Automation.VerbsCommunications.Write) (wr)|Adds information to a target. This verb is paired with `Read`.|For this action, do not use verbs such as Put or Print.|

## Data Verbs

PowerShell uses the [System.Management.Automation.VerbsData](/dotnet/api/System.Management.Automation.VerbsData) class to define actions that apply to data handling.
The following table lists most of the defined verbs.

|Verb Name (alias)|Action|Comments|
|-------------------------|------------|--------------|
|[Backup](/dotnet/api/System.Management.Automation.VerbsData.Backup) (ba)|Stores data by replicating it.|For this action, do not use verbs such as Save, Burn, Replicate, or Sync.|
|[Checkpoint](/dotnet/api/System.Management.Automation.VerbsData.Checkpoint) (ch)|Creates a snapshot of the current state of the data or of its configuration.|For this action, do not use a verb such as Diff.|
|[Compare](/dotnet/api/System.Management.Automation.VerbsData.Compare) (cr)|Evaluates the data from one resource against the data from another resource.|For this action, do not use a verb such as Diff.|
|[Compress](/dotnet/api/System.Management.Automation.VerbsData.Compress) (cm)|Compacts the data of a resource. Pairs with `Expand`.|For this action, do not use a verb such as Compact.|
|[Convert](/dotnet/api/System.Management.Automation.VerbsData.Convert) (cv)|Changes the data from one representation to another when the cmdlet supports bidirectional conversion or when the cmdlet supports conversion between multiple data types.|For this action, do not use verbs such as Change, Resize, or Resample.|
|[ConvertFrom](/dotnet/api/System.Management.Automation.VerbsData.ConvertFrom) (cf)|Converts one primary type of input (the cmdlet noun indicates the input) to one or more supported output types.|For this action, do not use verbs such as Export, Output, or Out.|
|[ConvertTo](/dotnet/api/System.Management.Automation.VerbsData.ConvertTo) (ct)|Converts from one or more types of input to a primary output type (the cmdlet noun indicates the output type).|For this action, do not use verbs such as Import, Input, or In.|
|[Dismount](/dotnet/api/System.Management.Automation.VerbsData.Dismount) (dm)|Detaches a named entity from a location. This verb is paired with `Mount`.|For this action, do not use verbs such as Unmount or Unlink.|
|[Edit](/dotnet/api/System.Management.Automation.VerbsData.Edit) (ed)|Modifies existing data by adding or removing content.|For this action, do not use verbs such as Change, Update, or Modify.|
|[Expand](/dotnet/api/System.Management.Automation.VerbsData.Expand) (en)|Restores the data of a resource that has been compressed to its original state. This verb is paired with `Compress`.|For this action, do not use verbs such as Explode or Uncompress.|
|[Export](/dotnet/api/System.Management.Automation.VerbsData.Export) (ep)|Encapsulates the primary input into a persistent data store, such as a file, or into an interchange format. This verb is paired with `Import`.|For this action, do not use verbs such as Extract or Backup.|
|[Group](/dotnet/api/System.Management.Automation.VerbsData.Group) (gp)|Arranges or associates one or more resources.|For this action, do not use verbs such as Aggregate, Arrange, Associate, or Correlate.|
|[Import](/dotnet/api/System.Management.Automation.VerbsData.Import) (ip)|Creates a resource from data that is stored in a persistent data store (such as a file) or in an interchange format. For example, the `Import-CSV` cmdlet imports data from a comma-separated value (CSV) file to objects that can be used by other cmdlets. This verb is paired with `Export`.|For this action, do not use verbs such as BulkLoad or Load.|
|[Initialize](/dotnet/api/System.Management.Automation.VerbsData.Initialize) (in)|Prepares a resource for use, and sets it to a default state.|For this action, do not use verbs such as Erase, Init, Renew, Rebuild, Reinitialize, or Setup.|
|[Limit](/dotnet/api/System.Management.Automation.VerbsData.Limit) (l)|Applies constraints to a resource.|For this action, do not use a verb such as Quota.|
|[Merge](/dotnet/api/System.Management.Automation.VerbsData.Merge) (mg)|Creates a single resource from multiple resources.|For this action, do not use verbs such as Combine or Join.|
|[Mount](/dotnet/api/System.Management.Automation.VerbsData.Mount) (mt)|Attaches a named entity to a location. This verb is paired with `Dismount`.|For this action, do not use the verb Connect.|
|[Out](/dotnet/api/System.Management.Automation.VerbsData.Out) (o)|Sends data out of the environment. For example, the `Out-Printer` cmdlet sends data to a printer.||
|[Publish](/dotnet/api/System.Management.Automation.VerbsData.Publish) (pb)|Makes a resource available to others. This verb is paired with `Unpublish`.|For this action, do not use verbs such as Deploy, Release, or Install.|
|[Restore](/dotnet/api/System.Management.Automation.VerbsData.Restore) (rr)|Sets a resource to a predefined state, such as a state set by `Checkpoint`. For example, the `Restore-Computer` cmdlet starts a system restore on the local computer.|For this action, do not use verbs such as Repair, Return, Undo, or Fix.|
|[Save](/dotnet/api/System.Management.Automation.VerbsData.Save) (sv)|Preserves data to avoid loss.||
|[Sync](/dotnet/api/System.Management.Automation.VerbsData.Sync) (sy)|Assures that two or more resources are in the same state.|For this action, do not use verbs such as Replicate, Coerce, or Match.|
|[Unpublish](/dotnet/api/System.Management.Automation.VerbsData.Unpublish) (ub)|Makes a resource unavailable to others. This verb is paired with `Publish`.|For this action, do not use verbs such as Uninstall, Revert, or Hide.|
|[Update](/dotnet/api/System.Management.Automation.VerbsData.Update) (ud)|Brings a resource up-to-date to maintain its state, accuracy, conformance, or compliance. For example, the `Update-FormatData` cmdlet updates and adds formatting files to the current PowerShell console.|For this action, do not use verbs such as Refresh, Renew, Recalculate, or Re-index.|

## Diagnostic Verbs

PowerShell uses the [System.Management.Automation.VerbsDiagnostic](/dotnet/api/System.Management.Automation.VerbsDiagnostic) class to define actions that apply to diagnostics.
The following table lists most of the defined verbs.

|Verb (alias)|Action|Comments|
|--------------------|------------|--------------|
|[Debug](/dotnet/api/System.Management.Automation.VerbsDiagnostic.Debug) (db)|Examines a resource to diagnose operational problems.|For this action, do not use a verb such as Diagnose.|
|[Measure](/dotnet/api/System.Management.Automation.VerbsDiagnostic.Measure) (ms)|Identifies resources that are consumed by a specified operation, or retrieves statistics about a resource.|For this action, do not use verbs such as Calculate, Determine, or Analyze.|
|[Ping](/dotnet/api/System.Management.Automation.VerbsDiagnostic.Ping) (pi)|Use the `Test` verb.||
|[Repair](/dotnet/api/System.Management.Automation.VerbsDiagnostic.Repair) (rp)|Restores a resource to a usable condition|For this action, do not use verbs such as Fix or Restore.|
|[Resolve](/dotnet/api/System.Management.Automation.VerbsDiagnostic.Resolve) (rv)|Maps a shorthand representation of a resource to a more complete representation.|For this action, do not use verbs such as Expand or Determine.|
|[Test](/dotnet/api/System.Management.Automation.VerbsDiagnostic.Test) (t)|Verifies the operation or consistency of a resource.|For this action, do not use verbs such as Diagnose, Analyze, Salvage, or Verify.|
|[Trace](/dotnet/api/System.Management.Automation.VerbsDiagnostic.Trace) (tr)|Tracks the activities of a resource.|For this action, do not use verbs such as Track, Follow, Inspect, or Dig.|

## Lifecycle Verbs

PowerShell uses the [System.Management.Automation.VerbsLifeCycle](/dotnet/api/System.Management.Automation.VerbsLifeCycle) class to define actions that apply to the lifecycle of a resource.
The following table lists most of the defined verbs.

|Verb (alias)|Action|Comments|
|--------------------|------------|--------------|
|[Approve](/dotnet/api/System.Management.Automation.VerbsLifecycle.Approve) (ap)|Confirms or agrees to the status of a resource or process.||
|[Assert](/dotnet/api/System.Management.Automation.VerbsLifecycle.Assert) (as)|Affirms the state of a resource.|For this action, do not use a verb such as Certify.|
|[Build](/dotnet/api/System.Management.Automation.VerbsLifecycle.Build) (bd)|Creates an artifact (usually a binary or document) out of some set of input files (usually source code or declarative documents)|This verb was added in PowerShell v6|
|[Complete](/dotnet/api/system.management.automation.host.buffercelltype?view=powershellsdk-1.1.0) (cp)|Concludes an operation.||
|[Confirm](/dotnet/api/System.Management.Automation.VerbsLifecycle.Confirm) (cn)|Acknowledges, verifies, or validates the state of a resource or process.|For this action, do not use verbs such as Acknowledge, Agree, Certify, Validate, or Verify.|
|[Deny](/dotnet/api/System.Management.Automation.VerbsLifecycle.Deny) (dn)|Refuses, objects, blocks, or opposes the state of a resource or process.|For this action, do not use verbs such as Block, Object, Refuse, or Reject.|
|[Deploy](/dotnet/api/System.Management.Automation.VerbsLifecycle.Deploy) (dp)|Sends an application, website, or solution to a remote target[s] in such a way that a consumer of that solution can access it after deployment is complete|This verb was added in PowerShell v6|
|[Disable](/dotnet/api/System.Management.Automation.VerbsLifecycle.Disable) (d)|Configures a resource to an unavailable or inactive state. For example, the `Disable-PSBreakpoint` cmdlet makes a breakpoint inactive. This verb is paired with `Enable`.|For this action, do not use verbs such as Halt or Hide.|
|[Enable](/dotnet/api/System.Management.Automation.VerbsLifecycle.Enable) (e)|Configures a resource to an available or active state. For example, the `Enable-PSBreakpoint` cmdlet makes a breakpoint active. This verb is paired with `Disable`.|For this action, do not use verbs such as Start or Begin.|
|[Install](/dotnet/api/System.Management.Automation.VerbsLifecycle.Install) (is)|Places a resource in a location, and optionally initializes it. This verb is paired with `Uninstall`.|For this action, do not a use verb such as Setup.|
|[Invoke](/dotnet/api/System.Management.Automation.VerbsLifecycle.Invoke) (i)|Performs an action, such as running a command or a method.|For this action, do not use verbs such as Run or Start.|
|[Register](/dotnet/api/System.Management.Automation.VerbsLifecycle.Register) (rg)|Creates an entry for a resource in a repository such as a database. This verb is paired with `Unregister`.||
|[Request](/dotnet/api/System.Management.Automation.VerbsLifecycle.Request) (rq)|Asks for a resource or asks for permissions.||
|[Restart](/dotnet/api/System.Management.Automation.VerbsLifecycle.Restart) (rt)|Stops an operation and then starts it again. For example, the `Restart-Service` cmdlet stops and then starts a service.|For this action, do not use a verb such as Recycle.|
|[Resume](/dotnet/api/System.Management.Automation.VerbsLifecycle.Resume) (ru)|Starts an operation that has been suspended. For example, the `Resume-Service` cmdlet starts a service that has been suspended. This verb is paired with `Suspend`.||
|[Start](/dotnet/api/System.Management.Automation.VerbsLifecycle.Start) (sa)|Initiates an operation. For example, the `Start-Service` cmdlet starts a service. This verb is paired with `Stop`.|For this action, do not use verbs such as Launch, Initiate, or Boot.|
|[Stop](/dotnet/api/System.Management.Automation.VerbsLifecycle.Stop) (sp)|Discontinues an activity. This verb is paired with `Start`.|For this action, do not use verbs such as End, Kill, Terminate, or Cancel.|
|[Submit](/dotnet/api/System.Management.Automation.VerbsLifecycle.Submit) (sb)|Presents a resource for approval.|For this action, do not use a verb such as Post.|
|[Suspend](/dotnet/api/System.Management.Automation.VerbsLifecycle.Suspend) (ss)|Pauses an activity. For example, the `Suspend-Service` cmdlet pauses a service. This verb is paired with `Resume`.|For this action, do not use a verb such as Pause.|
|[Uninstall](/dotnet/api/System.Management.Automation.VerbsLifecycle.Uninstall) (us)|Removes a resource from an indicated location. This verb is paired with `Install`.||
|[Unregister](/dotnet/api/System.Management.Automation.VerbsLifecycle.Unregister) (ur)|Removes the entry for a resource from a repository. This verb is paired with `Register`.|For this action, do not use a verb such as Remove.|
|[Wait](/dotnet/api/System.Management.Automation.VerbsLifecycle.Wait) (w)|Pauses an operation until a specified event occurs. For example, the `Wait-Job` cmdlet pauses operations until one or more of the background jobs are complete.|For this action, do not use verbs such as Sleep or Pause.|

## Security Verbs

PowerShell uses the [System.Management.Automation.VerbsSecurity](/dotnet/api/System.Management.Automation.VerbsSecurity) class to define actions that apply to security.
The following table lists most of the defined verbs.

|Verb (alias)|Action|Comments|
|--------------------|------------|--------------|
|[Block](/dotnet/api/System.Management.Automation.VerbsSecurity.Block) (bl)|Restricts access to a resource. This verb is paired with `Unblock`.|For this action, do not use verbs such as Prevent, Limit, or Deny.|
|[Grant](/dotnet/api/System.Management.Automation.VerbsSecurity.Grant) (gr)|Allows access to a resource. This verb is paired with `Revoke`.|For this action, do not use verbs such as Allow or Enable.|
|[Protect](/dotnet/api/System.Management.Automation.VerbsSecurity.Protect) (pt)|Safeguards a resource from attack or loss. This verb is paired with `Unprotect`.|For this action, do not use verbs such as Encrypt, Safeguard, or Seal.|
|[Revoke](/dotnet/api/System.Management.Automation.VerbsSecurity.Revoke) (rk)|Specifies an action that does not allow access to a resource. This verb is paired with `Grant`.|For this action, do not use verbs such as Remove or Disable.|
|[Unblock](/dotnet/api/System.Management.Automation.VerbsSecurity.Unblock) (ul)|Removes restrictions to a resource. This verb is paired with `Block`.|For this action, do not use verbs such as Clear or Allow.|
|[Unprotect](/dotnet/api/System.Management.Automation.VerbsSecurity.Unprotect) (up)|Removes safeguards from a resource that were added to prevent it from attack or loss. This verb is paired with `Protect`.|For this action, do not use verbs such as Decrypt or Unseal.|

## Other Verbs

PowerShell uses the [System.Management.Automation.VerbsOther](/dotnet/api/System.Management.Automation.VerbsOther) class to define canonical verb names that do not fit into a specific verb name category such as the common, communications, data, lifecycle, or security verb names verbs.

|Verb (alias)|Action|Comments|
|--------------------|------------|--------------|
|[Use](/dotnet/api/System.Management.Automation.VerbsOther.Use) (u)|Uses or includes a resource to do something.||

## See Also

[System.Management.Automation.VerbsCommon](/dotnet/api/System.Management.Automation.VerbsCommon)

[System.Management.Automation.VerbsCommunications](/dotnet/api/System.Management.Automation.VerbsCommunications)

[System.Management.Automation.VerbsData](/dotnet/api/System.Management.Automation.VerbsData)

[System.Management.Automation.VerbsDiagnostic](/dotnet/api/System.Management.Automation.VerbsDiagnostic)

[System.Management.Automation.VerbsLifeCycle](/dotnet/api/System.Management.Automation.VerbsLifeCycle)

[System.Management.Automation.VerbsSecurity](/dotnet/api/System.Management.Automation.VerbsSecurity)

[System.Management.Automation.VerbsOther](/dotnet/api/System.Management.Automation.VerbsOther)

[Cmdlet Declaration](./cmdlet-class-declaration.md)

[Windows PowerShell Programmer's Guide](../prog-guide/windows-powershell-programmer-s-guide.md)

[Windows PowerShell Shell SDK](../windows-powershell-reference.md)

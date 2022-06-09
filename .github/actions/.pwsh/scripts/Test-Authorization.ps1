<#
.SYNOPSIS
  Checks if a user may perform an action.
.DESCRIPTION
  Checks if a user may perform an action. A user is authorized if they have one or more of the
  specified permissions. If the user is not authorized, the script (and any GHA workflow calling it)
  fails.
.PARAMETER Owner
  The owner of the repository to check the user's permissions in. For `https://github.com/foo/bar`
  the owner is `foo`.
.PARAMETER Repo
  The name of the repository to check the user's permissions in. For `https://github.com/foo/bar`
  the name is `bar`.
.PARAMETER User
  The GitHub login to retrieve permissions for.
.PARAMETER TargetBranch
  Specifies the name of a branch requiring permissions to target.
.PARAMETER TargetPath
  Specifies the path to one or more files requiring permissions to modify.
.PARAMETER ValidPermissions
  One or more GitHub permissions the user must have. If the user has any of the specified
  permissions, they are authorized for the action. By default, a user must have the `Admin` or
  `Maintain` permission.

  GitHub permissions include:

  - `Admin`
  - `Maintain`
  - `Pull`
  - `Push`
  - `Triage`
.EXAMPLE
  ```powershell
  ./.github/pwsh/scripts/Test-Authorization.ps1 -Owner foo -Repo bar -Author baz -TargetBranch live
  ```

  The script checks the permissions of the `baz` user for `https://github.com/foo/bar`. If `baz` has
  maintainer or admin permissions, the script exits without error. If they do not, the script throws
  an error declaring the `baz` does not have enough permissions to target the `live` branch.
.EXAMPLE
  ```powershell
  $Paths = @(
    '.github/pwsh'
    '.github/workflows'
  )
  ./.github/pwsh/scripts/Test-Authorization.ps1 -Owner foo -Repo bar -Author baz -TargetPath $Paths
  ```

  The script checks the permissions of the `baz` user for https://github.com/foo/bar`. If `baz` has
  maintainer or admin permissions, the script exits without error. If they do not, the script throws
  an error declaring the `baz` does not have enough permissions to target either the `pwsh` or
  `workflows` folder.
.NOTES
  The **TargetBranch** and **TargetPath** parameters are for convenience; GitHub repositories do not
  have a built-in way to define permissions for branches or folders except for branch protection,
  which isn't enough for this purpose. To ensure this script is effective, use the **branches** and
  **paths** settings in the workflow when defining a **pull_request_target** job trigger.
  #>
[cmdletbinding(DefaultParameterSetName='Branch')]
param(
  [Parameter(Mandatory)]
  [string]$Owner,
  [Parameter(Mandatory)]
  [string]$Repo,
  [Parameter(Mandatory)]
  [string]$User,
  [Parameter(Mandatory, ParameterSetName='Branch')]
  [string]$TargetBranch,
  [Parameter(Mandatory, ParameterSetName='Path')]
  [string[]]$TargetPath,
  [ValidateSet('Admin', 'Maintain', 'Pull', 'Push', 'Triage')]
  [string[]]$ValidPermissions = @('Admin', 'Maintain')
)

begin {
  <#
    Setup steps:

    - Need to import the GHA module, which contains all of the functions that interact with the API
      and includes helper utilities for console formatting.
    - Need a string builder to generate the markdown summary for this step.
    - Need to grab the values for ANSI and PlainText output rendering so the markdown in the summary
      doesn't include ANSI decorations.
    - Need to create empty arrays to grab the data on comments and failures.
    - Need to grab the path to the body file for the PR comment.
  #>
  $GitHubFolder = Split-Path -Parent $PSScriptRoot | Split-Path -Parent
  $ModuleFile = Resolve-Path -Path "$GitHubFolder/.pwsh/module/gha.psd1"
  | Select-Object -ExpandProperty Path
  Import-Module $ModuleFile -Force
  $Summary = New-Object -TypeName System.Text.StringBuilder
  $Ansi = [System.Management.Automation.OutputRendering]::Ansi
  $Plain = [System.Management.Automation.OutputRendering]::PlainText
  $TargetStyle = @($PSStyle.Bold, $PSStyle.Foreground.BrightMagenta)
  $Texts = @{
    Success = @{
      Console = Format-ConsoleStyle -Text 'Success' -DefinedStyle Success
      Markdown = "**Success**"
    }
    Author = @{
      Console = Format-ConsoleStyle -Text $User -DefinedStyle UserName
      Markdown = "``$User``"
    }
  }
  if (![string]::IsNullOrEmpty($TargetBranch)) {
    $ConsoleBranch = Format-ConsoleStyle -Text $TargetBranch -StyleComponent $TargetStyle
    $Texts.Target = @{
      Console = "target the $ConsoleBranch branch."
      Markdown = "target the ``$TargetBranch`` branch."
      Error = "target the '$TargetBranch' branch."
    }
  } Else {
    $ConsolePaths = $TargetPath | Foreach-Object -Process {
      Format-ConsoleStyle -Text $_ -StyleComponent $TargetStyle
    }
    $MarkdownPaths = $TargetPath | ForEach-Object -Process {"- ``$_``"}
    $Texts.Target = @{
      Console = "modify file paths:`n`t$($ConsolePaths -join "`n`t")"
      Markdown = "modify file paths:`n`n$($MarkdownPaths -join "`n")"
      Error = "modify file paths:`n`t$($TargetPath -join "`n`t")"
    }
  }
}

process {
  try {
    $Permissions = Get-AuthorPermission -Owner $Owner -Repo $Repo -Author $User
  } catch {
    $Record = $_ | Get-GHAConsoleError
    Write-ActionFailureSummary -Record $Record -Synopsis 'Unable to retrieve permissions.'
    $PSCmdlet.ThrowTerminatingError($_)
  }

  #region    Permission Retrieval Messaging
  # Markdown Summary
  $null = $Summary.AppendLine('## Retrieved Permissions').AppendLine()
  $null = $Summary.AppendLine("Retrieved permissions for for ``$User``. Details:").AppendLine()
  $null = $Summary.AppendLine('```text')
  $PSStyle.OutputRendering = $Plain
  $PermissionsBlock = $Permissions | Format-List -Property * | Out-String
  $PSStyle.OutputRendering = $Ansi
  $null = $Summary.AppendLine($PermissionsBlock.Trim())
  $null = $Summary.AppendLine('```').AppendLine()
  # Console Logging
  "Retrieved permissions for $($Texts.Author.Console):"
  foreach ($Permission in @('Admin', 'Maintain', 'Pull', 'Push', 'Triage')) {
    $Prefix = "`t$($PSStyle.Bold)${Permission}:$($PSStyle.BoldOff)".PadRight(20)
    $Setting = Format-ConsoleBoolean -Value $Permissions.$Permission
    "$Prefix`t$Setting"
  }
  #endregion Permission Retrieval Messaging
  
  $null = $Summary.AppendLine('## Result').AppendLine()

  # Check for authorization; if the user has any of the valid permissions, they
  # are authorized for this action.
  $Authorized = $false
  foreach ($Permission in $ValidPermissions) {
    if ($Permissions.$Permission) {
      $Authorized = $true
      break
    }
  }

  if ($Authorized) {
    # Markdown Summary
    $null = $Summary.AppendLine(
      "**Success:** Author (``$User``) may $($Texts.Target.Markdown)"
    )
    $Summary.ToString() >> $ENV:GITHUB_STEP_SUMMARY
    # Console Logging
    $ConsoleMessage = New-Object -TypeName System.Text.StringBuilder
    $null = $ConsoleMessage.Append("$($Texts.Success.Console): ")
    $null = $ConsoleMessage.Append("author ($($Texts.Author.Console)) ")
    $null = $ConsoleMessage.Append("may $($Texts.Target.Console)")
    $ConsoleMessage.ToString()
  } else {
    # Markdown Summary
    $null = $Summary.AppendLine(
      "**Failure:** Author (``$User``) may not $($Texts.Target.Markdown)"
    )
    $Summary.ToString() >> $ENV:GITHUB_STEP_SUMMARY
    # Console Logging / Throw Error
    $Message = "Author ($($Texts.Author.Console)) may not $($Texts.Target.Error)"
    $Message = Format-GHAConsoleText -Text $Message
    $Exception = [System.ApplicationException]::new($Message)
    $TargetObject = $TargetBranch || $TargetPath
    $Record = [System.Management.Automation.ErrorRecord]::new(
        $Exception,
        'GHA.NotPermittedToTarget',
        [System.Management.Automation.ErrorCategory]::PermissionDenied,
        $TargetObject
    )
    $PSCmdlet.ThrowTerminatingError($Record)
  }
}

end {}
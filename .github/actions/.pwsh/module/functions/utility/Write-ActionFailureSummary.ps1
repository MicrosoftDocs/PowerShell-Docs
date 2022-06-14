<#
.SYNOPSIS
    Writes a standardized summary entry when a GHA fails due to thrown error.
.DESCRIPTION
    Writes a standardized summary entry when a GHA fails due to thrown error. It includes the record
    of the error in a Markdown codeblock under the heading "Action Failure."
.PARAMETER Synopsis
    Specifies a synopsis for what the action was trying to do when it failed.
.PARAMETER Record
    Specifies a record object to write in the error details. Does not have to be an error record.
.EXAMPLE
    $Record = Get-GHAConsoleError -Newest 1
    Write-ActionFailureSummary -Synopsis 'Unable to retrieve open pull requests.' -Record $Record

    The cmdlet writes the details of the failed `gh` command as markdown into the summary for this
    workflow step.
#>
function Write-ActionFailureSummary {
    [CmdletBinding()]
    param (
        [string]$Synopsis,
        [psobject]$Record
    )
    
    begin {
        $Ansi = [System.Management.Automation.OutputRendering]::Ansi
        $Plain = [System.Management.Automation.OutputRendering]::PlainText
    }
    
    process {
        $Summary = New-Object -TypeName System.Text.StringBuilder
        $PSStyle.OutputRendering = $Plain
        $null = $Summary.AppendLine('## Action Failure').AppendLine()
        $null = $Summary.AppendLine("$Synopsis Error details:").AppendLine()
        $null = $Summary.AppendLine('```text')
        $RecordBlock = $Record | Format-List -Property * | Out-String
        $null = $Summary.AppendLine($RecordBlock.Trim())
        $null = $Summary.AppendLine('```').AppendLine()
        $PSStyle.OutputRendering = $Ansi
        $Summary.ToString() >> $ENV:GITHUB_STEP_SUMMARY
    }
    
    end {
        
    }
}
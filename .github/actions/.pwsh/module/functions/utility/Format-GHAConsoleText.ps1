<#
.SYNOPSIS
    Reflows a text string at a specified length for easier console reading.
.DESCRIPTION
    This cmdlet reflows a text string at a specified length for easier console reading. It respects
    leading whitespace, keeping the indent for wrapped lines. It converts tabs to four spaces for
    consistency in viewing. It breaks lines on whitespace; not complex, but usually fine in console.

    Primarily useful for converting error messages into readable lines.
.PARAMETER Text
    Specifies input text to reflow.
.PARAMETER MaxWidth
    Specifies the maximum length in visible characters a line can be before reflowing. Defaults to
    72 characters.
.EXAMPLE
    ```powershell
    $Text = @'
    This is a very long string with multiple paragraphs. It will certainly need to be reflowed in a few different places. It's not always easy to read long lines like this in the console.

        It also respects leading whitespace. When a line is too long for reading in the console, it will happily reflow the leading whitespace to make sure that things don't look weird after.
    '@
    Format-GHAConsoleText -Text $Text
    ```

    ```Output
    This is a very long string with multiple paragraphs. It will certainly
    need to be reflowed in a few different places. It's not always easy to
    read long lines like this in the console.

        It also respects leading whitespace. When a line is too long for
        reading in the console, it will happily reflow the leading
        whitespace to make sure that things don't look weird after.
    ```

    The cmdlet wraps the input text at 72 characters, making the long input strings more readable
    and preserving the leading whitespace.
#>
function Format-GHAConsoleText {
    [CmdletBinding()]
    param(
        [parameter(Mandatory)]
        [string]$Text,
        [int]$MaxWidth = 72
    )

    begin {}

    process {
        # Replace tabs with four spaces for consistent reflow with console width.
        $Text = $Text -replace "`t", '    '
        # Make all lines terminate as LF even if they terminated as CRLF to simplify the rest of the
        # process. Then split on LF to process each line for reflow.
        if ($Text -match "`r`n") {
            $Text = $Text -replace "`r`n", "`n"
        }
        $InputLines = $Text -split "`n"

        # Process every input line separately, reflowing them as needed.
        $Output = New-Object -TypeName System.Text.StringBuilder
        foreach ($Line in $InputLines) {
            if ($Line.Length -lt $MaxWidth) {
                $null = $Output.AppendLine($Line.TrimEnd())
                continue
            }
            # If there is any leading whitespace for a line, discover it so it can be preserved for
            # reflowed lines. Make sure to trim trailing whitespace to account for lines that are
            # only whitespace; they break the flow badly.
            $Line = $Line.TrimEnd()
            $Prefix = $Line -match '^(\s+)' ? $Matches[1] : ''
            # Simple split on whitespace; not perfect, but okay for action logs. Trim whitespace
            # ahead of splitting; we already have the prefix.
            $Words = $Line.Trim() -split '\s+'
            # Set the new line with the discovered prefix before adding words.
            $NewLine = $Prefix
            # Loop over the words, appending a space and the word; if the updated line length is
            # over the max, write the existing line to output and reset the newline to the prefix,
            # continuing through the loop.
            foreach ($Word in $Words) {
                $UpdatedNewLine = $NewLine -eq $Prefix ? "$Newline$Word" : "$NewLine $Word"
                if ($UpdatedNewLine.Length -gt $MaxWidth) {
                    $null = $Output.AppendLine($NewLine.TrimEnd())
                    $NewLine = "$Prefix$Word"
                }
                else {
                    $NewLine = $UpdatedNewLine
                }
            }
            # Make sure to write any remaining text to the output.
            if ($NewLine.Length -gt 0) {
                $null = $Output.AppendLine($NewLine.TrimEnd())
            }
        }

        $Output.ToString()
    }

    end {}
}

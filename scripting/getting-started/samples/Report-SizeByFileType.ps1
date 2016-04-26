function Report-SizeByFileType {
    [CmdletBinding()]
    Param(
        [parameter (ValueFromPipeline=$true)] $pipeobject
    )

    begin { 
        $dict = @{};
    }

    process {
        if($pipeobject -is [System.IO.FileInfo]) {
            $dict[$pipeobject.Extension] += $pipeobject.Length
        }
    }

    end { 
        Write-Output $dict
    }
}


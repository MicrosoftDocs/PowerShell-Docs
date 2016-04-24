function sum-value {
    [CmdletBinding()]
    Param(
        [parameter (ValueFromPipeline=$true)] [int]$number
    )

    begin { 
        [int]$total = 0;
        [int]$items = 0;
    }
    process {
        $total = $total + $number;
        $items = $items + 1; 
        Write-Output "Adding $number gives $total" 
    }
    end { 
        Write-Output "Total items: $items" 
    }
}

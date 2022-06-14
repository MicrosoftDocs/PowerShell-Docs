@{
  Parameters = @(
    @{
      Name = 'Repository'
      Type = 'String'
      IfNullOrEmpty = {
        param($ErrorTarget)

        $ErrorDetails = @{
          Name    = 'Repository'
          Type    = 'Missing'
          Message = @(
            'Could not determine repository;'
            'was it passed as an input to the action?'
          ) -join ' '
          Target  = $ErrorTarget
        }
        $Record = New-InvalidParameterError @ErrorDetails

        throw $Record
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        $Parameters.Owner, $Parameters.Repo = $Value -split '/'
        Write-HostParameter -Name Owner -Value $Parameters.Owner
        Write-HostParameter -Name Repo -Value $Parameters.Repo

        return $Parameters
      }
    }

    @{
      Name = 'Number'
      Type = 'Int'
      IfNullOrEmpty = {
        param($ErrorTarget)

        $ErrorDetails = @{
          Name    = 'Number'
          Type    = 'Missing'
          Message = @(
            'Could not determine the Pull Request number to report on;'
            'was it passed as an input to the action?'
          ) -join ' '
          Target  = $ErrorTarget
        }
        $Record = New-InvalidParameterError @ErrorDetails

        throw $Record
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        $Parameters.Number = [int]$Value

        Write-HostParameter -Name Number -Value $Parameters.Number

        return $Parameters
      }
    }

    @{
      Name = 'Include_Path_Pattern'
      Type = 'String[]'
      IfNullOrEmpty = {
        # It's okay if this parameter is not specified.
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        $Patterns = $Value -split "`n"
        | ForEach-Object -Process { $_.Trim().Trim('"').Trim("'") }
        | Where-Object -FilterScript { -not [string]::IsNullOrEmpty($_) }

        if ($Patterns.Count -gt 0) {
          $Parameters.IncludePathPattern = $Patterns
          Write-HostParameter -Name IncludePathPattern -Value $Parameters.IncludePathPattern
        } else {
          Write-Warning "You should never see this; something went wrong figuring out the patterns!"
        }

        return $Parameters
      }
    }
    @{
      Name = 'Exclude_Path_Pattern'
      Type = 'String[]'
      IfNullOrEmpty = {
        # It's okay if this parameter is not specified.
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        $Patterns = $Value -split "`n"
        | ForEach-Object -Process { $_.Trim().Trim('"').Trim("'") }
        | Where-Object -FilterScript { -not [string]::IsNullOrEmpty($_) }

        if ($Patterns.Count -gt 0) {
          $Parameters.ExcludePathPattern = $Patterns
          Write-HostParameter -Name ExcludePathPattern -Value $Parameters.ExcludePathPattern
        } else {
          Write-Warning "You should never see this; something went wrong figuring out the patterns!"
        }

        return $Parameters
      }
    }
  )
}
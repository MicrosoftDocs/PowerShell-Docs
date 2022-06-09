@{
  Parameters = @(
    @{
      Name = 'Body'
      Type = 'string'
      IfNullOrEmpty = {
        param($ErrorTarget)

        $ErrorDetails = @{
          Name  = 'Body'
          Type  = 'Missing'
          Message = @(
            'Could not determine the body of the PR;'
            'was it passed as an input to the action?'
          ) -join ' '
          Target  = $ErrorTarget
        }
        $Record = New-InvalidParameterError @ErrorDetails

        throw $Record
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        $Parameters.Body = $Value
        Write-HostParameter -Name Body -Value $Parameters.Body -MultiLine

        return $Parameters
      }
    }

    @{
      Name          = 'Reference_Url'
      Type          = 'string'
      IfNullOrEmpty = {
        param($ErrorTarget)

        $ErrorDetails = @{
          Name    = 'ReferenceUrl'
          Type    = 'Missing'
          Message = @(
            'Could not determine the URL of the item;'
            'was it passed as an input to the action?'
          ) -join ' '
          Target  = $ErrorTarget
        }
        $Record = New-InvalidParameterError @ErrorDetails

        throw $Record
      }
      Process = {
        param($Parameters, $Value, $ErrorTarget)

        $Parameters.ReferenceUrl = $Value
        Write-HostParameter -Name ReferenceUrl -Value $Parameters.ReferenceUrl

        return $Parameters
      }
    }
  )
}
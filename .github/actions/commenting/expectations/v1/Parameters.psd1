@{
    Parameters = @(
      @{
        Name = 'Repository'
        Type = 'string'
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
        Name = 'Message_Body'
        Type = 'String'
        IfNullOrEmpty = {
          param($ErrorTarget)

          if ([string]::IsNullOrEmpty($env:INPUT_MESSAGE_PATH)) {
            $Message = @(
              'Could not determine the message body or path to write as the expectation comment;'
              'was either value passed as an input to the action?'
            ) -join ' '
            $Message = Format-GHAConsoleText -Text $Message
            $ErrorDetails = @{
              Name    = 'Message'
              Type    = 'Missing'
              Message = $Message
              Target  = $ErrorTarget
            }
            $Record = New-InvalidParameterError @ErrorDetails

            throw $Record
          }
        }
        Process = {
          param($Parameters, $Value, $ErrorTarget)

          if (![string]::IsNullOrEmpty($Value)) {
            if ($null -ne $Parameters.Message) {
              $Warning = @(
                'Specified both message body and path; preferring the explicitly passed'
                'body over the path. If you want to comment with a file, do not specify'
                'the message_body parameter.'
              ) -join ' '
              Write-Warning $Warning
            }
  
            $Parameters.Message = $Value
            Write-HostParameter -Name Message -Value $Parameters.Message -MultiLine
          }

          return $Parameters
        }
      }

      @{
        Name = 'Message_Path'
        Type = 'String'
        IfNullOrEmpty = {
          param($ErrorTarget)

          if ([string]::IsNullOrEmpty($env:INPUT_MESSAGE_BODY)) {
            $Message = @(
              'Could not determine the message body or path to write as the expectation comment;'
              'was either value passed as an input to the action?'
            ) -join ' '
            $Message = Format-GHAConsoleText -Text $Message
            $ErrorDetails = @{
              Name    = 'Message'
              Type    = 'Missing'
              Message = $Message
              Target  = $ErrorTarget
            }
            $Record = New-InvalidParameterError @ErrorDetails

            throw $Record
          }
        }
        Process = {
          param($Parameters, $Value, $ErrorTarget)

          if (![string]::IsNullOrEmpty($Value)) {
            if ($null -eq $Parameters.Message) {
              $Message = Get-Content -Raw -Path $Value
              $Parameters.Message = $Message
              Write-HostParameter -Name Message -Value $Parameters.Message -MultiLine
            } else {
              $Warning = @(
                'Specified both message body and path; preferring the explicitly passed'
                'body over the path. If you want to comment with a file, do not specify'
                'the message_body parameter.'
              ) -join ' '
              Write-Warning $Warning
            }
          }

          return $Parameters
        }
      }
    )
  }
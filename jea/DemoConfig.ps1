Configuration JeaTest
{
    Import-DscResource -Module JustEnoughAdministration, PSDesiredStateConfiguration

    File DnsAdminRoleCapability
    {
        SourcePath = "\\moduleSource\RoleCapabilities\DnsAdmin.psrc"
        DestinationPath = "C:\Program Files\WindowsPowerShell\Modules\JeaEndpoint\RoleCapabilities\DnsAdmin.psrc"
        Checksum = "ModifiedDate"
        Ensure = "Present"
        Type = "File"
    }

    JeaEndpoint Endpoint
    {
        EndpointName = "Microsoft.PowerShell"
        RoleDefinitions = "@{ 'CONTOSO\DnsAdmins' = @{ RoleCapabilities = 'DnsAdmin' } }"
        TranscriptDirectory = 'C:\ProgramData\JeaEndpoint\Transcripts'
        ScriptsToProcess = 'C:\ProgramData\JeaEndpoint\startup.ps1'
    }
}
# Automatic RunAs support for DSC Resources
Support for DSC RunAs credential
--------------------------------

WMF 5.0 Preview April 2015 includes support for running **any** DSC resource under a specified set of credentials by using the property PsDscRunAsCredential. It enables scenarios like installing MSI packages in a specific user context, accessing a user’s registry hive, accessing a user’s specific local directory, accessing a network share, etc.

The following shows an example of using the PsDscRunAsCredential property in DSC to change the background color of the command prompt of a user.

Configuration ChangeCmdBackGroundColor

{

    Node ("localhost")

    {

        Registry CmdPath

        {

            Key = "HKEY\_CURRENT\_USER\\\\Software\\Microsoft\\\\Command Processor"

            ValueName = "DefaultColor"

            ValueData = '1F'

            ValueType = "DWORD"

            Ensure = "Present"

            Force = $true

            Hex = $true

            PsDscRunAsCredential = get-credential

        }

    }

}

$configData = @{

AllNodes = @(

@{

NodeName="localhost";

CertificateFile = "C:\\publicKeys\\targetNode.cer"

}

)

}

ChangeCmdBackGroundColor -ConfigurationData $configData

## Known issues

In this release, the following are known issues of the DSC RunAs credential feature:

-   The WindowsProcess resource doesn’t support RunAs credential.


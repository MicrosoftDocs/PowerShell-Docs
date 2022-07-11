### Security

#### Always use PSCredential for credentials/passwords

You must avoid storing the password in a plain string object, or allowing the user to type them in
as a parameter (where it might end up in the history or exposed to screen-scraper malware). The best
method for this is to always deal with PSCredential objects (which store the Password in a
SecureString).

More specifically, you should always take PSCredentials as a parameter (and never call
Get-Credential within your function) to allow the user the opportunity to reuse credentials stored
in a variable.

Furthermore, you should use the Credential attribute as the built-in commands do, so if the user
passes their user name (instead of a PSCredential object), they will be prompted for their password
in a Windows secure dialog.

```PowerShell
param (
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credentials
)
```

If you absolutely must pass a password in a plain string to a .Net API call or a third party library
it is better to decrypt the credential as it is being passed instead of saving it in a variable.

```PowerShell
# Get the cleartext password for a method call:
$Insecure.SetPassword( $Credentials.GetNetworkCredential().Password )
```

#### Other Secure Strings

For other strings that may be sensitive, use the SecureString type to protect the value of the
string. Be sure to always provide an example for the user of passing the value using
`Read-Host -AsSecureString`.

Note, if you ever need to turn a SecureString into a string, you can use this method, but make sure
to call ZeroFreeBSTR to avoid a memory leak:

```PowerShell
# Decrypt a secure string.
$BSTR = [System.Runtime.InteropServices.marshal]::SecureStringToBSTR($this);
$plaintext = [System.Runtime.InteropServices.marshal]::PtrToStringAuto($BSTR);
[System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR);
return $plaintext
```

* For credentials that need to be saved to disk, serialize the credential object using Export-CliXml
  to protect the password value. The password will be protected as a secure string and will only be
  accessible to the user who generated the file on the same computer where it was generated.

```PowerShell
# Save a credential to disk
Get-Credential | Export-CliXml -Path c:\creds\credential.xml

# Import the previously saved credential
$Credential = Import-CliXml -Path c:\creds\credential.xml
```

* For strings that may be sensitive and need to be saved to disk, use ConvertFrom-SecureString to
  encrypt it into a standard string that can be saved to disk. You can then use
  ConvertTo-SecureString to convert the encrypted standard string back into a SecureString. NOTE:
  These commands use the Windows Data Protection API (DPAPI) to encrypt the data, so the encrypted
  strings can only be decrypted by the same user on the same machine, but there is an option to use
  AES with a shared key.

```PowerShell
# Prompt for a Secure String (in automation, just accept it as a parameter)
$Secure = Read-Host -Prompt "Enter the Secure String" -AsSecureString

# Encrypt to Standard String and store on disk
ConvertFrom-SecureString -SecureString $Secure | Out-File -Path "${Env:AppData}\Sec.bin"

# Read the Standard String from disk and convert to a SecureString
$Secure = Get-Content -Path "${Env:AppData}\Sec.bin" | ConvertTo-SecureString
```

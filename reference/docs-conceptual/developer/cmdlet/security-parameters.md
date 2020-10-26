---
ms.date: 09/13/2016
ms.topic: reference
title: Security Parameters
description: Security Parameters
---
# Security Parameters

The following table lists the recommended names and functionality for parameters used to provide security information for an operation, such as parameters that specify certificate key and privilege information.

|Parameter|Functionality|
|---|---|
|**ACL**<br>Data type: String|Implement this parameter to specify the access control level of protection for a catalog or for a Uniform Resource Identifier (URI).|
|**CertFile**<br>Data type: String|Implement this parameter so that the user can specify the name of a file that contains one of the following:<br>- A Base64 or Distinguished Encoding Rules (DER) encoded x.509 certificate<br>- A Public Key Cryptography Standards (PKCS) #12 file that contains at least one certificate and key|
|**CertIssuerName**<br>Data type: String|Implement this parameter so that the user can specify the name of the issuer of a certificate or so that the user can specify a substring.|
|**CertRequestFile**<br>Data type: String|Implement this parameter to specify the name of a file that contains a Base64 or DER-encoded PKCS #10 certificate request.|
|**CertSerialNumber**<br>Data type: String|Implement this parameter to specify the serial number that was issued by the certification authority.|
|**CertStoreLocation**<br>Data type: String|Implement this parameter so that the user can specify the location of the certificate store. The location is typically a file path.|
|**CertSubjectName**<br>Data type: String|Implement this parameter so that the user can specify the issuer of a certificate or so that the user can specify a substring.|
|**CertUsage**<br>Data type: String|Implement this parameter to specify the key usage or the enhanced key usage. The key can be represented as a bit mask, a bit, an object identifier (OID), or a string.|
|**Credential**<br>Data type: [System.Management.Automation.PSCredential](/dotnet/api/System.Management.Automation.PSCredential)|Implement this parameter so that the cmdlet will automatically prompt the user for a user name or password. A prompt for both is displayed if a full credential is not supplied directly.|
|**CSPName**<br>Data type: String|Implement this parameter so that the user can specify the name of the certificate service provider (CSP).|
|**CSPType**<br>Data type: Integer|Implement this parameter so that the user can specify the type of CSP.|
|**Group**<br>Data type: String|Implement this parameter so that the user can specify a collection of principals for access. For more information, see the description of the **Principal** parameter.|
|**KeyAlgorithm**<br>Data type: String|Implement this parameter so that the user can specify the key generation algorithm to use for security.|
|**KeyContainerName**<br>Data type: String|Implement this parameter so that the user can specify the name of the key container.|
|**KeyLength**<br>Data type: Integer|Implement this parameter so that the user can specify the length of the key in bits.|
|**Operation**<br>Data type: String|Implement this parameter so that the user can specify an action that can be performed on a protected object.|
|**Principal**<br>Data type: String|Implement this parameter so that the user can specify a unique identifiable entity for access.|
|**Privilege**<br>Data type: String|Implement this parameter so that the user can specify the right a cmdlet needs to perform an operation for a particular entity.|
|**Privileges**<br>Data type: Array of privileges|Implement this parameter so that the user can specify the rights that a cmdlet needs to perform its operation for a particular entry.|
|**Role**<br>Data type: String|Implement this parameter so that the user can specify a set of operations that can be performed by an entity.|
|**SaveCred**<br>Data type: SwitchParameter|Implement this parameter so that credentials that were previously saved by the user will be used when the parameter is specified.|
|**Scope**<br>Data type: String|Implement this parameter so that the user can specify the group of protected objects for the cmdlet.|
|**SID**<br>Data type: String|Implement this parameter so that the user can specify a unique identifier that represents a principal.|
|**Trusted**<br>Data type: SwitchParameter|Implement this parameter so that trust levels are supported when the parameter is specified.|
|**TrustLevel**<br>Data type: Keyword|Implement this parameter so that the user can specify the trust level that is supported. For example, possible values include internet, intranet, and fulltrust.|

## See Also

[Cmdlet Parameters](./cmdlet-parameters.md)

[Writing a Windows PowerShell Cmdlet](./writing-a-windows-powershell-cmdlet.md)

[Windows PowerShell SDK](../windows-powershell-reference.md)

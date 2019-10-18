---
title: "Implementing Custom Authorization for a Management OData web service | Microsoft Docs"
ms.custom: ""
ms.date: "09/13/2016"
ms.reviewer: ""
ms.suite: ""
ms.tgt_pltfrm: ""
ms.topic: "article"
ms.assetid: ae37e3f3-5fd6-4ff6-bf66-a249ff96822b
caps.latest.revision: 7
---
# Implementing Custom Authorization for a Management OData web service

Using the Windows PowerShell Web Service requires a third party to implement the [Microsoft.Management.Odata.CustomAuthorization](/dotnet/api/Microsoft.Management.Odata.CustomAuthorization) interface to expose Windows PowerShell cmdlets. This interface performs user authorization to the web service. After writing the code to implement the interface, you must compile it into a DLL to be used in the web application.

## Pass-through authorization

The simplest way to implement the [Microsoft.Management.Odata.CustomAuthorization](/dotnet/api/Microsoft.Management.Odata.CustomAuthorization) interface is a pass-through implementation that authorizes all users. This example provides no security, and s provided only as an illustration of how to implement the interface. An implementation of the  [Microsoft.Management.Odata.CustomAuthorization](/dotnet/api/Microsoft.Management.Odata.CustomAuthorization) interface must override two methods: [Microsoft.Management.Odata.CustomAuthorization.AuthorizeUser](/dotnet/api/Microsoft.Management.Odata.CustomAuthorization.AuthorizeUser) and [Microsoft.Management.Odata.CustomAuthorization.GetMembershipId](/dotnet/api/Microsoft.Management.Odata.CustomAuthorization.GetMembershipId). In this example, the [Microsoft.Management.Odata.CustomAuthorization.AuthorizeUser](/dotnet/api/Microsoft.Management.Odata.CustomAuthorization.AuthorizeUser) always returns the **System.Security.Principal.WindowsIdentity** object associated with the current user.

```csharp
namespace Microsoft.Samples. HYPERLINK "VBScript:u(%227%22,19)" Management. HYPERLINK "VBScript:u(%227%22,30)" OData. HYPERLINK "VBScript:u(%227%22,36)" BasicPlugins

{

    using System.Configuration;

    using System.Globalization;

    using System.Security. HYPERLINK "VBScript:u(%22B%22,17)" Principal;

    using Microsoft.Management. HYPERLINK "VBScript:u(%22C%22,22)" Odata;

    // Basic CustomAuthorization implementation

   // Management OData service uses Microsoft.Management.Odata.CustomAuthorization interface to authorize a user.

    // This is a pass-through implementation which means it authorizes all users.

    // It gives same quota values for all users. The quota values can be overridden by following application settings:

    // MaxConcurrentRequests: Overrides maximum number of concurrent requests for a user

    // MaxRequestsPerTimeslot: Overrides maximum number of requests in a time slot

    // TimeslotSize: Override size of time slot (in seconds)

    public class CustomAuthorization : Microsoft.Management. HYPERLINK "VBScript:u(%22N%22,106)" Odata. HYPERLINK "VBScript:u(%22N%22,135)" CustomAuthorization

    {

        // Default value of max concurrent requests

        private const int DefaultMaxConcurrentRequests = 10;

        // Default value of max request per time slot

        private const int DefaultMaxRequestsPerTimeslot = 4;

        // Default time slot size

        private const int DefaultTimeslotSize = 1;

        /// <summary>

        /// Default management system state key

        /// </summary>

        private const string DefaultManagementSystemStateId = "E7D438A1-C0BA-49D6-952E-EF7C45CB737D";

        /// <summary>

        /// Authorize a user.

        /// </summary>

        /// <param name="senderInfo">Sender information</param>

        /// <param name="userQuota">User quota value</param>

        /// <returns>User context in which to execute PowerShell cmdlet</returns>

        public override WindowsIdentity AuthorizeUser( HYPERLINK "VBScript:u(%221F%22,31)" SenderInfo senderInfo, out UserQuota userQuota)

        {

            var maxConcurrentRequests = ConfigurationManager.AppSettings["MaxConcurrentRequests"];

            var maxRequestsPerTimeslot = ConfigurationManager.AppSettings["MaxRequestsPerTimeslot"];

            var timeslotSize = ConfigurationManager.AppSettings["TimeslotSize"];

            userQuota = new UserQuota(

                maxConcurrentRequests != null ? int. HYPERLINK "VBScript:u(%221M%22,1)" Parse( HYPERLINK "VBScript:u(%221M%22,7)" maxConcurrentRequests, CultureInfo.CurrentUICulture) : DefaultMaxConcurrentRequests,

                maxRequestsPerTimeslot != null ? int. HYPERLINK "VBScript:u(%221N%22,1)" Parse( HYPERLINK "VBScript:u(%221N%22,7)" maxRequestsPerTimeslot, CultureInfo.CurrentUICulture) : DefaultMaxRequestsPerTimeslot,

                timeslotSize != null ? int. HYPERLINK "VBScript:u(%221O%22,1)" Parse( HYPERLINK "VBScript:u(%221O%22,7)" timeslotSize, CultureInfo.CurrentUICulture) : DefaultTimeslotSize);

            return WindowsIdentity.GetCurrent();

        }

        /// <summary>

        /// Gets membership id

        /// </summary>

        /// <param name="senderInfo">Sender information</param>

        /// <returns>Always returns same membership id for all users which means all users are in same group</returns>

        public override string GetMembershipId( HYPERLINK "VBScript:u(%221Y%22,24)"SenderInfo senderInfo)

        {

            return DefaultManagementSystemStateId;

        }

    }

}

```

### Role-based authorization

The following example implements a role-based authorization policy. The policy is defined in an XML file that resides in the main application directory with the web.config and MOF and XML mapping schema files. For information about how to configure the authorization schema file, see [Configuring Role-based Authorization](./configuring-role-based-authorization.md). The first part of the sample implements the [Microsoft.Management.Odata.CustomAuthorization.AuthorizeUser](/dotnet/api/Microsoft.Management.Odata.CustomAuthorization.AuthorizeUser) and [Microsoft.Management.Odata.CustomAuthorization.GetMembershipId](/dotnet/api/Microsoft.Management.Odata.CustomAuthorization.GetMembershipId) methods. In this case, the interface methods call methods in the `RbacSystem` class (defined below) that do the actual work of checking the permissions for the user.

```csharp
namespace Microsoft.Samples.Management.OData.RoleBasedPlugins
{
    using System;
    using System.Security.Principal;
    using Microsoft.Management.Odata;

    public class CustomAuthorization : Microsoft.Management.Odata.CustomAuthorization
    {

        // Authorizes a user

        //WindowsIdentity, if the user is authorized else throws an exception
        public override WindowsIdentity AuthorizeUser(SenderInfo senderInfo, out UserQuota quota)
        {
            if ((senderInfo == null) || (senderInfo.Principal == null) || (senderInfo.Principal.Identity == null))
            {
                throw new ArgumentNullException("senderInfo");
            }

            if (senderInfo.Principal.Identity.IsAuthenticated == false)
            {
                throw new ArgumentException("User is not authenticated");
            }

            RbacUser.RbacUserInfo userInfo = null;
            if (senderInfo.Principal.WindowsIdentity != null)
            {
                userInfo = new RbacUser.RbacUserInfo(senderInfo.Principal.WindowsIdentity);
            }
            else
            {
                userInfo = new RbacUser.RbacUserInfo(senderInfo.Principal.Identity);
            }

            return RbacSystem.Current.AuthorizeUser(userInfo, out quota);
        }

        // Gets Management system execution state keys for a user

        public override string GetMembershipId(SenderInfo senderInfo)
        {
            if ((senderInfo == null) || (senderInfo.Principal == null) || (senderInfo.Principal.Identity == null))
            {
                throw new ArgumentNullException("senderInfo");
            }

            return RbacSystem.Current.GetMembershipId(new RbacUser.RbacUserInfo(senderInfo.Principal.Identity));
        }
    }
}
```

The following example creates a class that parses authorization policy in the XML file.

```csharp
//-----------------------------------------------------------------------
// <copyright file="RbacConfiguration.cs" company="Microsoft Corporation">
//     Copyright (C) 2011 Microsoft Corporation
// </copyright>
//-----------------------------------------------------------------------

namespace Microsoft.Samples.Management.OData.RoleBasedPlugins
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Xml;
    using System.Xml.Schema;
    using System.Xml.Serialization;

    /// <summary>
    /// Keeps Configuration for the RbacSystem
    /// It reads the RacSystem configuration for configuration file and creates RbacConfiguration
    /// </summary>
    [Serializable]
    [XmlRoot("RbacConfiguration")]
    public class XmlConfiguration
    {
        /// <summary>
        /// Initializes a new instance of the XmlConfiguration class
        /// </summary>
        public XmlConfiguration()
        {
            this.Users = new List<XmlUser>();
            this.Groups = new List<XmlGroup>();
        }

        /// <summary> Gets collection of groups </summary>
        [XmlArray("Groups")]
        [XmlArrayItem("Group", typeof(XmlGroup))]
        public List<XmlGroup> Groups { get; private set; }

        /// <summary> Gets collection of users </summary>
        [XmlArray("Users")]
        [XmlArrayItem("User", typeof(XmlUser))]
        public List<XmlUser> Users { get; private set; }

        /// <summary>
        /// Creates RbacConfiguration from Rbac configuration file
        /// </summary>
        /// <param name="configPath">full path to the config file</param>
        /// <returns>RbacConfiguration created from the configuration file</returns>
        public static XmlConfiguration Create(string configPath)
        {
            string configData = File.ReadAllText(configPath);

            try
            {
                XmlReader xsd = XmlReader.Create(new StringReader(Resources.rbac));

                XmlReaderSettings settings = new XmlReaderSettings();

                settings.IgnoreComments = true;
                settings.IgnoreProcessingInstructions = true;
                settings.IgnoreWhitespace = true;
                settings.XmlResolver = null;
                settings.ValidationType = ValidationType.Schema;

                settings.ValidationEventHandler += delegate(object sender, ValidationEventArgs args)
                {
                    throw new ArgumentException("Rbac configuration file is incorrect", args.Exception);
                };

                XmlSerializer serializer = new XmlSerializer(typeof(XmlConfiguration));

                using (XmlReader reader = XmlReader.Create(new StringReader(configData), settings))
                {
                    return serializer.Deserialize(reader) as XmlConfiguration;
                }
            }
            catch (XmlException)
            {
                throw;
            }
        }
    }

    /// <summary>
    /// Represents Group in the RbacConfiguration
    /// </summary>
    [Serializable]
    public class XmlGroup
    {
        /// <summary>
        /// Initializes a new instance of the XmlGroup class
        /// </summary>
        public XmlGroup()
        {
            this.Cmdlets = new List<string>();
            this.Scripts = new List<string>();
            this.Modules = new List<string>();
        }

        /// <summary> Gets or sets name of the group </summary>
        [XmlAttribute("Name")]
        public string Name { get; set; }

        /// <summary> Gets or sets user name of the user in which context commands are executed for this group </summary>
        [XmlAttribute("UserName")]
        public string UserName { get; set; }

        /// <summary> Gets or sets password of the user in which context commands are executed for this group </summary>
        [XmlAttribute("Password")]
        public string Password { get; set; }

        /// <summary> Gets or sets domain of the user in which context commands are executed for this group </summary>
        [XmlAttribute("DomainName")]
        public string DomainName { get; set; }

        /// <summary> Gets or sets a value which indicates whether to map incoming user to the user context returned from custom authorization </summary>
        [XmlAttribute("MapIncomingUser")]
        public bool MapIncomingUser { get; set; }

        /// <summary> Gets collection of cmdlets in the group </summary>
        [XmlArray("Cmdlets")]
        [XmlArrayItem("Cmdlet", typeof(string))]
        public List<string> Cmdlets { get; private set; }

        /// <summary> Gets collection of cmdlets in the group </summary>
        [XmlArray("Scripts")]
        [XmlArrayItem("Script", typeof(string))]
        public List<string> Scripts { get; private set; }

        /// <summary> Gets collection of cmdlets in the group </summary>
        [XmlArray("Modules")]
        [XmlArrayItem("Module", typeof(string))]
        public List<string> Modules { get; private set; }
    }

    /// <summary>
    /// Represents User in the RbacConfiguration
    /// </summary>
    [Serializable]
    public class XmlUser
    {
        /// <summary> Gets or sets name of the user </summary>
        [XmlAttribute("Name")]
        public string Name { get; set; }

        /// <summary> Gets or sets authentication type used for the user </summary>
        [XmlAttribute("AuthenticationType")]
        public string AuthenticationType { get; set; }

        /// <summary> Gets or sets domain name of the user. If this is null/empty, domain is local machine </summary>
        [XmlAttribute("DomainName")]
        public string DomainName { get; set; }

        /// <summary> Gets or sets group in which the user has membership </summary>
        [XmlAttribute("GroupName")]
        public string GroupName { get; set; }

        /// <summary> Gets or sets quota for the user </summary>
        [XmlElement("Quota", typeof(XmlQuota))]
        public XmlQuota Quota { get; set; }
    }

    /// <summary>
    /// Represents quota for a user
    /// </summary>
    [Serializable]
    public class XmlQuota
    {
        /// <summary> Gets or sets maximum concurrent requests </summary>
        [XmlAttribute("MaxConcurrentRequests")]
        public int MaxConcurrentRequests { get; set; }

        /// <summary> Gets or sets maximum requests per time slot</summary>
        [XmlAttribute("MaxRequestsPerTimeslot")]
        public int MaxRequestsPerTimeslot { get; set; }

        /// <summary> Gets or sets time slot</summary>
        [XmlAttribute("Timeslot")]
        public int Timeslot { get; set; }
    }
}
```

 The following classes represent groups and users, respectively.

```csharp
//-----------------------------------------------------------------------
// <copyright file="RbacGroup.cs" company="Microsoft Corporation">
//     Copyright (C) 2011 Microsoft Corporation
// </copyright>
//-----------------------------------------------------------------------

namespace Microsoft.Samples.Management.OData.RoleBasedPlugins
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Security.Principal;

    /// <summary>
    /// Class represents a group in RBAC
    /// </summary>
    internal class RbacGroup
    {
        /// <summary>Default key guid</summary>
        private Guid keyGuid = Guid.NewGuid();

        /// <summary>
        /// Initializes a new instance of the RbacGroup class
        /// </summary>
        /// <param name="group">Group information</param>
        public RbacGroup(XmlGroup group)
            : this(group != null ? group.Name : string.Empty, group)
        {
        }

        /// <summary>
        /// Initializes a new instance of the RbacGroup class.
        /// </summary>
        /// <param name="groupName">Group name</param>
        /// <param name="group">Group configuration</param>
        public RbacGroup(string groupName, XmlGroup group)
        {
            if (string.IsNullOrEmpty(groupName))
            {
                throw new ArgumentException("groupName is passed as empty or null");
            }

            this.Name = groupName;

            if (group != null)
            {
                if (group.MapIncomingUser == true)
                {
                    this.MapIncomingUser = group.MapIncomingUser;

                    if (string.IsNullOrEmpty(group.UserName) == false || string.IsNullOrEmpty(group.Password) == false || string.IsNullOrEmpty(group.DomainName) == false)
                    {
                        throw new ArgumentException("Group " + groupName + " has defined incoming user to true and defined credential for mapped user. They are exclusive and only one can be defined.");
                    }
                }
                else
                {
                    this.UserName = group.UserName;
                    this.Password = group.Password;
                    this.DomainName = group.DomainName;
                }
            }

            if (group != null && group.Cmdlets != null)
            {
                this.Cmdlets = new List<string>(group.Cmdlets);
            }
            else
            {
                this.Cmdlets = new List<string>();
            }

            this.Scripts = new List<string>();

            if (group != null && group.Scripts != null)
            {
                foreach (string script in group.Scripts)
                {
                    this.Scripts.Add(script);
                }
            }

            this.Modules = new List<string>();

            if (group != null && group.Modules != null)
            {
                foreach (string module in group.Modules)
                {
                    this.Modules.Add(Path.Combine(Utils.GetBasePath(), module));
                }
            }
        }

        /// <summary> Gets name of the group </summary>
        public string Name { get; private set; }

        /// <summary> Gets collection of Commands supported in the group </summary>
        public List<string> Cmdlets { get; private set; }

        /// <summary> Gets collection of Scripts supported in the group </summary>
        public List<string> Scripts { get; private set; }

        /// <summary> Gets collection of Modules supported in the group </summary>
        public List<string> Modules { get; private set; }

        /// <summary> Gets or sets value indicating whether to use network client identity for executing a cmdlet </summary>
        public bool MapIncomingUser { get; private set; }

        /// <summary> Gets user name </summary>
        public string UserName { get; private set; }

        /// <summary> Gets password </summary>
        public string Password { get; private set; }

        /// <summary> Gets domain name </summary>
        public string DomainName { get; private set; }

        /// <summary>
        /// Gets the membershipId for the group
        /// </summary>
        /// <returns>Membership id of the group</returns>
        public string GetMembershipId()
        {
            return this.Name + this.keyGuid.ToString();
        }

        /// <summary>
        /// Gets Windows Identity associated with this group
        /// </summary>
        /// <returns>Windows Identity associated with this group</returns>
        public WindowsIdentity GetWindowsIdentity(WindowsIdentity incomingIdentity)
        {
            WindowsIdentity identity = null;

            if (this.MapIncomingUser == true)
            {
                if (incomingIdentity == null)
                {
                    throw new ArgumentException("Current user is mapped to group " + this.Name + " which is expected to return context of the incoming user. But context of the incoming user passed is null.");
                }

                return incomingIdentity;
            }

            if (this.UserName == null || this.Password == null)
            {
                if (this.UserName == null && this.Password == null)
                {
                    identity = WindowsIdentityHelper.GetCurrentWindowsIdentity();
                }
                else
                {
                    if (this.UserName == null)
                    {
                        throw new ArgumentException("User name is null for group " + this.Name);
                    }

                    if (this.Password == null)
                    {
                        throw new ArgumentException("Password is null for group " + this.Name);
                    }
                }
            }
            else
            {
                identity = WindowsIdentityHelper.GetWindowsIdentity(this.UserName, this.Password, this.DomainName);
            }

            return identity;
        }
    }
}
```

```csharp
//-----------------------------------------------------------------------
// <copyright file="RbacUser.cs" company="Microsoft Corporation">
//     Copyright (C) 2011 Microsoft Corporation
// </copyright>
//-----------------------------------------------------------------------

namespace Microsoft.Samples.Management.OData.RoleBasedPlugins
{
    using System;
    using System.Management.Automation.Remoting;
    using System.Security.Principal;

    /// <summary>
    /// Class Represents a user in RBAC
    /// </summary>
    internal class RbacUser
    {
        /// <summary>
        /// Initializes a new instance of the RbacUser class.
        /// </summary>
        /// <param name="userInfo">Name of the user</param>
        /// <param name="quota">User quota value</param>
        public RbacUser(RbacUserInfo userInfo, XmlQuota quota)
        {
            this.UserInfo = userInfo;
            this.Quota = new RbacQuota(quota);
        }

        /// <summary> Gets user information </summary>
        public RbacUserInfo UserInfo { get; private set; }

        /// <summary> Gets or sets list of groups the user is member of </summary>
        public RbacGroup Group { get; set; }

        /// <summary> Gets quota limits for the user </summary>
        public RbacQuota Quota { get; private set; }

        /// <summary>
        /// Gets the membershipId of the user
        /// </summary>
        /// <returns>Membership Id of the user</returns>
        public string GetMembershipId()
        {
            return this.Group.GetMembershipId();
        }

        /// <summary>
        /// RBAC system user information
        /// </summary>
        public class RbacUserInfo : IEquatable<RbacUserInfo>
        {
            /// <summary>
            /// Initializes a new instance of the RbacUserInfo class.
            /// </summary>
            /// <param name="name">Name of the user</param>
            /// <param name="authenticationType">Authentication type used</param>
            /// <param name="domainName">Domain name of the user. If the domain name is empty, localmachine name is used as domain</param>
            public RbacUserInfo(
                string name,
                string authenticationType,
                string domainName)
            {
                if (string.IsNullOrEmpty(domainName))
                {
                    domainName = Environment.MachineName;
                }

                this.Name = domainName + "\\" + name;
                this.AuthenticationType = authenticationType;
            }

            /// <summary>
            /// Initializes a new instance of the RbacUserInfo class.
            /// </summary>
            /// <param name="identity">User identity</param>
            public RbacUserInfo(IIdentity identity)
                : this(identity, null)
            {
            }

            /// <summary>
            /// Initializes a new instance of the RbacUserInfo class.
            /// </summary>
            /// <param name="identity">User identity</param>
            /// <param name="clientCert">Http client certificate</param>
            public RbacUserInfo(IIdentity identity, PSCertificateDetails clientCert)
            {
                if (identity == null)
                {
                    throw new ArgumentNullException("identity");
                }

                this.WindowsIdentity = identity as WindowsIdentity;

                this.Name = identity.Name;
                this.AuthenticationType = identity.AuthenticationType;
                this.CertificateDetails = clientCert;
            }

            /// <summary> Gets name of the user </summary>
            public string Name { get; private set; }

            /// <summary> Gets authentication type</summary>
            public string AuthenticationType { get; private set; }

            /// <summary> Gets windows identity for the user </summary>
            public WindowsIdentity WindowsIdentity { get; private set; }

            /// <summary>
            /// Gets details of the (optional) client certificate
            /// </summary>
            public PSCertificateDetails CertificateDetails { get; private set; }

            /// <summary>
            /// compare two PSCredentialDetails for equivalence.
            /// </summary>
            /// <param name="first">one set of details</param>
            /// <param name="second">the other set of details</param>
            /// <returns>true if they refer to the same certificate</returns>
            public static bool AreSame(PSCertificateDetails first, PSCertificateDetails second)
            {
                if (first == null && second == null)
                {
                    return true;
                }

                if (first == null || second == null)
                {
                    return false;
                }

                if (string.Equals(first.IssuerName, second.IssuerName, StringComparison.OrdinalIgnoreCase) == false ||
                    string.Equals(first.Subject, second.Subject, StringComparison.OrdinalIgnoreCase) == false ||
                    string.Equals(first.IssuerThumbprint, second.IssuerThumbprint, StringComparison.OrdinalIgnoreCase) == false)
                {
                    return false;
                }

                return true;
            }

            /// <summary>
            /// Indicates whether the current object is equal to another object of the same type.
            /// </summary>
            /// <param name="other">Other RbacUserInfo instance</param>
            /// <returns>True if the current object is equal to the other parameter; otherwise, False.</returns>
            public bool Equals(RbacUserInfo other)
            {
                if (other == null)
                {
                    return false;
                }

                if (string.Equals(this.Name, other.Name, StringComparison.OrdinalIgnoreCase) == false ||
                    string.Equals(this.AuthenticationType, other.AuthenticationType, StringComparison.OrdinalIgnoreCase) == false ||
                    AreSame(this.CertificateDetails, other.CertificateDetails) == false)
                {
                    return false;
                }

                return true;
            }

            /// <summary>
            /// Indicates whether the current object is equal to another object of the object type.
            /// </summary>
            /// <param name="other">Other object instance</param>
            /// <returns>true, if both instance are same else false</returns>
            public override bool Equals(object other)
            {
                return this.Equals(other as RbacUserInfo);
            }

            /// <summary>
            /// Gets hash code for the object
            /// </summary>
            /// <returns>Hash code for the object</returns>
            public override int GetHashCode()
            {
                return base.GetHashCode();
            }
        }
    }
}
```

Finally, the RbacSystem class implements methods that do the work of checking the permissions for the user and return the authorization status to the methods defined in the implementation of the [Microsoft.Management.Odata.CustomAuthorization](/dotnet/api/Microsoft.Management.Odata.CustomAuthorization) interface.
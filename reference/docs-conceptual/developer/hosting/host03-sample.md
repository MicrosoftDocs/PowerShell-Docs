---
ms.date: 09/13/2016
ms.topic: reference
title: Host03 Sample
description: Host03 Sample
---
# Host03 Sample

This sample shows how to build an interactive console-based host application that reads commands
from the command line, executes the commands, and then displays the results to the console.

## Requirements

This sample requires Windows PowerShell 2.0.

## Demonstrates

- Creating a custom host whose classes derive from the
  [System.Management.Automation.Host.PSHost](/dotnet/api/System.Management.Automation.Host.PSHost)
  class, the
  [System.Management.Automation.Host.PSHostUserInterface](/dotnet/api/System.Management.Automation.Host.PSHostUserInterface)
  class, and the
  [System.Management.Automation.Host.PSHostRawUserInterface](/dotnet/api/System.Management.Automation.Host.PSHostRawUserInterface)
  class.

- Building a console application that uses these host classes to build an interactive Windows
  PowerShell shell.

## Example 1

This example allows the user to enter commands at a command line, processes those commands, and then
prints out the results.

```csharp
// Copyright (c) 2006 Microsoft Corporation. All rights reserved.
//
// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
// ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
// PARTICULAR PURPOSE.
//

namespace Microsoft.Samples.PowerShell.Host
{
  using System;
  using System.Collections.ObjectModel;
  using System.Management.Automation;
  using System.Management.Automation.Runspaces;
  using PowerShell = System.Management.Automation.PowerShell;

  /// This class contains the Main entry point for this host application.
  internal class PSListenerConsoleSample
  {
    /// Indicator to tell the host application that it should exit.
    private bool shouldExit;

    /// The exit code that the host application will use to exit.
    private int exitCode;

    /// Holds the instance of the PSHost implementation for this interpreter.
    private MyHost myHost;

    /// Holds the runspace for this interpreter.
    private Runspace myRunSpace;

    /// Holds a reference to the currently executing pipeline so it can be
    /// stopped by the control-C handler.
    private PowerShell currentPowerShell;

    /// Used to serialize access to instance data.
    private object instanceLock = new object();

    /// Create this instance of the console listener.
    private PSListenerConsoleSample()
    {
      // Create the host and runspace instances for this interpreter.
      // Note that this application does not support console files so
      // only the default snapins will be available.
      this.myHost = new MyHost(this);
      this.myRunSpace = RunspaceFactory.CreateRunspace(this.myHost);
      this.myRunSpace.Open();
    }

    /// Gets or sets a value indicating whether the host application
    /// should exit.
    public bool ShouldExit
    {
      get { return this.shouldExit; }
      set { this.shouldExit = value; }
    }

    /// Gets or sets the exit code that the host application will use
    /// when exiting.
    public int ExitCode
    {
      get { return this.exitCode; }
      set { this.exitCode = value; }
    }

    /// Creates and initiates the listener instance.
    /// param name="args";This parameter is not used.
    private static void Main(string[] args)
    {
      // Display the welcome message...
      Console.Title = "PowerShell Console Host Sample Application";
      ConsoleColor oldFg = Console.ForegroundColor;
      Console.ForegroundColor = ConsoleColor.Cyan;
      Console.WriteLine("    PowerShell Console Host Interactive Sample");
      Console.WriteLine("    =====================================");
      Console.WriteLine(string.Empty);
      Console.WriteLine("This is an example of a simple interactive console host that uses the ");
      Console.WriteLine("Windows PowerShell engine to interpret commands. Type 'exit' to exit.");
      Console.WriteLine(string.Empty);
      Console.ForegroundColor = oldFg;

      // Create the listener and run it - this never returns...
      PSListenerConsoleSample listener = new PSListenerConsoleSample();
      listener.Run();
    }

    /// A helper class that builds and executes a pipeline that writes to the
    /// default output path. Any exceptions that are thrown are just passed to
    /// the caller. Since all output goes to the default outputter, this method()
    /// won't return anything.
    /// param name="cmd"; The script to run.
    /// param name="input";Any input arguments to pass to the script. If null
    /// then nothing is passed in.
    private void executeHelper(string cmd, object input)
    {
      // Ignore empty command lines.
      if (String.IsNullOrEmpty(cmd))
      {
        return;
      }

      // Create the pipeline object and make it available
      // to the ctrl-C handle through the currentPowerShell instance
      // variable
      lock (this.instanceLock)
      {
        this.currentPowerShell = PowerShell.Create();
      }

      this.currentPowerShell.Runspace = this.myRunSpace;

      // Create a pipeline for this execution. Place the result in the
      // currentPowerShell instance variable so that it is available
      // to be stopped.
      try
      {
        this.currentPowerShell.AddScript(cmd);

        // Now add the default outputter to the end of the pipe and indicate
        // that it should handle both output and errors from the previous
        // commands. This will result in the output being written using the PSHost
        // and PSHostUserInterface classes instead of returning objects to the hosting
        // application.
        this.currentPowerShell.AddCommand("out-default");
        this.currentPowerShell.Commands.Commands[0].MergeMyResults(PipelineResultTypes.Error, PipelineResultTypes.Output);

        // If there was any input specified, pass it in, otherwise just
        // execute the pipeline.
        if (input != null)
        {
          this.currentPowerShell.Invoke(new object[] { input });
        }
        else
        {
          this.currentPowerShell.Invoke();
        }
      }
      finally
      {
        // Dispose of the pipeline line and set it to null, locked because
        // currentPowerShell may be accessed by the ctrl-C handler.
        lock (this.instanceLock)
        {
          this.currentPowerShell.Dispose();
          this.currentPowerShell = null;
        }
      }
    }

    /// An exception occurred that we want to display
    /// using the display formatter. To do this we run
    /// a second pipeline passing in the error record.
    /// The runtime will bind this to the $input variable
    /// which is why $input is being piped to out-string.
    /// We then call WriteErrorLine to make sure the error
    /// gets displayed in the correct error color.

    /// param name="e"; The exception to display.
    private void ReportException(Exception e)
    {
      if (e != null)
      {
        object error;
        IContainsErrorRecord icer = e as IContainsErrorRecord;
        if (icer != null)
        {
          error = icer.ErrorRecord;
        }
        else
        {
          error = (object)new ErrorRecord(e, "Host.ReportException", ErrorCategory.NotSpecified, null);
        }

        lock (this.instanceLock)
        {
          this.currentPowerShell = PowerShell.Create();
        }

        this.currentPowerShell.Runspace = this.myRunSpace;

        try
        {
          this.currentPowerShell.AddScript("$input").AddCommand("out-string");

          // Do not merge errors, this function will swallow errors.
          Collection<PSObject> result;
          PSDataCollection<object> inputCollection = new PSDataCollection<object>();
          inputCollection.Add(error);
          inputCollection.Complete();
          result = this.currentPowerShell.Invoke(inputCollection);

          if (result.Count > 0)
          {
            string str = result[0].BaseObject as string;
            if (!string.IsNullOrEmpty(str))
            {
              // Remove \r\n that is added by Out-string.
              this.myHost.UI.WriteErrorLine(str.Substring(0, str.Length - 2));
            }
          }
        }
        finally
        {
          // Dispose of the pipeline line and set it to null, locked because currentPowerShell
          // may be accessed by the ctrl-C handler.
          lock (this.instanceLock)
          {
            this.currentPowerShell.Dispose();
            this.currentPowerShell = null;
          }
        }
      }
    }

    /// Basic script execution routine - any runtime exceptions are
    /// caught and passed back into the engine to display.

    /// param name="cmd"; The parameter is not used.
    private void Execute(string cmd)
    {
      try
      {
        // Execute the command with no input.
        this.executeHelper(cmd, null);
      }
      catch (RuntimeException rte)
      {
        this.ReportException(rte);
      }
    }

    /// Method used to handle control-C's from the user. It calls the
    /// pipeline Stop() method to stop execution. If any exceptions occur
    /// they are printed to the console but otherwise ignored.

    /// param name="sender"; See sender property of ConsoleCancelEventHandler documentation.
    /// param name="e"; See e property of ConsoleCancelEventHandler documentation.
    private void HandleControlC(object sender, ConsoleCancelEventArgs e)
    {
      try
      {
        lock (this.instanceLock)
        {
          if (this.currentPowerShell != null && this.currentPowerShell.InvocationStateInfo.State == PSInvocationState.Running)
          {
            this.currentPowerShell.Stop();
          }
        }

        e.Cancel = true;
      }
      catch (Exception exception)
      {
        this.myHost.UI.WriteErrorLine(exception.ToString());
      }
    }

    /// Implements the basic listener loop. It sets up the ctrl-C handler, then
    /// reads a command from the user, executes it and repeats until the ShouldExit
    /// flag is set.
    private void Run()
    {
      // Set up the control-C handler.
      Console.CancelKeyPress += new ConsoleCancelEventHandler(this.HandleControlC);
      Console.TreatControlCAsInput = false;

      // Read commands to execute until ShouldExit is set by
      // the user calling "exit".
      while (!this.ShouldExit)
      {
        this.myHost.UI.Write(ConsoleColor.Cyan, ConsoleColor.Black, "\nPSConsoleSample: ");
        string cmd = Console.ReadLine();
        this.Execute(cmd);
      }

      // Exit with the desired exit code that was set by exit command.
      // This is set in the host by the MyHost.SetShouldExit() implementation.
      Environment.Exit(this.ExitCode);
    }
  }
}
```

## Example 2

The following code is the implementation of the
[System.Management.Automation.Host.PSHost](/dotnet/api/System.Management.Automation.Host.PSHost)
class that is used by this host application. Those elements that are not implemented throw an
exception or return nothing.

```csharp
// Copyright (c) 2006 Microsoft Corporation. All rights reserved.
//
// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
// ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
// PARTICULAR PURPOSE.
//
using System;
using System.Collections.Generic;
using System.Text;
using System.Management.Automation;
using System.Management.Automation.Host;
using System.Management.Automation.Runspaces;

namespace Microsoft.Samples.PowerShell.Host
{
  /// <summary>
  /// Simple PowerShell interactive console host listener implementation. This class
  /// implements a basic read-evaluate-print loop or 'listener' allowing you to
  /// interactively work with the PowerShell runtime.
  /// </summary>
  class PSListenerConsoleSample
  {
    /// <summary>
    /// Define the property that the PSHost implementation will use to tell the host
    /// application that it should exit.
    /// </summary>
    public bool ShouldExit
    {
      get { return shouldExit; }
      set { shouldExit = value; }
    }
    private bool shouldExit;

    /// <summary>
    /// Define the property that the PSHost implementation will use to tell the host
    /// application what code to use when exiting.
    /// </summary>
    public int ExitCode
    {
      get { return exitCode; }
      set { exitCode = value; }
    }
    private int exitCode;
    /// <summary>
    /// Holds the instance of the PSHost implementation for this interpreter.
    /// </summary>
    private MyHost myHost;

    /// <summary>
    /// Holds the runspace for this interpreter.
    /// </summary>
    private Runspace myRunSpace;

    /// <summary>
    /// Holds a reference to the currently executing pipeline so it can be
    /// stopped by the control-C handler.
    /// </summary>
    private Pipeline currentPipeline;

    /// <summary>
    /// Used to serialize access to instance data...
    /// </summary>
    private object instanceLock = new object();

    /// <summary>
    /// Create this instance of the console listener.
    /// </summary>
    PSListenerConsoleSample()
    {
      // Create the host and runspace instances for this interpreter. Note that
      // this application doesn't support console files so only the default snapins
      // will be available.
      myHost = new MyHost(this);
      myRunSpace = RunspaceFactory.CreateRunspace(myHost);
      myRunSpace.Open();
    }

    /// <summary>
    /// A helper class that builds and executes a pipeline that writes to the
    /// default output path. Any exceptions that are thrown are just passed to
    /// the caller. Since all output goes to the default outputter, this method()
    /// won't return anything.
    /// </summary>
    /// <param name="cmd">The script to run</param>
    /// <param name="input">Any input arguments to pass to the script. If null
    /// then nothing is passed in.</param>
    void executeHelper(string cmd, object input)
    {
      // Ignore empty command lines.
      if (String.IsNullOrEmpty(cmd))
        return;

      // Create the pipeline object and make it available
      // to the ctrl-C handle through the currentPipeline instance
      // variable.
      lock (instanceLock)
      {
        currentPipeline = myRunSpace.CreatePipeline();
      }

      // Create a pipeline for this execution. Place the result in the currentPipeline
      // instance variable so that it is available to be stopped.
      try
      {
        currentPipeline.Commands.AddScript(cmd);

        // Now add the default outputter to the end of the pipe and indicate
        // that it should handle both output and errors from the previous
        // commands. This will result in the output being written using the PSHost
        // and PSHostUserInterface classes instead of returning objects to the hosting
        // application.
        currentPipeline.Commands.Add("out-default");
        currentPipeline.Commands[0].MergeMyResults(PipelineResultTypes.Error, PipelineResultTypes.Output);

        // If there was any input specified, pass it in, otherwise just
        // execute the pipeline.
        if (input != null)
        {
          currentPipeline.Invoke(new object[] { input });
        }
        else
        {
          currentPipeline.Invoke();
        }
      }
      finally
      {
        // Dispose of the pipeline line and set it to null, locked because currentPipeline
        // may be accessed by the ctrl-C handler.
        lock (instanceLock)
        {
          currentPipeline.Dispose();
          currentPipeline = null;
        }
      }
    }

    /// <summary>
    /// Basic script execution routine - any runtime exceptions are
    /// caught and passed back into the runtime to display.
    /// </summary>
    /// <param name="cmd"></param>
    void Execute(string cmd)
    {
      try
      {
        // execute the command with no input...
        executeHelper(cmd, null);
      }
      catch (RuntimeException rte)
      {
        // An exception occurred that we want to display
        // using the display formatter. To do this we run
        // a second pipeline passing in the error record.
        // The runtime will bind this to the $input variable
        // which is why $input is being piped to out-default
        executeHelper("$input | out-default", rte.ErrorRecord);
      }
    }

    /// <summary>
    /// Method used to handle control-C's from the user. It calls the
    /// pipeline Stop() method to stop execution. If any exceptions occur,
    /// they are printed to the console; otherwise they are ignored.
    /// </summary>
    /// <param name="sender">See ConsoleCancelEventHandler documentation</param>
    /// <param name="e">See ConsoleCancelEventHandler documentation</param>
    void HandleControlC(object sender, ConsoleCancelEventArgs e)
    {
      try
      {
        lock (instanceLock)
        {
          if (currentPipeline != null && currentPipeline.PipelineStateInfo.State == PipelineState.Running)
                    currentPipeline.Stop();
        }
        e.Cancel = true;
      }
      catch (Exception exception)
      {
        this.myHost.UI.WriteErrorLine(exception.ToString());
      }
    }

    /// <summary>
    /// Implements the basic listener loop. It sets up the ctrl-C handler, then
    /// reads a command from the user, executes it and repeats until the ShouldExit
    /// flag is set.
    /// </summary>
    private void Run()
    {
      // Set up the control-C handler.
      Console.CancelKeyPress += new ConsoleCancelEventHandler(HandleControlC);
      Console.TreatControlCAsInput = false;

      // Loop reading commands to execute until ShouldExit is set by
      // the user calling "exit".
      while (!ShouldExit)
      {
        myHost.UI.Write(ConsoleColor.Cyan, ConsoleColor.Black, "\nPSConsoleSample: ");
        string cmd = Console.ReadLine();
        Execute(cmd);
      }

      // Exit with the desired exit code that was set by exit command.
      // This is set in the host by the MyHost.SetShouldExit() implementation.
      Environment.Exit(ExitCode);
    }

    /// <summary>
    /// Creates and initiates the listener instance.
    /// </summary>
    /// <param name="args">Ignored for now.</param>
    static void Main(string[] args)
    {
      // Display the welcome message.
      Console.Title = "PowerShell Console Host Sample Application";
      ConsoleColor oldFg = Console.ForegroundColor;
      Console.ForegroundColor = ConsoleColor.Cyan;
      Console.WriteLine("    PowerShell Console Host Interactive Sample");
      Console.WriteLine("    =====================================");
      Console.WriteLine("");
      Console.WriteLine("This is an example of a simple interactive console host using the PowerShell");
      Console.WriteLine("engine to interpret commands. Type 'exit' to exit.");
      Console.WriteLine("");
      Console.ForegroundColor = oldFg;

      // Create the listener and run it - this never returns.
      PSListenerConsoleSample listener = new PSListenerConsoleSample();
      listener.Run();
    }
  }
}
```

## Example 3

The following code is the implementation of the
[System.Management.Automation.Host.PSHostUserInterface](/dotnet/api/System.Management.Automation.Host.PSHostUserInterface)
class that is used by this host application.

```csharp
namespace Microsoft.Samples.PowerShell.Host
{
  using System;
  using System.Collections.Generic;
  using System.Collections.ObjectModel;
  using System.Globalization;
  using System.Management.Automation;
  using System.Management.Automation.Host;
  using System.Text;

  /// <summary>
  /// A sample implementation of the PSHostUserInterface abstract class for
  /// console applications. Not all members are implemented. Those that are
  /// not implemented throw a NotImplementedException exception or return
  /// nothing. Members that are implemented include those that map easily to
  /// Console APIs and a basic implementation of the prompt API provided.
  /// </summary>
  internal class MyHostUserInterface : PSHostUserInterface
  {
    /// <summary>
    /// An instance of the PSRawUserInterface object.
    /// </summary>
    private MyRawUserInterface myRawUi = new MyRawUserInterface();

    /// <summary>
    /// Gets an instance of the PSRawUserInterface object for this host
    /// application.
    /// </summary>
    public override PSHostRawUserInterface RawUI
    {
      get { return this.myRawUi; }
    }

    /// <summary>
    /// Prompts the user for input.
    /// <param name="caption">The caption or title of the prompt.</param>
    /// <param name="message">The text of the prompt.</param>
    /// <param name="descriptions">A collection of FieldDescription objects that
    /// describe each field of the prompt.</param>
    /// <returns>A dictionary object that contains the results of the user
    /// prompts.</returns>
    public override Dictionary<string, PSObject> Prompt(
                                       string caption,
                                       string message,
                                       Collection<FieldDescription> descriptions)
    {
      this.Write(
                 ConsoleColor.Blue,
                 ConsoleColor.Black,
                 caption + "\n" + message + " ");
      Dictionary<string, PSObject> results =
               new Dictionary<string, PSObject>();
      foreach (FieldDescription fd in descriptions)
      {
        string[] label = GetHotkeyAndLabel(fd.Label);
        this.WriteLine(label[1]);
        string userData = Console.ReadLine();
        if (userData == null)
        {
          return null;
        }

        results[fd.Name] = PSObject.AsPSObject(userData);
      }

      return results;
    }

    /// <summary>

/// Provides a set of choices that enable the user to choose a
    /// single option from a set of options.
    /// </summary>
    /// <param name="caption">Text that proceeds (a title) the choices.</param>
    /// <param name="message">A message that describes the choice.</param>
    /// <param name="choices">A collection of ChoiceDescription objects that describe
    /// each choice.</param>
    /// <param name="defaultChoice">The index of the label in the Choices parameter
    /// collection. To indicate no default choice, set to -1.</param>
    /// <returns>The index of the Choices parameter collection element that corresponds
    /// to the option that is selected by the user.</returns>
    public override int PromptForChoice(
                                        string caption,
                                        string message,
                                        Collection<ChoiceDescription> choices,
                                        int defaultChoice)
    {
      // Write the caption and message strings in Blue.
      this.WriteLine(
                     ConsoleColor.Blue,
                     ConsoleColor.Black,
                     caption + "\n" + message + "\n");

      // Convert the choice collection into something that is easier to
      // work with. See the BuildHotkeysAndPlainLabels method for details.
      Dictionary<string, PSObject> results =
          new Dictionary<string, PSObject>();
      string[,] promptData = BuildHotkeysAndPlainLabels(choices);

      // Format the overall choice prompt string to display...
      StringBuilder sb = new StringBuilder();
      for (int element = 0; element < choices.Count; element++)
      {
        sb.Append(String.Format(
                                CultureInfo.CurrentCulture,
                                "|{0}> {1} ",
                                promptData[0, element],
                                promptData[1, element]));
      }

      sb.Append(String.Format(
                              CultureInfo.CurrentCulture,
                              "[Default is ({0}]",
                              promptData[0, defaultChoice]));

      // Read prompts until a match is made, the default is
      // chosen, or the loop is interrupted with ctrl-C.
      while (true)
      {
        this.WriteLine(ConsoleColor.Cyan, ConsoleColor.Black, sb.ToString());
        string data = Console.ReadLine().Trim().ToUpper(CultureInfo.CurrentCulture);

        // If the choice string was empty, use the default selection.
        if (data.Length == 0)
        {
          return defaultChoice;
        }

        // See if the selection matched and return the
        // corresponding index if it did.
        for (int i = 0; i < choices.Count; i++)
        {
          if (promptData[0, i] == data)
          {
            return i;
          }
        }

        this.WriteErrorLine("Invalid choice: " + data);
      }
    }

    /// <summary>
    /// Prompts the user for credentials with a specified prompt window caption,
    /// prompt message, user name, and target name. In this example this
    /// functionality is not needed so the method throws a
    /// NotImplementException exception.
    /// </summary>
    /// <param name="caption">The caption for the message window.</param>
    /// <param name="message">The text of the message.</param>
    /// <param name="userName">The user name whose credential is to be prompted for.</param>
    /// <param name="targetName">The name of the target for which the credential is collected.</param>
    /// <returns>Throws a NotImplementedException exception.</returns>
    public override PSCredential PromptForCredential(
                                                     string caption,
                                                     string message,
                                                     string userName,
                                                     string targetName)
    {
      throw new NotImplementedException("The method or operation is not implemented.");
    }

    /// <summary>
    /// Prompts the user for credentials by using a specified prompt window caption,
    /// prompt message, user name and target name, credential types allowed to be
    /// returned, and UI behavior options. In this example this functionality
    /// is not needed so the method throws a NotImplementException exception.
    /// </summary>
    /// <param name="caption">The caption for the message window.</param>
    /// <param name="message">The text of the message.</param>
    /// <param name="userName">The user name whose credential is to be prompted for.</param>
    /// <param name="targetName">The name of the target for which the credential is collected.</param>
    /// <param name="allowedCredentialTypes">A PSCredentialTypes constant that
    /// identifies the type of credentials that can be returned.</param>
    /// <param name="options">A PSCredentialUIOptions constant that identifies the UI
    /// behavior when it gathers the credentials.</param>
    /// <returns>Throws a NotImplementedException exception.</returns>
    public override PSCredential PromptForCredential(
                                                     string caption,
                                                     string message,
                                                     string userName,
                                                     string targetName,
                                                     PSCredentialTypes allowedCredentialTypes,
                                                     PSCredentialUIOptions options)
    {
      throw new NotImplementedException("The method or operation is not implemented.");
    }

    /// <summary>
    /// Reads characters that are entered by the user until a newline
    /// (carriage return) is encountered.
    /// </summary>
    /// <returns>The characters that are entered by the user.</returns>
    public override string ReadLine()
    {
      return Console.ReadLine();
    }

    /// <summary>
    /// Reads characters entered by the user until a newline (carriage return)
    /// is encountered and returns the characters as a secure string. In this
    /// example this functionality is not needed so the method throws a
    /// NotImplementException exception.
    /// </summary>
    /// <returns>Throws a NotImplemented exception.</returns>
    public override System.Security.SecureString ReadLineAsSecureString()
    {
      throw new NotImplementedException("The method or operation is not implemented.");
    }

    /// <summary>
    /// Writes characters to the output display of the host.
    /// </summary>
    /// <param name="value">The characters to be written.</param>
    public override void Write(string value)
    {
      Console.Write(value);
    }

    /// <summary>
    /// Writes characters to the output display of the host with possible
    /// foreground and background colors.
    /// </summary>
    /// <param name="foregroundColor">The color of the characters.</param>
    /// <param name="backgroundColor">The background color to use.</param>
    /// <param name="value">The characters to be written.</param>
    public override void Write(
                               ConsoleColor foregroundColor,
                               ConsoleColor backgroundColor,
                               string value)
    {
      ConsoleColor oldFg = Console.ForegroundColor;
      ConsoleColor oldBg = Console.BackgroundColor;
      Console.ForegroundColor = foregroundColor;
      Console.BackgroundColor = backgroundColor;
      Console.Write(value);
      Console.ForegroundColor = oldFg;
      Console.BackgroundColor = oldBg;
    }

    /// <summary>
    /// Writes a line of characters to the output display of the host
    /// with foreground and background colors and appends a newline (carriage return).
    /// </summary>
    /// <param name="foregroundColor">The foreground color of the display. </param>
    /// <param name="backgroundColor">The background color of the display. </param>
    /// <param name="value">The line to be written.</param>
    public override void WriteLine(
                                   ConsoleColor foregroundColor,
                                   ConsoleColor backgroundColor,
                                   string value)
    {
      ConsoleColor oldFg = Console.ForegroundColor;
      ConsoleColor oldBg = Console.BackgroundColor;
      Console.ForegroundColor = foregroundColor;
      Console.BackgroundColor = backgroundColor;
      Console.WriteLine(value);
      Console.ForegroundColor = oldFg;
      Console.BackgroundColor = oldBg;
    }

    /// <summary>
    /// Writes a debug message to the output display of the host.
    /// </summary>
    /// <param name="message">The debug message that is displayed.</param>
    public override void WriteDebugLine(string message)
    {
      this.WriteLine(
                     ConsoleColor.DarkYellow,
                     ConsoleColor.Black,
                     String.Format(CultureInfo.CurrentCulture, "DEBUG: {0}", message));
    }

    /// <summary>
    /// Writes an error message to the output display of the host.
    /// </summary>
    /// <param name="value">The error message that is displayed.</param>
    public override void WriteErrorLine(string value)
    {
      this.WriteLine(
                     ConsoleColor.Red,
                     ConsoleColor.Black,
                     value);
    }

    /// <summary>
    /// Writes a newline character (carriage return)
    /// to the output display of the host.
    /// </summary>
    public override void WriteLine()
    {
      Console.WriteLine();
    }

    /// <summary>
    /// Writes a line of characters to the output display of the host
    /// and appends a newline character(carriage return).
    /// </summary>
    /// <param name="value">The line to be written.</param>
    public override void WriteLine(string value)
    {
      Console.WriteLine(value);
    }

    /// <summary>
    /// Writes a progress report to the output display of the host.
    /// </summary>
    /// <param name="sourceId">Unique identifier of the source of the record. </param>
    /// <param name="record">A ProgressReport object.</param>
    public override void WriteProgress(long sourceId, ProgressRecord record)
    {

    }

    /// <summary>
    /// Writes a verbose message to the output display of the host.
    /// </summary>
    /// <param name="message">The verbose message that is displayed.</param>
    public override void WriteVerboseLine(string message)
    {
      this.WriteLine(
                     ConsoleColor.Green,
                     ConsoleColor.Black,
                     String.Format(CultureInfo.CurrentCulture, "VERBOSE: {0}", message));
    }

    /// <summary>
    /// Writes a warning message to the output display of the host.
    /// </summary>
    /// <param name="message">The warning message that is displayed.</param>
    public override void WriteWarningLine(string message)
    {
      this.WriteLine(
                     ConsoleColor.Yellow,
                     ConsoleColor.Black,
                     String.Format(CultureInfo.CurrentCulture, "WARNING: {0}", message));
    }

    /// <summary>
    /// This is a private worker function splits out the
    /// accelerator keys from the menu and builds a two
    /// dimensional array with the first access containing the
    /// accelerator and the second containing the label string
    /// with the & removed.
    /// </summary>
    /// <param name="choices">The choice collection to process</param>
    /// <returns>
    /// A two dimensional array containing the accelerator characters
    /// and the cleaned-up labels</returns>
    private static string[,] BuildHotkeysAndPlainLabels(
        Collection<ChoiceDescription> choices)
    {
      // Allocate the result array.
      string[,] hotkeysAndPlainLabels = new string[2, choices.Count];
      for (int i = 0; i < choices.Count; ++i)
      {
        string[] hotkeyAndLabel = GetHotkeyAndLabel(choices[i].Label);
        hotkeysAndPlainLabels[0, i] = hotkeyAndLabel[0];
        hotkeysAndPlainLabels[1, i] = hotkeyAndLabel[1];
      }

      return hotkeysAndPlainLabels;
    }

    /// <summary>
    /// Parse a string containing a hotkey character.
    /// Take a string of the form
    ///    Yes to &all
    /// and returns a two-dimensional array split out as
    ///    "A", "Yes to all".
    /// </summary>
    /// <param name="input">The string to process</param>
    /// <returns>
    /// A two dimensional array containing the parsed components.
    /// </returns>
    private static string[] GetHotkeyAndLabel(string input)
    {
      string[] result = new string[] { String.Empty, String.Empty };
      string[] fragments = input.Split('&');
      if (fragments.Length == 2)
      {
        if (fragments[1].Length > 0)
        {
          result[0] = fragments[1][0].ToString().
          ToUpper(CultureInfo.CurrentCulture);
        }

        result[1] = (fragments[0] + fragments[1]).Trim();
      }
      else
      {
        result[1] = input;
      }

      return result;
    }
  }
}
```

## Example 4

The following code is the implementation of the
[System.Management.Automation.Host.PSHostRawUserInterface](/dotnet/api/System.Management.Automation.Host.PSHostRawUserInterface)
class that is used by this host application. Those elements that are not implemented throw an
exception or return nothing.

```csharp
namespace Microsoft.Samples.PowerShell.Host
{
  using System;
  using System.Management.Automation.Host;

  /// <summary>
  /// A sample implementation of the PSHostRawUserInterface for console
  /// applications. Members of this class that easily map to the .NET
  /// console class are implemented. More complex methods are not
  /// implemented and throw a NotImplementedException exception.
  /// </summary>
  internal class MyRawUserInterface : PSHostRawUserInterface
  {
    /// <summary>
    /// Gets or sets the background color of text to be written.
    /// This maps to the corresponding Console.Background property.
    /// </summary>
    public override ConsoleColor BackgroundColor
    {
      get { return Console.BackgroundColor; }
      set { Console.BackgroundColor = value; }
    }

    /// <summary>
    /// Gets or sets the host buffer size adapted from the Console buffer
    /// size members.
    /// </summary>
    public override Size BufferSize
    {
      get { return new Size(Console.BufferWidth, Console.BufferHeight); }
      set { Console.SetBufferSize(value.Width, value.Height); }
    }

    /// <summary>
    /// Gets or sets the cursor position. In this example this
    /// functionality is not needed so the property throws a
    /// NotImplementException exception.
    /// </summary>
    public override Coordinates CursorPosition
    {
      get { throw new NotImplementedException(
                 "The method or operation is not implemented."); }
      set { throw new NotImplementedException(
                 "The method or operation is not implemented."); }
    }

    /// <summary>
    /// Gets or sets the cursor size taken directly from the
    /// Console.CursorSize property.
    /// </summary>
    public override int CursorSize
    {
      get { return Console.CursorSize; }
      set { Console.CursorSize = value; }
    }

    /// <summary>
    /// Gets or sets the foreground color of the text to be written.
    /// This maps to the corresponding Console.ForegroundColor property.
    /// </summary>
    public override ConsoleColor ForegroundColor
    {
      get { return Console.ForegroundColor; }
      set { Console.ForegroundColor = value; }
    }

    /// <summary>
    /// Gets a value indicating whether a key is available. This maps to
    /// the corresponding Console.KeyAvailable property.
    /// </summary>
    public override bool KeyAvailable
    {
      get { return Console.KeyAvailable; }
    }

    /// <summary>
    /// Gets the maximum physical size of the window adapted from the
    ///  Console.LargestWindowWidth and Console.LargestWindowHeight
    ///  properties.
    /// </summary>
    public override Size MaxPhysicalWindowSize
    {
      get { return new Size(Console.LargestWindowWidth, Console.LargestWindowHeight); }
    }

    /// <summary>
    /// Gets the maximum window size adapted from the
    /// Console.LargestWindowWidth and console.LargestWindowHeight
    /// properties.
    /// </summary>
    public override Size MaxWindowSize
    {
      get { return new Size(Console.LargestWindowWidth, Console.LargestWindowHeight); }
    }

    /// <summary>
    /// Gets or sets the window position adapted from the Console window position
    /// members.
    /// </summary>
    public override Coordinates WindowPosition
    {
      get { return new Coordinates(Console.WindowLeft, Console.WindowTop); }
      set { Console.SetWindowPosition(value.X, value.Y); }
    }

    /// <summary>
    /// Gets or sets the window size adapted from the corresponding Console
    /// calls.
    /// </summary>
    public override Size WindowSize
    {
      get { return new Size(Console.WindowWidth, Console.WindowHeight); }
      set { Console.SetWindowSize(value.Width, value.Height); }
    }

    /// <summary>
    /// Gets or sets the title of the window mapped to the Console.Title
    /// property.
    /// </summary>
    public override string WindowTitle
    {
      get { return Console.Title; }
      set { Console.Title = value; }
    }

    /// <summary>
    /// This API resets the input buffer. In this example this
    /// functionality is not needed so the method returns nothing.
    /// </summary>
    public override void FlushInputBuffer()
    {
    }

    /// <summary>
    /// This API returns a rectangular region of the screen buffer. In
    /// this example this functionality is not needed so the method throws
    /// a NotImplementException exception.
    /// </summary>
    /// <param name="rectangle">Defines the size of the rectangle.</param>
    /// <returns>Throws a NotImplementedException exception.</returns>
    public override BufferCell[,] GetBufferContents(Rectangle rectangle)
    {
      throw new NotImplementedException(
               "The method or operation is not implemented.");
    }

    /// <summary>
    /// This API Reads a pressed, released, or pressed and released keystroke
    /// from the keyboard device, blocking processing until a keystroke is
    /// typed that matches the specified keystroke options. In this example
    /// this functionality is not needed so the method throws a
    /// NotImplementException exception.
    /// </summary>
    /// <param name="options">Options, such as IncludeKeyDown,  used when
    /// reading the keyboard.</param>
    /// <returns>Throws a NotImplementedException exception.</returns>
    public override KeyInfo ReadKey(ReadKeyOptions options)
    {
      throw new NotImplementedException(
                "The method or operation is not implemented.");
    }

    /// <summary>
    /// This API crops a region of the screen buffer. In this example
    /// this functionality is not needed so the method throws a
    /// NotImplementException exception.
    /// </summary>
    /// <param name="source">The region of the screen to be scrolled.</param>
    /// <param name="destination">The region of the screen to receive the
    /// source region contents.</param>
    /// <param name="clip">The region of the screen to include in the operation.</param>
    /// <param name="fill">The character and attributes to be used to fill all cell.</param>
    public override void ScrollBufferContents(Rectangle source, Coordinates destination, Rectangle clip, BufferCell fill)
    {
      throw new NotImplementedException(
                "The method or operation is not implemented.");
    }

     /// <summary>
    /// This API copies an array of buffer cells into the screen buffer
    /// at a specified location. In this example this  functionality is
    /// not needed si the method  throws a NotImplementedException exception.
    /// </summary>
    /// <param name="origin">The parameter is not used.</param>
    /// <param name="contents">The parameter is not used.</param>
    public override void SetBufferContents(Coordinates origin, BufferCell[,] contents)
    {
      throw new NotImplementedException(
                "The method or operation is not implemented.");
    }

    /// <summary>
    /// This API Copies a given character, foreground color, and background
    /// color to a region of the screen buffer. In this example this
    /// functionality is not needed so the method throws a
    /// NotImplementException exception./// </summary>
    /// <param name="rectangle">Defines the area to be filled. </param>
    /// <param name="fill">Defines the fill character.</param>
    public override void SetBufferContents(Rectangle rectangle, BufferCell fill)
    {
      throw new NotImplementedException(
                "The method or operation is not implemented.");
    }
  }
}
```

## See Also

 [System.Management.Automation.Host.PSHost](/dotnet/api/System.Management.Automation.Host.PSHost)

 [System.Management.Automation.Host.Pshostuserinterface](/dotnet/api/System.Management.Automation.Host.PSHostUserInterface)

 [System.Management.Automation.Host.Pshostrawuserinterface](/dotnet/api/System.Management.Automation.Host.PSHostRawUserInterface)

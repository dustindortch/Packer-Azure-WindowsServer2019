# Packer-Azure-WindowsServer2019

## Purpose

A simple example of an Azure Managed Image build using Packer in Azure Pipelines.  The pipeline is also simple:

* Triggered on commit to "main" branch of my repository
* Build agent is Windows Server 2019
* DownloadSecureFile@1 used to download my pkrvars.hcl file for variable input, referenced as `$(mySecureFGile.secureFilePath)`
* Manual execution of Packer as a command instead of using PackerBuild@1 because it expects parameters that aren't needed if they are handled within the definition
* DeleteFiles@1 to cleanup the previous secure file

## Packer image definition

The image defaults to a Windows Server 2019 image from Azure (2019-datacenter) as the source image.  Four PowerShell scripts are executed:

* Wait.ps1 - waits for specific services to be in a running state
* Chocolately.ps1 - installs Chocolatey
* Build.ps1 - Installs PowerShell 7 and Git via Chocolatey, just as an example
* Sysprep.ps1 - Generalizes the install as necessary prior to making the image

## Real golden image tasks

A real golden image would have all of the utilities and agents that would be required on all systems and required OS hardening for compliance.

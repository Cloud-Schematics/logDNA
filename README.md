# tf-logdna

A Terraform configuration for deploying logDNA logsource on linux and ubuntu. This template provisions a linux and ubuntu vm's and deploys the logDNA logsource on them.

This configuration template is tested for IBM Cloud Provider version v0.12
# Usage
1. You will need to [setup up IBM Cloud provider credentials](#setting-up-provider-credentials) on your local machine. 
1. run `make logdna-instance`
    * Deploy the logDNA instance.
1. run `make logsource-ubuntu`  
    * Deploy log source for ubuntu.
1. run `make logsource-rhel`  
    * Deploy log source for RHEL.

# Prerequisite 
1) Download [Terraform binary](https://www.terraform.io/downloads.html).  Unzip it and keep the binary in path ex- /usr/local/bin.
2) Download [IBM Cloud Provider Plugin](https://github.com/IBM-Bluemix/terraform-provider-ibm/releases). Unzip it and keep the binary in path in the same directory where you placed Terraform binary in previous step. You can also build the binary yourself. Please look into [documentation](https://github.com/IBM-Bluemix/terraform-provider-ibm/blob/master/README.md).

# To run this project locally execute the following steps:

- Clone this project.
- You can override default values that are in your variables.tf file.
  - Alternatively these values can be supplied via the command line or environment variables, see https://www.terraform.io/intro/getting-started/variables.html.
- Refer [Usage](#usage) for deployment.
- `make clean-up-resources`: this will destroy all infrastructure which has been created

# Setting up Provider Credentials
To setup the IBM Cloud provider to work with this there are a few options for managing credentials safely; here we'll cover the preferred method using environment variables. Other methods can be used, please see the [Terraform Getting Started Variable documentation](https://www.terraform.io/intro/getting-started/variables.html) for further details.

## Environment Variables using IBMid credentials
You'll need to export the following environment variables:

- `TF_VAR_ibm_bluemix_api_key` - your Bluemix api key
- `TF_VAR_ibm_softlayer_api_key` - your softlayer api key
- `TF_VAR_ibm_softlayer_user_name` - your softlayer username



On OS X this is achieved by entering the following into your terminal, replacing the `<value>` characters with the actual values (remove the `<>`:

- `export TF_VAR_ibm_bluemix_api_key=<value>`
- `export TF_VAR_ibm_softlayer_api_key=<value>`
- `export TF_VAR_ibm_softlayer_user_name=<value>`


# Variables

|Variable Name|Description|Default Value|
|-------------|-----------|-------------|
|logdna_name | Name of the log dna instance|my-logdna|
|logdna_plan| logDNA plan|lite| 
|public_key   |  public SSH key to use in keypair         |~/.ssh/id_rsa.pub|
|ssh_label|| ssh_logdna |
|osref_ubuntu| Ubuntu OS version | UBUNTU_16_64 |
|osref_rhel|RHEL OS version|REDHAT_7_64|
|datacenter||dal10|
|rhel_ingestion|your unique ingestion key||
|ubuntu_ingestion|your unique ingestion key||
|rhel_api_host|logDNA API host ||
|rhel_log_host|logDNA log host ||
|rhel_log_path|Configure extra log folders seperated with :||
|rhel_tag|Add tags||
|ubuntu_api_host|logDNA API host ||
|ubuntu_log_host|logDNA log host ||
|ubuntu_log_path|Configure extra log folders seperated with :||
|ubuntu_tag|Add tags||
|ssh_private_key||~/.ssh/id_rsa|

# Output

Upon completion, terraform will output the public ip of the rhel and ubuntu, e.g.:

```
rhel_ip = "<IPADDRESS>"

ubuntu_ip = "<IPADDRESS>"

```
**Use this ip's to access your rhel and ubuntu**

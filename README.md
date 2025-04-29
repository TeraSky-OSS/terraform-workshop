# Terraform Workshop

A comprehensive collection of hands-on labs and demos showcasing various Terraform use cases across different cloud providers and platforms.

## 🚀 Overview

This repository contains practical examples and hands-on labs demonstrating Terraform's capabilities for infrastructure as code (IaC). Each lab focuses on different aspects of Terraform, from basic concepts to advanced implementations across multiple cloud providers and platforms.

## 📋 Prerequisites

Before starting the labs, ensure you have:

1. AWS Account(s) with appropriate permissions
2. AWS CLI installed and configured
3. Terraform installed (version 1.0.0 or later)
4. kubectl installed (for Kubernetes labs)
5. Helm installed (for Helm-based labs)
6. jq installed (for multi-account setup)

### Initial Setup

#### Single Account Setup

1. Connect to your AWS account
2. Deploy the Terraform module in [Environment Preparation](./env_preparation/)
3. Update your `kubeconfig` file:
   ```bash
   aws eks --region us-east-1 update-kubeconfig --name terraform-workshop
   ```

#### Multi-Account Setup

If you need to prepare multiple AWS accounts for the workshop, you can use the provided script to automate the process. This is particularly useful for training environments where each participant needs their own isolated AWS account.

1. Create the accounts.csv file by retrieving accounts from a specific OU:
   ```bash
   # Set the AWS profile for the management account
   export AWS_PROFILE=management-account
   aws configure --profile management-account --region eu-west-1
   
   # Set the OU ID
   OU_ID="ou-ky6x-snavbufo" # Get this from the console
   
   # Create the CSV header
   echo "account_id,account_name,email" > env_preparation/accounts.csv
   
   # Get accounts in the OU and append to CSV, properly handling spaces in names
   aws organizations list-accounts-for-parent \
     --parent-id $OU_ID \
     --query 'Accounts[].[Id,Name,Email]' \
     --output json | jq -r '.[] | [.[0], (.[1] | gsub(" "; "_")), .[2]] | @csv' >> env_preparation/accounts.csv
   ```

2. Set the environment variables for the "Shared-Services" account
   ```bash
   export AWS_ACCESS_KEY_ID="xxx"
   export AWS_SECRET_ACCESS_KEY="xxx"
   export AWS_SESSION_TOKEN="xxx"
   ```

3. Run the `setup-accounts.sh` script:
   ```bash
   cd env_preparation
   chmod +x setup_accounts.sh
   ./setup_accounts.sh
   ```

4. The script will:
   - Retrieve Labs-Admin credentials from Secrets Manager
   - Process each account in the CSV file
   - Assume the LabExecutionRole in each target account
   - Deploy the environment preparation module
   - Generate setup instructions for each account
   - Create separate kubeconfig files for each cluster
   - Configure S3 backend for Terraform state

5. After the script completes, you'll find:
   - Individual setup instruction files for each account
   - Terraform state files stored in S3

6. To manage the infrastructure after creation:
   ```bash
   # Set the account you want to manage
   export lab_account="<account_id>"

   # Set the AWS profile for the "Shared-Services" account (Ireland)
   export AWS_PROFILE=shared-services-account
   aws configure --profile shared-services-account --region eu-west-1
   
   # Retrieve the Labs-Admin credentials
   LABS_ADMIN_CREDS=$(aws secretsmanager get-secret-value \
     --secret-id labs-admin-credentials \
     --region eu-west-1 \
     --query 'SecretString' \
     --output text)
   
   # Export the credentials
   export AWS_ACCESS_KEY_ID=$(echo $LABS_ADMIN_CREDS | jq -r .AWS_ACCESS_KEY_ID)
   export AWS_SECRET_ACCESS_KEY=$(echo $LABS_ADMIN_CREDS | jq -r .AWS_SECRET_ACCESS_KEY)
   
   # Assume the LabExecutionRole
   ASSUMED_ROLE=$(aws sts assume-role \
     --role-arn arn:aws:iam::${lab_account}:role/LabExecutionRole \
     --role-session-name "TerraformWorkshop" \
     --region us-east-1)
   
   # Export the temporary credentials
   export AWS_ACCESS_KEY_ID=$(echo $ASSUMED_ROLE | jq -r .Credentials.AccessKeyId)
   export AWS_SECRET_ACCESS_KEY=$(echo $ASSUMED_ROLE | jq -r .Credentials.SecretAccessKey)
   export AWS_SESSION_TOKEN=$(echo $ASSUMED_ROLE | jq -r .Credentials.SessionToken)
   
   # Initialize Terraform with the S3 backend
   cd env_preparation
   terraform init \
     -backend-config="bucket=terraform-workshop-tf-states-${lab_account}" \
     -backend-config="key=terraform.tfstate" \
     -backend-config="region=eu-west-1" \
     -backend-config="use_lockfile=true" \
     -backend-config="encrypt=true" \
     -reconfigure
   
   # Now you can run Terraform commands
   terraform plan
   terraform apply
   ```

## 🎯 Hands-On Labs

### AWS Labs
- **[Simple Web Application](./hands_on_labs/aws/simple_web_app)** - Deploy a basic web application on AWS using Terraform
- **[Multiple Web Applications](./hands_on_labs/aws/multiple_web_apps)** - Manage multiple web applications with Terraform
- **[Module Separation](./hands_on_labs/aws/modules)** - Learn about Terraform module organization and reusability
- **[VPC and Subnets](./hands_on_labs/aws/vpc_subnets)** - Set up a VPC with public and private subnets using Terraform
- **[VPC and Transit Gateway](./hands_on_labs/aws/transit_gateway)** - Create a VPC with public and private subnets and set up an AWS Transit Gateway using Terraform

### Kubernetes Labs
- **[Native Manifests](./hands_on_labs/kubernetes/k8s_native_manifests)** - Deploy Kubernetes resources using native manifests
- **[Helm Integration](./hands_on_labs/kubernetes/k8s_helm)** - Deploy applications using Helm charts
- **[Full Application Stack](./hands_on_labs/kubernetes/k8s_full_app)** - Deploy a complete application stack to Kubernetes

## 🎓 Demos

- **[VMware Integration](./demos/vmware)** - Deploy VMs on VMware vSphere
- **[Terraform Testing](./demos/terraform_tests)** - Learn about testing Terraform configurations
- **[Packer Integration](./demos/packer)** - Create custom machine images with Packer
- **[Azure Web Application](./demos/azure_webapp/)** - Deploy a web application on Azure using Terraform
- **[Folder Structure Example](./demos/folder_structure_example/)** - Understand best practices for organizing Terraform projects

## 🛠️ Getting Started

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/terraform-workshop.git
   cd terraform-workshop
   ```

2. Choose a lab or demo from the sections above
3. Follow the instructions in the respective directory's README

## 📚 Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Kubernetes Provider Documentation](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)

## 👥 Authors

- Daniel Vaknin - Initial work
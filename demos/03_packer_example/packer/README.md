# Packer Demo: Building an NGINX AMI

This demo demonstrates how to use HashiCorp Packer to create a custom Amazon Machine Image (AMI) with NGINX pre-installed and configured.

## Overview

This Packer configuration:
1. Creates an Ubuntu 24.04 (Noble) AMI
2. Installs and configures NGINX
3. Deploys a custom index.html page
4. Uses the existing VPC infrastructure from the Terraform workshop

## Prerequisites

- AWS CLI configured with appropriate credentials
- Packer installed on your system
- Existing VPC infrastructure (created by the Terraform workshop)
- AWS region: us-east-1

## Configuration

The demo uses the following configuration:
- Base image: Ubuntu 24.04 (Noble) Server
- Instance type: t2.micro
- VPC: Uses the workshop VPC (terraform-workshop-vpc)
- Subnet: Randomly selects from public subnets
- AMI name: terraform-workshop-packer-nginx

## Usage

1. Initialize Packer:
```bash
packer init .
```

2. Validate the configuration:
```bash
packer validate aws-nginx.pkr.hcl
```

3. Inspect the configuration (optional):
```bash
packer inspect aws-nginx.pkr.hcl
```

4. Build the AMI:
```bash
packer build aws-nginx.pkr.hcl
```

## Verification

After the build completes:
1. Launch an EC2 instance using the created AMI
2. Access the instance's public IP address in a web browser
3. You should see the custom NGINX page with "Terraform Workshop" and "Packer Demo :)" headers

## Files

- `aws-nginx.pkr.hcl`: Main Packer configuration file
- `index.html`: Custom webpage to be served by NGINX
- `README.md`: This documentation file

## Notes

- The AMI is created in the same VPC as the workshop infrastructure
- The configuration uses Ubuntu 24.04 as the base image
- The resulting AMI will have NGINX pre-installed and configured

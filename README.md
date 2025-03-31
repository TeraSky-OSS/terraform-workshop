# Terraform Workshop

A comprehensive collection of hands-on labs and demos showcasing various Terraform use cases across different cloud providers and platforms.

## 🚀 Overview

This repository contains practical examples and hands-on labs demonstrating Terraform's capabilities for infrastructure as code (IaC). Each lab focuses on different aspects of Terraform, from basic concepts to advanced implementations across multiple cloud providers and platforms.

## 📋 Prerequisites

Before starting the labs, ensure you have:

1. AWS Account with appropriate permissions
2. AWS CLI installed and configured
3. Terraform installed (version 1.0.0 or later)
4. kubectl installed (for Kubernetes labs)
5. Helm installed (for Helm-based labs)

### Initial Setup

1. Connect to your AWS account
2. Deploy the Terraform module in [Environment Preparation](./env_preparation/)
3. Update your `kubeconfig` file:
   ```bash
   aws eks --region us-east-1 update-kubeconfig --name terraform-workshop
   ```

## 🎯 Hands-On Labs

### AWS Labs
- **[Simple Web Application](./hands_on_labs/01_simple_web_app)** - Deploy a basic web application on AWS using Terraform
- **[Multiple Web Applications](./hands_on_labs/02_multiple_web_apps)** - Manage multiple web applications with Terraform
- **[Module Separation](./hands_on_labs/03_modules)** - Learn about Terraform module organization and reusability

### Kubernetes Labs
- **[Native Manifests](./hands_on_labs/04_k8s_native_manifests)** - Deploy Kubernetes resources using native manifests
- **[Helm Integration](./hands_on_labs/05_k8s_helm)** - Deploy applications using Helm charts
- **[Full Application Stack](./hands_on_labs/06_k8s_full_app)** - Deploy a complete application stack to Kubernetes

## 🎓 Demos

### Advanced Topics
- **[VMware Integration](./demos/01_vmware_example)** - Deploy VMs on VMware vSphere
- **[Terraform Testing](./demos/02_terraform_tests)** - Learn about testing Terraform configurations
- **[Packer Integration](./demos/03_packer_example)** - Create custom machine images with Packer
- **[Azure Web Application](./demos/04_azure_webapp/)** - Deploy a web application on Azure using Terraform

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
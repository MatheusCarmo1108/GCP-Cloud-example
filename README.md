# Terraform and Ansible Configuration for Cloud Infrastructure

## Overview
This repository contains the Terraform configuration files and Ansible playbooks used to provision and manage cloud infrastructurelike Google Kubernetes Engine (GKE), TimescaleDB, and more. It includes setting up VPCs, static IPs, secret management, and various other cloud resources.

## Prerequisites

Before you begin, ensure you have the following installed and configured:

- [Terraform](https://www.terraform.io/downloads.html) 
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) for post-provisioning configuration 
- Cloud provider credentials (Google Cloud,)

## Repository Structure

Here is a brief explanation of each configuration file:

- **`gke.tf`**: Configures Google Kubernetes Engine (GKE) clusters, including the necessary network settings and node pools.
- **`bastion.tf`**: Sets up a bastion host for secure access to private infrastructure resources.
- **`bucket.tf`**: Creates cloud storage buckets for managing data and backups.
- **`cloudDNS.tf`**: Manages DNS records and configurations using Google Cloud DNS.
- **`firewall.tf`**: Defines firewall rules to control traffic within the Virtual Private Cloud (VPC).
- **`node-pools.tf`**: Configures node pools for GKE clusters, allowing for scalable Kubernetes workloads.
- **`outputs.tf`**: Provides outputs like instance IPs and other resource identifiers after Terraform execution.
- **`postgres.tf`**: Manages PostgreSQL instances on a cloud provider.
- **`provider.tf`**: Specifies the cloud provider and credentials used for Terraform operations.
- **`secret-manager.tf`**: Integrates with Secret Manager to securely store and manage secrets.
- **`static-ip.tf`**: Provisions static IP addresses for services that require fixed IPs.
- **`timescale-db.tf`**: Sets up TimescaleDB, an extension for PostgreSQL optimized for time-series data.
- **`vpc.tf`**: Configures the Virtual Private Cloud (VPC) network for secure and isolated infrastructure.
- **`variables.tf`**: Defines input variables to customize the deployment.

### Ansible Folder
- **`ansible/`**: Contains Ansible playbooks used for further configuration and management of cloud resources. Typically used to automate application deployment, configuration management, and other post-provisioning tasks. Refer to the specific playbooks inside the folder for details.

## Setup Instructions

 **Clone the repository:**
   ```bash
   git clone https://github.com/MatheusCarmo1108/GCP-Cloud-example.git
   cd GCP-Cloud Example
   ```
## Terraform Commands

 **Run Terraform:**
   ```bash
   terraform init
   terraform plan
   terraform apply
   terraform destroy
   ```
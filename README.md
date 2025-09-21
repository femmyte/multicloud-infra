# Multicloud Infrastructure with Terraform

This repository provisions a standard **3-tier infrastructure** across **AWS,
Azure, and GCP** using **Terraform**.  
It is modularized for reusability and uses **remote state backends** for each
provider.

---

## Repository Structure

environments/

-   ├── aws/ # Terraform configuration for AWS
-   │ ├── modules/ # Reusable Terraform modules for AWS
-   │ │ ├── database/ # Database infrastructure (RDS, etc.)
-   │ │ └── network/ # Networking components (VPC, subnets, SGs)
-   │ ├── backend.tf # Remote backend configuration for AWS state
-   │ ├── main.tf # Main entry point for AWS resources
-   │ ├── providers.tf # AWS provider configuration
-   │ └── variable.tf # Input variables for AWS deployment
-   │
-   ├── azure/ # Terraform configuration for Azure
-   │ ├── module/ # Reusable Terraform modules for Azure
-   │ │ ├── compute/ # Compute resources (VMs, scaling sets)
-   │ │ ├── database/ # Database infrastructure (Azure SQL, etc.)
-   │ │ └── network/ # Networking components (VNet, NSGs, subnets)
-   │ ├── backend.tf # Remote backend configuration for Azure state
-   │ ├── maint.tf # Main entry point for Azure resources
-   │ ├── providers.tf # Azure provider configuration
-   │ ├── secret.tfvars # Sensitive variables (secrets, credentials)
-   │ └── variable.tf # Input variables for Azure deployment
-   │
-   └── gcp/ # Terraform configuration for Google Cloud
-   ├── module/ # Reusable Terraform modules for GCP
-   │ ├── compute/ # Compute resources (VM instances, MIGs)
-   │ ├── database/ # Database infrastructure (Cloud SQL, etc.)
-   │ └── network/ # Networking components (VPC, subnets, firewalls)
-   ├── backend.tf # Remote backend configuration for GCP state
-   ├── main.tf # Main entry point for GCP resources
-   ├── providers.tf # GCP provider configuration
-   └── variable.tf # Input variables for GCP deployment

Other files:

-   `.gitignore` → ignores Terraform state files and sensitive variables
-   `README.md` → project documentation

---

## Overview

This repo provisions the following per cloud:

-   **AWS**
    -   VPC, subnets, security groups
    -   EC2 instance
    -   RDS database
    -   Remote state in **S3**
-   **Azure**
    -   Virtual Network, subnet, NSG
    -   Linux VM
    -   Azure SQL Database
    -   Remote state in **Azure Storage**
-   **GCP**
    -   VPC with public & private subnets
    -   Compute Engine instance
    -   Cloud SQL (Postgres)
    -   Remote state in **GCS**

---

## Prerequisites

-   [Terraform](https://developer.hashicorp.com/terraform/downloads)
-   Cloud CLI tools:
    -   [AWS CLI](https://docs.aws.amazon.com/cli/)
    -   [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/)
    -   [gcloud CLI](https://cloud.google.com/sdk/docs/install)
-   Credentials set up locally for each provider:
    -   AWS: IAM user profile
    -   Azure: Service principal / CLI login
    -   GCP: Service account key JSON

---

## Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/femmyte/multicloud-infra.git
    cd multicloud-infra
    ```

2. Navigate to a provider directory (AWS, Azure, GCP):

    ```bash
    cd environments/aws
    ```

3. Initialize Terraform with the backend:

    ```bash
    terraform init
    ```

4. Review the plan:

    ```bash
    terraform plan -var-file="secret.tfvars"
    ```

5. Apply the infrastructure:

    ```bash
    terraform apply -var-file="secret.tfvars"
    ```

6. To destroy:

    ```bash
    terraform destroy -var-file="secret.tfvars"
    ```

---

## Modules

Each cloud environment is split into **modules** for reusability:

-   **network** → VPC/VNet, subnets, NSGs / firewalls
-   **compute** → VM/EC2/GCE
-   **database** → RDS / Azure SQL / Cloud SQL

This modular structure allows extending or reusing components across
environments.

---

## Security Notes

-   Secrets should never be committed to git. Store them in `secret.tfvars`
    (already git-ignored).
-   Restrict security group / NSG rules (e.g., SSH/HTTP access).
-   Use **private networking** for databases where possible.
-   Enable encryption and backups.

---

## Architecture Diagram

Below is the high-level architecture across all three clouds:

![Architecture Diagram](./images/architecture-diagram.png)

---

## Example Resource Summary

| Cloud | Compute  | Network                      | Database             | State Backend |
| ----- | -------- | ---------------------------- | -------------------- | ------------- |
| AWS   | EC2      | VPC + Subnets + SG           | RDS (Postgres/MySQL) | S3            |
| Azure | Linux VM | VNet + Subnet + NSG          | Azure SQL            | Azure Storage |
| GCP   | GCE      | VPC + Public/Private Subnets | Cloud SQL            | GCS           |

---

## Contributing

1. Fork the repo
2. Create a feature branch
3. Run `terraform fmt` and `terraform validate`
4. Submit a PR

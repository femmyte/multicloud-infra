# Multi-Cloud Terraform Infrastructure

A production-ready multi-cloud Terraform infrastructure repository supporting
AWS, Azure, and GCP with a standardized 3-tier architecture using modular design
patterns.

## Architecture Overview

This repository implements a consistent 3-tier architecture across all three
major cloud providers using reusable Terraform modules:

-   **Tier 1**: Network layer (VPC/VNet, subnets, security groups)
-   **Tier 2**: Compute layer (EC2/VM/Compute Engine instances)
-   **Tier 3**: Database layer (RDS/Azure SQL/Cloud SQL)

## Repository Structure

\`\`\` multi-cloud-terraform/ ├── README.md ├── Architecture ├── .gitignore ├──
aws/ # AWS infrastructure │ ├── main.tf # Main configuration using modules │ ├──
providers.tf # AWS provider configuration │ ├── backend.tf # Remote state
configuration │ ├── variables.tf # Input variables │ ├── outputs.tf # Output
values │ ├── terraform.tfvars.example │ └── modules/ # AWS-specific modules │
├── network/ # VPC, subnets, routing │ ├── security/ # Security groups, NACLs │
├── compute/ # EC2 instances, launch templates │ └── database/ # RDS instances
and configurations ├── azure/ # Azure infrastructure │ ├── main.tf # Main
configuration using modules │ ├── providers.tf # Azure provider configuration │
├── backend.tf # Remote state configuration │ ├── variables.tf # Input variables
│ ├── outputs.tf # Output values │ ├── terraform.tfvars.example │ └── modules/ #
Azure-specific modules │ ├── network/ # VNet, subnets, routing │ ├── security/ #
NSGs, security rules │ ├── compute/ # Virtual machines, scale sets │ └──
database/ # Azure SQL instances ├── gcp/ # GCP infrastructure │ ├── main.tf #
Main configuration using modules │ ├── providers.tf # GCP provider configuration
│ ├── backend.tf # Remote state configuration │ ├── variables.tf # Input
variables │ ├── outputs.tf # Output values │ ├── terraform.tfvars.example │ └──
modules/ # GCP-specific modules │ ├── network/ # VPC, subnets, Cloud Router/NAT
│ ├── security/ # Firewall rules │ ├── compute/ # Compute Engine instances │ └──
database/ # Cloud SQL instances | └── docs/ # Documentation ├──
BACKEND_SETUP.md # Backend configuration guide └── MODULES.md # Module
documentation \`\`\`

## Modular Architecture Benefits

-   **Reusability**: Modules can be reused across different environments
-   **Maintainability**: Changes to modules automatically apply to all
    implementations
-   **Consistency**: Standardized patterns across all cloud providers
-   **Scalability**: Easy to add new environments or modify existing ones
-   **Testing**: Individual modules can be tested independently

## Prerequisites

-   Terraform >= 1.0
-   AWS CLI configured with appropriate credentials
-   Azure CLI configured with appropriate credentials
-   Google Cloud SDK configured with appropriate credentials

## Quick Start

### 1. Clone and Initialize

\`\`\`bash git clone <repository-url> cd multi-cloud-terraform \`\`\`

### 2. Choose Our Cloud Provider

Navigate to the desired cloud provider directory:

\`\`\`bash

# For AWS

cd aws

# For Azure

cd azure

# For GCP

cd gcp \`\`\`

### 3. Configure Variables

Copy the example variables file and customize:

\`\`\`bash cp terraform.tfvars.example terraform.tfvars

# Edit terraform.tfvars with our specific values

\`\`\`

### 4. Initialize and Deploy

\`\`\`bash

# Initialize Terraform

terraform init

# Review the plan

terraform plan

# Apply the infrastructure

terraform apply \`\`\`

## Module Structure

Each cloud provider follows a consistent module structure:

### Network Module

-   Creates VPC/VNet with appropriate CIDR blocks
-   Sets up public, private, and database subnets
-   Configures routing tables and NAT gateways
-   Establishes private connectivity for databases

### Security Module

-   Implements security groups/NSGs/firewall rules
-   Follows principle of least privilege
-   Separates traffic between tiers
-   Allows only necessary ports and protocols

### Compute Module

-   Creates instance templates/images
-   Deploys instances across availability zones
-   Configures user data for application setup
-   Implements proper tagging and labeling

### Database Module

-   Deploys managed database services
-   Sets up private networking
-   Implements encryption at rest and in transit

## Cloud-Specific Setup

### AWS Setup

1. Configure AWS credentials: \`\`\`bash aws configure \`\`\`

2. Create S3 bucket for Terraform state (update `backend.tf` with our bucket
   name): \`\`\`bash aws s3 mb s3://our-terraform-state-bucket \`\`\`

3. Create DynamoDB table for state locking: \`\`\`bash aws dynamodb create-table
   \
    --table-name terraform-state-lock \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \`\`\`

### Azure Setup

1. Login to Azure: \`\`\`bash az login \`\`\`

2. Create a storage account for Terraform state (update `backend.tf` with our
   details): \`\`\`bash az group create --name terraform-state-rg --location
   "East US" az storage account create --name ourtfstateaccount --resource-group
   terraform-state-rg --location "East US" --sku Standard_LRS \`\`\`

### GCP Setup

1. Authenticate with Google Cloud: \`\`\`bash gcloud auth login gcloud auth
   application-default login \`\`\`

2. Create a storage bucket for Terraform state (update `backend.tf` with our
   bucket name): \`\`\`bash gsutil mb gs://our-terraform-state-bucket \`\`\`

## Security Considerations

-   All network tiers are properly segmented with security groups/NSGs/firewall
    rules
-   Database instances are deployed in private subnets with no internet access
-   Web tier allows HTTP/HTTPS traffic from internet only
-   App tier allows traffic only from web tier
-   Database tier allows traffic only from app tier
-   All resources use encryption at rest and in transit where available

## Module Customization

Each module accepts variables that allow us to customize:

### Network Module Variables

-   VPC/VNet CIDR blocks
-   Subnet configurations
-   Availability zone distribution
-   NAT gateway settings

### Security Module Variables

-   Custom firewall rules
-   Port configurations
-   Source/destination restrictions
-   Protocol specifications

### Compute Module Variables

-   Instance types and sizes
-   Auto-scaling configurations
-   User data scripts
-   Key pair assignments

### Database Module Variables

-   Engine versions
-   Instance classes
-   Storage configurations
-   Backup settings
-   Maintenance windows

## Outputs

Each module and main configuration provides comprehensive outputs:

### Network Outputs

-   VPC/VNet IDs and names
-   Subnet IDs and CIDR blocks
-   Route table IDs
-   NAT gateway IDs

### Security Outputs

-   Security group/NSG IDs
-   Firewall rule IDs
-   Applied rule configurations

### Compute Outputs

-   Instance IDs and names
-   Public and private IP addresses
-   Instance states

### Database Outputs

-   Database instance identifiers
-   Connection endpoints
-   Port numbers

## Best Practices

1. **State Management**: Always use remote state with locking
2. **Variable Validation**: Use variable validation rules where appropriate
3. **Tagging**: Implement consistent tagging across all resources
4. **Documentation**: Keep module documentation up to date
5. **Testing**: Test modules in development before production deployment
6. **Security**: Follow cloud provider security best practices
7. **Monitoring**: Implement logging and monitoring for all resources

## Troubleshooting

Common issues and solutions:

1. **State Lock Issues**: Check backend configuration and permissions
2. **Provider Authentication**: Verify CLI tools are properly configured
3. **Resource Limits**: Check cloud provider quotas and limits
4. **Network Connectivity**: Verify security group and firewall rules
5. **Module Dependencies**: Ensure proper dependency ordering

## Contributing

1. Follow Terraform best practices and style guidelines
2. Ensure all code passes `terraform validate` and `terraform fmt -check`
3. Update module documentation for any changes
4. Test configurations in development environment first
5. Submit pull requests with clear descriptions of changes
6. Include examples and test cases for new modules

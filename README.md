# 🚀 Deploy Static Website to Azure Storage with Terraform + GitHub Actions

This repository contains a complete, production-ready implementation for deploying a static website to Azure Storage Account using Infrastructure as Code (Terraform) and GitHub Actions CI/CD pipeline.

## 📋 Project Overview

This project demonstrates:
- **Infrastructure as Code**: Terraform manages Azure resources (Resource Group, Storage Account)
- **Static Website Hosting**: Azure Storage Account static website feature
- **CI/CD Automation**: GitHub Actions automatically deploys on every push to `main`
- **Cloud-Native Development**: GitHub Codespaces for browser-based development
- **Security Best Practices**: Service Principal authentication, least-privilege access

## 📁 Repository Structure

```
.
├── .github/
│   └── workflows/
│       └── deploy.yml              # GitHub Actions CI/CD pipeline
├── terraform/
│   ├── main.tf                     # Azure Storage Account & Resource Group
│   ├── variables.tf                # Input variables
│   ├── outputs.tf                  # Output values (URLs, IDs)
│   ├── providers.tf                # Terraform & provider configuration
│   └── backend.tf                  # Remote state configuration (optional)
├── website/
│   ├── index.html                  # Home page
│   ├── 404.html                    # Error page
│   ├── style.css                   # Styling
│   └── images/                     # Image assets
├── .gitignore                      # Git ignore patterns
└── README.md                       # This file
```

## 🏗️ Architecture

```
GitHub Repository (main branch)
            ↓
    GitHub Actions Workflow
            ↓
    +------ Terraform ------+
    |                       |
    ├→ Create Resource Group
    ├→ Create Storage Account
    └→ Enable Static Website
            ↓
    Upload Files to $web Container
            ↓
    Static Website URL: https://<storage>.z13.web.core.windows.net/
```

## 🔧 Prerequisites

### Local Development
- Terraform >= 1.5.0
- Azure CLI >= 2.50.0
- Git
- GitHub account with repository access

### Azure Resources
- Azure Subscription (with available quota)
- Azure CLI logged in: `az login`

### GitHub Configuration
- GitHub repository with Actions enabled
- GitHub Codespaces enabled (optional, for browser-based dev)

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/kshivakumar2085/Terraform.git
cd Terraform
```

### 2. Set Up Azure Service Principal

Create a Service Principal for GitHub Actions authentication:

```bash
# Get your subscription ID
SUBSCRIPTION_ID=$(az account show --query id -o tsv)

# Create Service Principal with Contributor role
az ad sp create-for-rbac \
  --name github-terraform-sp \
  --role Contributor \
  --scopes /subscriptions/$SUBSCRIPTION_ID \
  --json-auth > sp-credentials.json
```

Save the output JSON securely.

### 3. Add GitHub Secrets

In your GitHub repository:
1. Go to **Settings → Secrets and variables → Actions**
2. Add the following secrets:

| Secret Name         | Value                                          |
| ------------------- | ---------------------------------------------- |
| `AZURE_CREDENTIALS` | JSON output from Service Principal creation   |
| `STORAGE_NAME`      | Your desired storage account name (see below)  |

**Storage Account Naming Rules:**
- 3-24 characters
- Lowercase letters and numbers only
- Globally unique across Azure

Example:
```
STORAGE_NAME=staticsite123456789abc
```

### 4. Create terraform.tfvars

Create a file `terraform/terraform.tfvars`:

```hcl
rg_name              = "my-static-site-rg"
location             = "East US"
storage_account_name = "staticsite123456789abc"
```

### 5. Deploy

Push to main branch to trigger automatic deployment:

```bash
git add .
git commit -m "Initial deployment"
git push origin main
```

GitHub Actions will automatically:
1. Run Terraform to create Azure resources
2. Upload website files to the storage account
3. Display the website URL

## 🔐 Security Best Practices

### 1. Least Privilege Access

Instead of subscription-level access, restrict Service Principal to specific resource group:

```bash
# Get resource group created by Terraform
RESOURCE_GROUP=$(terraform -chdir=terraform output -raw resource_group_name)

# Remove subscription-level role (if needed)
az role assignment delete \
  --assignee $APP_ID \
  --role Contributor \
  --scope /subscriptions/$SUBSCRIPTION_ID

# Assign to resource group only
az role assignment create \
  --assignee $APP_ID \
  --role "Contributor" \
  --resource-group $RESOURCE_GROUP
```

### 2. Terraform State Management

For production, use remote state instead of local:

In `terraform/backend.tf`:
```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfstatestorageaccount"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
```

### 3. Secrets Management

- ✅ Never commit `terraform.tfvars` with sensitive data
- ✅ Use GitHub Secrets for credentials
- ✅ Rotate Service Principal credentials periodically
- ✅ Enable Azure Key Vault integration for production

## 📝 Workflow Files

### Terraform Configuration

**main.tf** - Creates:
- Azure Resource Group
- Storage Account with static website enabled
- Configures index.html and 404.html

**variables.tf** - Input variables:
- `rg_name`: Resource group name
- `location`: Azure region (default: East US)
- `storage_account_name`: Storage account name

**outputs.tf** - Exported values:
- Storage account ID
- Website URL
- Resource group information

### GitHub Actions (deploy.yml)

Triggers on: `push` to `main` branch

Steps:
1. Checkout code
2. Azure login using Service Principal
3. Setup Terraform
4. Terraform init & plan
5. Terraform apply (creates infrastructure)
6. Upload website files to $web container
7. Display website URL

## 🌐 Accessing Your Website

### Get Website URL

```bash
az storage account show \
  -n <storage-account-name> \
  -g <resource-group-name> \
  --query "primaryEndpoints.web" -o tsv
```

Example output:
```
https://staticsite123456789abc.z13.web.core.windows.net/
```

### Verify Deployment

List uploaded blobs:
```bash
az storage blob list \
  --container-name '$web' \
  --account-name <storage-account-name> \
  -o table
```

### Test Website

Open the URL in your browser:
```bash
# macOS
open https://staticsite123456789abc.z13.web.core.windows.net/

# Linux
xdg-open https://staticsite123456789abc.z13.web.core.windows.net/

# Windows
start https://staticsite123456789abc.z13.web.core.windows.net/
```

## 📝 Making Changes

### 1. Create Feature Branch

```bash
git checkout -b feature/update-website
```

### 2. Edit Website Files

Edit files in `website/` directory:
- `index.html` - Main page
- `style.css` - Styling
- Add images in `website/images/`

### 3. Commit & Push

```bash
git add website/
git commit -m "Update website content"
git push origin feature/update-website
```

### 4. Create Pull Request

Create PR to `dev` branch for review.

### 5. Merge to Main

Once approved, merge to `main` branch → automatic deployment!

## 🔄 CI/CD Pipeline Flow

```
Developer on feature/ branch
        ↓
  Edit website files
  & commit to feature/
        ↓
  Create PR to dev
        ↓
  Code review & approval
        ↓
  Merge dev → main
        ↓
GitHub Actions triggered
        ↓
  Terraform creates/updates infra
        ↓
  Deploys website files
        ↓
  ✅ Live on Azure!
```

## 📊 Monitoring & Validation

### Check GitHub Actions Status

1. Go to **Actions** tab in repository
2. View workflow runs and logs
3. Check for any failures

### View Terraform State

```bash
cd terraform
terraform state list
terraform state show azurerm_storage_account.sa
```

### Monitor Azure Resources

```bash
# List all resources in group
az resource list -g <resource-group-name> -o table

# Check storage account details
az storage account show -n <storage-account-name> -g <resource-group-name>

# View static website config
az storage account show \
  -n <storage-account-name> \
  -g <resource-group-name> \
  --query "staticWebsite"
```

## 🧹 Cleanup

To delete all Azure resources:

```bash
cd terraform
terraform destroy -auto-approve
```

Or manually:
```bash
az group delete -n <resource-group-name> --yes
```

## 📚 Additional Resources

- [Terraform Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Storage Static Website](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Azure CLI Reference](https://learn.microsoft.com/en-us/cli/azure/)
- [GitHub Codespaces Guide](https://docs.github.com/en/codespaces)

## 🤝 Branching Strategy

Follow this professional branching model:

| Branch        | Purpose                                          | Merge From |
| ------------- | ------------------------------------------------ | ---------- |
| `main`        | Production - auto-deploys to Azure              | `dev`      |
| `dev`         | Development - testing & staging                 | `feature/*` |
| `feature/*`   | Feature development - individual contributor    | `dev`      |

Example workflow:
```bash
# Create feature branch
git checkout -b feature/add-contact-form

# Make changes
# ... edit files ...

# Commit & push
git push origin feature/add-contact-form

# Create PR to dev (via GitHub UI)

# After approval & merge:
# Merge dev → main (triggers GitHub Actions deployment)
```

## 🐛 Troubleshooting

### Terraform Plan Fails

**Problem:** `Error: building AzureRM client`

**Solution:**
```bash
# Ensure Azure CLI is logged in
az login

# Check subscription
az account show
```

### GitHub Actions Fails

**Problem:** `AZURE_CREDENTIALS secret not found`

**Solution:**
1. Go to repository Settings → Secrets → Actions
2. Verify `AZURE_CREDENTIALS` is set correctly
3. Re-run workflow

### Website Not Accessible

**Problem:** 404 or connection refused

**Solution:**
```bash
# Verify storage account exists
az storage account show -n <storage-name>

# Check static website is enabled
az storage account show -n <storage-name> \
  --query "staticWebsite"

# Verify files uploaded
az storage blob list -c '$web' -a <storage-name>
```

### Storage Account Name Already Exists

**Problem:** `StorageAccountAlreadyTaken`

**Solution:**
- Storage account names must be globally unique
- Use a more unique name in `terraform.tfvars`
- Example: `staticsite20250102abc123def`

## 💡 Tips & Best Practices

✅ **Version Control**
- Commit all Terraform files
- Keep `.gitignore` up-to-date
- Never commit secrets or `.tfvars` files

✅ **Testing**
- Test locally with Terraform before pushing
- Review `terraform plan` output carefully
- Use pull requests for code review

✅ **Documentation**
- Update README with custom setup
- Document any infrastructure changes
- Keep deployment guides current

✅ **Automation**
- Let GitHub Actions handle deployments
- Avoid manual Azure CLI commands
- Use Terraform for all infrastructure

✅ **Monitoring**
- Review GitHub Actions logs regularly
- Set up Azure alerts for anomalies
- Monitor storage account costs

## 📄 License

This project is provided as-is for educational and production use.

## 👤 Author

Created by: Kubernetes & Terraform Automation Team

For questions or issues, open a GitHub issue in the repository.

---

**Last Updated:** December 2, 2025

**Happy Deploying! 🎉**

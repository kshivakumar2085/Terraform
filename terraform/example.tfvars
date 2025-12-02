# Example Terraform Variables File
# Copy this to terraform/terraform.tfvars and customize values

# Resource group name (must be lowercase, alphanumeric + hyphens)
rg_name = "static-website-rg"

# Azure region where resources will be created
# Options: East US, West US, East US 2, West Europe, Southeast Asia, etc.
location = "East US"

# Storage account name
# RULES:
# - Must be 3-24 characters
# - Can only contain lowercase letters and numbers
# - Must be GLOBALLY UNIQUE (no one else can use this name)
# - Cannot contain hyphens or underscores
#
# EXAMPLE PATTERNS:
# - staticsite2025 + random suffix (e.g., staticsite2025abc123)
# - companyname + region + date (e.g., mycompanyeastusdec2025)
# - website + identifier (e.g., website12345abcde)
storage_account_name = "staticsite20250102abc123"

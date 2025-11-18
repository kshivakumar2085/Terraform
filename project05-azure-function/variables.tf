variable "resource_group_name" {
  description = "RG for function"
  type        = string
  default     = "function-rg"
}

variable "location" {
  description = "Location for function"
  type        = string
  default     = "West US 2"
}

variable "storage_account_name" {
  description = "Storage account name"
  type        = string
  default     = "functionstrgacc"
}

variable "app_service_plan_name" {
  description = "App service plan name"
  type        = string
  default     = "function-plan"
}

variable "function_app_name" {
  description = "Function app name"
  type        = string
  default     = "my-function-app"
}

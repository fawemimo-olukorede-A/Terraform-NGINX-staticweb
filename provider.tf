provider "azurerm" {
  features {}
  subscription_id = var.ARM_SUBSCRIPTION_ID

}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}
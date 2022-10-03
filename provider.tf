terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.25.0"
    }
  }

  required_version = "~> 1.3.0"
}

provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
    backend "azurerm" {
        resource_group_name = "Terraform-AzureDevops"
        strorage_account_name = "tfstrgdevops"
        container_name = "tfstatecontainer"
        access_key = ""
      }

}

  provider "azurerm" {
  features {}
  }


data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "AzureDevops-IaCDeploy"
  location = "eastus"
}

resource "azurerm_storage_account" "example1" {
  name                     = "storageacountiac"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "bharani"
  }
}

resource "azurerm_app_service_plan" "app-service-plan" {
  name                = "webapp-plan-${var.postfix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "webapp-${var.postfix}-${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.app-service-plan.id
}

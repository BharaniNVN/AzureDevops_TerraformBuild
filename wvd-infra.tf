resource "azurerm_resource_group" "wvd_rg" {
  name     = "${var.prefix}-RG-${var.postfix}"
  location = var.location
}

resource "azurerm_virtual_desktop_host_pool" "wvd_pool" {
  location            = var.location
  resource_group_name = azurerm_resource_group.wvd_rg.name

  name                     = "${var.prefix}-hostpool-${var.postfix}"
  friendly_name            = "Devops hostpool"
  validate_environment     = true
  #start_vm_on_connect      = var.start_vm_on_connect
  #custom_rdp_properties    = var.custom_rdp_properties
  description              = "Acceptance Test: A pooled host pool - pooleddepthfirst"
  type                     = var.pooltype
  maximum_sessions_allowed = 50
  load_balancer_type       = var.loadbalancer
}

resource "azurerm_virtual_desktop_application_group" "wvd_desktopapp_group" {
  name                = "${var.prefix}-appgroup-${var.postfix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.wvd_rg.name

  type          = var.appgroup
  host_pool_id  = azurerm_virtual_desktop_host_pool.wvd_pool.id
  friendly_name = "Desktop App Group"
  description   = "An application group to publish Desktop"
}

resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = "${var.prefix}-workspace-${var.postfix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.wvd_rg.name

  friendly_name = "Dev Workspace"
  description   = "Dev workspace"
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "appgroup_association_workspace" {
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
  application_group_id = azurerm_virtual_desktop_application_group.wvd_desktopapp_group.id
}
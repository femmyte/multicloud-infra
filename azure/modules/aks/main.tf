

resource "azurerm_resource_group" "rg" {
  name     = "shopedge-rg"
  location = "East US" # Change to your preferred Azure region
}





resource "azurerm_kubernetes_cluster" "aks" {
  name                = "shopedge-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "shopedge"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure" # ecommended for production
    network_policy = "azure"
  }

  role_based_access_control_enabled = true
}

# Azure Container Registry (ACR)

resource "azurerm_container_registry" "acr" {
  name                = "shopedgeacr${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Random string to avoid ACR name collisions (ACR names must be globally unique)
resource "random_string" "suffix" {
  length  = 5
  upper   = false
  lower   = true
  special = false
  numeric = true
}

# Role Assignment (AKS -> ACR)

resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
}

# network
resource "azurerm_virtual_network" "vnet" {
  name                = "shopedge-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
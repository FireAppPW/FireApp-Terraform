resource "azurerm_user_assigned_identity" "k8s" {
  name                = "aks-identity"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "ersms-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "dns-k8s"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.vmSize
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.k8s.id]
  }

  tags = {
    environment = "Demo"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "scrna_omics" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "scrna_omics" {
  name                = "scrna-omics-cluster"
  location            = azurerm_resource_group.scrna_omics.location
  resource_group_name = azurerm_resource_group.scrna_omics.name
  dns_prefix          = "scrna-omics"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.scrna_omics.name
}

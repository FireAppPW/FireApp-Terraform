
# resource "azurerm_postgresql_server" "example" {
#   name                = "psqlserver"
#   location            = azurerm_resource_group.default.location
#   resource_group_name = azurerm_resource_group.default.name

#   administrator_login          = var.dataSourceUsername
#   administrator_login_password = var.datasourcePassword

#   sku_name   = "GP_Gen5_4"
#   version    = "11"
#   storage_mb = 640000

#   backup_retention_days        = 7
#   geo_redundant_backup_enabled = true
#   auto_grow_enabled            = true

#   public_network_access_enabled    = false
#   ssl_enforcement_enabled          = true
#   ssl_minimal_tls_version_enforced = "TLS1_2"
# }
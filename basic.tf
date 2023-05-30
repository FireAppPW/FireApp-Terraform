# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "default" {
  name     = "ersms-k8s-rg"
  location = "West Europe"

  tags = {
    environment = "Demo"
  }
}
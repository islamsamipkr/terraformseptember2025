variable "apps_by_region" {
  type = map(object({
    app_name     : string
    sku_name     : string
    worker_count : number
  }))
  default = {
    "Canada Central" = { app_name = "inovocb-api-win-cc", sku_name = "B1",   worker_count = 1 }
    "East US"        = { app_name = "riidoz-ui-win-eus",  sku_name = "S1",   worker_count = 2 }
    "West Europe"    = { app_name = "gamecb-core-win-weu",sku_name = "P1v3", worker_count = 2 }
    "Australia East" = { app_name = "analytics-win-aue",  sku_name = "P2v3", worker_count = 3 }
  }
}

# -----------------------------------------
# Resource Groups (one per region)
# -----------------------------------------
resource "azurerm_resource_group" "rg" {
  for_each = var.apps_by_region

  name     = "rg-${replace(lower(each.key), " ", "-")}"
  location = each.key
}

# -----------------------------------------
# Windows App Service Plans (one per region, different SKUs/workers)
# -----------------------------------------
resource "azurerm_service_plan" "plan" {
  for_each            = var.apps_by_region
  name                = "asp-${replace(lower(each.key), " ", "-")}"
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name

  os_type      = "Windows"
  sku_name     = each.value.sku_name
  worker_count = each.value.worker_count
}

# -----------------------------------------
# Windows Web Apps (one per region)
# -----------------------------------------
resource "azurerm_windows_web_app" "app" {
  for_each            = var.apps_by_region

  name                = each.value.app_name       # must be globally unique
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  service_plan_id     = azurerm_service_plan.plan[each.key].id
  https_only          = true

  site_config {
    always_on           = true
    minimum_tls_version = "1.2"
    ftps_state          = "FtpsOnly"

    # Optional: uncomment and set if you know the runtime
    # application_stack {
    #   current_stack  = "dotnet"   # or "node", "java", etc.
    #   dotnet_version = "v8.0"     # example for .NET
    # }
  }

  app_settings = {
    ENVIRONMENT = "prod"
    REGION_NAME = each.key
  }
}

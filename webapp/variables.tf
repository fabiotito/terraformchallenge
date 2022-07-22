variable env {
    type = string
}
variable location {
    type = string
}
variable app_name {
    type = string
}
variable number {
    type = string
}
variable rsgr_name {
    type = string
}
variable lgan_id {
    type = string
}

locals {

    #mapas
    location_map = {
        eu2 = "eastus2"
        cu1 = "centralus"
    }
    env_map = {
        dev = "d"
        qa = "q"
        prod = "p"
    }

    #resource group
    wapp_code = "wapp"
    aspl_code = "aspl"
    apin_code = "apin"
    azal_code = "azal"
    rsgr_code = "rsgr"
    location = local.location_map[lower(var.location)]
    aspl_name = "${local.aspl_code}${lower(var.location)}${var.app_name}${local.env_map[lower(var.env)]}${var.number}"
    wapp_name = "${local.wapp_code}${lower(var.location)}${var.app_name}${local.env_map[lower(var.env)]}${var.number}"
    apin_name = "${local.apin_name}${lower(var.location)}${var.app_name}${local.env_map[lower(var.env)]}${var.number}"

    #apin
    webtest_name = "${local.wapp_name}-${lower(var.env)}"
    #alert
    azal_name = "${local.azal_code}${lower(var.location)}${var.app_name}${local.env_map[lower(var.env)]}${var.number}"
}
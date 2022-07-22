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
    lgan_code = "lgan"
    rsgr_code = "rsgr"
    location = local.location_map[lower(var.location)]
    lgan_name = "${local.lgan_code}${lower(var.location)}${var.app_name}${local.env_map[lower(var.env)]}${var.number}"
}


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
    rsgr_code ="rsgr"
    location = local.location_map[lower(var.location)]
    rsgr_name = "${local.rsgr_code}${lower(var.location)}${var.app_name}${local.env_map[lower(var.env)]}${var.number}"
}
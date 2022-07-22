

module "rsgr" {
  source = "./rsgr"
  env = "dev"
  location = "eu2"
  app_name = "fabs"
  number = "01"
}

module "lgan" {
  source = "./lgan"
  env = "dev"
  location = "eu2"
  app_name = "fabs"
  number = "01"
  rsgr_name = module.rsgr.rsgr_name

  depends_on = [
    module.rsgr
  ]
}

module "webapp" {
  source = "./webapp"
  env = "dev"
  location = "eu2"
  app_name = "fabs"
  number = "01"
  rsgr_name = module.rsgr.rsgr_name
  lgan_id = module.lgan.lgan_id
  
  depends_on = [
    module.rsgr
  ]
}
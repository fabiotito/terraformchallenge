

module "rsgr" {
  source = "./rsgr"
  env = "dev"
  location = "eu2"
  app_name = "fabs"
  number = "01"
}

module "webapp" {
  source = "./webapp"
  env = "dev"
  location = "eu2"
  app_name = "fabs"
  number = "01"
  
  depends_on = [
    module.rsgr
  ]
}
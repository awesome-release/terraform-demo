module "gateway-api" {
  source                = "../../gateway-api/config"
  namespace             = var.env_id
}

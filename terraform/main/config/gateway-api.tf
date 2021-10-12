module "gateway-api" {
  source              = "../../gateway-api/config"
  namespace           = var.env_id
  backend_ingress_url = var.backend_ingress_url
  tld_name            = var.tld_name
  certificate_arn     = var.certificate_arn
}

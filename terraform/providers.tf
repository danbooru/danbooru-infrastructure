provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "linode" {
  token = var.linode_token
}

provider "ovh" {
  endpoint           = "ovh-us"
  application_key    = var.ovh_application_key
  application_secret = var.ovh_application_secret
  consumer_key       = var.ovh_consumer_key
}

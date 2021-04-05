# https://registry.terraform.io/providers/ovh/ovh/latest/docs
# https://registry.terraform.io/providers/ovh/ovh/latest/docs/data-sources/dedicated_server

data "ovh_dedicated_server" "inuyama_donmai_us" {
  service_name = var.server_ids.inuyama
}

data "ovh_dedicated_server" "kagamihara_donmai_us" {
  service_name = var.server_ids.kagamihara
}

data "ovh_dedicated_server" "korone_donmai_us" {
  service_name = var.server_ids.korone
}

data "ovh_dedicated_server" "shima_donmai_us" {
  service_name = var.server_ids.shima
}

data "ovh_dedicated_server" "oogaki_donmai_us" {
  service_name = var.server_ids.oogaki
}

data "ovh_dedicated_server" "saitou_donmai_us" {
  service_name = var.server_ids.saitou
}
